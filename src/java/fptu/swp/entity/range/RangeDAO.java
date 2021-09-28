/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.range;

import fptu.swp.utils.DBHelper;
import java.io.Serializable;
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
public class RangeDAO implements Serializable {
    
    public List<String>  getAllDetailSlot() throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<String> details;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "select detail "
                            +"from tblTimeRanges ";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                details = new ArrayList<>();
                while(rs.next()) {
                    details.add(rs.getString(1));
                }
                
                return details;
            }
        } finally {
            if (con != null) {
                con.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        
        return null;
    }
    
    public String getDetailSlotById(int id) throws NamingException, SQLException {
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String detail = null;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "select detail "
                            +"from tblTimeRanges "
                            +"where id = ? ";
                ps = con.prepareStatement(sql);
                ps.setInt(1, id);
                
                rs = ps.executeQuery();
                
                if (rs.next()) detail = rs.getString("detail");
                
                return detail;
            }
        } finally {
            if (con != null) {
                con.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        
        return null;
        
    }
    
}
