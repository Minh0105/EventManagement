/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.schedule;

import fptu.swp.utils.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author triet
 */
public class ScheduleDAO {
    public List<ScheduleDTO> getListTimingNoti() throws SQLException, NamingException, ParseException{
        List<ScheduleDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy HH:mm");
         try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT u.eventId eventId, u.runningDate runningDate, v.detail rangeDetail, t.eventName, t.organizerAvatar\n" +
                                "FROM (SELECT eventId, MIN(rangeId) AS \"startSlot\", MIN(date) AS \"runningDate\"\n" +
                                "FROM tblDateTimeLocation \n" +
                                "WHERE statusId = 1\n" +
                                "GROUP BY eventId) u\n" +
                                "JOIN tblTimeRanges v ON u.startSlot = v.id\n" +
                                "JOIN (SELECT u.id eventId, u.name eventName, v.avatar organizerAvatar FROM tblEvents u JOIN tblUsers v ON u.userId = v.id AND (u.statusId = 1 OR u.statusId = 2)) t\n" +
                                "ON u.eventId = t.eventId";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int eventId = rs.getInt("eventId");
                    String runningDate = sdf.format(rs.getTimestamp("runningDate"));
                    String time = runningDate.substring(0,11) + rs.getString("rangeDetail").substring(0,5);
                    Date startTime = sdf.parse(time);
                    String eventName = rs.getString("eventName");
                    String organizerAvatar = rs.getString("organizerAvatar");
                    list.add(new ScheduleDTO(eventId,startTime,eventName,organizerAvatar));
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
    
    public List<ScheduleDTO> getListTimingFinish() throws SQLException, NamingException, ParseException{
        List<ScheduleDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy HH:mm");
         try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT u.eventId eventId, u.runningDate runningDate, v.detail rangeDetail, t.eventName, t.organizerAvatar\n" +
                                "FROM (SELECT eventId, MAX(rangeId) AS \"startSlot\", MIN(date) AS \"runningDate\"\n" +
                                "FROM tblDateTimeLocation \n" +
                                "WHERE statusId = 1\n" +
                                "GROUP BY eventId) u\n" +
                                "JOIN tblTimeRanges v ON u.startSlot = v.id\n" +
                                "JOIN (SELECT u.id eventId, u.name eventName, v.avatar organizerAvatar FROM tblEvents u JOIN tblUsers v ON u.userId = v.id AND (u.statusId = 1 OR u.statusId = 2)) t\n" +
                                "ON u.eventId = t.eventId";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int eventId = rs.getInt("eventId");
                    String runningDate = sdf.format(rs.getTimestamp("runningDate"));
                    String time = runningDate.substring(0,11) + rs.getString("rangeDetail").substring(8);
                    Date endTime = sdf.parse(time);
                    String eventName = rs.getString("eventName");
                    String organizerAvatar = rs.getString("organizerAvatar");
                    list.add(new ScheduleDTO(eventId,endTime,eventName,organizerAvatar));
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
}
