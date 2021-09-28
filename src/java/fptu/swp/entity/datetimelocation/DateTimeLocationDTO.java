/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.datetimelocation;

import java.io.Serializable;
import java.util.Date;


/**
 *
 * @author admin
 */
public class DateTimeLocationDTO implements Serializable {
    private int eventId;
    private int rangeId;
    private int locationId;
    private Date date;
    private String statusName;

    public DateTimeLocationDTO() {
    }

    public DateTimeLocationDTO(int locationId, Date date) {
        this.locationId = locationId;
        this.date = date;
    }
    
    public DateTimeLocationDTO(int eventId, int rangeId, int locationId, Date date, String statusName) {
        this.eventId = eventId;
        this.rangeId = rangeId;
        this.locationId = locationId;
        this.date = date;
        this.statusName = statusName;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getRangeId() {
        return rangeId;
    }

    public void setRangeId(int rangeId) {
        this.rangeId = rangeId;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }
    
    
    
}
