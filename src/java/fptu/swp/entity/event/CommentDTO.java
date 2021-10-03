/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.event;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author triet
 */
public class CommentDTO implements Comparable<CommentDTO>{
    private int commentId;
    private String contents;
    private int eventId;
    private String userAvatar;
    private String userName;
    private boolean isQuestion;
    private String commentDatetime;
    private List<ReplyDTO> replyList;

    public CommentDTO() {
    }

    public CommentDTO(int commentId, String contents, int eventId, String userAvatar, String userName, boolean isQuestion, String commentDatetime, List<ReplyDTO> replyList) {
        this.commentId = commentId;
        this.contents = contents;
        this.eventId = eventId;
        this.userAvatar = userAvatar;
        this.userName = userName;
        this.isQuestion = isQuestion;
        this.commentDatetime = commentDatetime;
        this.replyList = replyList;
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

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public boolean isIsQuestion() {
        return isQuestion;
    }

    public void setIsQuestion(boolean isQuestion) {
        this.isQuestion = isQuestion;
    }

    public String getCommentDatetime() {
        return commentDatetime;
    }

    public void setCommentDatetime(String commentDatetime) {
        this.commentDatetime = commentDatetime;
    }

    public List<ReplyDTO> getReplyList() {
        return replyList;
    }

    public void setReplyList(List<ReplyDTO> replyList) {
        this.replyList = replyList;
    }

    @Override
    public int compareTo(CommentDTO t) {
       try {
            Date date1 = new SimpleDateFormat("yyyy/MM/dd h:m").parse(this.getCommentDatetime());
            Date date2 = new SimpleDateFormat("yyyy/MM/dd h:m").parse(t.getCommentDatetime());        
            return date1.compareTo(date2);
        } catch (ParseException ex) {
            Logger.getLogger(ReplyDTO.class.getName()).log(Level.SEVERE, null, ex);
        }
       return 0;
    }
}
