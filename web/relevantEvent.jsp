<%-- 
    Document   : relevantEvent
    Created on : Nov 12, 2021, 2:14:37 PM
    Author     : triet
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <c:if test="${requestScope.LIST_EVENT ne null}">
        <div class="service">
            <table border="1">
                <thead>
                    <tr class="service1">
                        <th>No</th>
                        <th>Name</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Organizer Name</th>
                        <th>Following</th>
                        <th>Joining</th>
                        <th>Status</th>
                        <th>View detail</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="event" items="${requestScope.LIST_EVENT}" varStatus="status">
                    <tr class="service2">
                        <td>${status.count}</td>
                        <td>${event.name}</td>
                        <td>${event.location}</td>
                        <td>${event.date}</td>
                        <td>${event.time}</td>
                        <td>${event.organizerName}</td>
                        <td>${event.following}</td>
                        <td>${event.joining}</td>
                        <td>${event.statusId}</td>
                        <td><a href="viewEventDetail?eventId=${event.id}">Chi tiết</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
    </c:if>
</body>
</html>
