/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.location;

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
public class LocationDAO {

    public List<LocationDTO> getLocationByName(String txtSearch) {
        List<LocationDTO> listDto = new ArrayList<>();
        LocationDTO dto;
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "select id, name "
                            +"from tblLocations "
                            +"where name LIKE ?";
                
                ps = con.prepareStatement(sql);
                ps.setString(1, "%" + txtSearch + "%");
                
                rs = ps.executeQuery();
                while (rs.next()) {
                    dto = new LocationDTO(rs.getInt(1), rs.getString(2));
                    listDto.add(dto);
                }
                
                return listDto;
            }
  
        } catch (NamingException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return null;
    }
    
}
