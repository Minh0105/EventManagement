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
        <script>a
            history.forward();
        </script>
    </head>

    <body>
        <nav class="navbar navbar-expand-md navbar-light navbar-color sticky-top">
            <div id="nav_content" class="container-fluid">
                <a id="navbar_branch" href="#">
                    <img id="app_icon" src="resources/icon/app_icon.svg">
                    <h5 class="d-none d-md-block">Cập nhật ảnh bì</h5>
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

            </div>

            <c:set var="eventDetail" value="${sessionScope.EVENT_DETAIL_REVIEW}" />

            <!-- EVENT NAME -->
            <!-- <h5 class="title col-12">${eventDetail.name}</h5> -->
            <h5 class="title col-12">Liệu mai trời có nắng</h5>

            <!-- EVENT IMAGE  -->
            <h5 class="title col-12">Ảnh sự kiện</h5>

            <div id="image_container" class="col-12 col-lg-7">
                <figure id="figure_image" >
                    <img id="chosen-image" src="data:image/jpg;base64,${eventDetail.poster}">
                </figure>

                <input class="d-none" type="file" id="upload-button" 
                       accept="image/*" name="fileUp" value="" style="visibility:hidden;">

                <label id="btn_upload_image" for="upload-button">
                    Chọn hình ảnh
                </label>
            </div>

            <p id="btn_review" onclick="sendDataToServer()">Xem trước</p>

        <div id="submiter"></div>

        <script src="resources/js/create_event.js"></script>

        <footer style="height: 400px;">

        </footer>
    </body>

</html>