/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.range;

/**
 *
 * @author admin
 */
public class RangeDTO {
    private int id;
    private String rangeName;
    private String detail;

    public RangeDTO() {
    }

    public RangeDTO(int id, String rangeName, String detail) {
        this.id = id;
        this.rangeName = rangeName;
        this.detail = detail;
    }

    public RangeDTO(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRangeName() {
        return rangeName;
    }

    public void setRangeName(String rangeName) {
        this.rangeName = rangeName;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }
    
    
}
