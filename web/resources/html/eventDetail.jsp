<%-- 
    Document   : eventDetail
    Created on : Oct 1, 2021, 5:47:27 PM
    Author     : triet
--%>

<%@page import="fptu.swp.entity.user.LecturerBriefInfo"%>
<%@page import="java.util.List"%>
<%@page import="fptu.swp.entity.event.EventDetail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detail Page</title>
    </head>
    <body>
        <%
        EventDetail detail = (EventDetail) request.getAttribute("EVENT_DETAIL");
        List<LecturerBriefInfo> listLecturer = (List<LecturerBriefInfo>) request.getAttribute("LIST_LECTURER");
        %>
        <br>        <img src="<%= detail.getPoster() %>" alt="">
        <br><%= detail.getDate() %> - <%= detail.getLocation() %>
        <br><%= detail.getName()%>
        <br><%= detail.getOrganizerName() %>
        <br><%= detail.getDescription() %>
       <br> ______________________________________________________________
       <br> <br>  GIẢNG VIÊN
        <%
        for (LecturerBriefInfo lecturer : listLecturer){
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
</html>
