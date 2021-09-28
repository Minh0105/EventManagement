/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.user;

import java.io.Serializable;

/**
 *
 * @author admin
 */

    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author triet
 */
public class LecturerBriefInfoDTO implements Serializable{
    private int id;
    private String avatar;
    private String name;
    private String description;

    public LecturerBriefInfoDTO() {
    }

    public LecturerBriefInfoDTO(int id, String avatar, String name, String description) {
        this.id = id;
        this.avatar = avatar;
        this.name = name;
    }

    public LecturerBriefInfoDTO(int id, String avatar, String name) {
        this.id = id;
        this.avatar = avatar;
        this.name = name;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
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
    
    

    @Override
    public String toString() {
        return "LecturerBriefInfoDTO{" +  id + ", " + avatar + ", " + name + '}';
    }
    
    
    
}
