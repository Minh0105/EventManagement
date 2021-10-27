<%-- 
    Document   : allEvent
    Created on : Oct 25, 2021, 12:40:27 PM
    Author     : triet
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tổng hợp sự kiện</title>
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
                <link rel="stylesheet" type="text/css" href="resources/css/allEvents.css"/>
                   <link rel="stylesheet" type="text/css" href="resources/css/nav_bar.css"/>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    </head>
    <body>
                <nav class="navbar navbar-expand-md navbar-light navbar-color sticky-top">
            <div id="nav_content" class="container-fluid">
                <a id="navbar_branch" href="#">
                    <img id="app_icon" src="resources/icon/app_icon.svg">
                    <h5 class="d-none d-md-block">FPT Event Management</h5>
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" 
                        data-target="#navbarResponsive">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto nav-margin">
                        <li class="nav-item">
                            <a id="icon_name_container" class="nav-link" href="ViewInfoPage"> 
                                <!-- <img class="nav-avatar rounded-circle" src="${sessionScope.USER.avatar}"> ${sessionScope.USER.name}</img></a> -->
                                <img id="avatar_icon" class="rounded-circle" src="${sessionScope.USER.avatar}" />
                                <span id="avatar_name" class="text-white">${sessionScope.USER.name}</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <img id="btn_bell" src="resources/icon/bell_icon.svg" alt="Bell_icon" />
                            </a>
                        </li>
                        <li class="nav-item dropdown">

                            <a class="nav-link" href="#" id="navbarDropdown " role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img id="btn_menu" src="resources/icon/hamburger_button_icon.svg" alt="hamburger_button" />
                            </a>     

                            <form action="logout" class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                                <button class="btn btn-outline-light profile-button logout " type="submit">
                                    <img src="resources/icon/log_out_icon.svg">Log Out</button> 
                            </form>   

                        </li>				
                    </ul>
                </div>
            </div>
                </nav><br>
            <div class="header4">
                       <section id="filter_bar">
            <div id="decorating_text">
                <h1>Chi Tiết Sự Kiện</h1>
            </div>

         
        </section>
               <div class="col-md-6 "><h3>Tìm event theo: </h3></div><br>

                <!--           ĐÃ LOAD LIST ALL ORGANIZER, Select o day là khi nguoi dùng ho chon option nào thì mình show LIST ORGANIZER-->
                <div class="col-md-6"><label class="labels">Kiểu nhà tổ chức:</label><select class="form-control" id="organizerType" onchange="organizerTypeHandler(this)" >
                    <option value="allOrganizer" selected='selected'>Tất cả</option> <!-- (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                    <option value="CL">Club's leader</option>
                    <option value="DM">Department's manager</option>
                </select>
                <form action ="filterEvent">
                    <div id="filter_organizer">
                      <label class="labels">Tên nhà tổ chức:</label><div id="organizer_name">
                                <!--           Neu chon "Tất cả" ở cái select trên  (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                                <select class="form-control" name="idOrganizer">
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
                        <div >
                           <label class="labels">Tình Trạng Sư Kiện:</label><select class="form-control" name="eventStatus" >
                                <option value="0">Tất cả</option>
                                <option value="1">Sắp diễn ra</option>
                                <option value="2">Đóng đăng kí</option>
                                <option value="3">Đã kết thúc</option>
                                <option value="4">Đã hủy</option>
                            </select>
                        </div><br>
                        <input type="submit" value="Search" class="btn btn-primary"/>
                    </div>
                </form>
                <div id="allOrganizer">
                    <!--           Neu chon "Tất cả" ở cái select trên  (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                    <select class="form-control" name="idOrganizer">
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
                    <select class="form-control" name="idOrganizer">
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
                    <select class="form-control" name="idOrganizer">
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
                </div></div><br>
                <div>
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
                </div>
            </div>
            <script>
                var organizerTypeSelect = document.getElementById("organizerType");
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
    </body>
</html>
