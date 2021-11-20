<%-- Document : admin Created on : Oct 16, 2021, 3:33:21 AM Author : triet --%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Event Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU"
              crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="resources/css/admin.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css"
              integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">

        </script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js">

        </script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
                integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
                crossorigin="anonymous">
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
                integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
                crossorigin="anonymous">
        </script>
        <link rel="stylesheet" href="resources/css/mybutton.css" >
    </head>

    <body>

        <%
            String authorized = (String) session.getAttribute("ACCESS_TOKEN");
            if (authorized == null || authorized.isEmpty()) {
                session.setAttribute("AUTHORIZING_SENDING_EMAIL", "false");
            }
        %>

        <%
            String action = request.getParameter("management");
            boolean organizerSelected = action.equals("organizer");
            boolean studentSelected = action.equals("student");
            boolean lecturerSelected = action.equals("lecturer");
            boolean eventSelected = action.equals("event");
            boolean commentSelected = action.equals("comment");
        %>

        <div class="header1" id="b">
            <div class="header3">
                <div id="big_title">
                    <h4 class="text-center"> FPT Event Management </h4>
                </div>

                <!-- MENU  -->
                <ul id="side_bar_menu">

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (organizerSelected) {%> selected<%}%>" href="manageByAdmin?management=organizer">Câu lạc bộ, phòng ban</a>
                    </li>

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (eventSelected) {%> selected<%}%>" href="manageByAdmin?management=event">Sự kiện</a>
                    </li>

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (studentSelected) {%> selected<%}%>" href="manageByAdmin?management=student">Sinh viên</a>
                    </li>

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (lecturerSelected) {%> selected<%}%>" href="manageByAdmin?management=lecturer">Giảng viên</a>
                    </li>

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (commentSelected) {%> selected<%}%>" href="manageByAdmin?management=comment">Bình luận</a>
                    </li>

                    <a id="btn_logout" href="logout">Đăng xuất</a>
                </ul>
                <div class="wrapper">

                    <div class="navbar-toggle" id="a">
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div class="header4">
        <c:if test="${requestScope.LIST_ORGANIZER ne null}">
            <div class="top_title d-flex justify-content-between align-items-center">
                <h3 class="right_title">Quản lí câu lạc bộ, phòng ban</h3>
                <button type="button" class="mybutton btn-orange" data-toggle="modal"
                        data-target="#exampleModal">
                    Tạo tài khoản mới
                </button>
            </div> 

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
                 aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Tạo tài khoản</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="col-md-12 ">
                                <form action="manageUserByAdmin" method="POST">
                                    <label class="labels">Loại tài khoản</label>
                                    <select class="form-control" name="roleId">
                                        <option value="3">Chủ nhiệm câu lạc bộ</option>
                                        <option value="4">Trưởng phòng quản lý </option>

                                    </select>
                                    <input type="hidden" name="action" value="Create" />
                                    <div class="">
                                        <label class="labels">Email</label>
                                        <input
                                            class="form-control" type="email" name="email" required />
                                        <!--pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"-->
                                    </div>
                                    <div class="">
                                        <label class="labels">Tên</label>
                                        <input
                                            class="form-control" type="text" name="name" required />
                                    </div>
                                    <br>
                                    <div class="text-right"> <button type="submit"
                                                                     class="btn btn-primary">Tạo tài khoản mới</button> </div>
                                </form>
                            </div>

                        </div>

                    </div>
                </div>
            </div>

            <div class="service">
                <span>${requestScope.NOTIFICATION}</span>
                <table class="table table-bordered text-center">
                    <thead class="thead-light">
                        <tr class="service1">
                            <th>STT</th>
                            <th>Email</th>
                            <th>Tên</th>
                            <th>SĐT</th>
                            <th>Chức vụ</th>
                            <th>Tr. thái</th>
                            <th>SLSK</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER}"
                                   varStatus="status">
                            <tr class="service2">
                                <td><p>${status.count}</p></td>
                                <td><p>${organizer.email}</p></td>
                                <td><p>${organizer.name}</p></td>
                                <td><p>${organizer.phoneNum}</p></td>
                                <td><p>${organizer.roleName}</p></td>
                                <td>
                                    <c:if test="${organizer.status eq 'Activated'}">
                                        <!-- 3.svg -->
                                        <div class="rec_green"></div>
                                    </c:if>
                                    <c:if test="${organizer.status eq 'Deactivated'}">
                                        <!-- 4.svg -->
                                        <div class="rec_red"></div>
                                    </c:if>
                                </td>
                                <td><p>${organizer.numOfEvent}</p></td>
                                <td class="button_td">
                                    <form action="manageUserByAdmin" method="POST">
                                        <input type="hidden" name="userId" value="${organizer.id}" />
                                        <c:if test="${organizer.status eq 'Activated'}">
                                            <c:if test="${sessionScope.AUTHORIZING_SENDING_EMAIL eq 'false'}">
                                                <button type="submit" class="deac_button" formaction="authorizeSendingEmail">
                                                    Deactivate
                                                </button>
                                            </c:if>
                                            <c:if test="${sessionScope.AUTHORIZING_SENDING_EMAIL eq 'true'}">
                                                <button type="button" class="deac_button" data-toggle="modal"
                                                        data-target="#exampleModal${organizer.id}">
                                                    Deactivate
                                                </button>
                                                <div class="modal fade" id="exampleModal${organizer.id}" tabindex="-1" role="dialog"
                                                     aria-labelledby="exampleModalLabel" aria-hidden="true">     

                                                    <div class="modal-dialog" role="document">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title" id="exampleModalLabel">Nội dung của việc khóa tài khoản</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">                                                        


                                                                <div class="col-md-12 ">                                                                                
                                                                    <div class="">
                                                                        <input type="hidden" name="userId" value="${organizer.id}" />


                                                                        </select>
                                                                        <label class="labels">Nội Dung</label>

                                                                        <input
                                                                            class="form-control" type="text" name="reason" required />                                                             
                                                                    </div>
                                                                    <br>
                                                                    <div class="text-right"><input type="submit" name="action" value="Deactivate" /> </div>

                                                                </div>

                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                            </c:if>


                                        </c:if>
                                        <c:if test="${organizer.status eq 'Deactivated'}">
                                            <input type="submit" name="action" value="Activate" />
                                        </c:if>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${requestScope.LIST_STUDENT ne null}">
                <div class="top_title">
                    <h3 class="right_title">Student Management</h3>
                </div>
                <div class="service">
                    <table class="table table-bordered text-center">
                        <thead class="thead-light">
                            <tr class="service1">
                                <th>STT</th>
                                <th>Email</th>
                                <th>Tên</th>
                                <th>Địa chỉ</th>
                                <th>SĐT</th>
                                <th>Tr. thái</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${requestScope.LIST_STUDENT}" varStatus="status">
                                <tr class="service2">
                                    <td><p>${status.count}</p></td>
                                    <td><p>${student.email}</p></td>
                                    <td><p>${student.name}</p></td>
                                    <td><p>${student.address}</p></td>
                                    <td><p>${student.phoneNum}</p></td>
                                    <td>
                                        <c:if test="${student.status eq 'Activated'}">
                                            <!-- 3.svg -->
                                            <div class="rec_green"></div>
                                        </c:if>
                                        <c:if test="${student.status eq 'Deactivated'}">
                                            <!-- 4.svg -->
                                            <div class="rec_red"></div>
                                        </c:if>
                                    </td>
                                    <td class="button_td">
                                        <form action="manageUserByAdmin" method="POST">
                                            <input type="hidden" name="userId" value="${student.id}" />
                                            <c:if test="${student.status eq 'Activated'}">
                                                <c:if test="${sessionScope.AUTHORIZING_SENDING_EMAIL eq 'false'}">
                                                    <button type="submit" class="deac_button" formaction="authorizeSendingEmail">
                                                        Deactivate
                                                    </button>
                                                </c:if>
                                                <c:if test="${sessionScope.AUTHORIZING_SENDING_EMAIL eq 'true'}">
                                                    <button type="button" class="deac_button" data-toggle="modal"
                                                            data-target="#exampleModal${student.id}">
                                                        Deactivate
                                                    </button>

                                                    <div class="modal fade" id="exampleModal${student.id}" tabindex="-1" role="dialog"
                                                         aria-labelledby="exampleModalLabel" aria-hidden="true">     

                                                        <div class="modal-dialog" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel">Nội dung của việc khóa tài khoản</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">                                                        


                                                                    <div class="col-md-12 ">                                                                                
                                                                        <div class="">
                                                                            <input type="hidden" name="userId" value="${student.id}" />


                                                                            </select>
                                                                            <label class="labels">Nội Dung</label>

                                                                            <input
                                                                                class="form-control" type="text" name="reason" required />                                                             
                                                                        </div>
                                                                        <br>
                                                                        <div class="text-right"><input type="submit" name="action" value="Deactivate" /> </div>

                                                                    </div>

                                                                </div>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </c:if>


                                            </c:if>
                                            <c:if test="${student.status eq 'Deactivated'}">
                                                <input type="submit" name="action" value="Activate" />
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
                <div class="top_title d-flex justify-content-between align-items-center">
                    <h3 class="right_title">Quản lí giảng viên</h3>
                    <button type="button" class="mybutton btn-orange" data-toggle="modal" data-target="#exampleModal">
                        Tạo tài khoản mới
                    </button>
                </div>

                <!-- Modal -->
                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
                     aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Tạo tài khoản</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="manageUserByAdmin" method="POST">

                                    <input type="hidden" name="roleId" value="2" />
                                    <input type="hidden" name="action" value="Create" />
                                    <div class="col-md-12">
                                        <label class="labels">Email</label>
                                        <input
                                            class="form-control" type="email" name="email" required />
                                        <!--pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"-->
                                    </div>
                                    <div class="col-md-12">
                                        <label class="labels">Name</label>
                                        <input
                                            class="form-control" type="text" name="name" required />
                                        <br>
                                    </div>
                                    <div class="col-md-12 text-right">
                                        <button type="submit"
                                                class="btn btn-primary">Thêm tài khoản giảng viên</button>
                                    </div>
                                </form> <br>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="service">
                    <table class="table table-bordered text-center">
                        <thead class="thead-light">
                            <tr class="service1">
                                <th>No</th>
                                <th>Email</th>
                                <th>Tên</th>
                                <th>Địa chỉ</th>
                                <th>SĐT</th>
                                <th>Tr. thái</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="lecturer" items="${requestScope.LIST_LECTURER}" varStatus="status">
                                <tr class="service2">
                                    <td><p>${status.count}</p></td>
                                    <td><p>${lecturer.email}</p></td>
                                    <td><p>${lecturer.name}</p></td>
                                    <td><p>${lecturer.address}</p></td>
                                    <td><p>${lecturer.phoneNum}</p></td>
                                    <td>
                                        <c:if test="${lecturer.status eq 'Activated'}">
                                            <!-- 3.svg -->
                                            <div class="rec_green"></div>
                                        </c:if>
                                        <c:if test="${lecturer.status eq 'Deactivated'}">
                                            <!-- 4.svg -->
                                            <div class="rec_red"></div>
                                        </c:if>
                                    </td>
                                    <td class="button_td">
                                        <form action="manageUserByAdmin" method="POST">
                                            <input type="hidden" name="userId" value="${lecturer.id}" />
                                            <c:if test="${lecturer.status eq 'Activated'}">
                                                <c:if test="${sessionScope.AUTHORIZING_SENDING_EMAIL eq 'false'}">
                                                    <button type="submit" class="deac_button" formaction="authorizeSendingEmail">
                                                        Deactivate
                                                    </button>
                                                </c:if>
                                                <c:if test="${sessionScope.AUTHORIZING_SENDING_EMAIL eq 'true'}">
                                                    <button type="button" class="deac_button" data-toggle="modal"
                                                            data-target="#exampleModal${lecturer.id}">
                                                        Deactivate
                                                    </button>

                                                    <div class="modal fade" id="exampleModal${lecturer.id}" tabindex="-1" role="dialog"
                                                         aria-labelledby="exampleModalLabel" aria-hidden="true">     

                                                        <div class="modal-dialog" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="exampleModalLabel">Nội dung của việc khóa tài khoản</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">                                                        


                                                                    <div class="col-md-12 ">                                                                                
                                                                        <div class="">
                                                                            <input type="hidden" name="userId" value="${lecturer.id}" />



                                                                            <label class="labels">Nội Dung</label>

                                                                            <input
                                                                                class="form-control" type="text" name="reason" required />                                                             
                                                                        </div>
                                                                        <br>
                                                                        <div class="text-right"><input type="submit" name="action" value="Deactivate" /> </div>

                                                                    </div>

                                                                </div>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </c:if>


                                            </c:if>
                                            <c:if test="${lecturer.status eq 'Deactivated'}">
                                                <input type="submit" name="action" value="Activate" />
                                            </c:if>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                </div>
            </c:if>

            <!--quản lý bình luận-->
            <c:if test="${requestScope.mapComment ne null}">
                <div class="top_title">
                    <h3 class="right_title">Quản lí bình luận</h3>
                </div>
                <div class="service">
                    <table class="table table-bordered text-center">
                        <thead class="thead-light">
                            <tr>
                                <th>SST</th>
                                <th>Nội dung</th>
                                <th>Sự kiện</th>
                                <th>Tên</th>
                                <th>Chức vụ</th>
                                <th>Tr. thái</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="comment" items="${requestScope.mapComment}" varStatus="status">
                                <tr>
                                    <td><p>${status.count}</p></td>
                                    <td><p>${comment.value.content}</p></td>
                                    <td><a href="viewEventDetail?eventId=${comment.value.eventId}"><p>Xem</p></a></td>
                                    <td><p>${comment.value.userName}</p></td>
                                    <td><p>${comment.value.userRoleName}</p></td>
                                    <c:if test="${comment.value.statusId eq 'AC'}">
                                        <!-- 3.svg -->
                                        <td><div class="rec_green"></div></td>

                                        <td class="button_td">
                                              <button type="button" class="deac_button" data-toggle="modal"
                                                                data-target="#exampleModalBanComment">
                                                            Ban
                                                        </button>

                                                        <div class="modal fade" id="exampleModalBanComment" tabindex="-1" role="dialog"
                                                             aria-labelledby="exampleModalLabel" aria-hidden="true">     

                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="exampleModalLabel">Ban Comment</h5>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">                                                        


                                                                        <div class="col-md-12 ">                                                                                
                                                                            <div class="">                                                                       
                                                                                    <label class="labels">Nội Dung</label>
                                                                                    <input
                                                                                        class="form-control" type="text" required />                                                             
                                                                            </div>
                                                                            <br>
                                                                            <div class="text-right"> <button onclick="banComment('${comment.key}')">Ban</button> </div>
                                                                            </form>
                                                                        </div>

                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>
                                      
                                        </td>
                                    </c:if>
                                    <c:if test="${comment.value.statusId eq 'DA'}">
                                        <!-- 4.svg -->
                                        <td><div class="rec_red"></div></td>
                                        <td class="button_td" style="visibility: hidden;">
                                            <button>___</button>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <!--quản lý sự kiện-->
            <c:if test="${requestScope.LIST_ORGANIZER_EVENT ne null}">
                <div class="top_title">
                    <h3 class="right_title">Quản lí sự kiện</h3>
                </div>
                <div>
                    <div class="col-md-6 ">
                        <h5 style="font-weight: 400">Tìm event theo: </h5>
                    </div>
                    <!-- ĐÃ LOAD LIST ALL ORGANIZER, Select o day là khi nguoi dùng ho chon option nào thì mình show LIST ORGANIZER-->

                    <form action="filterEvent">
                        <div class="col-md-6">
                            <label class="labels">Chức vụ</label>
                            <select class="form-control" name="organizerType" id="organizerType"
                                    onchange="organizerTypeHandler(this)">
                                <option value="allOrganizer">Tất cả</option>
                                <!-- (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                                <option value="CL">Club's leader</option>
                                <option value="DM">Department's manager</option>
                            </select>
                        </div>
                        <br>
                        <script>
                            var items = document.getElementById("organizerType").options;
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].value == "${param.organizerType}") {
                                    items[i].selected = true;
                                }
                            }
                        </script>

                        <div id="filter_organizer">

                            <div id="organizer_name">
                                <!--           Neu chon "Tất cả" ở cái select trên  (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                                <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label>
                                    <select
                                        class="form-control" name="idOrganizer">
                                        <option value="0">Tất cả</option>
                                        <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER_EVENT}">
                                            <c:if test="${param.idOrganizer eq organizer.id}">
                                                <option value="${organizer.id}" selected>${organizer.name}
                                                </option>
                                            </c:if>
                                            <c:if test="${param.idOrganizer ne organizer.id}">
                                                <option value="${organizer.id}">${organizer.name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <br>

                            <div class="row mx-0">
                                <div class="col-md-6"> <label class="labels">Tình trạng sự kiện:</label> <select
                                        class="form-control" name="eventStatus" id="eventStatus">
                                        <option value="0">Tất cả</option>
                                        <option value="1">Sắp diễn ra</option>
                                        <option value="2">Đóng đăng kí</option>
                                        <option value="3">Đã kết thúc</option>
                                        <option value="4">Đã hủy</option>
                                    </select>
                                </div>
                                <script>
                                    var items = document.getElementById("eventStatus").options;
                                    for (var i = 0; i < items.length; i++) {
                                        if (items[i].value == "${param.eventStatus}") {
                                            items[i].selected = true;
                                        }
                                    }
                                </script>
                                <div class="col-md-4 ml-2 d-flex align-items-end">
                                    <input type="submit" style="height: fit-content" value="Tìm kiếm" class="mybutton btn-orange" />
                                </div>
                            </div>
                        </div>
                    </form>
                    <br>
                    <div id="allOrganizer">
                        <!--           Neu chon "Tất cả" ở cái select trên  (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                        <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label>
                            <select
                                class="form-control" name="idOrganizer">
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
                    </div>
                    <!-- Nếu chọn "Club's leader" ở cái select trên-->
                    <div id="CL">
                        <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label>
                            <select
                                class="form-control" name="idOrganizer">
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
                    </div>

                    <!--           Nếu chọn "Department's manager" ở cái select trên-->
                    <div id="DM">
                        <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label>
                            <select
                                class="form-control" name="idOrganizer">
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
                    </div>
                    <div>
                        <c:if test="${requestScope.LIST_EVENT ne null}">
                            <div class="service" style="overflow-x:scroll; margin-top: 1.5rem">
                                <table class="table table-bordered text-center">
                                    <thead class="thead-light">
                                        <tr class="service1">
                                            <th>No</th>
                                            <th>Tên</th>
                                            <th>Địa điểm</th>
                                            <th>Ngày</th>
                                            <th>Giờ</th>
                                            <th>Người tổ chức</th>
                                            <th>Qu. tâm</th>
                                            <th>Th. gia</th>
                                            <th>Tr. thái</th>
                                            <th>Cancel</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="event" items="${requestScope.LIST_EVENT}"
                                                   varStatus="status">
                                            <tr class="service2">
                                                <td><p>${status.count}</p></td>
                                                <td>
                                                    <a href="viewEventDetail?eventId=${event.id}">
                                                        ${event.name}
                                                    </a>
                                                </td>
                                                <td><p>${event.location}</p></td>
                                                <td><p>${event.date}</p></td>
                                                <td><p>${event.time}</p></td>
                                                <td><p>${event.organizerName}</p></td>
                                                <td><p>${event.following}</p></td>
                                                <td><p>${event.joining}</p></td>
                                                <td><p>${event.statusId}</p></td>
                                                <td>
                                                    <c:if test="${event.statusId == 1 || event.statusId == 2}">
                                                        <button type="button" class="deac_button" data-toggle="modal"
                                                                data-target="#exampleModal${event.id}">
                                                            Cancel
                                                        </button>

                                                        <div class="modal fade" id="exampleModal${event.id}" tabindex="-1" role="dialog"
                                                             aria-labelledby="exampleModalLabel" aria-hidden="true">     

                                                            <div class="modal-dialog" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="exampleModalLabel">Cancel Event</h5>
                                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                            <span aria-hidden="true">&times;</span>
                                                                        </button>
                                                                    </div>
                                                                    <div class="modal-body">                                                        


                                                                        <div class="col-md-12 ">                                                                                
                                                                            <div class="">
                                                                                <form action="cancelEvent" method="POST">
                                                                                    <input type="hidden" name="eventId"
                                                                                           value="${event.id}" />
                                                                                    <input type="hidden" name="organizerType"
                                                                                           value="${param.organizerType}" />
                                                                                    <input type="hidden" name="eventStatus"
                                                                                           value="${param.eventStatus}" />
                                                                                    <input type="hidden" name="idOrganizer"
                                                                                           value="${param.idOrganizer}" />
                                                                                    <label class="labels">Nội Dung</label>
                                                                                    <input
                                                                                        class="form-control" type="text" required />                                                             
                                                                            </div>
                                                                            <br>
                                                                            <div class="text-right"><input 
                                                                                    type="submit" name="action" value="Confirm" /> </div>
                                                                            </form>
                                                                        </div>

                                                                    </div>

                                                                </div>
                                                            </div>

                                                        </div>

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

        <script src="<c:url value=" https://www.gstatic.com/firebasejs/7.2.0/firebase-app.js" />">
        </script>
        <script src="<c:url value=" https://www.gstatic.com/firebasejs/7.2.0/firebase-database.js" />">
        </script>
        <script src="resources/js/configFirebase.js">
        </script>
        <script src="resources/js/comment.js">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.min.js"
                integrity="sha384-skAcpIdS7UcVUC05LJ9Dxay8AXcDYfBJqt1CJ85S/CFujBsIzCIv+l9liuYLaMQ/"
                crossorigin="anonymous">
        </script>
</body>

</html>

