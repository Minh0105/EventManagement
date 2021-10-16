/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.entity.event;

import java.util.Date;
import java.util.List;

/**
 *
 * @author triet
 */
public class CommentDTO implements Comparable<CommentDTO>{
    private int commentId;
    private String contents;
    private int eventId;
    private int userId;
    private String userAvatar;
    private String userName;
    private boolean isQuestion;
    private Date commentDatetime;
    private String userRoleName;
    private List<ReplyDTO> replyList;
    private String statusId;

    public CommentDTO() {
    }

    public CommentDTO(int commentId, String contents, int eventId, int userId, String userAvatar, String userName, boolean isQuestion, Date commentDatetime, String userRoleName, List<ReplyDTO> replyList) {
        this.commentId = commentId;
        this.contents = contents;
        this.eventId = eventId;
        this.userId = userId;
        this.userAvatar = userAvatar;
        this.userName = userName;
        this.isQuestion = isQuestion;
        this.commentDatetime = commentDatetime;
        this.userRoleName = userRoleName;
        this.replyList = replyList;
    }

    public CommentDTO(int commentId, String contents, int eventId, int userId, String userAvatar, String userName, boolean isQuestion, Date commentDatetime, String userRoleName, List<ReplyDTO> replyList, String statusId) {
        this.commentId = commentId;
        this.contents = contents;
        this.eventId = eventId;
        this.userId = userId;
        this.userAvatar = userAvatar;
        this.userName = userName;
        this.isQuestion = isQuestion;
        this.commentDatetime = commentDatetime;
        this.userRoleName = userRoleName;
        this.replyList = replyList;
        this.statusId = statusId;
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

    public boolean isIsQuestion() {
        return isQuestion;
    }

    public void setIsQuestion(boolean isQuestion) {
        this.isQuestion = isQuestion;
    }

    public Date getCommentDatetime() {
        return commentDatetime;
    }

    public void setCommentDatetime(Date commentDatetime) {
        this.commentDatetime = commentDatetime;
    }

    public List<ReplyDTO> getReplyList() {
        return replyList;
    }

    public void setReplyList(List<ReplyDTO> replyList) {
        this.replyList = replyList;
    }

    public String getUserRoleName() {
        return userRoleName;
    }

    public void setUserRoleName(String userRoleName) {
        this.userRoleName = userRoleName;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
    }

    @Override
    public int compareTo(CommentDTO t) {
            return - this.getCommentDatetime().compareTo(t.getCommentDatetime());
    }

    @Override
    public String toString() {
        return "CommentDTO{" + "commentId=" + commentId + ", contents=" + contents + ", eventId=" + eventId + ", userAvatar=" + userAvatar + ", userName=" + userName + ", isQuestion=" + isQuestion + ", commentDatetime=" + commentDatetime + ", replyList=" + replyList.toString() + '}';
    }
    
}
