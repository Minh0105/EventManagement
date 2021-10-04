<%-- 
    Document   : appendEventDetail
    Created on : Oct 3, 2021, 3:34:20 PM
    Author     : admin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            history.forward();
        </script>
    </head>
    <body>
        <h1>Session Scope - ChosenLocationList</h1>
        <c:forEach var="locationDTO" items="${sessionScope.ChosenLocationList}" >
            <p>Location Id: ${locationDTO.id} - Location Name: ${locationDTO.name}</p>
        </c:forEach>
        --------    
        <h1>Session Scope - ChosenDate</h1>
        <p>ChosenDate : ${sessionScope.ChosenDate}</p>
        --------
        <h1>Session Scope - ChosenTimeRange</h1>
        <p>ChosenTimeRange : ${sessionScope.ChosenTimeRange}</p>
        --------
        <h1>Session Scope - LecturerList</h1>
        <c:forEach var="lec" items="${sessionScope.LecturerList}" >
            <p>Lecturer Id: ${lec.id} - Name : ${lec.name} - avatar : ${lec.avatar} </p>
        </c:forEach>
    </body>
</html>
