/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.event;

import java.util.Date;

/**
 *
 * @author triet
 */
public class ReplyDTO implements Comparable<ReplyDTO>{
    private int id;
    private String contents;
    private int userId;
    private String userAvatar;
    private String userName;
    private String userRoleName;
    private Date replyDatetime;
    private String statusId;

    public ReplyDTO() {
    }

    public ReplyDTO(int id, String contents, int userId, String userAvatar, String userName, String userRoleName, Date replyDatetime) {
        this.id = id;
        this.contents = contents;
        this.userId = userId;
        this.userAvatar = userAvatar;
        this.userName = userName;
        this.userRoleName = userRoleName;
        this.replyDatetime = replyDatetime;
    }

    public ReplyDTO(int id, String contents, int userId, String userAvatar, String userName, String userRoleName, Date replyDatetime, String statusId) {
        this.id = id;
        this.contents = contents;
        this.userId = userId;
        this.userAvatar = userAvatar;
        this.userName = userName;
        this.userRoleName = userRoleName;
        this.replyDatetime = replyDatetime;
        this.statusId = statusId;
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Date getReplyDatetime() {
        return replyDatetime;
    }

    public void setReplyDatetime(Date replyDatetime) {
        this.replyDatetime = replyDatetime;
    }

    public String getUserRoleName() {
        return userRoleName;
    }

    public void setUserRoleName(String userRoleName) {
        this.userRoleName = userRoleName;
    }

    @Override
    public int compareTo(ReplyDTO t) {
        return this.getReplyDatetime().compareTo(t.getReplyDatetime());
    }

    @Override
    public String toString() {
        return "ReplyDTO{" + "id=" + id + ", contents=" + contents + ", userAvatar=" + userAvatar + ", userName=" + userName + ", replyDatetime=" + replyDatetime + '}';
    }
}
