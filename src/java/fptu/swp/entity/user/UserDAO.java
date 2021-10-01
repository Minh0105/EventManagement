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
import java.util.ArrayList;
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
        ResultSet rs = null;
        String email = googlePojo.getEmail();
        int userId = 0;
        String name = "";
        String avatar = "";
        String address = "";
        String phoneNum ="";
        String statusId = "";
        String roleName = "";
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT id, name, avatar, address, phoneNum, roleId, statusId"
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

                    //Set cung roleName bang roleId
                    if (roleId == 1) {
                        roleName = "STUDENT";
                    } else if (roleId == 2) {
                        roleName = "LECTURER";
                    } else if (roleId == 3) {
                        roleName = "CLUB'S LEADER";
                    } else if (roleId == 4) {
                        roleName = "DEPARTMENT'S MANAGER";
                    }
                    user = new UserDTO(userId, email, name, avatar, address, phoneNum, roleName);
                }else if(email.endsWith("@fpt.edu.vn")){ //chua co thong tin trong DB va dang nhap bang mail fpt
                    name = googlePojo.getName();
                    avatar = googlePojo.getPicture();
                    roleName = "STUDENT";
                    user = new UserDTO(0, email, name, avatar, address, phoneNum, roleName);
                    boolean checkInsert = insertNewUser(user);
                    if (!checkInsert) {
                        user = null;
                    }else{
                        sql = "SELECT id"
                        + " FROM tblUsers"
                        + " WHERE email=?";
                        stm = conn.prepareStatement(sql);
                        stm.setString(1, email);
                        rs = stm.executeQuery();
                        if(rs.next()) {
                            userId = rs.getInt("id");
                            user.setId(userId);
                        }
                    }
                }else if(email.endsWith("@fe.edu.vn")){ //chua co thong tin trong DB va dang nhap bang mail fpt
                    name = googlePojo.getName();
                    avatar = googlePojo.getPicture();
                    roleName = "LECTURER";
                    user = new UserDTO(0, email, name, avatar, address, phoneNum, roleName);
                    boolean checkInsert = insertNewUser(user);
                    if (!checkInsert) {
                        user = null;
                    }else{
                        sql = "SELECT id"
                        + " FROM tblUsers"
                        + " WHERE email=?";
                        stm = conn.prepareStatement(sql);
                        stm.setString(1, email);
                        rs = stm.executeQuery();
                        if(rs.next()) {
                            userId = rs.getInt("id");
                            user.setId(userId);
                        }
                    }
                }else{ //dang nhap thanh cong nhung khong co trong DB va ko la mail FPT
                    user = null;
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
        System.out.println(user.toString());
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
                String sql = "INSERT INTO tblUsers(email, name, avatar, address, phoneNum, roleID , statusId)"
                        + " VALUES(?,?,?,?,?,?,'AC')";
                stm = conn.prepareStatement(sql);
                stm.setString(1, user.getEmail());
                stm.setNString(2, user.getName());
                stm.setString(3, user.getAvatar());
                stm.setString(4, user.getAddress());
                stm.setString(5, user.getPhoneNum());
                stm.setInt(6, "STUDENT".equals(user.getRoleName())? 1 : 2);
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
                        + " SET name=?, address=?, phoneNum=?"
                        + " WHERE email=?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, user.getName());
                stm.setString(2, user.getAddress());
                stm.setString(3, user.getPhoneNum());
                stm.setString(4, user.getEmail());
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
    public List<LecturerBriefInfo> getListLecturerBriefInfo(int eventId) throws SQLException{
        List<LecturerBriefInfo> list = new ArrayList<>();
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
                String sql = "SELECT v.id id, v.name name, v.avatar avatar, v.description description" +
                                " FROM tblLecturersInEvents u, tblUsers v" +
                                " WHERE u.eventId = ? AND u.lecturerId = v.id AND u.statusId = 1;";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    id = rs.getInt("id");
                    avatar = rs.getString("avatar");
                    name = rs.getString("name");
                    description = rs.getString("description");
                    list.add(new LecturerBriefInfo(id, avatar, name, description));
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
}
