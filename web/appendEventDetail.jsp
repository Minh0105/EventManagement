<%-- Document : appendEventDetail Created on : Oct 3, 2021, 3:34:20 PM Author : admin --%>
<%@page import="java.util.ArrayList"%>
<%@page import="fptu.swp.entity.user.LecturerBriefInfoDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Event</title>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link rel='stylesheet' type='text/css' media='screen' href='resources/css/create_event.css'>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            history.forward();
        </script>
        <script src="<c:url value='resources/ckeditor/ckeditor.js' />"></script>
    </head>

    <body>
        <nav class="navbar navbar-expand-md navbar-light navbar-color sticky-top">
            <div id="nav_content" class="container-fluid">
                <a id="navbar_branch" href="#">
                    <img id="app_icon" src="resources/icon/app_icon.svg">
                    <h5 class="d-none d-md-block">Điền thông tin sự kiện</h5>
                </a>		
            </div>
        </nav>

        <div id="body" class="container-fluid">

            <div id="date_time_row" class="row"> 

                <!-- CHOSEN LOCATION -->
                <div id="chosen_date_container" class="col-12 col-md-7 col-lg-6 container-fluid">
                    <div class="row gx-1 gy-1">
                        <c:forEach var="locationDTO" items="${sessionScope.ChosenLocationList}" >     
                            <div class="col-6 col-md-4">
                                <div class="date_pill">           
                                    <p class="date_content">${locationDTO.name}</p>
                                </div>
                            </div>      
                        </c:forEach>
                    </div>
                </div>

                <!-- CHOSEN DATE & TIME -->
                <div id="chosen_date_time_container" class="col-7 col-md-3 col-lg-4">
                    <p id="chosen_date">${sessionScope.ChosenDate}</p>
                    <p id="chosen_time">${sessionScope.ChosenTimeRange}</p>
                </div>

                <!-- BACK BUTTON -->
                <div id="btn_back_container" class="col-5 col-md-2 col-lg-2">
                    <p id="btn_back" onclick="goBackToDateAndTimeScreen()">
                        Quay về trước
                    </p>
                </div>

            </div>

            <c:set var="eventDetail" value="${sessionScope.EVENT_DETAIL_REVIEW}" />

            <!-- EVENT NAME -->
            <h5 class="title col-12">Tên Sự Kiện</h5>
            <input class="col-12 col-lg-7" id="input_event_name" type="text"  
                   name="eventName" value="${eventDetail.name}">

            <!-- EVENT DESCRIPTION        -->
            <h5 class="title col-12">Nội Dung Sự Kiện</h5>
            <textarea class="col-12 col-lg-7" id="input_event_description" rows="7" cols="12"
                      type="text"name="description">${eventDetail.description}</textarea>

            <!-- EVENT IMAGE  -->
            <h5 class="title col-12">Ảnh sự kiện</h5>

            <div id="image_container" class="col-12 col-lg-7">
                <figure id="figure_image" >
                    <img id="chosen-image">
                </figure>

                <input class="d-none" type="file" id="upload-button" 
                       accept="image/*" name="fileUp" value="" style="visibility:hidden;">

                <label id="btn_upload_image" for="upload-button">
                    Chọn hình ảnh
                </label>
            </div>

            <!-- LECTURER -->
            <!-- CHOSEN LECTURER -->
            <h5 class="title">Danh sách giảng viên</h5>
            <p>Đã chọn</p>

            <div id="chosen_lecturer_container">
                <c:forEach var="chosenLec" items="${sessionScope.ChosenLecturerList}">
                    <div class="chosen_lecturer_item">
                        <div class="d-flex align-items-center">
                            <img class="rounded-circle lec-avatar " src="${chosenLec.avatar}"> 
                            <p class="chosen_lec_name">${chosenLec.name}</p>
                        </div>
                        <input class="chosen_lecturer d-none" type="hidden" name="chosen_lecturer" value="1"/>
                        <img class="btn_remove_lec" onclick="onRemoveChosenLecturerClick('${chosenLec.id}')" src="resources/icon/icon_remove_lecturer.svg"/>
                    </div>
                </c:forEach>
            </div>

            <!-- SEARCH LECTURER  -->
            <input class="col-12 col-lg-7" type="text" id="myInput" onkeyup="myFunction()"
                   placeholder="Search for names.." title="Type in a name">

            <!-- LECTURER LIST -->
            <ul id="lecturer_list">

                <%
                    ArrayList<LecturerBriefInfoDTO> lecturerList = (ArrayList) session.getAttribute("LecturerList");
                    ArrayList<LecturerBriefInfoDTO> chosenLecturerList = (ArrayList) session.getAttribute("ChosenLecturerList");

                    for (LecturerBriefInfoDTO lecturer : lecturerList) {
                %>
                <li>
                    <div 
                        <%
                            if ((chosenLecturerList != null) && chosenLecturerList.contains(lecturer)) {
                        %>
                        style="display: none" 
                        <%
                            }
                        %>
                        class="lecturer_infor col-12 col-lg-7" onclick="onChooseLecturer(this)">
                        <input type="hidden" name="chosen_lecturer" value="<%= lecturer.getId()%>"/>
                        <img class="rounded-circle lec-avatar" src="<%= lecturer.getAvatar()%>"> 
                        <span class="lec_name"><%= lecturer.getName()%></span>
                    </div>
                </li>
                <%
                    }
                %>

            </ul>

            <p id="btn_review" onclick="sendDataToServer()">Xem trước</p>
        </div>

        <div id="submiter"></div>

        <script src="resources/js/create_event.js"></script>

        <footer style="height: 400px;">

        </footer>
        <script>
                if (screen.width >= 1200) {
                    CKEDITOR.replace('input_event_description', {
                        width: '58.3333%'
                    });
                } else {
                    CKEDITOR.replace('input_event_description', {
                        width: '100%'
                    });
                }
        </script>
    </body>

</html>