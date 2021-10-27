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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <!--                <link rel="stylesheet" type="text/css" href="resources/css/admin.css"/>-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
            _________________________Thêm Club's Leader_____________________________
            <form action="manageUserByAdmin" method="POST">
                <input type="hidden" name="roleId" value="3"/>
                <input type="hidden" name="action" value="Create"/>
                <p>Email: <input type="email" name="email" required/> <!--pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"-->
                    <br></p> 
                <p>Name: <input type="text" name="name"required/><br></p>
                <button type="submit" class="btn btn-primary">Thêm CL</button>
            </form>
            _________________________Thêm Department's Manager_____________________________
            <form action="manageUserByAdmin" method="POST">
                <input type="hidden" name="roleId" value="4"/>
                <input type="hidden" name="action" value="Create"/>
                <p>Email: <input type="email" name="email" required/> <!--pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"-->
                    <br></p> 
                <p>Name: <input type="text" name="name"required/><br></p>
                <button type="submit" class="btn btn-primary">Thêm DM</button>
            </form>
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
                                    <form action="manageUserByAdmin" method="POST">
                                        <input type="hidden" name="userId" value="${organizer.id}"/>
                                        <c:if test="${organizer.status eq 'Activated'}">
                                            <input type="submit" name="action" value="Deactivate"/>
                                        </c:if>
                                        <c:if test="${organizer.status eq 'Deactivated'}">
                                            <input type="submit" name="action" value="Reactivate"/>
                                        </c:if>
                                    </form>
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
                                    <form action="manageUserByAdmin" method="POST">
                                        <input type="hidden" name="userId" value="${student.id}"/>
                                        <c:if test="${student.status eq 'Activated'}">
                                            <input type="submit" name="action" value="Deactivate"/>
                                        </c:if>
                                        <c:if test="${student.status eq 'Deactivated'}">
                                            <input type="submit" name="action" value="Reactivate"/>
                                        </c:if>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
        </c:if>
        <c:if test="${requestScope.LIST_LECTURER ne null}">
            <form action="manageUserByAdmin" method="POST">
                <input type="hidden" name="roleId" value="2"/>
                <input type="hidden" name="action" value="Create"/>
                <p>Email: <input type="email" name="email" required/> <!--pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"-->
                    <br></p> 
                <p>Name: <input type="text" name="name" required/><br></p>
                <button type="submit" class="btn btn-primary">Thêm</button>
            </form>
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
                                <td>${lecturer.address}</td>
                                <td>${lecturer.phoneNum}</td>
                                <td>${lecturer.roleName}</td>
                                <td>${lecturer.status}</td>
                                <td>${lecturer.description}</td>
                                <td>
                                    <form action="manageUserByAdmin" method="POST">
                                        <input type="hidden" name="userId" value="${lecturer.id}"/>
                                        <c:if test="${lecturer.status eq 'Activated'}">
                                            <input type="submit" name="action" value="Deactivate"/>
                                        </c:if>
                                        <c:if test="${lecturer.status eq 'Deactivated'}">
                                            <input type="submit" name="action" value="Reactivate"/>
                                        </c:if>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
        </c:if>
        <c:if test="${requestScope.LIST_ORGANIZER_EVENT ne null}">
            <div>
                Tìm event theo: <br>
                ${param.organizerType}
                ${param.eventStatus}
                <!--           ĐÃ LOAD LIST ALL ORGANIZER, Select o day là khi nguoi dùng ho chon option nào thì mình show LIST ORGANIZER-->
                Kiểu nhà tổ chức: 
                <form action ="filterEvent">
                    <select name="organizerType" id="organizerType" onchange="organizerTypeHandler(this)" >
                        <option value="allOrganizer">Tất cả</option> <!-- (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                        <option value="CL">Club's leader</option>
                        <option value="DM">Department's manager</option>
                    </select>
                    <script>
                        var items = document.getElementById("organizerType").options;
                        for (var i = 0; i < items.length; i++) {
                                    if (items[i].value == "${param.organizerType}") {
                                        items[i].selected = true;
                                    }
                                }
                    </script>

                    <div id="filter_organizer">
                        Tên nhà tổ chức:
                        <div id="organizer_name">
                            <!--           Neu chon "Tất cả" ở cái select trên  (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                            <select name="idOrganizer">
                                <option value="0">Tất cả</option>
                                <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER_EVENT}">
                                    <c:if test="${param.idOrganizer eq organizer.id}">
                                        <option value="${organizer.id}" selected>${organizer.name}</option>
                                    </c:if>
                                    <c:if test="${param.idOrganizer ne organizer.id}">
                                        <option value="${organizer.id}">${organizer.name}</option>
                                    </c:if>
                                </c:forEach>  
                            </select>

                        </div>
                        <div>
                            Tình trạng sự kiện: <select name="eventStatus" id="eventStatus">
                                <option value="0">Tất cả</option>
                                <option value="1">Sắp diễn ra</option>
                                <option value="2">Đóng đăng kí</option>
                                <option value="3">Đã kết thúc</option>
                                <option value="4">Đã hủy</option>
                            </select>
                            <script>
                                var items = document.getElementById("eventStatus").options;
                                for (var i = 0; i < items.length; i++) {
                                    if (items[i].value == "${param.eventStatus}") {
                                        items[i].selected = true;
                                    }
                                }
                            </script>
                        </div>
                        <input type="submit" value="filter"/>
                    </div>
                </form>
                <div id="allOrganizer">
                    <!--           Neu chon "Tất cả" ở cái select trên  (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                    <select name="idOrganizer">
                        <option value="0">Tất cả</option>
                        <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER_EVENT}">
                            <c:if test="${param.idOrganizer eq organizer.id}">
                                <option value="${organizer.id}" selected>${organizer.name}</option>
                            </c:if>
                            <c:if test="${param.idOrganizer ne organizer.id}">
                                <option value="${organizer.id}">${organizer.name}</option>
                            </c:if>
                        </c:forEach>  
                    </select>
                </div>
                <!--           Nếu chọn "Club's leader" ở cái select trên-->
                <div id="CL">
                    <select name="idOrganizer">
                        <option value="-1">Tất cả</option>
                        <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER_EVENT}">
                            <c:if test="${organizer.roleName eq 'CL'}">
                                <c:if test="${param.idOrganizer eq organizer.id}">
                                    <option value="${organizer.id}" selected>${organizer.name}</option>
                                </c:if>
                                <c:if test="${param.idOrganizer ne organizer.id}">
                                    <option value="${organizer.id}">${organizer.name}</option>
                                </c:if>
                            </c:if>
                        </c:forEach>  
                    </select>
                </div>

                <!--           Nếu chọn "Department's manager" ở cái select trên-->
                <div id="DM">
                    <select name="idOrganizer">
                        <option value="-2">Tất cả</option>
                        <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER_EVENT}">
                            <c:if test="${organizer.roleName eq 'DM'}">
                                <c:if test="${param.idOrganizer eq organizer.id}">
                                    <option value="${organizer.id}" selected>${organizer.name}</option>
                                </c:if>
                                <c:if test="${param.idOrganizer ne organizer.id}">
                                    <option value="${organizer.id}">${organizer.name}</option>
                                </c:if>
                            </c:if>
                        </c:forEach>  
                    </select>
                </div>
                <div>
                    <c:if test="${requestScope.LIST_EVENT ne null}">
                        <div>
                            <table border="1">
                                <thead>
                                    <tr>
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
                                        <th>Cancel</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="event" items="${requestScope.LIST_EVENT}" varStatus="status">
                                        <tr>
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
                                            <td>
                                                <c:if test="${event.statusId == 1 || event.statusId == 2}">
                                                    <form action="cancelEvent" method="POST">
                                                        <input type="hidden" name="eventId" value="${event.id}"/>
                                                        <input type="hidden" name="organizerType" value="$${param.organizerType}"/>
                                                        <input type="hidden" name="eventStatus" value="${param.eventStatus}"/>
                                                        <input type="hidden" name="idOrganizer" value="${param.idOrganizer}"/>
                                                        <input type="submit" name="action" value="Cancel"/>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </c:if>
                </div>
            </div>
            <script>
                var organizerTypeSelect = document.getElementById("organizerType");
                var eventStatusSelect = document.getElementById("eventStatus");

                document.getElementById("allOrganizer").style.display = "none";
                document.getElementById("CL").style.display = "none";
                document.getElementById("DM").style.display = "none";
                function organizerTypeHandler(organizerTypeSelect) {
                    document.getElementById("organizer_name").innerHTML = "";
                    var organizerType = organizerTypeSelect.value;
                    var allOrganizer = document.getElementById("allOrganizer").innerHTML;
                    var CL = document.getElementById("CL").innerHTML;
                    var DM = document.getElementById("DM").innerHTML;
                    if (organizerType == 'allOrganizer') {
                        document.getElementById("organizer_name").innerHTML = allOrganizer;
                    } else if (organizerType == 'CL') {
                        document.getElementById("organizer_name").innerHTML = CL;
                    } else if (organizerType == 'DM') {
                        document.getElementById("organizer_name").innerHTML = DM;
                    }
                }
            </script>
        </c:if>
        <c:if test="${requestScope.mapComment ne null}">
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
                                <td><img src="${comment.value.userAvatar}"></td>
                                <td>${comment.value.userName}</td>
                                <td>${comment.value.userRoleName}</td>
                                <td>${comment.value.statusId}</td>
                                <td><button onclick="banComment('${comment.key}')" >Ban</button></td>
                            </tr>
                            <c:if test="${comment.value.replyList ne null}" >
                                <c:forEach var="reply" items="${comment.value.replyList}" varStatus="stt">
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                    <tr>
                                        <td>${stt.count}</td>
                                        <td>${reply.value.content}</td>
                                        <td>${reply.value.eventId}</td>
                                        <td><img src="${reply.value.userAvatar}"></td>
                                        <td>${reply.value.userName}</td>
                                        <td>${reply.value.userRoleName}</td>
                                        <td>${reply.value.statusId}</td>
                                        <td><button onclick="banReply('${comment.key}' , '${reply.key}')" >Ban</button></td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>

            </div>
            
        </c:if>
        <script src="<c:url value="https://www.gstatic.com/firebasejs/7.2.0/firebase-app.js" />"></script>
        <script src="<c:url value="https://www.gstatic.com/firebasejs/7.2.0/firebase-database.js" />"></script>
        <script src="resources/js/comment.js" ></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.min.js"
                integrity="sha384-skAcpIdS7UcVUC05LJ9Dxay8AXcDYfBJqt1CJ85S/CFujBsIzCIv+l9liuYLaMQ/"
        crossorigin="anonymous"></script>
    </body>
</html>
