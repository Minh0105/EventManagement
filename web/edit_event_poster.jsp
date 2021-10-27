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
        <link rel='stylesheet' href="resources/css/edit_event_poster.css"/>
        <link rel='stylesheet' type='text/css' media='screen' href='resources/css/create_event.css'>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            history.forward();
        </script>
    </head>

    <body>
        <nav class="navbar navbar-expand-md navbar-light navbar-color sticky-top">
            <div id="nav_content" class="container-fluid">
                <a id="navbar_branch" href="#">
                    <img id="app_icon" src="resources/icon/app_icon.svg">
                    <h5 class="d-none d-md-block">Cập nhật ảnh bìa</h5>
                </a>		
            </div>
        </nav>

        <div id="body" class="container-fluid">

            <c:set var="eventDetail" value="${sessionScope.EVENT_DETAIL_REVIEW}" />

            <!-- EVENT NAME -->
            <!-- <h5 class="title col-12">${eventDetail.name}</h5> -->
            <h5 class="title col-12">Sự kiện: Liệu mai trời có nắng</h5>

            <div id="image_container" class="col-12 col-lg-7 mt-3">
                <figure id="figure_image" >
                    <img style="border-radius: 6px; box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.35);" id="chosen-image" src="resources/image/eventDetail 9.png">
                </figure>

                <input class="d-none" type="file" id="upload-button" 
                       accept="image/*" name="fileUp" value="" style="visibility:hidden;">
                
                <div style="width: 100%" class="d-flex justify-content-end">
                    <p style="height:fit-content" class="d-block mr-3" id="btn_upload_image" for="upload-button">
                        Chọn hình ảnh
                    </p>
        
                    <p id="btn_review" class="mt-0" onclick="sendDataToServer()">Cập nhật</p>
                </div>

            </div>

            
        <div id="submiter"></div>

        <script src="resources/js/create_event.js"></script>

        <footer style="height: 400px;">

        </footer>
    </body>

</html>