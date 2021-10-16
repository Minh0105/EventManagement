<%-- 
    Document   : admin
    Created on : Oct 16, 2021, 3:33:21 AM
    Author     : triet
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Event Management</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css"
              integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
<!--        <link rel="stylesheet" type="text/css" href="resources/css/admin.css"/>-->
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">Vertical Navbar</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto flex-column vertical-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="manageByAdmin?management=organizer">Organizer Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manageByAdmin?management=student">Student Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manageByAdmin?management=lecturer">Lecturer Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manageByAdmin?management=event">Event Management</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manageByAdmin?management=comment">Comment Management</a>
                    </li>
                </ul>
            </div>
        </nav>
        <c:if test="${requestScope.LIST_ORGANIZER ne null}">
        <div>

            <table border="1">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Email</th>
                        <th>Name</th>
                        <th>Avatar</th>
                        <th>Phone Number</th>
                        <th>Role Name</th>
                        <th>Status</th>
                        <th>Description</th>
                        <th>NumOfEvent</th>
                        <th>Deactivate</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER}" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${organizer.email}</td>
                            <td>${organizer.name}</td>
                            <td>...</td>
                            <td>${organizer.phoneNum}</td>
                            <td>${organizer.roleName}</td>
                            <td>${organizer.status}</td>
                            <td>${organizer.description}</td>
                            <td>${organizer.numOfEvent}</td>
                            <td>
                                <c:if test="${organizer.status eq 'Activated'}">
                                   <a href="#">Deactivate</a>
                                 </c:if>
                                <c:if test="${organizer.status eq 'Deactivated'}">
                                   <a href="#">Reactivate</a>
                                 </c:if>
                            </td>
                        </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
        </c:if>
        <c:if test="${requestScope.LIST_STUDENT ne null}">
        <div>

            <table border="1">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Email</th>
                        <th>Name</th>
                        <th>Avatar</th>
                        <th>Address</th>
                        <th>Phone Number</th>
                        <th>Role Name</th>
                        <th>Status</th>
                        <th>Deactivate</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="student" items="${requestScope.LIST_STUDENT}" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${student.email}</td>
                            <td>${student.name}</td>
                            <td>...</td>
                            <td>${student.address}
                            <td>${student.phoneNum}</td>
                            <td>${student.roleName}</td>
                            <td>${student.status}</td>
                            <td>
                                <c:if test="${student.status eq 'Activated'}">
                                   <a href="#">Deactivate</a>
                                 </c:if>
                                <c:if test="${student.status eq 'Deactivated'}">
                                   <a href="#">Reactivate</a>
                                 </c:if>
                            </td>
                        </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
        </c:if>
        <c:if test="${requestScope.LIST_LECTURER ne null}">
        <div>

            <table border="1">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Email</th>
                        <th>Name</th>
                        <th>Avatar</th>
                        <th>Address</th>
                        <th>Phone Number</th>
                        <th>Role Name</th>
                        <th>Status</th>
                        <th>Description</th>
                        <th>Deactivate</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="lecturer" items="${requestScope.LIST_LECTURER}" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${lecturer.email}</td>
                            <td>${lecturer.name}</td>
                            <td>...</td>
                            <td>${lecturer.address}
                            <td>${lecturer.phoneNum}</td>
                            <td>${lecturer.roleName}</td>
                            <td>${lecturer.status}</td>
                            <td>${lecturer.description}</td>
                            <td>
                                <c:if test="${lecturer.status eq 'Activated'}">
                                   <a href="#">Deactivate</a>
                                 </c:if>
                                <c:if test="${lecturer.status eq 'Deactivated'}">
                                   <a href="#">Reactivate</a>
                                 </c:if>
                            </td>
                        </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
        </c:if>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"
                integrity="sha384-W8fXfP3gkOKtndU4JGtKDvXbO53Wy8SZCQHczT5FMiiqmQfUpWbYdTil/SxwZgAN"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.min.js"
                integrity="sha384-skAcpIdS7UcVUC05LJ9Dxay8AXcDYfBJqt1CJ85S/CFujBsIzCIv+l9liuYLaMQ/"
        crossorigin="anonymous"></script>
    </body>
</html>
