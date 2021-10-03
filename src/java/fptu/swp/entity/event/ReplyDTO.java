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
    private String userAvatar;
    private String userName;
    private Date replyDatetime;

    public ReplyDTO() {
    }

    public ReplyDTO(int id, String contents, String userAvatar, String userName, Date replyDatetime) {
        this.id = id;
        this.contents = contents;
        this.userAvatar = userAvatar;
        this.userName = userName;
        this.replyDatetime = replyDatetime;
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

    @Override
    public int compareTo(ReplyDTO t) {
        return this.getReplyDatetime().compareTo(t.getReplyDatetime());
    }

    @Override
    public String toString() {
        return "ReplyDTO{" + "id=" + id + ", contents=" + contents + ", userAvatar=" + userAvatar + ", userName=" + userName + ", replyDatetime=" + replyDatetime + '}';
    }
}
