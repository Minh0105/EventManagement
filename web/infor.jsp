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
        <p>id: ${requestScope.id}</p>
        <p>name: ${requestScope.name}</p>
        <p>email: ${requestScope.email}</p>       
        <img src="${requestScope.icon}">
    </body>
</html>
