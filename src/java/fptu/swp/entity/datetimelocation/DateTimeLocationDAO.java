/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.datetimelocation;

import fptu.swp.utils.DBHelper;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

import javax.naming.NamingException;

/**
 *
 * @author admin
 */
public class DateTimeLocationDAO implements Serializable{
    
    public Set<RangeDateDTO> getFreeSlotByFirstDateOfWeek(int locationId, Date firstDateOfWeek) throws NamingException, SQLException {
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Set<RangeDateDTO> listRangeDate;
        
        try {
            con = DBHelper.makeConnection();
            String sql = "select DATEPART(dw,[date]) as day , rangeId "
                        +"from tblDateTimeLocation "
                        +"where locationId = ? AND [date] between ? AND DATEADD(DAY,6, ?) ";
            ps = con.prepareStatement(sql);
            ps.setInt(1, locationId);
            ps.setString(2, firstDateOfWeek.toString());
            ps.setString(3, firstDateOfWeek.toString());
            rs = ps.executeQuery();
            RangeDateDTO rangeDate;
            listRangeDate = new HashSet();
            while (rs.next()) {
                // get from DB each ele
                int dayInWeek = rs.getInt("day");
                int rangeId = rs.getInt("rangeId");
                System.out.println("Busy Slot DB: " + dayInWeek + "-" + rangeId);
                // inject into DTO
                rangeDate = new RangeDateDTO(rangeId, dayInWeek);
                // add DTO ele to list
                listRangeDate.add(rangeDate);
            }
            
            return listRangeDate;
            
        } finally {
            if (con != null) {
                con.close();
            }
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        
    }
}
