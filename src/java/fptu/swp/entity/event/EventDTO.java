/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.event;

import java.sql.Date;

/**
 *
 * @author admin
 */
public class EventDTO {
    private int id;
    private String name;
    private String description;
    private String poster;
    private String createDate;
    private int statusId;
    private int userId;
    private String postAfterEvent;
    private String imageAfterEvent;

    public EventDTO() {
    }

    public EventDTO(int id, String name, String description, String poster, String createDate, int statusId, int userId, String postAfterEvent, String imageAfterEvent) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.poster = poster;
        this.createDate = createDate;
        this.statusId = statusId;
        this.userId = userId;
        this.postAfterEvent = postAfterEvent;
        this.imageAfterEvent = imageAfterEvent;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPostAfterEvent() {
        return postAfterEvent;
    }

    public void setPostAfterEvent(String postAfterEvent) {
        this.postAfterEvent = postAfterEvent;
    }

    public String getImageAfterEvent() {
        return imageAfterEvent;
    }

    public void setImageAfterEvent(String imageAfterEvent) {
        this.imageAfterEvent = imageAfterEvent;
    }

    
}
