<%-- 
    Document   : upload.html
    Created on : Oct 3, 2021, 10:08:59 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="uploadFile" method="POST" enctype="multipart/form-data">
            <input type="file" accept=".png" name="photo" required="">
            <input type="submit" value="Submit" />
        </form>
    </body>
</html>
