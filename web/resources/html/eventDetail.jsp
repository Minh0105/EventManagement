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
        <%= detail.getPoster() %>
        <%= detail.getDate() %> - <%= detail.getLocation() %>
        <%= detail.getName()%>
        <%= detail.getOrganizerName() %>
        <%= detail.getDescription() %>
        ______________________________________________________________
        
        <%
        for (LecturerBriefInfo lecturer : listLecturer){
            %>
        <%= lecturer.getAvatar() %>
        <%= lecturer.getName() %>
        <%= lecturer.getDescription() %>
        
       
        <%
        }
        %>
        
        
        _______________________________________________________________
        
        
        
        
        
        <%= detail.getOrganizerName() %>
        <%= detail.getOrganizerAvatar() %>
        <%= detail.getOrganizerDescription() %>
    </body>
</html>
