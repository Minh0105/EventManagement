<%-- Document : appendEventDetail Created on : Oct 3, 2021, 3:34:20 PM Author : admin --%>
<%@page import="java.util.ArrayList"%>
<%@page import="fptu.swp.entity.user.LecturerBriefInfoDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tạo sự kiện</title>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link rel='stylesheet' type='text/css' media='screen' href='resources/css/create_event.css'>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!-- <script>
            history.forward();
        </script> -->
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

        <div>
            <div id="date_time_row" class="row mr-0"> 
                <!-- CHOSEN LOCATION -->
                <div id="chosen_date_container" class="col-12 col-md-7 col-lg-6 container-fluid">
                    <div id="location_container" class="row gy-2">
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
                <div id="btn_back_container d-flex align-items-center" class="col-5 col-md-2 col-lg-2">
                    <p style="float:right; margin-bottom: 0 !important;" class="mybutton btn-blue" onclick="goBackToDateAndTimeScreen()">
                        Quay về trước
                    </p>
                </div>

            </div>
        </div>
        <div id="body" class="container-fluid">
            <div id="body_content" class="container-fluid">
                <c:set var="eventDetail" value="${sessionScope.EVENT_DETAIL_REVIEW}" />

                <!-- EVENT NAME -->
                <h5 class="title col-12 mt-0">Tên Sự Kiện</h5>
                <input class="col-12 my-text-input" id="input_event_name" type="text"  
                    name="eventName" value="${eventDetail.name}">

                <!-- EVENT DESCRIPTION        -->

                <h5 class="title col-12">Nội Dung Sự Kiện</h5>
                <textarea class="col-12" id="input_event_description" rows="7" cols="12"
                        type="text"name="description">${eventDetail.description}</textarea>

                <script src="resources/js/setUpCKEditor.js"></script>

                <!-- EVENT IMAGE  -->
                <h5 class="title col-12">Ảnh sự kiện</h5>

                <div id="image_container" class="col-12">
                    <figure id="figure_image" >
                        <img id="chosen-image" 
                        <c:if test="${not empty eventDetail.poster}">
                            src="data:image/jpg;base64,${eventDetail.poster}">
                        </c:if>
                        <c:if test="${empty eventDetail.poster}">
                            src="resouces/image/default_image.png">
                        </c:if>
                    </figure>

                    <input class="d-none" type="file" id="upload-button" 
                        accept="image/*" name="fileUp" value="" style="visibility:hidden;">

                    <div class="text-right">
                        <label class="mybutton btn-blue" id="btn_upload_image" for="upload-button">
                            Chọn hình ảnh
                        </label>
                    </div>       
                    
                </div>

                <!-- LECTURER -->
                <!-- CHOSEN LECTURER -->
                <h5 class="title">Danh sách giảng viên</h5>
                <p class="sub_title">Đã chọn</p>
                <div id="chosen_lecturer_container">
                    <div class="place_holder">
                        <div>
                            <span class="mr-3" style="visibility: hidden;">Placleholder name</span>
                            <img class="btn_remove_lec" style="visibility:hidden;" src="resources/icon/icon_remove_lecturer.svg">
                        </div>
                    </div>
                    <c:forEach var="chosenLec" items="${sessionScope.ChosenLecturerList}">
                        <div class="chosen_lecturer">
                            <div>
                                <span class="mr-3">${chosenLec.name}</span>
                                <img onclick="onRemoveChosenLecturerClick('${chosenLec.id}', this)" class="btn_remove_lec"src="resources/icon/icon_remove_lecturer.svg">
                                <input class="chosen_lecturer_id d-none" type="hidden" name="chosen_lecturer" value="${chosenLec.id}"/>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <p class="sub_title mt-3">Tìm kiếm giảng viên</p>

                <!-- SEARCH LECTURER  -->
                <input class="col-12 my-text-input my-0" type="text" id="myInput" onkeyup="onSearchLecturerName()"
                    placeholder="Nhập tên giảng viên" title="Type in a name">

                <!-- LECTURER LIST -->
                <div id="floated_lecturer_list">
                    <div id="btn_hide_lecturer_list" onclick="hideLecturerList()">
                        <img src="resources/icon/icon_btn_gray_x.svg" >
                    </div>
                    <%
                        ArrayList<LecturerBriefInfoDTO> lecturerList = (ArrayList) session.getAttribute("LecturerList");
                        ArrayList<LecturerBriefInfoDTO> chosenLecturerList = (ArrayList) session.getAttribute("ChosenLecturerList");

                        for (LecturerBriefInfoDTO lecturer : lecturerList) {
                        %>
                            <div class="lec_item" onclick="onChooseLecturer(this)" 
                        <%
                            if ((chosenLecturerList != null) && chosenLecturerList.contains(lecturer)) {
                        %>
                                style="display: none"
                        <%
                            }
                        %>      >
                                <img class="lec_ava" src="<%= lecturer.getAvatar()%>">
                                <p class="d-inline-block mb-0 ml-3 lec_name" style="color: #303030;"><%= lecturer.getName()%></p>
                                <input type="hidden" name="chosen_lecturer" value="<%= lecturer.getId()%>"/>
                            </div>
                    <%
                        }
                    %>
                </div> 

                <div class="text-right">
                    <button style="margin-top:1rem" class="mybutton btn-orange" onclick="sendDataToServer()">Xem trước</button>
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>
        
        <div id="submiter"></div>
        <script src="resources/js/create_event.js"></script>
        <script>
            var noLecturerChosen = document.getElementsByClassName("chosen_lecturer").length == 0;
            if (noLecturerChosen == false) {
                hideChosenLecturerPlaceHolder();
            }
        </script>
    </body>

</html>