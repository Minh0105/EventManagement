/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.location;

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
public class LocationDAO implements Serializable{

    public List<LocationDTO> getLocationByName(String txtSearch) throws NamingException, SQLException {
        List<LocationDTO> listDto = new ArrayList<>();
        LocationDTO dto;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "select id, name "
                        + "from tblLocations "
                        + "where name LIKE ?";

                ps = con.prepareStatement(sql);
                ps.setNString(1, "%" + txtSearch + "%");

                rs = ps.executeQuery();
                while (rs.next()) {
                    dto = new LocationDTO(rs.getInt(1), rs.getString(2));
                    listDto.add(dto);
                }

                return listDto;
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

    public List<LocationDTO> getListLocationIdName(List<Integer> listLocationId) throws NamingException, SQLException {
        List<LocationDTO> listDto = new ArrayList<>();
        LocationDTO dto;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "select id, name "
                        + "from tblLocations "
                        + "where id = ? ";

                ps = con.prepareStatement(sql);
                for (int locationId : listLocationId) {
                    ps.setInt(1, locationId);

                    rs = ps.executeQuery();

                    dto = new LocationDTO(rs.getInt(1), rs.getString(2));
                    listDto.add(dto);
                }

                return listDto;
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
