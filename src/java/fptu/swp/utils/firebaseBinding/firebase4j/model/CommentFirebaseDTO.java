/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fptu.swp.utils.firebaseBinding.firebase4j.model;

import java.util.Map;

/**
 *
 * @author admin
 */
public class CommentFirebaseDTO {
    private String content;
    private int eventId;
    private Map<String, ReplyFirebaseDTO> replyList;
    private String statusId;
    private String userAvatar;
    private int userId;
    private String userName;
    private String userRoleName;

    public CommentFirebaseDTO() {
    }

    public CommentFirebaseDTO(String content, int eventId, Map<String, ReplyFirebaseDTO> replyList, String statusId, String userAvatar, int userId, String userName, String userRoleName) {
        this.content = content;
        this.eventId = eventId;
        this.replyList = replyList;
        this.statusId = statusId;
        this.userAvatar = userAvatar;
        this.userId = userId;
        this.userName = userName;
        this.userRoleName = userRoleName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public Map<String, ReplyFirebaseDTO> getReplyList() {
        return replyList;
    }

    public void setReplyList(Map<String, ReplyFirebaseDTO> replyList) {
        this.replyList = replyList;
    }

    public String getStatusId() {
        return statusId;
    }

    public void setStatusId(String statusId) {
        this.statusId = statusId;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserRoleName() {
        return userRoleName;
    }

    public void setUserRoleName(String userRoleName) {
        this.userRoleName = userRoleName;
    }

    @Override
    public String toString() {
        return "CommentFirebaseDTO{" +content + eventId + replyList + statusId + userAvatar + userId + userName + userRoleName + "}";
    }
    
    
    
}
