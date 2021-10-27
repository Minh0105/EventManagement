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
        <link rel="profile" href="<c:url value='http://gmpg.org/xfn/11' />" />
        <script src="<c:url value='https://code.jquery.com/jquery-1.10.2.js' />"></script>
        <script src="<c:url value='https://cdn.firebase.com/v0/firebase.js' />"></script>
    </head>
    <body>
        <div>
                <table border="1">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Content</th>
                            <th>Event ID</th>
                            <th>userAvatar</th>
                            <th>userName</th>
                            <th>userRoleName</th>
                            <th>StatusID</th>
                            <th>Ban comment</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="comment" items="${requestScope.mapComment}" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${comment.value.content}</td>
                                <td>${comment.value.eventId}</td>
                                <td><img src="${comment.value.userAvatar}" /></td>
                                <td>${comment.value.userName}</td>
                                <td>${comment.value.userRoleName}</td>
                                <td>${comment.value.statusId}</td>
                                <td><button onclick="banComment(${comment.key})">Ban</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
        <script src="resources/js/comment.js" ></script>
        
        
        <script src="<c:url value="https://www.gstatic.com/firebasejs/7.2.0/firebase-app.js" />"></script>
        <script src="<c:url value="https://www.gstatic.com/firebasejs/7.2.0/firebase-database.js" />"></script>
        <script src="resources/js/function.js"></script>
        
    </body>
</html>
