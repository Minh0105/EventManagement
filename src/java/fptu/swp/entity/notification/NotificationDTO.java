/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.notification;

import java.io.Serializable;

/**
 *
 * @author admin
 */
public class NotificationDTO implements Serializable{
    private int id;
    private String title;
    private int eventId;
    private int userId;

    public NotificationDTO(int id, String title, int eventId, int userId) {
        this.id = id;
        this.title = title;
        this.eventId = eventId;
        this.userId = userId;
    }

    public NotificationDTO() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "NotificationDTO{" + "id=" + id + ", title=" + title + ", eventId=" + eventId + ", userId=" + userId + '}';
    }
    
}
