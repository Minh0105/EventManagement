/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.event;

/**
 *
 * @author triet
 */
public class EventDetail {
    private int id;
    private String name;
    private String poster;
    private String location;
    private String date;
    private String time;
    private String organizerName;
    private int following;
    private int joining;
    private String description;
    private String organizerDescription;
    private String organizerAvatar;

    public EventDetail() {
    }

    public EventDetail(int id, String name, String poster, String location, String date, String time, String organizerName, int following, int joining, String description, String organizerDescription, String organizerAvatar) {
        this.id = id;
        this.name = name;
        this.poster = poster;
        this.location = location;
        this.date = date;
        this.time = time;
        this.organizerName = organizerName;
        this.following = following;
        this.joining = joining;
        this.description = description;
        this.organizerDescription = organizerDescription;
        this.organizerAvatar = organizerAvatar;
    }
    
    public EventDetail(String organizerAvatar) {
        this.organizerAvatar = organizerAvatar;
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

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getOrganizerDescription() {
        return organizerDescription;
    }

    public void setOrganizerDescription(String organizerDescription) {
        this.organizerDescription = organizerDescription;
    }

    public String getOrganizerAvatar() {
        return organizerAvatar;
    }

    public void setOrganizerAvatar(String organizerAvatar) {
        this.organizerAvatar = organizerAvatar;
    }
}
