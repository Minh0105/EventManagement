/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.datetimelocation;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

/**
 *
 * @author admin
 */
public class RangeDateDTO implements Serializable {
    private int rangeId;
    private int dayOfWeek;

    public RangeDateDTO() {
    }

    public RangeDateDTO(int rangeId, int dayOfWeek) {
        this.rangeId = rangeId;
        this.dayOfWeek = dayOfWeek;
    }

    public int getRangeId() {
        return rangeId;
    }

    public void setRangeId(int rangeId) {
        this.rangeId = rangeId;
    }

    public int getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(int dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 41 * hash + this.rangeId;
        hash = 41 * hash + this.dayOfWeek;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final RangeDateDTO other = (RangeDateDTO) obj;
        if (this.rangeId != other.rangeId) {
            return false;
        }
        if (this.dayOfWeek != other.dayOfWeek) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "RangeDateDTO{" +  rangeId + "-" + dayOfWeek + '}';
    }

    
    
    
}
