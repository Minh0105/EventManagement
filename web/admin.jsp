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
            boolean questionSelected = action.equals("question");
        %>

        <script>
            <c:if test="${not empty requestScope.NOTIFICATION}">
                window.alert("${requestScope.NOTIFICATION}");
            </c:if>
        </script>

        <div class="header1" id="b">
            <div class="header3">
                <div id="big_title">
                    <h4 class="text-center"> FPT Event Management </h4>
                </div>

                <!-- MENU  -->
                <ul id="side_bar_menu">

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (organizerSelected) {%> selected<%}%>" href="manageByAdmin?management=organizer">C??u l???c b???, ph??ng ban</a>
                    </li>

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (eventSelected) {%> selected<%}%>" href="manageByAdmin?management=event">S??? ki???n</a>
                    </li>

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (studentSelected) {%> selected<%}%>" href="manageByAdmin?management=student">Sinh vi??n</a>
                    </li>

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (lecturerSelected) {%> selected<%}%>" href="manageByAdmin?management=lecturer">Gi???ng vi??n</a>
                    </li>

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (commentSelected) {%> selected<%}%>" href="manageByAdmin?management=comment">B??nh lu???n</a>
                    </li>

                    <li class="nav-item side_bar_option">
                        <a class="nav-link <%if (questionSelected) {%> selected<%}%>" href="manageByAdmin?management=question">H???i ????p</a>
                    </li>

                    <a id="btn_logout" href="logout">????ng xu???t</a>
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
                <h3 class="right_title">Qu???n l?? c??u l???c b???, ph??ng ban</h3>
                <button type="button" class="mybutton btn-orange" data-toggle="modal"
                        data-target="#exampleModal">
                    T???o t??i kho???n m???i
                </button>
            </div> 

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
                 aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">T???o t??i kho???n</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="col-md-12 ">
                                <form action="manageUserByAdmin" method="POST">
                                    <label class="labels">Lo???i t??i kho???n</label>
                                    <select class="form-control" name="roleId">
                                        <option value="3">Ch??? nhi???m c??u l???c b???</option>
                                        <option value="4">Tr?????ng ph??ng qu???n l?? </option>

                                    </select>
                                    <input type="hidden" name="action" value="Create" />
                                    <div class="mt-3">
                                        <label class="labels">Email</label>
                                        <input
                                            class="form-control" type="email" name="email" required />
                                        <!--pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"-->
                                    </div>
                                    <div class="mt-3">
                                        <label class="labels">T??n</label>
                                        <input
                                            class="form-control" type="text" name="name" required />
                                    </div>
                                    <br>
                                    <div class="text-right mb-3"> <button type="submit"
                                                                     class="mybutton btn-blue">T???o t??i kho???n m???i</button> </div>
                                </form>
                            </div>

                        </div>

                    </div>
                </div>
            </div>


            <div class="service">
                <table class="table table-bordered text-center">
                    <thead class="thead-light">
                        <tr class="service1">
                            <th>STT</th>
                            <th>Email</th>
                            <th>T??n</th>
                            <th>S??T</th>
                            <th>Ch???c v???</th>
                            <th>Tr. th??i</th>
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
                                                                <h5 class="modal-title" id="exampleModalLabel">N???i dung c???a vi???c kh??a t??i kho???n</h5>
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                    <span aria-hidden="true">&times;</span>
                                                                </button>
                                                            </div>
                                                            <div class="modal-body">                                                        


                                                                <div class="col-md-12 ">                                                                                
                                                                    <div class="">
                                                                        <input type="hidden" name="userId" value="${organizer.id}" />


                                                                        </select>
                                                                        <div class="text-left"> <label class="labels">N???i Dung</label></div>

                                                                        <textarea
                                                                            rows="5"   class="form-control" type="text" name="reason" required ></textarea>                                                                        
                                                                    </div>
                                                                    <br>
                                                                    <div class="text-right"><Button type="submit" name="action" value="Deactivate" class="mybutton btn-orange" >Kh??a t??i kho???n</button> </div>

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
                                <th>T??n</th>
                                <th>?????a ch???</th>
                                <th>S??T</th>
                                <th>Tr. th??i</th>
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
                                                                    <h5 class="modal-title" id="exampleModalLabel">N???i dung c???a vi???c kh??a t??i kho???n</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">                                                        


                                                                    <div class="col-md-12 ">                                                                                
                                                                        <div class="">
                                                                            <input type="hidden" name="userId" value="${student.id}" />


                                                                            <div class="text-left"> <label class="labels">N???i Dung</label></div>

                                                                            <textarea
                                                                                rows="5"   class="form-control" type="text" name="reason" required ></textarea>                                                                        
                                                                        </div>
                                                                        <br>
                                                                        <div class="text-right"><Button type="submit" name="action" value="Deactivate" class="btn btn-primary" >Deactivate</button> </div>

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
                    <h3 class="right_title">Qu???n l?? gi???ng vi??n</h3>
                    <button type="button" class="mybutton btn-orange" data-toggle="modal" data-target="#exampleModal">
                        T???o t??i kho???n m???i
                    </button>
                </div>

                <!-- Modal -->
                <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
                     aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">????ng k?? t??i kho???n gi???ng vi??n</h5>
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
                                    <div class="col-md-12 mt-3">
                                        <label class="labels">T??n</label>
                                        <input class="form-control" type="text" name="name" required="true" minlength="12" maxlength="50"/>
                                    </div>
                                    <div class="col-md-12 text-right mt-4 mb-3">
                                        <button type="submit" class="mybutton btn-blue">T???o</button>
                                    </div>
                                </form> 
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
                                <th>T??n</th>
                                <th>?????a ch???</th>
                                <th>S??T</th>
                                <th>Tr. th??i</th>
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
                                                                    <h5 class="modal-title" id="exampleModalLabel">N???i dung c???a vi???c kh??a t??i kho???n</h5>
                                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                        <span aria-hidden="true">&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body">                                                        


                                                                    <div class="col-md-12 ">                                                                                
                                                                        <div class="">
                                                                            <div class="text-left"> <label class="labels">N???i Dung</label></div>

                                                                            <textarea
                                                                                rows="5"   class="form-control" type="text" name="reason" required ></textarea>                                                                        
                                                                        </div>
                                                                        <br>
                                                                        <div class="text-right"><Button type="submit" name="action" value="Deactivate" class="btn btn-primary" >Deactivate</button> </div>
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

            <!--qu???n l?? b??nh lu???n-->
            <c:if test="${requestScope.mapComment ne null}">
                <div class="top_title">
                    <h3 class="right_title">Qu???n l?? b??nh lu???n</h3>
                </div>
                <div class="service">
                    <table class="table table-bordered text-center">
                        <thead class="thead-light">
                            <tr>
                                <th>SST</th>
                                <th>N???i dung</th>
                                <th>S??? ki???n</th>
                                <th>T??n</th>
                                <th>Ch???c v???</th>
                                <th>Tr. th??i</th>
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
                                                    data-target="#exampleModal${comment.key}">
                                                Ban
                                            </button>

                                            <div class="modal fade" id="exampleModal${comment.key}" tabindex="-1" role="dialog"
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
                                                                <form action="sendNotificationToUser" method="POST">
                                                                    <div class="d-block">                                                                       
                                                                        <div class="text-left"><label class="labels">N???i Dung</label></div>
                                                                        <textarea class="input_message form-control" rows="5"
                                                                        style="width: 100%;" 
                                                                        type="text" name="message" required="true"></textarea>                                                                        
                                                                    </div>
                                                                    <input type="hidden" name="userId" value="${comment.value.userId}">
                                                                    <input type="hidden" name="eventId" value="${comment.value.eventId}">
                                                                    <div class="text-right mt-3"> 
                                                                        <button type="button" class="btn btn-primary" onclick="banComment('${comment.key}', this)">Ban</button> 
                                                                    </div>
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
            <!--qu???n l?? s??? ki???n-->
            <c:if test="${requestScope.LIST_ORGANIZER_EVENT ne null}">
                <div class="top_title">
                    <h3 class="right_title">Qu???n l?? s??? ki???n</h3>
                </div>
                <div>
                    <div class="col-md-6 ">
                        <h5 style="font-weight: 400">T??m event theo: </h5>
                    </div>
                    <!-- ???? LOAD LIST ALL ORGANIZER, Select o day l?? khi nguoi d??ng ho chon option n??o th?? m??nh show LIST ORGANIZER-->

                    <form action="filterEvent">
                        <div class="col-md-6">
                            <label class="labels">Ch???c v???</label>
                            <select class="form-control" name="organizerType" id="organizerType"
                                    onchange="organizerTypeHandler(this)">
                                <option value="allOrganizer">T???t c???</option>
                                <!-- (????Y L?? MAC ??INH KHI BAM V??O "Event Management"-->
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
                                <!--           Neu chon "T???t c???" ??? c??i select tr??n  (????Y L?? MAC ??INH KHI BAM V??O "Event Management"-->
                                <div class="col-md-6"> <label class="labels">T??n nh?? t??? ch???c:</label>
                                    <select
                                        class="form-control" name="idOrganizer">
                                        <option value="0">T???t c???</option>
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
                                <div class="col-md-6"> <label class="labels">T??nh tr???ng s??? ki???n:</label> <select
                                        class="form-control" name="eventStatus" id="eventStatus">
                                        <option value="0">T???t c???</option>
                                        <option value="1">S???p di???n ra</option>
                                        <option value="2">????ng ????ng k??</option>
                                        <option value="3">???? k???t th??c</option>
                                        <option value="4">???? h???y</option>
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
                                    <input type="submit" style="height: fit-content" value="T??m ki???m" class="mybutton btn-orange" />
                                </div>
                            </div>
                        </div>
                    </form>
                    <br>
                    <div id="allOrganizer">
                        <!--           Neu chon "T???t c???" ??? c??i select tr??n  (????Y L?? MAC ??INH KHI BAM V??O "Event Management"-->
                        <div class="col-md-6"> <label class="labels">T??n nh?? t??? ch???c:</label>
                            <select
                                class="form-control" name="idOrganizer">
                                <option value="0">T???t c???</option>
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
                    <!-- N???u ch???n "Club's leader" ??? c??i select tr??n-->
                    <div id="CL">
                        <div class="col-md-6"> <label class="labels">T??n nh?? t??? ch???c:</label>
                            <select
                                class="form-control" name="idOrganizer">
                                <option value="-1">T???t c???</option>
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

                    <!--           N???u ch???n "Department's manager" ??? c??i select tr??n-->
                    <div id="DM">
                        <div class="col-md-6"> <label class="labels">T??n nh?? t??? ch???c:</label>
                            <select
                                class="form-control" name="idOrganizer">
                                <option value="-2">T???t c???</option>
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
                                            <th>T??n</th>
                                            <th>?????a ??i???m</th>
                                            <th>Ng??y</th>
                                            <th>Gi???</th>
                                            <th>Ng?????i t??? ch???c</th>
                                            <th>Qu. t??m</th>
                                            <th>Th. gia</th>
                                            <th>Tr. th??i</th>
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
                                                <c:if test="${event.statusId == 1}">
                                                    <td><div class="rec_green"></div></td>    
                                                </c:if>
                                                <c:if test="${event.statusId == 2}">
                                                    <td><div class="rec_yellow"></div></td>    
                                                </c:if>
                                                <c:if test="${event.statusId == 3}">
                                                    <td><div class="rec_red"></div></td>    
                                                </c:if>
                                                <c:if test="${event.statusId == 4}">
                                                    <td><div class="rec_grey"></div></td>    
                                                </c:if>
                                                
                                                <td>
                                                    <form action="cancelEvent" method="POST">
                                                        <c:if test="${event.statusId == 1 || event.statusId == 2}">
                                                            <c:if test="${sessionScope.AUTHORIZING_SENDING_EMAIL eq 'false'}">
                                                                <button type="submit" class="deac_button" formaction="authorizeSendingEmail">
                                                                    Cancel
                                                                </button>
                                                            </c:if>
                                                            <c:if test="${sessionScope.AUTHORIZING_SENDING_EMAIL eq 'true'}">
                                                                <button type="button" class="deac_button" data-toggle="modal"
                                                                        data-target="#exampleModal${event.id}">
                                                                    Cancel
                                                                </button>

                                                                <div class="modal fade" id="exampleModal${event.id}" tabindex="-1" role="dialog"
                                                                     aria-labelledby="exampleModalLabel" aria-hidden="true">     

                                                                    <div class="modal-dialog" role="document">
                                                                        <div class="modal-content">
                                                                            <div class="modal-header">
                                                                                <h5 class="modal-title" id="exampleModalLabel">X??c Nh???n H???y Event</h5>
                                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                    <span aria-hidden="true">&times;</span>
                                                                                </button>
                                                                            </div>
                                                                            <div class="modal-body">                                                        
                                                                                <div class="col-md-12 ">                                                                                
                                                                                    <div class="">
                                                                                        <form action="cancelEvent">
                                                                                            <input type="hidden" name="eventId"
                                                                                                   value="${event.id}" />
                                                                                            <input type="hidden" name="organizerType"
                                                                                                   value="${param.organizerType}" />
                                                                                            <input type="hidden" name="eventStatus"
                                                                                                   value="${param.eventStatus}" />
                                                                                            <input type="hidden" name="idODeacadminrganizer"
                                                                                                   value="${param.idOrganizer}" />
                                                                                            <div class="text-left"><label class="labels">N???i Dung</label></div>
                                                                                            <textarea
                                                                                                rows="5"   class="form-control" type="text" name="reason" required  ></textarea>                                                                      
                                                                                    </div>
                                                                                    <br>
                                                                                    <div class="text-right"><button
                                                                                            type="submit" name="action" value="Confirm" class="btn btn-primary" >Confirm</button> </div>
                                                                                    </form>
                                                                                </div>
                                                                            </div>

                                                                        </div>
                                                                    </div>

                                                                </div>
                                                            </c:if>
                                                        </c:if>
                                                    </form>
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
        <!--qu???n l?? h???i ????p-->
        <c:if test="${requestScope.LIST_QUESTION ne null}">
            <div class="top_title">
                <h3 class="right_title">Qu???n l?? h???i ????p</h3>
            </div>
            <div class="service">
                <table class="table table-bordered text-center">
                    <thead class="thead-light">
                        <tr>
                            <th>SST</th>
                            <th>N???i dung</th>
                            <th>S??? ki???n</th>
                            <th>T??n</th>
                            <th>Ch???c v???</th>
                            <th>Tr. th??i</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="question" items="${requestScope.LIST_QUESTION}" varStatus="status">
                            <tr>
                                <td><p>${status.count}</p></td>
                                <td><p>${question.contents}</p></td>
                                <td><a href="viewEventDetail?eventId=${question.eventId}"><p>Xem</p></a></td>
                                <td><p>${question.userName}</p></td>
                                <td><p>${question.userRoleName}</p></td>
                                <c:if test="${question.statusId eq 'AC'}">
                                    <!-- 3.svg -->
                                    <td><div class="rec_green"></div></td>

                                    <td class="button_td">
                                        <button type="button" class="deac_button" data-toggle="modal"
                                                data-target="#exampleModalBanComment${question.commentId}">
                                            Ban
                                        </button>

                                        <div class="modal fade" id="exampleModalBanComment${question.commentId}" tabindex="-1" role="dialog"
                                             aria-labelledby="exampleModalLabel" aria-hidden="true">     

                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel">Ban c??u h???i</h5>

                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">                                                        


                                                        <div class="col-md-12 ">                                                                                
                                                            <br>
                                                            <form action="deactivateQuestionAndReply">

                                                                <h3>X??c nh???n x??a c??u h???i</h3>
                                                                <br>
                                                                <div class="text-right"> <button class="btn btn-primary" type="submit">Confirm</button> </div>
                                                                <input type="hidden" name="commentId" value="${question.commentId}"/>
                                                            </form>
                                                            </form>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>

                                        </div>

                                    </td>
                                </c:if>
                                <c:if test="${question.statusId eq 'DE'}">
                                    <!-- 4.svg -->
                                    <td><div class="rec_red"></div></td>
                                    <td class="button_td" style="visibility: hidden;">
                                        <button>__</button>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
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

