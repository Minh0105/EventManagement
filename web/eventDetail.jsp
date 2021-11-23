<%-- 
    Document   : eventDetail
    Created on : Oct 1, 2021, 5:47:27 PM
    Author     : triet
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="fptu.swp.entity.user.UserDTO"%>
<%@page import="fptu.swp.entity.event.ReplyDTO"%>
<%@page import="fptu.swp.entity.event.CommentDTO"%>
<%@page import="fptu.swp.entity.user.LecturerBriefInfoDTO"%>
<%@page import="java.util.List"%>
<%@page import="fptu.swp.entity.event.EventDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết</title>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="resources/sweetalert2.all.min.js"></script> 

        <!--        <script src='bootstrap/js/bootstrap.js'></script>-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="resources/css/eventDetail.css"/>
        <script src="<c:url value='resources/ckeditor/ckeditor.js' />"></script>
        <link rel="stylesheet" type="text/css" href="resources/css/mybutton.css">
        <link rel="stylesheet" type="text/css" href="resources/css/myInputField.css">
    </head>
    <body id="html_body">

        <%@include file="nav_bar.jsp" %>

        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("USER");
            EventDetailDTO detail = (EventDetailDTO) request.getAttribute("EVENT_DETAIL");
            List<LecturerBriefInfoDTO> listLecturer = (List<LecturerBriefInfoDTO>) request.getAttribute("LIST_LECTURER");
        %>

        <section id="poster_section">
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
                    <p class="care_infor_text"> <%= detail.getFollowing()%> bạn đã quan tâm</p> 
                    <div id="dot"></div>
                    <p class="care_infor_text"> <%= detail.getJoining()%> bạn sẽ tham gia</p>
                </div>

                <!-- STATUS PART -->
                <div id="care_infor_part">
                    <%if (detail.getStatusId() == 1) { %> 
                    <p class="care_infor_text green">Sắp diễn ra</p> 
                    <% } else if (detail.getStatusId() == 2) { %> 
                    <p class="care_infor_text yellow">Đã đóng đăng kí</p> 
                    <% } else if (detail.getStatusId() == 3) { %> 
                    <p class="care_infor_text red">Đã bị hủy</p> 
                    <% } else if (detail.getStatusId() == 4) { %> 
                    <p class="care_infor_text grey">Đã kết thúc</p> 
                    <% } %>
                </div>    

            </div>
        </section>

        <!-- EVENT ORGANIZER BUTTONS  -->
        <% if (("CLUB'S LEADER".equals(loginUser.getRoleName()) || "DEPARTMENT'S MANAGER".equals(loginUser.getRoleName()))) { %>  
        <% if (request.getAttribute("ORGANIZER_ID").equals(loginUser.getId())) { %>
        <div id="menu_container">   
            <div id="menu_panel">   
                <%
                    if (detail.getStatusId() == 1 || detail.getStatusId() == 2) {
                %>
                <div id="btn_edit_event_details" class="menu_button">
                    <p>Chỉnh sửa thông tin</p>
                </div>

                <div id="btn_edit_event_content" class="menu_sub_button">
                    <a href="changeDetailByCreatingNewEvent?stage=start&eventId=<%= detail.getId()%>">
                        <p>Thời gian và địa điểm</p>
                    </a>
                </div>

                <div id="btn_edit_event_time_and_lock" class="menu_sub_button">
                    <a href="organizerRedirect?action=updateInformation&eventId=<%= detail.getId()%>">
                        <p>Thông tin sự kiện</p>
                    </a>
                </div>

                <div type="button" data-toggle="modal" data-target="#setEvtStatus" id="btn_update_event_status" class="menu_button">
                    <p>Cập nhật trạng thái</p>
                </div>
                <%
                    }
                %>

                <div id="btn_add_summary" class="menu_button">
                    <a href="organizerRedirect?action=updateFollowUp&eventId=<%= detail.getId()%>"><p>Sửa nội dung tiến trình</p></a>
                </div>

                <div id="btn_view_member" class="menu_button">
                    <button onclick="showMemberList()"><p>Xem danh sách thành viên</p></button>
                </div>


                <div type="button" data-toggle="modal" data-target="#sendNotificationModal" id="btn_update_event_status" class="menu_button">
                    <p>Gửi thông báo</p>
                </div>
            </div>

            <% }%>
        </div>

        <!-- SET EVENT STATUS MODAL  -->
        <div class="modal fade" id="setEvtStatus" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title my_modal_title" id="exampleModalLabel">Cập nhật trạng thái sự kiện</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <h5 class="my_modal_title"><%= detail.getName()%></h5>
                        <% if (detail.getStatusId() == 1) { %>
                        <span class="status_dot green_dot"></span>
                        <span class="status_text">Sắp diễn ra</span>
                        <% } else if (detail.getStatusId() == 2) { %> 
                        <span class="status_dot yellow_dot"></span>
                        <span class="status_text">Đã đóng đăng kí</span>
                        <% } %>
                    </div>

                    <div class="modal-footer">

                        <!-- CLOSE / OPEN REGISTER BUTTONS -->
                        <form action="updateEventStatus" method="POST">
                            <% if (detail.getStatusId() == 1) { %>

                                <button id="btn_close_register" type="submit" class="mybutton btn_close_register">Đóng đăng kí</button>

                            <% } else if (detail.getStatusId() == 2) { %>

                                <button id="btn_open_register" type="submit" class="mybutton btn-blue">Mở đăng kí</button>

                            <% } %>
                            <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                        </form>

                        <!-- CANCEL EVENT BUTTON -->
                        <button id="btn_cancel_event" onclick="showCancelEventConfirmation()" class="mybutton btn_cancel_event">Ngừng sự kiện</button>

                        <!-- CANCEL EVENT CONFIRMATION BUTTON -->
                        <form id="cancelEventConfirmationForm" action="cancelEvent" method="POST" style="display:none">
                            <p>Xác nhận ngừng sự kiện <b><%=detail.getName()%></b></p>
                            <div class="d-flex text-right justify-content-end"  >
                                <button type="submit" class="mybutton btn_cancel_event">Xác nhận</button>
                                <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                                <button type="button" onclick="hideCancelEventConfirmation()" class="mybutton btn-grey ml-3">Hủy</button>    
                            </div>
                        </form>

                        <script>
                            function showCancelEventConfirmation () {
                                $("#cancelEventConfirmationForm").show();
                                $("#btn_cancel_event").hide();
                                if ($("#btn_close_register") != undefined) { 
                                    $("#btn_close_register").hide();
                                }
                                if ($("#btn_open_register") != undefined) { 
                                    $("#btn_open_register").hide();
                                }
                            }

                            function hideCancelEventConfirmation () {
                                $("#cancelEventConfirmationForm").hide();
                                $("#btn_cancel_event").show();
                                if ($("#btn_close_register") != undefined) { 
                                    $("#btn_close_register").show();
                                }
                                if ($("#btn_open_register") != undefined) { 
                                    $("#btn_open_register").show();
                                }
                            }
                        </script>

                    </div>
                </div>
            </div>
        </div>

        <!-- SEND NOTIFICATION MODAL -->
        <div class="modal fade" id="sendNotificationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form action="sendNotification" id="notif_form"> 
                        <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>

                        <div class="modal-header">
                            <h5 class="modal-title my_modal_title" id="exampleModalLabel">Gửi thông báo</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body pb-0">
                            <h5 class="my_modal_title">Nội dung</h5>
                            <textarea name="message" id="notif_input" class="my-text-input w-full-parent" form="notif_form" rows="8"></textarea>
                        </div>

                        <div class="modal-footer">
                            <button type="submit" class="mybutton btn-orange m-0 px-5">Gửi</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%
            }
        %>

        <!-- EVENT HEADER -->
        <div id="event_header" class="container-fluid">
            <section class="carousel">
                <div class="date_time_section">
                    <h4><%= detail.getDate()%>, <%= detail.getTime()%><br>
                        <%= detail.getLocation()%>
                    </h4>
                </div>

                <%
                    if ("STUDENT".equals(loginUser.getRoleName()) && detail.getStatusId() == 1) {
                        boolean checkFollowed = (boolean) request.getAttribute("IS_FOLLOWED");
                        boolean checkJoining = (boolean) request.getAttribute("IS_JOINING");
                %>
                <div class="buttons_section">

                    <form action="joinEvent">
                        <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                        <input type="hidden" name="isJoining" value="<%= checkJoining%>"/>
                        <%
                            if (checkJoining) {
                        %>
                        <button type="submit" class="care_buttons mybutton btn-grey btn-big mr-2" onclick="waitingForSubmit(this)">
                            <img src="resources/icon/icon_cancel_white.svg" alt="">
                            <p>Hủy Tham Gia</p>
                        </button>
                        <%
                        } else {
                        %>
                        <button type="submit" class="care_buttons mybutton btn-blue btn-big mr-2" onclick="waitingForSubmit(this)">
                            <img src="resources/icon/icon_join_white.svg" alt="">
                            <p>Sẽ Tham Gia</p>
                        </button>
                        <%
                            }
                        %>
                    </form>

                    <form action="followEvent">
                        <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                        <input type="hidden" name="isFollowed" value="<%= checkFollowed%>"/>
                        <%
                            if (checkFollowed) {
                        %>
                        <button type="submit" class="care_buttons mybutton btn-grey btn-big mr-2" onclick="waitingForSubmit(this)">
                            <img src="resources/icon/icon_cancel_white.svg" alt="">
                            <p>Hủy Quan Tâm</p>
                        </button>
                        <%
                        } else {
                        %>
                        <button type="submit" class="care_buttons mybutton btn-blue btn-big mr-2" onclick="waitingForSubmit(this)">
                            <img src="resources/icon/icon_care_white.svg" alt="">
                            <p>Quan Tâm</p>
                        </button>
                        <%
                            }
                        %>
                    </form>
                </div>
                <%
                } else if (("CLUB'S LEADER".equals(loginUser.getRoleName())) || ("DEPARTMENT'S MANAGER".equals(loginUser.getRoleName()))) {
                %> 
                <% if (request.getAttribute("ORGANIZER_ID").equals(loginUser.getId())) { %>

                <img onclick="onMenuIconClick()" id="btn_event_operation_menu" src="resources/icon/icon_orange_hamburger_button.svg">

                <% } %>
                <%
                    }
                %>
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
                <a class="nav-link" id="home-tab" data-bs-toggle="tab" data-bs-target="#end"
                   role="tab" aria-controls="home" aria-selected="true">Tiến trình</a>
            </li>

            <li class="nav-item">
                <a class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home"
                   role="tab" aria-controls="home" aria-selected="true">Giới thiệu</a>
            </li>

            <li class="nav-item" id="comment_tab_button">
                <a class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button"
                   role="tab" aria-controls="profile" aria-selected="false">Thảo luận</a>
            </li>

            <li class="nav-item" id="discuss_tab_button">
                <a class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button"
                   role="tab" aria-controls="contact" aria-selected="false">Hỏi đáp</a>
            </li>
        </ul>

        <div id="body_content">
            <div class="tab-content" id="myTabContent">
                <!-- FOLLOW UP -->
                <div class="tab-pane fade show" id="end" role="tabpanel" aria-labelledby="end-tab">
                    <section class="navWord">
                        <h4 class="w-full-parent text-center">Tiến trình sự kiện</h4>
                        <p><%= detail.getFollowUp()%>
                    </section>   

                </div>

                <!-- INTRODUCTION -->
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                    <section class="navWord">
                        <h4 class="content_title mt-0">Nội dung sự kiện</h4>
                        <p><%= detail.getDescription()%></p>
                    </section>   

                    <!-- LECTURER -->
                    <% if (listLecturer.size() > 0) { %> 
                        <section class="single">
                            <h4 class="content_title">Giảng viên</h4>
                        </section>
                    <% } %>

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

                <!-- COMMENT -->
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">

                    <form id="comment_box" action="comment" name="loginBox" target="#here">
                        <input id="input_comment" class="my-text-input dicussion_input" type="text" placeholder="Vui lòng nhập bình luận của bạn" name="content" required/>
                        <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                        <input class="mybutton btn-orange mt-3" onclick="sendCmt()" type="button" value="Bình luận"/>
                    </form>

                    <div id="comment">
                        <!-- COMMENT WILL BE CREATED BY FIREBASE and JAVASCRIPT -->
                        <!-- <%
                            List<CommentDTO> listComment = (List<CommentDTO>) request.getAttribute("LIST_COMMENT");
                            for (CommentDTO comment : listComment) {
                        %>
                                <div class="comment_item">
                                    <div class="comment_infor_section">
                                        <div class="avatar_container">
                                            <img class="rounded-circle lec_avatar" src="<%= comment.getUserAvatar()%>" alt="">
                                        </div>
    
                                        <div class="comment_infor">
                                            <p class="comment_username"><%= comment.getUserName()%> - <%= comment.getUserRoleName()%></p>
                                            <p class="comment_content"><%= comment.getContents()%></p>
                                            <p class="btn_show_reply" onclick="showReplyBox(this)">Trả lời</p>
                                        </div>
                                    </div>

                                    <form class="reply_box" action ="reply" >
                                        <input class="input_reply" type="text" name="content" placeholder="Trả lời..." required/>
                                        <input type="hidden" name="commentId" value = "<%= comment.getCommentId()%>"/>
                                        <input type="hidden" name="eventId" value = "<%= detail.getId()%>"/>
                                        <input class="btn_reply" type="submit" value="Gửi"/>
                                    </form>

                                    <div class="reply_container">
                                        <div class="repComment2">
                                            <div class="repComment2a">
                                                <img src="resources/image/mock_avatar.jpeg" class="rounded-circle" class="rounded-circle" alt="">
                                            </div>
                                            <div class="repComment2b">
                                                <p class="comment_username">Tester - Student</p>
                                                <p class="comment_content">Xin chào mình là Tester Reply</p>
                                            </div>
                                        </div>

                                        <div class="repComment2">
                                            <div class="repComment2a">
                                                <img src="resources/image/mock_avatar.jpeg" class="rounded-circle" class="rounded-circle" alt="">
                                            </div>
                                            <div class="repComment2b">
                                                <p class="comment_username">Tester 2 - Student</p>
                                                <p class="comment_content">Hay thật đấy</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        <%
                            List<ReplyDTO> listReply = comment.getReplyList();
                            for (ReplyDTO reply : listReply) {
                        %>
                                <div class="repComment2">
                                    <div class="repComment2a">
                                        <img src="<%= reply.getUserAvatar()%>" class="rounded-circle" class="rounded-circle" alt="">
                                    </div>
                                    <div class="repComment2b">
                                        <p class="comment_username"><%= reply.getUserName()%> - <%= reply.getUserRoleName()%></p>
                                        <p class="comment_content"><%= reply.getContents()%></p>
                                    </div>
                                </div>
                        <%
                                }
                            }
                        %> -->
                    </div> 
                </div>

                <!-- QUESTION & ANSWER -->
                <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
                    <% if ("CLUB'S LEADER".equals(loginUser.getRoleName()) || "DEPARTMENT'S MANAGER".equals(loginUser.getRoleName())) { %>
                        <p id="no_question_text" style="color:rgba(0, 0, 0, 0.5)">Chưa có câu hỏi nào</p>
                    <% } %>

                    <div class="ask">
                        <%
                            if ("STUDENT".equals(loginUser.getRoleName())) {
                        %>
                                <form action ="askQuestion">
                                    <textarea id="question_input" class="my-text-input dicussion_input" type="text" placeholder="Vui lòng nhập câu hỏi của bạn....." name="content" required></textarea>

                                    <div style="width: 100%; display:flex; justify-content:flex-end">
                                        <button type="submit" class="mybutton btn-orange mt-2">Gửi câu hỏi</button>
                                    </div>

                                    <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                                </form>
                        <%
                            }
                            List<CommentDTO> listQuestion = (List<CommentDTO>) request.getAttribute("LIST_QUESTION");
                            for (CommentDTO question : listQuestion) {
                        %>
                                <script>$('#no_question_text').hide()</script>
                                <div class="comment_item">
                                    <div class="comment_infor_section">
                                        <div class="avatar_container">
                                            <img class="organizer_ava" src="<%= question.getUserAvatar()%>" class="rounded-circle" alt="" referrerpolicy="no-referrer">
                                        </div>

                                        <div class="comment_infor">
                                            <p class="comment_username"><%= question.getUserName()%> - <%= question.getUserRoleName()%></p>
                                            <p class="comment_content"><%= question.getContents()%></p>
                                            <div class="d-flex align-items-center">
                                                <% if (!"STUDENT".equals(loginUser.getRoleName())) { %>
                                                    <p class="btn_show_reply" onclick="showAnswerReplyBox(this)">Trả lời</p>
                                                <% } %>   

                                                <% if (question.getUserId() == loginUser.getId() || (loginUser.getRoleName().equals("CLUB'S LEADER") || loginUser.getRoleName().equals("DEPARTMENT'S MANAGER") && request.getAttribute("ORGANIZER_ID").equals(loginUser.getId()))) { %>
                                                    <a class="btn_delete_question" href="deactivateQuestionAndReply?commentId=<%= question.getCommentId()%>">Xóa</a>
                                                <% } %>
                                            </div>
                                        </div>
                                    </div>

                                    <% if (!"STUDENT".equals(loginUser.getRoleName())) { %>
                                        <form class="reply_box" action ="reply" >
                                            <input class="input_reply" type="text" name="content" placeholder="Nhập nội dung câu trả lời" required/>
                                            <input type="hidden" name="commentId" value = "<%= question.getCommentId()%>"/>
                                            <input type="hidden" name="eventId" value = "<%= detail.getId()%>"/>
                                            <button onclick="sendReply()" class="btn_reply">Gửi</button>
                                            <button onclick="hideReplyBox(this)" class="btn_hide_reply mybutton btn-grey">Hủy</button>
                                        </form>
                                    <% } %>
                                </div>

                                <div class="question_answers_container">
                        <%
                                    List<ReplyDTO> listReply = question.getReplyList();
                                    for (ReplyDTO reply : listReply) { %>
                                        <div class="repComment2">
                                            <div class="repComment2a">
                                                <img src="<%= reply.getUserAvatar()%>" class="organizer_ava" class="rounded-circle" alt="" referrerpolicy="no-referrer">
                                            </div>
                                            <div class="repComment2b">
                                                <p class="comment_username"><%= reply.getUserName()%> - <%= reply.getUserRoleName()%></p>
                                                <p class="comment_content"><%= reply.getContents()%></p>
                                            </div>
                                        </div>
                                <%  } %> 
                                </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- PARTICIPANT LIST -->
    <section id="member_list" style="display: none;">
        <h4>
            DSTV Tham gia
        </h4>
        <c:if test="${empty requestScope.LIST_PARTICIPANTS}">
            <p>Chưa có người tham gia</p>
        </c:if>
        <c:if test="${not empty requestScope.LIST_PARTICIPANTS}">
            <table id="member_table">
                <tr>
                    <th>Email</th>
                    <th>Tên</th>
                </tr>
                <c:forEach var="user" items="${requestScope.LIST_PARTICIPANTS}">
                    <tr>
                        <td>${user.email}</td>
                        <td>${user.name}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        <br>
        <br>

        <!-- FOLLOWER LIST -->
        <h4>
            DSTV Quan tâm
        </h4>
        <c:if test="${empty requestScope.LIST_FOLLOWERS}">
            <p>Chưa có người quan tâm</p>
        </c:if>
        <c:if test="${not empty requestScope.LIST_FOLLOWERS}">
            <table id="member_table">
                <tr>
                    <th>Email</th>
                    <th>Tên</th>
                </tr>
                <c:forEach var="user" items="${requestScope.LIST_FOLLOWERS}">
                    <tr>
                        <td>${user.email}</td>
                        <td>${user.name}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

        <!--EXPORT EXCEL OPTION PANEL-->
        <div id="member_list_buttons">
            <button id="btn_export_excel" class="mybutton btn-green" >
                Xuất file Excel
            </button>
            <button id="btn_back_to_content" class="mybutton btn-grey" onclick="goBackToContent()" >
                Quay lại
            </button>
        </div>

        <div id="export_option_menu">
            <a class="mybutton no-show" href="downloadMemberListInExcelFile?eventId=<%=detail.getId()%>&people=participant">
                Thành viên tham gia
            </a>

            <a class="mybutton no-shadow" href="downloadMemberListInExcelFile?eventId=<%=detail.getId()%>&people=follower">
                Thành viên quan tâm
            </a>

            <a class="mybutton no-shadow" href="downloadMemberListInExcelFile?eventId=<%=detail.getId()%>&people=all">
                Tất cả
            </a>
        </div>

    </section>



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

    <link rel="profile" href="<c:url value='http://gmpg.org/xfn/11' />" />
    <script src="https://www.gstatic.com/firebasejs/7.2.0/firebase-app.js""></script>
    <script src="https://www.gstatic.com/firebasejs/7.2.0/firebase-database.js""></script>
    <script src="resources/js/function.js"></script>
    <script>
        setEventId("<%= detail.getId()%>");
        setUserId("<%= loginUser.getId()%>");
        setUserAvatar("<%= loginUser.getAvatar()%>");
        setUserRoleName("<%= loginUser.getRoleName()%>");
        setUserName("<%= loginUser.getName()%>");
        startOnAddCommentListener();
        startOnAddReplyListener();
    </script>
</body>
</html>
