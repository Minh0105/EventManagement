<%-- 
    Document   : firebase
    Created on : Oct 8, 2021, 4:47:14 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="<c:url value='//code.jquery.com/jquery-1.10.2.js' />"></script>
        <script src="<c:url value='https://cdn.firebase.com/v0/firebase.js' />"></script>
    </head>
    <body>
        <h1>JSON</h1>
        <form action="addNotification">
            ID <input type="text" name="notificationID" id="notificationId" value="" />
            EventID <input type="text" name="eventId" id="eventId" value="" />
            StudentID <input type="text" name="studentId" id="studentId" value="" />
            Title <input type="text" name="title" id="title" value="" />
            <input type="submit" value="save" name="Action" />
            <input type="submit" value="update" name="Action" />
        </form>
        
        <h2>${requestScope.res}</h2>
        
        <div id="messages">
	
        </div>
        <script>
            
            
        </script>

    </body>
    <script src="<c:url value='resources/js/function.js' />"></script>
</html>
