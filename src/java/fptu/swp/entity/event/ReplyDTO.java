/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.event;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author triet
 */
public class ReplyDTO implements Comparable<ReplyDTO>{
    private int id;
    private String contents;
    private int commentId;
    private String userAvatar;
    private String userName;
    private String replyDatetime;

    public ReplyDTO() {
    }

    public ReplyDTO(int id, String contents, int commentId, String userAvatar, String userName, String replyDatetime) {
        this.id = id;
        this.contents = contents;
        this.commentId = commentId;
        this.userAvatar = userAvatar;
        this.userName = userName;
        this.replyDatetime = replyDatetime;
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

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public String getReplyDatetime() {
        return replyDatetime;
    }

    public void setReplyDatetime(String replyDatetime) {
        this.replyDatetime = replyDatetime;
    }

    @Override
    public int compareTo(ReplyDTO t) {
        try {
            Date date1 = new SimpleDateFormat("yyyy/MM/dd h:m").parse(this.getReplyDatetime());
            Date date2 = new SimpleDateFormat("yyyy/MM/dd h:m").parse(t.getReplyDatetime());        
            return date1.compareTo(date2);
        } catch (ParseException ex) {
            Logger.getLogger(ReplyDTO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
