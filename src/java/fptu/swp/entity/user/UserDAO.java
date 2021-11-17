/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.user;

import fptu.swp.controller.accessgoogle.GooglePojo;
import fptu.swp.utils.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author admin
 */
public class UserDAO {

    //ham login 
    public UserDTO login(GooglePojo googlePojo) throws SQLException {
        UserDTO user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        PreparedStatement stm2 = null;
        ResultSet rs = null;
        String email = googlePojo.getEmail();
        int userId = 0;
        String avatarGoogle = googlePojo.getPicture();
        String name = "";
        String avatar = "";
        String address = "";
        String phoneNum = "";
        String statusId = "";
        String roleName = "";
        String description = "";
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id, name, avatar, address, phoneNum, roleId, statusId, description"
                        + " FROM tblUsers"
                        + " WHERE email=?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, email);
                rs = stm.executeQuery();
                if (rs.next()) { //neu da co thong tin trong DB
                    userId = rs.getInt("id");
                    name = rs.getString("name");
                    avatar = rs.getString("avatar");
                    address = rs.getString("address");
                    phoneNum = rs.getString("phoneNum");
                    int roleId = rs.getInt("roleId");
                    statusId = rs.getString("statusId");
                    description = rs.getString("description");
                    if ("DE".equals(statusId)) {
                        return null;
                    }
                    //Set cung roleName bang roleId
                    if (roleId == 1) {
                        roleName = "STUDENT";
                    } else if (roleId == 2) {
                        roleName = "LECTURER";
                    } else if (roleId == 3) {
                        roleName = "CLUB'S LEADER";
                    } else if (roleId == 4) {
                        roleName = "DEPARTMENT'S MANAGER";
                    } else if (roleId == 5) {
                        roleName = "ADMIN";
                    }
                    if (!avatarGoogle.equals(avatar)) {
                        String sql2 = "UPDATE tblUsers"
                                + " SET avatar=?"
                                + " WHERE email=?";
                        stm2 = conn.prepareStatement(sql2);
                        stm2.setString(1, avatarGoogle);
                        stm2.setString(2, email);
                        boolean checkSetAvatar = stm2.executeUpdate() > 0;
                    }
                    user = new UserDTO(userId, email, name, avatarGoogle, address, phoneNum, roleName, "Activated", description);
                } else if (email.endsWith("@fpt.edu.vn")) { //chua co thong tin trong DB va dang nhap bang mail fpt
                    name = googlePojo.getName();
                    avatar = googlePojo.getPicture();
                    roleName = "STUDENT";
                    user = new UserDTO(0, email, name, avatar, address, phoneNum, roleName);
                    boolean checkInsert = insertNewUser(user);
                    if (!checkInsert) {
                        user = null;
                    } else {
                        sql = "SELECT id"
                                + " FROM tblUsers"
                                + " WHERE email=?";
                        stm = conn.prepareStatement(sql);
                        stm.setString(1, email);
                        rs = stm.executeQuery();
                        if (rs.next()) {
                            userId = rs.getInt("id");
                            user.setId(userId);
                        }
                    }
                } else if (email.endsWith("@fe.edu.vn")) { //chua co thong tin trong DB va dang nhap bang mail fe
                    name = googlePojo.getName();
                    avatar = googlePojo.getPicture();
                    roleName = "LECTURER";
                    user = new UserDTO(0, email, name, avatar, address, phoneNum, roleName);
                    boolean checkInsert = insertNewUser(user);
                    if (!checkInsert) {
                        user = null;
                    } else {
                        sql = "SELECT id"
                                + " FROM tblUsers"
                                + " WHERE email=?";
                        stm = conn.prepareStatement(sql);
                        stm.setString(1, email);
                        rs = stm.executeQuery();
                        if (rs.next()) {
                            userId = rs.getInt("id");
                            user.setId(userId);
                        }
                    }
                } else { //dang nhap thanh cong nhung khong co trong DB va ko la mail FPT
                    user = null;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm2 != null) {
                stm2.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

    //khi nguoi dung dang nhap bang mail fpt.edu.vn lan dau thi goi ham nay de insert thong tin vao DB
    public boolean insertNewUser(UserDTO user) throws SQLException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblUsers(email, name, avatar, address, phoneNum, roleId , statusId)"
                        + " VALUES(?,?,?,?,?,?,'AC')";
                stm = conn.prepareStatement(sql);
                stm.setString(1, user.getEmail());
                stm.setNString(2, user.getName());
                stm.setString(3, user.getAvatar());
                stm.setString(4, user.getAddress());
                stm.setString(5, user.getPhoneNum());
                stm.setInt(6, "STUDENT".equals(user.getRoleName()) ? 1 : 2);
                check = stm.executeUpdate() > 0;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;

    }

    //Ham update thong tin user vao DB
    public boolean updateUser(UserDTO user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "UPDATE tblUsers "
                        + " SET name=?, address=?, phoneNum=?, description=?"
                        + " WHERE email=?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, user.getName());
                stm.setString(2, user.getAddress());
                stm.setString(3, user.getPhoneNum());
                stm.setString(4, user.getDescription());
                stm.setString(5, user.getEmail());
                check = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    //ham lay list lecture boi event ID
    public List<LecturerBriefInfoDTO> getListLecturerBriefInfo(int eventId) throws SQLException {
        List<LecturerBriefInfoDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int id = 0;
        String name = "";
        String avatar = "";
        String description = "";
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT v.id id, v.name name, v.avatar avatar, v.description description"
                        + " FROM tblLecturersInEvents u INNER JOIN tblUsers v ON u.lecturerId = v.id"
                        + " WHERE u.eventId = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    id = rs.getInt("id");
                    avatar = rs.getString("avatar");
                    name = rs.getString("name");
                    description = rs.getString("description");
                    list.add(new LecturerBriefInfoDTO(id, avatar, name, description));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public List<LecturerBriefInfoDTO> getAllLecturer() throws SQLException, NamingException {
        List<LecturerBriefInfoDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id, name, avatar, description "
                        + "FROM tblUsers "
                        + "WHERE roleId = 2 ";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String avatar = rs.getString("avatar");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    list.add(new LecturerBriefInfoDTO(id, avatar, name, description));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public String getDescription(int userId) throws SQLException, NamingException {
        String description = "";
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT description "
                        + "FROM tblUsers "
                        + "WHERE id = ? ";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, userId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    description = rs.getString("description");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return description;
    }

    public LecturerBriefInfoDTO getLecturerById(int id) throws SQLException, NamingException {
        LecturerBriefInfoDTO lecturerInfo = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT name, avatar, description "
                        + "FROM tblUsers "
                        + "WHERE roleId = 2 AND id = ? ";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String avatar = rs.getString("avatar");
                    String name = rs.getString("name");
                    String description = rs.getString("description");
                    lecturerInfo = new LecturerBriefInfoDTO(id, avatar, name, description);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return lecturerInfo;
    }

    public List<UserDTO> getAllOrganizerAndNumberOfEventByQuarter(Date date) throws SQLException, NamingException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Timestamp startDateOfQuarter = getFirstDayOfQuarter(date);
        Timestamp endDateOfQuarter = getLastDayOfQuarter(date);
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT u.id as id, u.email as email, u.name as name, u.avatar as avatar, u.phoneNum as phoneNum, u.roleId as roleId, u.statusId statusId, u.description description, v.demEvent as numOfEvent"
                        + " FROM tblUsers u LEFT JOIN (SELECT userId, COUNT(id) as demEvent FROM tblEvents WHERE createDate >= ? AND createDate <= ? GROUP BY userId) v ON u.id = v.userId"
                        + " WHERE roleId = 3 OR roleId = 4 ORDER BY numOfEvent DESC";
                stm = conn.prepareStatement(sql);
                stm.setTimestamp(1, startDateOfQuarter);
                stm.setTimestamp(2, endDateOfQuarter);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String email = rs.getString("email");
                    String name = rs.getString("name");
                    String avatar = rs.getString("avatar");
                    String phoneNum = rs.getString("phoneNum");
                    String roleName = (rs.getInt("roleId") == 3) ? "CLUB'S LEADER" : "DEPARTMENT'S MANAGER";
                    String status = (rs.getString("statusId").equals("AC")) ? "Activated" : "Deactivated";
                    String description = rs.getString("description");
                    int numOfEvent = rs.getInt("numOfEvent");
                    list.add(new UserDTO(id, email, name, avatar, null, phoneNum, roleName, status, description, numOfEvent));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    //Ham de admin them user vao DB truoc cho Organizer (CL + DM) va Lecturer
    public boolean insertOrganizerOrLecturer(UserDTO user, int roleId) throws SQLException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblUsers(email, name, avatar, address, phoneNum, roleId , statusId, description)"
                        + " VALUES(?,?,?,?,?,?,'AC',?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, user.getEmail());
                stm.setNString(2, user.getName());
                stm.setString(3, user.getAvatar());
                stm.setString(4, user.getAddress());
                stm.setString(5, user.getPhoneNum());
                stm.setInt(6, roleId);
                stm.setString(7, user.getDescription());
                check = stm.executeUpdate() > 0;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;

    }

    public boolean deactivateUser(int userId) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "UPDATE tblUsers "
                        + " SET statusId = 'DE'"
                        + " WHERE id = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, userId);
                check = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean reactivateUser(int userId) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "UPDATE tblUsers "
                        + " SET statusId = 'AC'"
                        + " WHERE id = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, userId);
                check = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<UserDTO> getAllLecturerForAdmin() throws SQLException, NamingException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id, email, name, avatar, address, phoneNum, roleId, statusId, description"
                        + " FROM tblUsers "
                        + " WHERE roleId = 2";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String email = rs.getString("email");
                    String name = rs.getString("name");
                    String avatar = rs.getString("avatar");
                    String address = rs.getString("address");
                    String phoneNum = rs.getString("phoneNum");
                    String roleName = "LECTURER";
                    String status = (rs.getString("statusId").equals("AC")) ? "Activated" : "Deactivated";
                    String description = rs.getString("description");
                    list.add(new UserDTO(id, email, name, avatar, address, phoneNum, roleName, status, description));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public List<UserDTO> getListAllOrganizer() throws SQLException, NamingException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id, email, name, avatar, phoneNum, roleId, statusId, description"
                        + " FROM tblUsers "
                        + " WHERE roleId = 3 OR roleId = 4";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String email = rs.getString("email");
                    String name = rs.getString("name");
                    String avatar = rs.getString("avatar");
                    String phoneNum = rs.getString("phoneNum");
                    String roleName = (rs.getInt("roleId") == 3) ? "CL" : "DM";
                    String status = (rs.getString("statusId").equals("AC")) ? "Activated" : "Deactivated";
                    String description = rs.getString("description");
                    list.add(new UserDTO(id, email, name, avatar, null, phoneNum, roleName, status, description));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public List<UserDTO> getAllStudent() throws SQLException, NamingException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id, email, name, avatar, address, phoneNum,roleId,statusId"
                        + " FROM tblUsers"
                        + " WHERE roleId = 1";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String email = rs.getString("email");
                    String name = rs.getString("name");
                    String avatar = rs.getString("avatar");
                    String address = rs.getString("address");
                    String phoneNum = rs.getString("phoneNum");
                    String roleName = "STUDENT";
                    String status = (rs.getString("statusId").equals("AC")) ? "Activated" : "Deactivated";
                    list.add(new UserDTO(id, email, name, avatar, address, phoneNum, roleName, status));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public int getUserRoleId(int userId) throws SQLException, NamingException {
        int roleId = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT roleId"
                        + " FROM tblUsers"
                        + " WHERE id = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, userId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    roleId = rs.getInt("roleId");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return roleId;
    }
    
    public UserDTO getUserByEmail(String email) throws SQLException, NamingException {
       UserDTO user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id, email, name, avatar, address, phoneNum,roleId,statusId, description"
                        + " FROM tblUsers"
                        + " WHERE email = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, email);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String avatar = rs.getString("avatar");
                    String address = rs.getString("address");
                    String phoneNum = rs.getString("phoneNum");
                    int roleId = rs.getInt("roleId");
                    String roleName = "";
                    if (roleId == 1) {
                        roleName = "STUDENT";
                    } else if (roleId == 2) {
                        roleName = "LECTURER";
                    } else if (roleId == 3) {
                        roleName = "CLUB'S LEADER";
                    } else if (roleId == 4) {
                        roleName = "DEPARTMENT'S MANAGER";
                    } else if (roleId == 5) {
                        roleName = "ADMIN";
                    }
                    String status = (rs.getString("statusId").equals("AC")) ? "Activated" : "Deactivated";
                    String description = rs.getString("description");
                    user = new UserDTO(id, email, name, avatar, address, phoneNum, roleName, status, description);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

    private static Timestamp getFirstDayOfQuarter(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) / 3 * 3);
        return new Timestamp(cal.getTime().getTime());
    }

    private static Timestamp getLastDayOfQuarter(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.DAY_OF_MONTH, 1);
        cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) / 3 * 3 + 2);
        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
        return new Timestamp(cal.getTime().getTime());
    }
    public List<UserDTO> getFollowersByEventId(int eventId) throws SQLException, NamingException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id, email, name, avatar, address, phoneNum, roleId, statusId" +
                                " FROM tblUsers u" +
                                " JOIN tblStudentsInEvents v ON u.id = v.studentId AND v.isFollowing = 1 AND v.eventId = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String avatar = rs.getString("avatar");
                    String address = rs.getString("address");
                    String phoneNum = rs.getString("phoneNum");
                    String roleName = "STUDENT";
                    String status = (rs.getString("statusId").equals("AC")) ? "Activated" : "Deactivated";
                    list.add(new UserDTO(id, email, name, avatar, address, phoneNum, roleName, status));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
    public List<UserDTO> getParticipantsByEventId(int eventId) throws SQLException, NamingException {
        List<UserDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id, email, name, avatar, address, phoneNum, roleId, statusId" +
                                " FROM tblUsers u" +
                                " JOIN tblStudentsInEvents v ON u.id = v.studentId AND v.isJoining = 1 AND v.eventId = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String avatar = rs.getString("avatar");
                    String address = rs.getString("address");
                    String phoneNum = rs.getString("phoneNum");
                    String roleName = "STUDENT";
                    String status = (rs.getString("statusId").equals("AC")) ? "Activated" : "Deactivated";
                    list.add(new UserDTO(id, email, name, avatar, address, phoneNum, roleName, status));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
    public List<Integer> getFollowersIdByEventId(int eventId) throws SQLException, NamingException {
        List<Integer> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id" +
                                " FROM tblUsers u" +
                                " JOIN tblStudentsInEvents v ON u.id = v.studentId AND v.isFollowing = 1 AND v.eventId = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt("id");
                    list.add(id);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
    
    public UserDTO getUserById(int id) throws SQLException, NamingException {
       UserDTO user = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id, email, name, avatar, address, phoneNum,roleId,statusId, description"
                        + " FROM tblUsers"
                        + " WHERE id = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String email = rs.getString("email");
                    String name = rs.getString("name");
                    String avatar = rs.getString("avatar");
                    String address = rs.getString("address");
                    String phoneNum = rs.getString("phoneNum");
                    int roleId = rs.getInt("roleId");
                    String roleName = "";
                    if (roleId == 1) {
                        roleName = "STUDENT";
                    } else if (roleId == 2) {
                        roleName = "LECTURER";
                    } else if (roleId == 3) {
                        roleName = "CLUB'S LEADER";
                    } else if (roleId == 4) {
                        roleName = "DEPARTMENT'S MANAGER";
                    } else if (roleId == 5) {
                        roleName = "ADMIN";
                    }
                    String status = (rs.getString("statusId").equals("AC")) ? "Activated" : "Deactivated";
                    String description = rs.getString("description");
                    user = new UserDTO(id, email, name, avatar, address, phoneNum, roleName, status, description);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return user;
    }

    public List<UserDTO> getUserByEventId(int eventId) throws NamingException, SQLException {
        List<UserDTO> list = new ArrayList<>();
        UserDTO userInfo;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT u.name name, u.email email, u.phoneNum phoneNum" +
                        " FROM tblUsers u" +
                        " JOIN tblStudentsInEvents v ON u.id = v.studentId AND (v.isFollowing = 1 OR v.isJoining = 1) AND v.eventId = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String phoneNum = rs.getString("phoneNum");
                    userInfo = new UserDTO(email, name, phoneNum);
                    list.add(userInfo);
                }
//                
//                return list;
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
    
    public int getOrganizerIdByEventId(int eventId) throws NamingException, SQLException{
        int organizerId = 0;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT userId" +
                        " FROM tblEvents" +
                        " WHERE id = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    organizerId = rs.getInt("userId");
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return organizerId;
    }
}
