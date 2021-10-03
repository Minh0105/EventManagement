/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.event;

import java.util.List;

/**
 *
 * @author triet
 */
public class EventCardDTO {
    private int id;
    private String name;
    private String poster;
    private String location;
    private String date;
    private String organizerName;
    private int following;
    private int joining;

    public EventCardDTO() {
    }

    public EventCardDTO(int id, String name, String poster, String location, String date, String organizerName, int following, int joining) {
        this.id = id;
        this.name = name;
        this.poster = poster;
        this.location = location;
        this.date = date;
        this.organizerName = organizerName;
        this.following = following;
        this.joining = joining;
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

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getOrganizerName() {
        return organizerName;
    }

    public void setOrganizerName(String organizerName) {
        this.organizerName = organizerName;
    }

    public int getFollowing() {
        return following;
    }

    public void setFollowing(int following) {
        this.following = following;
    }

    public int getJoining() {
        return joining;
    }

    public void setJoining(int joining) {
        this.joining = joining;
    }

 
}
