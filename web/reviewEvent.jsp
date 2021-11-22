<%-- 
    Document   : eventDetail
    Created on : Oct 1, 2021, 5:47:27 PM
    Author     : triet
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="fptu.swp.entity.user.UserDTO"%>
<%@page import="fptu.swp.entity.event.ReplyDTO"%>
<%@page import="fptu.swp.entity.event.CommentDTO"%>
<%@page import="fptu.swp.entity.user.LecturerBriefInfoDTO"%>
<%@page import="java.util.List"%>
<%@page import="fptu.swp.entity.event.EventDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Xem trước</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css"
              integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">

        <!--        <script src='bootstrap/js/bootstrap.js'></script>-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>  
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <link rel="stylesheet" type="text/css" href="resources/css/eventDetail.css"/>
        <link rel='stylesheet' type='text/css' media='screen' href='resources/css/style.css'>
    </head>
    <body>
        <div id="#messages">

        </div>

        <%@include file="nav_bar.jsp" %>
        
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("USER");
            EventDetailDTO detail = (EventDetailDTO) session.getAttribute("EVENT_DETAIL_REVIEW");
            List<LecturerBriefInfoDTO> listLecturer = (List<LecturerBriefInfoDTO>) session.getAttribute("ChosenLecturerList");
        %>
        
        <section id="poster_section" style="position: relative;">
            <div class="review_text">
                <p>Xem trước</p>
            </div>
            <div id="poster_image">
                <img src="data:image/jpg;base64,<%= detail.getPoster()%>" alt="">
            </div>

            <div id="calendar_part">
                <div id="calendar_section">
                    <div id="orange_decoration"></div>
                    <div id="date_part">
                        <h3 id="date_render"> <%= detail.getDate()%></h3>
                        <p id="day_render"> </p>
                    </div>
                </div>

                <!-- CARE PART  -->
                <div id="care_infor_part">
                    <p class="care_infor_text"> 0 bạn đã quan tâm</p> 
                    <div id="dot"></div>
                    <p class="care_infor_text"> 0 bạn sẽ tham gia</p>
                </div>

                <!-- STATUS PART -->
                <div id="care_infor_part">
                    <p class="care_infor_text green">Sắp diễn ra</p> 
                </div>    

            </div>
        </section>

        <!-- EVENT HEADER -->
        <div id="event_header" class="container-fluid">
            <section class="carousel">
                <div class="date_time_section">
                    <h4><%= detail.getDate()%>, <%= detail.getTime()%><br>
                        <%= detail.getLocation()%>
                    </h4>
                </div>
            </section>

            <div class="organizer_name">
                <marquee direction="down" behavior="slide" loop="1" scrollamount="2" word-break: keep-all;>
                    <%= detail.getName()%>
                </marquee>
                <p id="scroll_target_title" class="mb-0"><%= detail.getOrganizerName()%></p>
            </div>
        </div>

        <!-- CONTENT -->
        <section id="content">
             <!-- CONTENT NAVIGATION -->
            <ul class="nav nav-tabs" id="tab_container">
                <li class="nav-item" id="first_tab_button">
                    <a class="nav-link" id="home-tab"
                    role="tab" aria-controls="home" aria-selected="true">Tiến trình</a>
                </li>

                <li class="nav-item">
                <a class="nav-link active" id="home-tab" 
                role="tab" aria-controls="home" aria-selected="true">Giới thiệu</a>
                </li>

                <li class="nav-item" id="comment_tab_button">
                <a class="nav-link" id="profile-tab" type="button"
                role="tab" aria-controls="profile" aria-selected="false">Thảo luận</a>
                </li>

                <li class="nav-item" id="discuss_tab_button">
                <a class="nav-link" id="contact-tab" type="button"
                role="tab" aria-controls="contact" aria-selected="false">Hỏi đáp</a>
                </li>
            </ul>

            <div id="body_content">
                <div class="tab-content" id="myTabContent">
                    <!-- FOLLOW UP -->
                    <div class="tab-pane fade show" id="end" role="tabpanel" aria-labelledby="end-tab">
                        <section class="navWord">
                            <h2 class="content_title w-full-parent text-center">Tiến trình sự kiện</h3>
                            <p><%= detail.getFollowUp() %>
                        </section>   
    
                    </div>
    
                    <!-- INTRODUCTION -->
                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <section class="navWord">
                            <h4 class="content_title mt-0">Nội dung sự kiện</h4>
                            <p><%= detail.getDescription()%></p>
                        </section>   

                        <!-- LECTURER -->
                        <section class="single">
                            <h4 class="content_title">Giảng viên</h4>
                        </section>

                        <!-- LECTURER CARD -->
                        <section id="lecturer_section">
                            <div id="lecturer_container" class="container">
                                <div id="lecturer_row" class="row">
                                    <%
                                        for (LecturerBriefInfoDTO lecturer : listLecturer) {
                                    %>
                                    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-6">
                                        <div class="lecturer_card">
                                            <div class="lec_ava_container">
                                                <div class="sub_container">
                                                    <img src="<%= lecturer.getAvatar()%>" class="rounded-circle" alt="" referrerpolicy="no-referrer">
                                                </div>
                                            </div>
                                            <p class="lec_name"><%= lecturer.getName()%></p>
                                            <p class="lec_description"><%= lecturer.getDescription()%></p>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </section>

                        <!-- ORGANIZER -->
                        <h4 class="content_title">Người tổ chức</h4>
                        <div class="organizer_container">
                            <img src="<%= detail.getOrganizerAvatar()%>" class="organizer_ava" alt="" referrerpolicy="no-referrer">
                            <div class="organizer_infor">
                                <p id="organizer_name"><%= detail.getOrganizerName()%></p>
                                <p id="organizer_description"><%= detail.getOrganizerDescription()%></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="col-12 text-center d-flex justify-content-center align-items-center" style="margin-top: 20vh; color: white">
            <% if (session.getAttribute("CHANGING_EVENT_ID") != null) { %>
                <a href="createEvent" class="mybutton btn-orange btn-big">Cập nhật sự kiện</a>

            <% } else { %>
                <a href="createEvent" class="mybutton btn-orange btn-big">Tạo sự kiện</a>
            <% } %>

            <button onclick="goBack()" class="mybutton btn-blue btn-big ml-3">Quay về trước</button>
        </div>
        <script>
            function goBack() {
                window.history.back();
            }
        </script>


    <%@include file="footer.jsp" %>

    <!-- -------------------------gắn link------------------------------- -->

        <script>
            let dateDOM = document.getElementById('date_render'); // 1,2,3,4,.. 31
            let dayDOM = document.getElementById('day_render'); // Mon, Tue,..
            if (dateDOM && dayDOM) {
                let d1 = "<%= detail.getDate()%>"; 
                let subStringDate = d1.substring(d1.length - 8, d1.length - 10);
                let subStringDay = d1.substring(0, d1.indexOf(","));
                    dateDOM.innerHTML = subStringDate;
                    dayDOM.innerHTML = subStringDay;
            }
        </script>

        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"
            integrity="sha384-W8fXfP3gkOKtndU4JGtKDvXbO53Wy8SZCQHczT5FMiiqmQfUpWbYdTil/SxwZgAN"
            crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.min.js"
            integrity="sha384-skAcpIdS7UcVUC05LJ9Dxay8AXcDYfBJqt1CJ85S/CFujBsIzCIv+l9liuYLaMQ/"
            crossorigin="anonymous">
        </script>
        <script src="resources/js/eventDetail.js"></script>

</body>

</html>