<%-- 
    Document   : reviewEvent
    Created on : Oct 6, 2021, 12:53:55 AM
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
            EventDetailDTO detail = (EventDetailDTO) request.getAttribute("EVENT_DETAIL_REVIEW");
            List<LecturerBriefInfoDTO> listLecturer = (List<LecturerBriefInfoDTO>) request.getAttribute("LIST_LECTURER");
            
        %>
        <img id="ItemPreview" src="data:image/jpg;base64,<%= detail.getPoster() %>">
<!--        <script>document.getElementById("ItemPreview").src = "<c:url value='data:image/png;base64,<%= detail.getPoster() %>'/>" ;</script>-->
        
        
        <br><%= detail.getDate()%> - <%= detail.getLocation()%>
        <br><%= detail.getName()%>
        <br><%= detail.getOrganizerName()%>
        <br><%= detail.getDescription()%>
        <br> ______________________________________________________________
        <br> <br>  GIẢNG VIÊN
        <%
            for (LecturerBriefInfoDTO lecturer : listLecturer) {
        %>
        <br> <img src="<%= lecturer.getAvatar()%>" alt="">
        <br> <%= lecturer.getName()%>
        <br> <%= lecturer.getDescription()%>
        <br> 
        <%
            }
        %>
      <br>  _______________________________________________________________
        <br> 
        <br> <%= detail.getOrganizerName()%>
        <img src="<%= detail.getOrganizerAvatar()%>" alt=""> 
        <br>   <%= detail.getOrganizerDescription()%>
    </body>
    <br>  _______________________________________________________________
    <br> 
    <br>  _______________________________________________________________
    <br> 
    <br>  _______________________________________________________________
    <br> 
    <br>  _______________________________________________________________
    <br> 

</html>

