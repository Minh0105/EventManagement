/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.event;

import fptu.swp.utils.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author triet
 */
public class EventDAO {

    public boolean insertNewEvent(EventDTO event) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "INSERT INTO tblEvents(name, description, poster, createDate, statusId, userId) "
                        + " VALUES(?,?,?,CURRENT_TIMESTAMP,1,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, event.getName());
                stm.setString(2, event.getDescription());
                stm.setString(3, event.getPoster());
                stm.setInt(4, event.getUserId());
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

//    public List<EventCard> getCreatedEventListByOrganizerId(int userId) throws SQLException {
//        List<EventCard> list = new ArrayList<>();
//        Connection conn = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        int eventId = 0;
//        int currentEventId = 0;
//        String eventName = "";
//        String eventPoster = "";
//        String organizerName = "";
//        String date = "";
//        String locationName = "";
//        int following = 0;
//        int joining = 0;
//        List<String> listLocation = new ArrayList<>();
//        try {
//            conn = DBHelper.makeConnection();
//            if (conn != null) {
//                String sql
//                        = "SELECT s.id eventId, s.name eventName, s.poster eventPoster, m.name organizerName, t.date date, t.name locationName, s.numberOfFollowers, s.numberOfParticipants"
//                        + " FROM tblEvents s"
//                        + " LEFT JOIN tblUsers m ON s.userId = m.id"
//                        + " LEFT JOIN ( SELECT DISTINCT eventId, date, u.name FROM tblDateTimeLocation"
//                        + "                  LEFT JOIN tblLocations u ON locationId = u.id) t ON s.id = t.eventId"
//                        + " WHERE s.userId = ?";
//                stm = conn.prepareStatement(sql);
//                stm.setInt(1, userId);
//                rs = stm.executeQuery();
//                while (rs.next()) {
//                    eventId = rs.getInt("eventId");
//                    if (currentEventId != eventId) {
//                        if (currentEventId != 0) {
//                            list.add(new EventCard(currentEventId, eventName, eventPoster, listLocation, date, organizerName, following, joining));
//                        }
//                        listLocation.clear();
//                        currentEventId = eventId;
//                        eventName = rs.getString("eventName");
//                        eventPoster = rs.getString("eventPoster");
//                        organizerName = rs.getString("organizerName");
//                        date = rs.getTimestamp("date").toString();
//                        locationName = rs.getString("locationName");
//                        following = rs.getInt("following");
//                        joining = rs.getInt("joining");
//                        listLocation.add(locationName);
//                        
//                    } else {
//                        locationName = rs.getString("locationName");
//                        listLocation.add(locationName);
//                    }
//                }
//                list.add(new EventCard(eventId, eventName, eventPoster, listLocation, date, organizerName, following, joining));
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (rs != null) {
//                rs.close();
//            }
//            if (stm != null) {
//                stm.close();
//            }
//            if (conn != null) {
//                conn.close();
//            }
//        }
//        return list;
//    }
//
//    public List<EventCard> getFollowedEventList(int studentId) throws SQLException {
//        List<EventCard> list = new ArrayList<>();
//        Connection conn = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        int eventId = 0;
//        int currentEventId = 0;
//        String eventName = "";
//        String eventPoster = "";
//        String organizerName = "";
//        String date = "";
//        String locationName = "";
//        int following = 0;
//        int joining = 0;
//        List<String> listLocation = new ArrayList<>();
//        try {
//            conn = DBHelper.makeConnection();
//            if (conn != null) {
//                String sql
//                        = "SELECT s.id eventId, s.name eventName, s.poster eventPoster, m.name organizerName, t.date date, t.name locationName, s.numberOfFollowers, s.numberOfParticipants"
//                        + " FROM tblEvents s"
//                        + " LEFT JOIN tblUsers m ON s.userId = m.id"
//                        + " LEFT JOIN ( SELECT DISTINCT eventId, date, u.name FROM tblDateTimeLocation"
//                        + "                  LEFT JOIN tblLocations u ON locationId = u.id) t ON s.id = t.eventId"
//                        + " WHERE s.id IN (SELECT eventId FROM tblStudentsInEvents WHERE studentId= ? AND isFollowing = 1)";
//                stm = conn.prepareStatement(sql);
//                stm.setInt(1, studentId);
//                rs = stm.executeQuery();
//                while (rs.next()) {
//                    eventId = rs.getInt("eventId");
//                    if (currentEventId != eventId) {
//                        if (currentEventId != 0) {
//                            list.add(new EventCard(currentEventId, eventName, eventPoster, listLocation, date, organizerName, following, joining));
//                        }
//                        listLocation.clear();
//                        currentEventId = eventId;
//                        eventName = rs.getString("eventName");
//                        eventPoster = rs.getString("eventPoster");
//                        organizerName = rs.getString("organizerName");
//                        date = rs.getTimestamp("date").toString();
//                        locationName = rs.getString("locationName");
//                        following = rs.getInt("numbersOfFollowers");
//                        joining = rs.getInt("numberOfParticipants");
//                        listLocation.add(locationName);
//                    } else {
//                        locationName = rs.getString("locationName");
//                        listLocation.add(locationName);
//                    }
//                }
//                list.add(new EventCard(eventId, eventName, eventPoster, listLocation, date, organizerName, following, joining));
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (rs != null) {
//                rs.close();
//            }
//            if (stm != null) {
//                stm.close();
//            }
//            if (conn != null) {
//                conn.close();
//            }
//        }
//        return list;
//    }
//    
//    public List<EventCard> getJoiningEventList(int studentId) throws SQLException {
//        List<EventCard> list = new ArrayList<>();
//        Connection conn = null;
//        PreparedStatement stm = null;
//        ResultSet rs = null;
//        int eventId = 0;
//        int currentEventId = 0;
//        String eventName = "";
//        String eventPoster = "";
//        String organizerName = "";
//        String date = "";
//        String locationName = "";
//        int following = 0;
//        int joining = 0;
//        List<String> listLocation = new ArrayList<>();
//        try {
//            conn = DBHelper.makeConnection();
//            if (conn != null) {
//                String sql
//                        = "SELECT s.id eventId, s.name eventName, s.poster eventPoster, m.name organizerName, t.date date, t.name locationName, s.numberOfFollowers, s.numberOfParticipants"
//                        + " FROM tblEvents s"
//                        + " LEFT JOIN tblUsers m ON s.userId = m.id"
//                        + " LEFT JOIN ( SELECT DISTINCT eventId, date, u.name FROM tblDateTimeLocation"
//                        + "                  LEFT JOIN tblLocations u ON locationId = u.id) t ON s.id = t.eventId"
//                        + " WHERE s.id IN (SELECT eventId FROM tblStudentsInEvents WHERE studentId= ? AND isJoining = 1)";
//                stm = conn.prepareStatement(sql);
//                stm.setInt(1, studentId);
//                rs = stm.executeQuery();
//                while (rs.next()) {
//                    eventId = rs.getInt("eventId");
//                    if (currentEventId != eventId) {
//                        if (currentEventId != 0) {
//                            list.add(new EventCard(currentEventId, eventName, eventPoster, listLocation, date, organizerName, following, joining));
//                        }
//                        listLocation.clear();
//                        currentEventId = eventId;
//                        eventName = rs.getString("eventName");
//                        eventPoster = rs.getString("eventPoster");
//                        organizerName = rs.getString("organizerName");
//                        date = rs.getTimestamp("date").toString();
//                        locationName = rs.getString("locationName");
//                        following = rs.getInt("numbersOfFollowers");
//                        joining = rs.getInt("numberOfParticipants");
//                        listLocation.add(locationName);
//                    } else {
//                        locationName = rs.getString("locationName");
//                        listLocation.add(locationName);
//                    }
//                }
//                list.add(new EventCard(eventId, eventName, eventPoster, listLocation, date, organizerName, following, joining));
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (rs != null) {
//                rs.close();
//            }
//            if (stm != null) {
//                stm.close();
//            }
//            if (conn != null) {
//                conn.close();
//            }
//        }
//        return list;
//    }
    
    public List<EventCard> getNewFeedEventList() throws SQLException {
        List<EventCard> list = new ArrayList<>();
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
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql
                        = "SELECT s.id eventId, s.name eventName, s.poster eventPoster, m.name organizerName, t.date date, t.name locationName, s.numberOfFollowers followers, s.numberOfParticipants participants"
                        + " FROM tblEvents s"
                        + " LEFT JOIN tblUsers m ON s.userId = m.id"
                        + " LEFT JOIN ( SELECT DISTINCT eventId, date, u.name FROM tblDateTimeLocation"
                        + "                  LEFT JOIN tblLocations u ON locationId = u.id) t ON s.id = t.eventId"
                        + " WHERE s.statusId = 1";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    eventId = rs.getInt("eventId");
                    if (currentEventId != eventId) {
                        if (currentEventId != 0) {
                            int i = 0;
                            String location = "";
                            for(i = 0 ; i < listLocation.size() - 1 ; i ++){
                                location += listLocation.get(i) + ", "; 
                            }
                            location += listLocation.get(i); 
                            EventCard card = new EventCard(currentEventId, eventName, eventPoster, location, date, organizerName, following, joining);
                            list.add(card); 
                        }
                        listLocation.clear();
                        currentEventId = eventId;
                        eventName = rs.getString("eventName");
                        eventPoster = rs.getString("eventPoster");
                        organizerName = rs.getString("organizerName");
                        date = formatter.format(rs.getTimestamp("date")).toString();
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
                for(i = 0 ; i < listLocation.size() - 1 ; i ++){
                    location += listLocation.get(i) + ", "; 
                }
                location += listLocation.get(i); 
                EventCard card = new EventCard(currentEventId, eventName, eventPoster, location, date, organizerName, following, joining);
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

}
