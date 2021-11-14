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
                <link rel="stylesheet" type="text/css" href="resources/css/admin.css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css"
        integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
           <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    </head>
    <body>

        <div class="header1" id="b">
            <div class="header3">
                <div id="big_title" class="link">                   
                    <h4 class="text-center"> FPT Event Management </h4>          
                    <ul>
                        <li class="nav-item">
                            <a class="nav-link" href="manageByAdmin?management=organizer">Organizer
                                Management
                                <i class="mega-octicon octicon-organization"></i>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="manageByAdmin?management=student">Student
                                Management</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="manageByAdmin?management=lecturer">Lecturer
                                Management</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="manageByAdmin?management=event">Event Management</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="manageByAdmin?management=comment">Comment Management</a>
                        </li>
                        
                        <li class="nav-item">
                            <a class="nav-link" href="authorizeSendingEmail">Email Sending Authorization</a>
                        </li>
                        <c:if test="${sessionScope.AUTHORIZING_SENDING_EMAIL eq 'true'}">
                            <li class="nav-item">
                            <a class="nav-link" href="#">Sending email when deactivate user enabled!!!</a>
                        </li>
                        </c:if>
                        
                        
                        <li class="nav-item col-md-6">
                            <form action="logout" class="">
                                <button class="btn btn-link profile-button logout mt-5 d-flex align-items-center" type="submit">
                                    <span style="color:white"><h5>Log out</h5><span>
                                </button> 
                            </form>   

                        </li>
                    </ul>
                </div>
                <div class="wrapper">

                    <div class="navbar-toggle" id="a">
                    </div>
                </div>

            </div>
        </div>

        <img id="btn_show_sidebar" onclick="showSideBar()"/>

        <script>
            var a = document.getElementById("a");
            var b = document.getElementById("b");
            var headerHeight1 = b.clientHeight;

            a.onclick = function () {
                a.classList.toggle('open');
                b.classList.toggle('toggleHeight');

                // var  isClose = b.clientHeight === headerHeight1;
                // if(isClose){
                //     b.style.height = "300px";
                // }else{
                //     b.style.height = headerHeight1;
                // }
            }

        </script>
    </div>
  
    <div class="header4">
      
          <c:if test="${requestScope.LIST_ORGANIZER ne null}">
                 <div class=""><h3 class="right_title">Organizer Management</h3></div>
  <!-- Button trigger modal -->
  <div class="text-right"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  Tạo tài khoản mới
</button></div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                        <input type="hidden" name="action" value="Create"/>
                        <div class=""><label class="labels">Email</label><input class="form-control" type="email" name="email" required/> <!--pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"-->
                        </div>
                        <div class=""><label class="labels">Name</label><input class="form-control" type="text" name="name"required/><br></div>
                        <div class="text-right"> <button type="submit" class="btn btn-primary">Tạo tài khoản mới</button> </div>
                    </form></div>
               
      </div>
    
      </div>
    </div>
  </div>

      

            <div class="service">
                   
                <span>${requestScope.NOTIFICATION}</span>
         
                <table class="table table-bordered text-center">
                 
                    <thead class="thead-light">
                        <tr class="service1" >
                            <th >No</th>
                            <th>Email</th>
                            <th >Name</th>                       
                            <th >Phone Number</th>
                            <th >Role Name</th>
                            <th >Status</th>
                            <th>Description</th>
                            <th>NoE</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER}" varStatus="status">
                            <tr class="service2">
                                <td >${status.count}</td>
                                <td >${organizer.email}</td>
                                <td >${organizer.name}</td>           
                                <td>${organizer.phoneNum}</td>
                                <td >${organizer.roleName}</td>
                                <td >
                              <c:if test="${organizer.status eq 'Activated'}">                             
                                            <img src="resources/icon/Rectangle 263.svg">
                                        </c:if>
                                        <c:if test="${organizer.status eq 'Deactivated'}">
                           <img src="resources/icon/Rectangle 264.svg">
                                        </c:if>
                                </td>
                                <td >${organizer.description}</td>
                                <td >${organizer.numOfEvent}</td>
                                <td class="button_td" >
                                    <form action="manageUserByAdmin" method="POST">
                                        <input   type="hidden" name="userId" value="${organizer.id}"/>
                                        <c:if test="${organizer.status eq 'Activated'}">
                                            <input type="submit" name="action" value="Deactivate"/>
                                        </c:if>
                                        <c:if test="${organizer.status eq 'Deactivated'}">
                                            <input type="submit" name="action" value="Activate"/>
                                        </c:if>

                                    </form>
                                </td>

                            </tr>

                        </c:forEach>
                    </tbody> 
                </table>                    
                   
                
        </c:if>
            
        <c:if test="${requestScope.LIST_STUDENT ne null}">
            <div class=""><h3 class="right_title">Student Management</h3></div>
            <div class="service" >
                <table class="table table-bordered text-center">
                    <thead class="thead-light">
                        <tr class="service1">
                            <th>No</th>
                            <th>Email</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Phone Number</th>
                            <th>Role Name</th>
                            <th>Status</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="student" items="${requestScope.LIST_STUDENT}" varStatus="status">
                            <tr class="service2">
                                <td>${status.count}</td>
                                <td>${student.email}</td>
                                <td>${student.name}</td>
                                <td>${student.address}
                                <td>${student.phoneNum}</td>
                                <td>${student.roleName}</td>
                                <td>   <c:if test="${student.status eq 'Activated'}">                             
                                            <img src="resources/icon/Rectangle 263.svg">
                                        </c:if>
                                        <c:if test="${student.status eq 'Deactivated'}">
                           <img src="resources/icon/Rectangle 264.svg">
                                        </c:if>
                                </td>
                                <td class="button_td">
                                    <form action="manageUserByAdmin" method="POST">
                                        <input type="hidden" name="userId" value="${student.id}"/>
                                        <c:if test="${student.status eq 'Activated'}">                             
                                            <input type="submit" name="action" value="Deactivate"/>
                                        </c:if>
                                        <c:if test="${student.status eq 'Deactivated'}">
                                            <input type="submit" name="action" value="Activate"/>
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
             <div class=""><h3 class="right_title">Lecturer Management</h3></div>
             <!-- Button trigger modal -->
  <div class="text-right"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  Tạo tài khoản mới
</button></div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
        
                <input type="hidden" name="roleId" value="2"/>
                <input type="hidden" name="action" value="Create"/>
                <div class="col-md-12"><label class="labels">Email</label><input class="form-control" type="email" name="email" required/> <!--pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"-->
                </div>
                <div class="col-md-12"><label class="labels">Name</label><input class="form-control" type="text" name="name"required/><br></div>
                <div class="col-md-12 text-right"><button type="submit" class="btn btn-primary">Add Lecturer</button></div>
            </form> <br>  
      </div>
    
      </div>
    </div>
  </div>

      
       

                      <!-- <div>
                            
                                <button class="btn btn-primary hight" type="button" id="a" data-toggle="modal" data-target="#createNewLecturer">
                                    <p>Thêm tài khoản giảng viên</p>
                                </button>
            
                                
                                <div class="modal fade" id="createNewLecture" tabindex="-1" aria-labelledby="createNewLecturerLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="createNewLecturerLabel">Thêm tài khoản giảng viên</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <input type="hidden" name="roleId" value="2"/>
                                                <input type="hidden" name="action" value="Create"/>
                                                <p>Email: <input type="text" name="email"/><br></p> 
                                                <p>Name: <input type="text" name="name"/><br></p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary">Thêm</button>
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> -->
       

            <div class="service">
                <table class="table table-bordered text-center">
                    <thead class="thead-light">
                        <tr class="service1">
                            <th>No</th>
                            <th>Email</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Phone number</th>
                            <th>Role Name</th>
                            <th>Status</th>
                            <th>Description</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="lecturer" items="${requestScope.LIST_LECTURER}" varStatus="status">
                            <tr class="service2">
                                <td>${status.count}</td>
                                <td>${lecturer.email}</td>
                                <td>${lecturer.name}</td>
                                <td>${lecturer.address}</td>
                                <td>${lecturer.phoneNum}</td>
                                <td>${lecturer.roleName}</td>
                                <td> <c:if test="${lecturer.status eq 'Activated'}">                             
                                            <img src="resources/icon/Rectangle 263.svg">
                                        </c:if>
                                        <c:if test="${lecturer.status eq 'Deactivated'}">
                           <img src="resources/icon/Rectangle 264.svg">
                                        </c:if>
                                </td>
                                <td>${lecturer.description}</td>
                                <td class="button_td" >
                                    <form action="manageUserByAdmin" method="POST">
                                        <input type="hidden" name="userId" value="${lecturer.id}"/>
                                        <c:if test="${lecturer.status eq 'Activated'}">
                                            <input type="submit" name="action" value="Deactivate"/>
                                        </c:if>
                                        <c:if test="${lecturer.status eq 'Deactivated'}">
                                            <input type="submit" name="action" value="Activate"/>
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
            <div class=""><h3 class="right_title">Event Management</h3></div>
            <div>
                <div class="col-md-6 "><h4>Tìm event theo: </h4></div><br>
                <!--           ĐÃ LOAD LIST ALL ORGANIZER, Select o day là khi nguoi dùng ho chon option nào thì mình show LIST ORGANIZER-->

                <form  action ="filterEvent">
                    <div class="col-md-6"><label class="labels">Kiểu nhà tổ chức:</label>
                        <select class="form-control"  name="organizerType" id="organizerType" onchange="organizerTypeHandler(this)" >
                            <option value="allOrganizer">Tất cả</option> <!-- (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                            <option value="CL">Club's leader</option>
                            <option value="DM">Department's manager</option>
                        </select></div><br>
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
                            <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label><select class="form-control"  name="idOrganizer">
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

                            </div></div><br>
                        <div>
                            <div class="col-md-6"> <label class="labels">Tình trạng sự kiện:</label> <select class="form-control" name="eventStatus" id="eventStatus">
                                    <option value="0">Tất cả</option>
                                    <option value="1">Sắp diễn ra</option>
                                    <option value="2">Đóng đăng kí</option>
                                    <option value="3">Đã kết thúc</option>
                                    <option value="4">Đã hủy</option>
                                </select></div>
                            <script>
                                var items = document.getElementById("eventStatus").options;
                                for (var i = 0; i < items.length; i++) {
                                    if (items[i].value == "${param.eventStatus}") {
                                        items[i].selected = true;
                                    }
                                }
                            </script>
                        </div><br>
                        <div class="col-md-6 text-right"> 
                            <input type="submit" value="Search" class="btn btn-primary" />
                        </div>
                    </div> 
                </form><br>
                <div id="allOrganizer">
                    <!--           Neu chon "Tất cả" ở cái select trên  (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                    <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label><select class="form-control"  name="idOrganizer">
                            <option value="0">Tất cả</option>
                            <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER_EVENT}">
                                <c:if test="${param.idOrganizer eq organizer.id}">
                                    <option value="${organizer.id}" selected>${organizer.name}</option>
                                </c:if>
                                <c:if test="${param.idOrganizer ne organizer.id}">
                                    <option value="${organizer.id}">${organizer.name}</option>
                                </c:if>
                            </c:forEach>  
                        </select></div>
                </div>
                <!--           Nếu chọn "Club's leader" ở cái select trên-->
                <div id="CL">
                    <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label><select class="form-control"  name="idOrganizer">
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
                        </select></div>
                </div>

                <!--           Nếu chọn "Department's manager" ở cái select trên-->
                <div id="DM">
                    <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label><select class="form-control"  name="idOrganizer">
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
                        </select></div>
                </div>
                <div>
                    <c:if test="${requestScope.LIST_EVENT ne null}">
                        <div class="service">
                            <table class="table table-bordered text-center">
                                <thead class="thead-light">
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
                                        <th>Detail</th>
                                        <th>Cancel</th>
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
                                            <td><a class="btn btn-link" href="viewEventDetail?eventId=${event.id}">Detail</a></td>
                                            <td>
                                                <c:if test="${event.statusId == 1 || event.statusId == 2}">
                                                    <form  action="cancelEvent" method="POST">
                                                        <input type="hidden" name="eventId" value="${event.id}"/>
                                                        <input type="hidden" name="organizerType" value="$${param.organizerType}"/>
                                                        <input type="hidden" name="eventStatus" value="${param.eventStatus}"/>
                                                        <input type="hidden" name="idOrganizer" value="${param.idOrganizer}"/>
                                                        <input style="color:red" class="btn btn-link" type="submit" name="action" value="Cancel"/>
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
  <div class=""><h3 class="right_title">Comment Management</h3></div>
        <div class="service">
            <table class="table table-bordered text-center">
                <thead class="thead-light" >
                    <tr>
                        <th>No</th>
                        <th>Content</th>
                        <th>Event ID</th>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th colspan="2"></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="comment" items="${requestScope.mapComment}" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${comment.value.content}</td>
                            <td>${comment.value.eventId}</td>
                            <td>${comment.value.userName}</td>
                            <td>${comment.value.userRoleName}</td>
                            <td>${comment.value.statusId}</td>
                            <td class="button_td"><button onclick="banComment('${comment.key}')" >Ban</button></td>
                        </tr>
                        <c:if test="${comment.value.replyList ne null}" >
                            <c:forEach var="reply" items="${comment.value.replyList}" varStatus="stt">
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <tr>
                                    <td>${stt.count}</td>
                                    <td>${reply.value.content}</td>
                                    <td>${reply.value.eventId}</td>
                                    <td>${reply.value.userName}</td>
                                    <td>${reply.value.userRoleName}</td>
                                    <td>${reply.value.statusId}</td>
                                    <td class="button_td"><button onclick="banReply('${comment.key}', '${reply.key}')" >Ban</button></td>
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
    <script src="resources/js/configFirebase.js" ></script>
    <script src="resources/js/comment.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.min.js"
            integrity="sha384-skAcpIdS7UcVUC05LJ9Dxay8AXcDYfBJqt1CJ85S/CFujBsIzCIv+l9liuYLaMQ/"
    crossorigin="anonymous"></script>
</body>
</html>
