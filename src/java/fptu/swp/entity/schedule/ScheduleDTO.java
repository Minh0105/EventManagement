/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.schedule;

import java.util.Date;

/**
 *
 * @author triet
 */
public class ScheduleDTO {
    private int eventId;
    private Date runningTime;
    private String eventName;
    private String organizerAvatar;

    public ScheduleDTO() {
    }

    public ScheduleDTO(int eventId, Date runningTime, String eventName, String organizerAvatar) {
        this.eventId = eventId;
        this.runningTime = runningTime;
        this.eventName = eventName;
        this.organizerAvatar = organizerAvatar;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public Date getRunningTime() {
        return runningTime;
    }

    public void setRunningTime(Date runningTime) {
        this.runningTime = runningTime;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getOrganizerAvatar() {
        return organizerAvatar;
    }

    public void setOrganizerAvatar(String organizerAvatar) {
        this.organizerAvatar = organizerAvatar;
    }

    @Override
    public String toString() {
        return "ScheduleDTO{" + "eventId=" + eventId + ", runningTime=" + runningTime + ", eventName=" + eventName + ", organizerAvatar=" + organizerAvatar + '}';
    }
}
