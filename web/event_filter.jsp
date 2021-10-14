<%-- 
    Document   : event_filter
    Created on : Oct 14, 2021, 5:21:43 PM
    Author     : triet
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="filterEvent">
            <select name="status">
                <option value="0">Tất cả</option>
                <option value="1">Sắp diễn ra</option>
                <option value="2">Đang diễn ra</option>
                <option value="4">Đã kết thúc</option>
                <option value="3">Đã hủy</option>
            </select>
            <select name="isJoiningOrFollowing">
                <option value="0">Tất cả</option>
                <option value="1">Đã đăng kí</option>
                <option value="2">Đã quan tâm</option>
            </select>
            <input type="submit" value="Xem danh sách sự kiện"/>
        </form>
    </body>
</html>
