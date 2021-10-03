/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.event;

import fptu.swp.entity.user.UserDTO;
import fptu.swp.utils.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.List;

/**
 *
 * @author triet
 */
public class EventDAO {

//    public boolean insertNewEvent(EventDTO event) throws SQLException {
//        boolean check = false;
//        Connection conn = null;
//        PreparedStatement stm = null;
//        try {
//            conn = DBHelper.makeConnection();
//            if (conn != null) {
//                String sql = "INSERT INTO tblEvents(name, description, poster, createDate, statusId, userId) "
//                        + " VALUES(?,?,?,CURRENT_TIMESTAMP,1,?)";
//                stm = conn.prepareStatement(sql);
//                stm.setString(1, event.getName());
//                stm.setString(2, event.getDescription());
//                stm.setString(3, event.getPoster());
//                stm.setInt(4, event.getUserId());
//                check = stm.executeUpdate() > 0;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (stm != null) {
//                stm.close();
//            }
//            if (conn != null) {
//                conn.close();
//            }
//        }
//        return check;
//    }

    //Ham lay danh sach event card hs da bam Quan tam
    //Cac comment ap dung cho 3 ham get list EventCard
    public List<EventCardDTO> getFollowedEventList(int studentId) throws SQLException {
        List<EventCardDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int eventId = 0;
        int currentEventId = 0;
        String eventName = "";
        String eventPoster = "";
        String organizerName = "";
        String date = "";
        String locationName = "";
        int following = 0;
        int joining = 0;
        List<String> listLocation = new ArrayList<>();
        SimpleDateFormat formatter = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql
                        = "SELECT s.id eventId, s.name eventName, s.poster eventPoster, m.name organizerName, t.date date, t.name locationName, s.numberOfFollowers followers, s.numberOfParticipants participants"
                        + " FROM tblEvents s"
                        + " LEFT JOIN tblUsers m ON s.userId = m.id"
                        + " LEFT JOIN ( SELECT DISTINCT eventId, date, u.name FROM tblDateTimeLocation"
                        + "                  LEFT JOIN tblLocations u ON locationId = u.id) t ON s.id = t.eventId"
                        + " WHERE s.id IN (SELECT eventId FROM tblStudentsInEvents WHERE studentId = ? AND isFollowing = 1)";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, studentId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    eventId = rs.getInt("eventId");
                    if (currentEventId != eventId) { //qua 1 event khac
                        if (currentEventId != 0) { //event khong phai event dau tien
                            int i = 0;
                            String location = "";
                            for (i = 0; i < listLocation.size() - 1; i++) {
                                location += listLocation.get(i) + ", ";
                            }//format cuoi location
                            location += listLocation.get(i);
                            EventCardDTO card = new EventCardDTO(currentEventId, eventName, eventPoster, location, date, organizerName, following, joining);
                            list.add(card);
                        }
                        listLocation.clear(); //qua moi event khoi tao lai list dia diem
                        currentEventId = eventId;
                        eventName = rs.getString("eventName");
                        eventPoster = rs.getString("eventPoster");
                        organizerName = rs.getString("organizerName");
                        formatter = new SimpleDateFormat("dd/MM/yyyy");
                        Date dateFromDB = rs.getTimestamp("date");
                        date = formatter.format(dateFromDB).toString();
                        formatter = new SimpleDateFormat("EEEE");
                        date = formatter.format(dateFromDB).toString() + ", " + date; //gop thu ngay thang thanh chuoi date
                        locationName = rs.getString("locationName"); //lay location cua 1 record
                        following = rs.getInt("followers");
                        joining = rs.getInt("participants");
                        listLocation.add(locationName); // add location vao chuoi
                    } else {
                        locationName = rs.getString("locationName");
                        listLocation.add(locationName);
                    }
                }
                int i = 0;
                String location = "";
                for (i = 0; i < listLocation.size() - 1; i++) {
                    location += listLocation.get(i) + ", ";
                } //format chuoi location
                location += listLocation.get(i);
                EventCardDTO card = new EventCardDTO(currentEventId, eventName, eventPoster, location, date, organizerName, following, joining);
                list.add(card);
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

    public List<EventCardDTO> getJoiningEventList(int studentId) throws SQLException {
        List<EventCardDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int eventId = 0;
        int currentEventId = 0;
        String eventName = "";
        String eventPoster = "";
        String organizerName = "";
        String date = "";
        String locationName = "";
        int following = 0;
        int joining = 0;
        List<String> listLocation = new ArrayList<>();
        SimpleDateFormat formatter = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql
                        = "SELECT s.id eventId, s.name eventName, s.poster eventPoster, m.name organizerName, t.date date, t.name locationName, s.numberOfFollowers followers, s.numberOfParticipants participants"
                        + " FROM tblEvents s"
                        + " LEFT JOIN tblUsers m ON s.userId = m.id"
                        + " LEFT JOIN ( SELECT DISTINCT eventId, date, u.name FROM tblDateTimeLocation"
                        + "                  LEFT JOIN tblLocations u ON locationId = u.id) t ON s.id = t.eventId"
                        + " WHERE s.id IN (SELECT eventId FROM tblStudentsInEvents WHERE studentId = ? AND isJoining = 1)";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, studentId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    eventId = rs.getInt("eventId");
                    if (currentEventId != eventId) {
                        if (currentEventId != 0) {
                            int i = 0;
                            String location = "";
                            for (i = 0; i < listLocation.size() - 1; i++) {
                                location += listLocation.get(i) + ", ";
                            }
                            location += listLocation.get(i);
                            EventCardDTO card = new EventCardDTO(currentEventId, eventName, eventPoster, location, date, organizerName, following, joining);
                            list.add(card);
                        }
                        listLocation.clear();
                        currentEventId = eventId;
                        eventName = rs.getString("eventName");
                        eventPoster = rs.getString("eventPoster");
                        organizerName = rs.getString("organizerName");
                        formatter = new SimpleDateFormat("dd/MM/yyyy");
                        Date dateFromDB = rs.getTimestamp("date");
                        date = formatter.format(dateFromDB).toString();
                        formatter = new SimpleDateFormat("EEEE");
                        date = formatter.format(dateFromDB).toString() + ", " + date;
                        locationName = rs.getString("locationName");
                        following = rs.getInt("followers");
                        joining = rs.getInt("participants");
                        listLocation.add(locationName);
                    } else {
                        locationName = rs.getString("locationName");
                        listLocation.add(locationName);
                    }
                }
                int i = 0;
                String location = "";
                for (i = 0; i < listLocation.size() - 1; i++) {
                    location += listLocation.get(i) + ", ";
                }
                location += listLocation.get(i);
                EventCardDTO card = new EventCardDTO(currentEventId, eventName, eventPoster, location, date, organizerName, following, joining);
                list.add(card);
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

    public List<EventCardDTO> getNewFeedEventList(UserDTO loginUser) throws SQLException {
        List<EventCardDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int eventId = 0;
        int currentEventId = 0;
        String eventName = "";
        String eventPoster = "";
        String organizerName = "";
        String date = "";
        String locationName = "";
        int following = 0;
        int joining = 0;
        List<String> listLocation = new ArrayList<>();
        SimpleDateFormat formatter = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "";
                if ("STUDENT".equals(loginUser.getRoleName())) {
                    sql = "SELECT s.id eventId, s.name eventName, s.poster eventPoster, m.name organizerName, t.date date, t.name locationName, s.numberOfFollowers followers, s.numberOfParticipants participants"
                            + " FROM tblEvents s"
                            + " LEFT JOIN tblUsers m ON s.userId = m.id"
                            + " LEFT JOIN ( SELECT DISTINCT eventId, date, u.name FROM tblDateTimeLocation"
                            + "                  LEFT JOIN tblLocations u ON locationId = u.id) t ON s.id = t.eventId"
                            + " WHERE s.statusId = 1";
                    stm = conn.prepareStatement(sql);
                } else if ("CLUB'S LEADER".equals(loginUser.getRoleName()) || "DEPARTMENT'S MANAGER".equals(loginUser.getRoleName())) {
                    sql = "SELECT s.id eventId, s.name eventName, s.poster eventPoster, m.name organizerName, t.date date, t.name locationName, s.numberOfFollowers followers, s.numberOfParticipants participants"
                            + " FROM tblEvents s"
                            + " LEFT JOIN tblUsers m ON s.userId = m.id"
                            + " LEFT JOIN ( SELECT DISTINCT eventId, date, u.name FROM tblDateTimeLocation"
                            + "                  LEFT JOIN tblLocations u ON locationId = u.id) t ON s.id = t.eventId"
                            + " WHERE s.userId = ?";
                    stm = conn.prepareStatement(sql);
                    stm.setInt(1, loginUser.getId());
                } else if ("LECTURER".equals(loginUser.getRoleName())) {
                    sql = "SELECT s.id eventId, s.name eventName, s.poster eventPoster, m.name organizerName, t.date date, t.name locationName, s.numberOfFollowers followers, s.numberOfParticipants participants"
                            + " FROM tblEvents s"
                            + " LEFT JOIN tblUsers m ON s.userId = m.id"
                            + " LEFT JOIN ( SELECT DISTINCT eventId, date, u.name FROM tblDateTimeLocation"
                            + "                  LEFT JOIN tblLocations u ON locationId = u.id) t ON s.id = t.eventId"
                            + " WHERE s.id IN (SELECT eventId FROM tblLecturersInEvents WHERE lecturerId = ? AND statusId = 1)";
                    stm = conn.prepareStatement(sql);
                    stm.setInt(1, loginUser.getId());
                }
                rs = stm.executeQuery();
                while (rs.next()) {
                    eventId = rs.getInt("eventId");
                    if (currentEventId != eventId) {
                        if (currentEventId != 0) {
                            int i = 0;
                            String location = "";
                            for (i = 0; i < listLocation.size() - 1; i++) {
                                location += listLocation.get(i) + ", ";
                            }
                            location += listLocation.get(i);
                            EventCardDTO card = new EventCardDTO(currentEventId, eventName, eventPoster, location, date, organizerName, following, joining);
                            list.add(card);
                        }
                        listLocation.clear();
                        currentEventId = eventId;
                        eventName = rs.getString("eventName");
                        eventPoster = rs.getString("eventPoster");
                        organizerName = rs.getString("organizerName");
                        formatter = new SimpleDateFormat("dd/MM/yyyy");
                        Date dateFromDB = rs.getTimestamp("date");
                        date = formatter.format(dateFromDB).toString();
                        formatter = new SimpleDateFormat("EEEE");
                        date = formatter.format(dateFromDB).toString() + ", " + date;
                        locationName = rs.getString("locationName");
                        following = rs.getInt("followers");
                        joining = rs.getInt("participants");
                        listLocation.add(locationName);
                    } else {
                        locationName = rs.getString("locationName");
                        listLocation.add(locationName);
                    }
                }
                int i = 0;
                String location = "";
                for (i = 0; i < listLocation.size() - 1; i++) {
                    location += listLocation.get(i) + ", ";
                }
                location += listLocation.get(i);
                EventCardDTO card = new EventCardDTO(currentEventId, eventName, eventPoster, location, date, organizerName, following, joining);
                list.add(card);

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

    public EventDetailDTO getEventDetail(int eventId) throws SQLException {
        EventDetailDTO detail = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String eventName = "";
        String eventPoster = "";
        String organizerName = "";
        String date = "";
        String rangeName = "";
        String locationName = "";
        int following = 0;
        int joining = 0;
        String description = "";
        String organizerDescription = "";
        String organizerAvatar = "";
        List<String> listLocation = new ArrayList<>();
        List<String> listTime = new ArrayList<>();
        SimpleDateFormat formatter = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql
                        = "SELECT s.name eventName, s.poster eventPoster, m.name organizerName, t.date date,"
                        + " t.name locationName, s.numberOfFollowers followers, s.numberOfParticipants participants,"
                        + " s.description description, m.description organizerDescription, m.avatar organizerAvatar"
                        + " FROM tblEvents s"
                        + " LEFT JOIN tblUsers m ON s.userId = m.id"
                        + " LEFT JOIN ( SELECT DISTINCT eventId, date, u.name FROM tblDateTimeLocation"
                        + "                  LEFT JOIN tblLocations u ON locationId = u.id) t ON s.id = t.eventId"
                        + " WHERE s.id = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    eventName = rs.getString("eventName");
                    eventPoster = rs.getString("eventPoster");
                    organizerName = rs.getString("organizerName");
                    formatter = new SimpleDateFormat("dd/MM/yyyy");
                    Date dateFromDB = rs.getTimestamp("date");
                    date = formatter.format(dateFromDB).toString();
                    formatter = new SimpleDateFormat("EEEE");
                    date = formatter.format(dateFromDB).toString() + ", " + date;
                    locationName = rs.getString("locationName");
                    following = rs.getInt("followers");
                    joining = rs.getInt("participants");
                    description = rs.getString("description");
                    organizerDescription = rs.getString("organizerDescription");
                    organizerAvatar = rs.getString("organizerAvatar");
                    listLocation.add(locationName);
                }
                while (rs.next()) {
                    locationName = rs.getString("locationName");
                    listLocation.add(locationName);
                }
                int i = 0;
                //format location string
                String location = "";
                for (i = 0; i < listLocation.size() - 1; i++) {
                    location += listLocation.get(i) + ", ";
                }
                location += listLocation.get(i);
                sql = "SELECT v.rangeId rangeId, u.rangeName rangeName\n"
                        + " FROM tblTimeRanges u"
                        + " RIGHT JOIN (SELECT DISTINCT v.rangeId\n"
                        + "                   FROM tblEvents u, tblDateTimeLocation v"
                        + "                   WHERE u.id = v.eventId AND v.eventId = ?) v"
                        + " ON u.id = v.rangeId";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    rangeName = rs.getString("rangeName");
                    listTime.add(rangeName);
                }
                //format time string (gan name cua cac time range)
                String time = "";
                for (i = 0; i < listTime.size() - 1; i++) {
                    time += listTime.get(i) + ", ";
                }
                time += listTime.get(i);
                detail = new EventDetailDTO(eventId, eventName, eventPoster, location, date, time, organizerName, following, joining, description, organizerDescription, organizerAvatar);
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
        return detail;
    }

    public List<CommentDTO> getListCommentByEventId(int eventId) throws SQLException {
        List<CommentDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        PreparedStatement stm2 = null;
        ResultSet rs2 = null;
        int commentId = 0;
        String contents = "";
        String userAvatar= "";
        String userName= "";
        boolean isQuestion = false;
        Date commentDatetime;
        List<ReplyDTO> replyList = new ArrayList<>();

        SimpleDateFormat formatter = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT u.commentId commentId, u.contents contents, v.avatar userAvatar,"
                              + " v.name userName, u.isQuestion isQuestion, u.commentDatetime commentDatetime"
                              + " FROM tblComments u"
                              + " LEFT JOIN tblUsers v ON u.userId = v.id"
                              + " WHERE u.eventId = ? AND u.replyId IS NULL";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    commentId = rs.getInt("commentId");
                    contents= rs.getString("contents");
                    userAvatar = rs.getString("userAvatar");
                    userName = rs.getString("userName");
                    isQuestion = rs.getBoolean("isQuestion");
                    commentDatetime = rs.getTimestamp("commentDatetime");
                    String sql2 = "SELECT u.commentId commentId, u.contents contents, v.avatar userAvatar, v.name userName, u.commentDatetime replyDatetime" 
                                     + " FROM tblComments u" 
                                     + " LEFT JOIN tblUsers v ON u.userId = v.id" 
                                     + " WHERE eventId = ? AND replyId = ?;";
                    stm2 = conn.prepareStatement(sql2);
                    stm2.setInt(1, eventId);
                    stm2.setInt(2, commentId);
                    rs2 = stm2.executeQuery();
                    while(rs2.next()){
                         int replyCommentId = rs2.getInt("commentId");
                         String replyContents= rs2.getString("contents");
                         String replyUserAvatar = rs2.getString("userAvatar");
                         String replyUserName = rs2.getString("userName");
                         Date replyCommentDatetime = rs2.getTimestamp("replyDatetime");
                         replyList.add(new ReplyDTO(replyCommentId, replyContents, replyUserAvatar, replyUserName, replyCommentDatetime));
                    }
                    if(replyList.size()>0){
                        Collections.sort(replyList);
                    }
                    CommentDTO tmp = new CommentDTO(commentId, contents, eventId, userAvatar, userName, isQuestion, commentDatetime, replyList);
                    list.add(tmp);
                    System.out.println();
                    replyList = new ArrayList<>();
                }
                Collections.sort(list);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs2 != null) {
                rs2.close();
            }
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
        return list;
    }
}
