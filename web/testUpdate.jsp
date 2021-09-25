<%-- 
    Document   : testUpdate
    Created on : Sep 25, 2021, 12:23:43 AM
    Author     : triet
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Page</title>
    </head>
    <body>
        <p>Avatar: ${sessionScope.USER.avatar}</p>
        <p>email: ${sessionScope.USER.email}</p> 
        <p>Name: ${sessionScope.USER.name}</p>
        <p>Address: ${sessionScope.USER.address}</p> 
        <p>Phone Number: ${sessionScope.USER.phoneNum}</p> 
    </body>
</html>
