<%-- 
    Document   : infor.jsp
    Created on : Sep 24, 2021, 3:23:29 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Index</h1>
        <p>email: ${sessionScope.USER.email}</p>
        <p>name: ${sessionScope.USER.name}</p>
        <p>phonenum: ${sessionScope.USER.phoneNum}</p>       
        <img src="${sessionScope.USER.avatar}">
        
        <p>test: ${sessionScope.USER.roleName}</p> 
        <form action="logout">
            <input type ="submit" name="action" value="Logout">
        </form>
    </body>
</html>
