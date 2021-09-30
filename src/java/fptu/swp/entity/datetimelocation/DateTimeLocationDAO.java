/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.datetimelocation;

import fptu.swp.utils.DBHelper;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author triet
 */
public class DateTimeLocationDAO {

    //Lay thoi gian va dia diem to chuc cua 1 event
    public List<DateTimeLocationDTO> getListDateTimeLocationByEventId(int eventId) throws SQLException {
        List<DateTimeLocationDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                String sql = "SELECT rangeId, locationId, date, statusId"
                        + " FROM tblDateTimeLocation"
                        + " WHERE eventId=?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, eventId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int rangeId = rs.getInt("rangeId");
                    int locationId = rs.getInt("locationId");
                    Date date = rs.getDate("date");
                    int statusId = rs.getInt("statusId");
                    String statusName = (statusId == 1) ? "Bị chiếm" : "Bị hủy";
                    list.add(new DateTimeLocationDTO(eventId, rangeId, locationId, date, statusName));
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

    public boolean insertDateTimeLocationOfAnEvent(List<DateTimeLocationDTO> list) throws SQLException {
        boolean check = true;
        Connection conn = null;
        PreparedStatement stm = null;

        try {
            conn = DBHelper.makeConnection();
            if (conn != null) {
                for (DateTimeLocationDTO dto : list) {
                    String sql = "INSERT INTO tblDateTimeLocation(eventId, rangeId, locationId, date, statusId)"
                            + " VALUES(?,?,?,?,1)";
                    stm = conn.prepareStatement(sql);
                    stm.setInt(1, dto.getEventId());
                    stm.setInt(2, dto.getRangeId());
                    stm.setInt(3, dto.getLocationId());
                    stm.setDate(4, new java.sql.Date(dto.getDate().getTime()));
                    check = stm.executeUpdate() > 0;
                    if (!check) {
                        break;
                    }
                }
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
}
