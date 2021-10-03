<%-- 
    Document   : eventDetail
    Created on : Oct 1, 2021, 5:47:27 PM
    Author     : triet
--%>

<%@page import="fptu.swp.entity.event.ReplyDTO"%>
<%@page import="fptu.swp.entity.event.CommentDTO"%>
<%@page import="fptu.swp.entity.user.LecturerBriefInfoDTO"%>
<%@page import="java.util.List"%>
<%@page import="fptu.swp.entity.event.EventDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detail Page</title>
    </head>
    <body>
        <%
        EventDetailDTO detail = (EventDetailDTO) request.getAttribute("EVENT_DETAIL");
        List<LecturerBriefInfoDTO> listLecturer = (List<LecturerBriefInfoDTO>) request.getAttribute("LIST_LECTURER");
        %>
        <br>        <img src="<%= detail.getPoster() %>" alt="">
        <br><%= detail.getDate() %> - <%= detail.getLocation() %>
        <br><%= detail.getName()%>
        <br><%= detail.getOrganizerName() %>
        <br><%= detail.getDescription() %>
       <br> ______________________________________________________________
       <br> <br>  GIẢNG VIÊN
        <%
        for (LecturerBriefInfoDTO lecturer : listLecturer){
            %>
          
       <br> <img src="<%= lecturer.getAvatar() %>" alt="">
       <br> <%= lecturer.getName() %>
       <br> <%= lecturer.getDescription() %>
       <br> 
       
        <%
        }
        %>
        
        
      <br>  _______________________________________________________________
       <br> 
        
        
        
        
       <br> <%= detail.getOrganizerName() %>
       <img src="<%= detail.getOrganizerAvatar() %>" alt=""> 
     <br>   <%= detail.getOrganizerDescription() %>
    </body>
    <br>  _______________________________________________________________
       <br> 
        <br>  _______________________________________________________________
       <br> 
        <br>  _______________________________________________________________
       <br> 
        <br>  _______________________________________________________________
       <br> 
        <%
            List<CommentDTO> listComment = (List<CommentDTO>) request.getAttribute("LIST_COMMENT");
            for (CommentDTO comment : listComment){
            %>
          
       <br> <img src="<%= comment.getUserAvatar() %>" alt="">
       <br> <%= comment.getUserName() %>
       <br> <%= comment.getContents()%>
       <br> <%= comment.getCommentDatetime()%>
       <%
           List<ReplyDTO> listReply = comment.getReplyList();
           for (ReplyDTO reply : listReply){
               %>
       
       <br> ----<img src="<%= reply.getUserAvatar() %>" alt="">
       <br> ----<%= reply.getUserName() %>
       <br> ----<%= reply.getContents()%>
       <br> ----<%= reply.getReplyDatetime()%>
       
       <%
                   
           }
       %>
       <br> 
       
        <%
        }
        %>
</html>
