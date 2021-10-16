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
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css"
              integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">

        <!--        <script src='bootstrap/js/bootstrap.js'></script>-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="resources/sweetalert2.all.min.js"></script>  
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <link rel="stylesheet" type="text/css" href="resources/css/eventDetail.css"/>
        <link rel='stylesheet' type='text/css' media='screen' href='resources/css/style.css'>
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
        </nav>

        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("USER");
            EventDetailDTO detail = (EventDetailDTO) request.getAttribute("EVENT_DETAIL");
            List<LecturerBriefInfoDTO> listLecturer = (List<LecturerBriefInfoDTO>) request.getAttribute("LIST_LECTURER");
        %>
        <section class="second">
            <div class="second1">
                <img src="data:image/jpg;base64,<%= detail.getPoster()%>" alt="">
            </div>

            <div class="second2">
                <div class="second2Img">
                    <img src="resources/image/image_calendar_background.svg" alt="">

                    <!------------------Thêm ngày  và thứ ------------------------------------------------------->
                    <div class="numberDay">
                        <h3 id="dateRender"> <%= detail.getDate()%></h3>
                        <p id="dayRender"></p>
                    </div>

                    <!---------------------------------------------------------------------------------------------->
                </div>

                <div class="second2Line">
                    <div class="second2Line1">
                        <p class="people"> <%= detail.getFollowing()%> người đã quan tâm</p> 
                    </div>
                    <div class="dot"></div>
                    <div class="second2Line1">
                        <p class="people"><%= detail.getJoining()%> người sẽ tham gia</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="carousel">
            <div class="carouselWrite">
                <h3><%= detail.getDate()%> - <%= detail.getLocation()%> <br>
                    <%= detail.getTime()%>
                </h3>
            </div>
            <%
                if ("STUDENT".equals(loginUser.getRoleName()) && detail.getStatusId() == 1) {
                    boolean checkFollowed = (boolean) request.getAttribute("IS_FOLLOWED");
                    boolean checkJoining = (boolean) request.getAttribute("IS_JOINING");
            %>

            <div class="carouselButton">
                <form action="joinEvent">
                    <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                    <input type="hidden" name="isJoining" value="<%= checkJoining%>"/>
                    <div class="carouselButton1">
                        <button class="hight" type="submit" id="a">
                            <%if (checkJoining) {
                            %>
                            <img src="resources/icon/icon_cancel_white.svg" alt="">
                            <p>Hủy Tham Gia</p>
                            <%
                            } else {
                            %>
                            <img src="resources/icon/icon_join_white.svg" alt="">
                            <p>Sẽ Tham Gia</p>
                            <%
                                }
                            %>
                        </button>
                    </div>
                </form>
                <form action="followEvent">
                    <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                    <input type="hidden" name="isFollowed" value="<%= checkFollowed%>"/>
                    <div class="carouselButton1" type="submit">
                        <button class="hight" id="b">
                            <%if (checkFollowed) {
                            %>
                            <img src="resources/icon/icon_cancel_white.svg" alt="">
                            <p>Hủy Quan Tâm</p>
                            <%
                            } else { %>
                            <img src="resources/icon/icon_care_white.svg" alt="">
                            <p>Quan Tâm</p>
                            <%
                                    }
                                }
                            %>
                        </button>
                    </div>
                </form>
            </div>
            <%
                if (("CLUB'S LEADER".equals(loginUser.getRoleName()) || "DEPARTMENT'S MANAGER".equals(loginUser.getRoleName())) && (detail.getStatusId() == 1 || detail.getStatusId() == 2)) {
            %>
            <div class="carouselButton">
                <% if (detail.getStatusId() == 1 || detail.getStatusId() == 2) {
                %>
                <form action="setEventStatus" method="POST">
                    <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                    <div class="carouselButton1">

                        <!-- button trigger modal-->
                        <button class="btn btn-primary hight" type="button" id="a" data-toggle="modal" data-target="#setEvtStatus">
                            <!--                            <img src="resources/icon/icon_cancel_white.svg" alt="">-->
                            <p>Sửa trạng thái</p>
                        </button>

                        <!-- Modal-->
                        <div class="modal fade" id="setEvtStatus" tabindex="-1" aria-labelledby="setEventModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="setEventModalLabel">Sửa trạng thái sự kiện <%= detail.getName()%></h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <select name="eventStatus">
                                            <option value="2">Đóng đăng kí</option>
                                            <option value="3">Đã kết thúc</option>
                                        </select>
                                        <br>
                                        <input type="checkbox" id="export" name="export" value="yes">
                                        <label for="isExporting">Xuất file Excel thành viên tham dự</label><br>
                                    </div>
                                    <div class="modal-footer">
                                        <form action=""
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Lưu</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <%
                    }
                    if (detail.getStatusId() == 1) {
                %>
                <form action="updateEvent" method="POST">
                    <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                    <div class="carouselButton1" type="submit">
                        <button class="hight" id="b">
                            <!--                            <img src="resources/icon/icon_cancel_white.svg" alt="">-->
                            <p>Sửa thông tin</p>
                        </button>
                    </div>
                </form>
                <%
                        }
                    }
                %>
            </div>

        </section>

        <section class="fast">
            <div class="fastWord">
                <marquee direction="up" behavior="slide" loop = "2" scrollamount="5" word-break: keep-all;">
                         <%= detail.getName()%>
            </marquee>
            <p><%= detail.getOrganizerName()%></p>
        </div>
    </section>

    <div id="grey_line"></div>

    <!-- nav -->
    <section id="content">
        <ul class="nav" id="tab_container">
            <li class="nav-item" id="home_tab_button">
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

        <div class="tab-content" id="myTabContent">
            <!-- Giới Thiệu -->
            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                <section class="navWord">
                    <h2 class="content_title">Nội Dung Sự Kiện</h3>
                        <p><%= detail.getDescription()%></p>
                </section>   
                <!-- Giảng Viên -->
                <section class="single">
                    <h2 class="content_title">
                        Giảng Viên
                        </h3>
                </section>
                <!-- Thẻ -->
                <section id="lecturer_section">
                    <div id="lecturer_container" class="container">
                        <div id="lecturer_row" class="row">
                            <%
                                for (LecturerBriefInfoDTO lecturer : listLecturer) {
                            %>
                            <div class="col-lg-4 col-md-6 col-sm-12 col-xs-6">
                                <div class="lecturer_card">
                                    <div class="lec_ava_container">
                                        <img src="<%= lecturer.getAvatar()%>" class="rounded-circle" alt="">
                                    </div>
                                    <h4><%= lecturer.getName()%></h4>
                                    <h5><%= lecturer.getDescription()%></h5>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </section>
                <!-- người tổ chức -->
                <h2 class="content_title">Người Tổ Chức</h3>
                    <div class="organizer_container">
                        <img src="<%= detail.getOrganizerAvatar()%>" class="rounded-circle" alt="">
                        <div class="organizer_infor">
                            <h5><%= detail.getOrganizerName()%></h5>
                            <p><%= detail.getOrganizerDescription()%></p>
                        </div>
                    </div>

            </div>
            <!-- Comment -->
            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                <div id="comment">
                    <form id="comment_box" action="comment" name="loginBox" target="#here">
                        <input id="input_comment" type="text" placeholder="Vui lòng nhập bình luận của bạn" name="content" required/>
                        <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                        <input id="btn_enter_comment" type="submit" value="Bình luận"/>
                    </form>
                    <%
                        List<CommentDTO> listComment = (List<CommentDTO>) request.getAttribute("LIST_COMMENT");
                        for (CommentDTO comment : listComment) {
                    %>
                    <div class="comment_item">
                        <div class="avatar_container">
                            <img class="rounded-circle lec_avatar" src="<%= comment.getUserAvatar()%>" alt="">
                        </div>

                        <div class="comment_infor">
                            <p class="comment_username"><%= comment.getUserName()%> - <%= comment.getUserRoleName()%></p>
                            <p class="comment_content"><%= comment.getContents()%></p>
                            <p class="btn_show_reply" onclick="showReply(this)">Trả lời</p>

                            <form class="reply_box" action ="reply" >
                                <input class="input_reply" type="text" name="content" placeholder="Trả lời..." required/>
                                <input type="hidden" name="commentId" value = "<%= comment.getCommentId()%>"/>
                                <input type="hidden" name="eventId" value = "<%= detail.getId()%>"/>
                                <input class="btn_reply" type="submit" value="Gửi"/>
                            </form>

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
                    %>
                </div>
            </div>

            <!-- Hỏi Đáp -->
            <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
                <div class="ask">
                    <%
                        if ("STUDENT".equals(loginUser.getRoleName())) {
                    %>
                    <form action ="askQuestion">
                        <textarea id="input_question" type="text" placeholder="Vui lòng nhập câu hỏi của bạn....." name="content" required></textarea>

                        <div style="width: 100%; display:flex; justify-content:flex-end">
                            <button id="btn_enter_question" type="submit" class="sendButton">Gửi</button>
                        </div>

                        <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>

                    </form>
                    <%
                        }
                        List<CommentDTO> listQuestion = (List<CommentDTO>) request.getAttribute("LIST_QUESTION");
                        for (CommentDTO question : listQuestion) {
                    %>
                    <div class="comment_item">
                        <div class="avatar_container">
                            <img class="rounded-circle lec_avatar" src="<%= question.getUserAvatar()%>" class="rounded-circle" alt="">
                        </div>

                        <div class="comment_infor">
                            <p class="comment_username"><%= question.getUserName()%> - <%= question.getUserRoleName()%></p>
                            <p class="comment_content"><%= question.getContents()%></p>

                            <%
                                if (!"STUDENT".equals(loginUser.getRoleName())) {
                            %>
                            <form class="reply_box" action ="reply" >
                                <input class="input_reply" type="text" name="content" placeholder="Nhập nội dung" required/>
                                <input type="hidden" name="commentId" value = "<%= question.getCommentId()%>"/>
                                <input type="hidden" name="eventId" value = "<%= detail.getId()%>"/>
                                <input class="btn_reply" type="submit" value="Gửi"/>
                            </form>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <%
                        List<ReplyDTO> listReply = question.getReplyList();
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
                    %>
                </div>
            </div>


        </div>
    </div>
</section>


<!--END-->
<section class="end">
    <h4>Developed By Aladudu Group</h4>
    <p id = "date"></p>
</section>

<!-- -------------------------gắn link------------------------------- -->

<script>
    let dateDOM = document.getElementById('dateRender'); // 1,2,3,4,.. 31
    let dayDOM = document.getElementById('dayRender'); // Mon, Tue,..
    if (dateDOM && dayDOM) {
        let d1 = "<%= detail.getDate()%>";
        let subStringDate = d1.substring(d1.length - 8, d1.length - 10);
        let subStringDay = d1.substring(0, d1.indexOf(","));
        dateDOM.innerHTML = subStringDate;
        dayDOM.innerHTML = subStringDay;
    }
    var d = new Date();
    var thang = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
    document.getElementById("date").innerHTML = "COVID-19, "
            + d.getDate() + "/" + thang[d.getMonth()] + "/" +
            +d.getFullYear();
</script>

<!-- click chuột đổi màu button  -->
<script type="text/javascript" id="a">
    $('#a').click(function () {
        if (!$(this).hasClass('red')) {
            $(this).removeClass('blue').addClass('red');
        } else {
            $(this).removeClass('red').addClass('blue');
            ;
        }

    });
    $('#b').click(function () {
        if (!$(this).hasClass('red')) {
            $(this).removeClass('blue').addClass('red');
        } else {
            $(this).removeClass('red').addClass('blue');
            ;
        }

    });

</script>


<!--     comment ko dùng nút 
      
    <script type="text/javascript">
        // Using jQuery.

        $(function () {
            $('form').each(function () {
                $(this).find('input').keypress(function (e) {
                    // Enter pressed?
                    if (e.which == 10 || e.which == 13) {
                        this.form.submit();
                    }
                });

                $(this).find('input[type=submit]').hide();
            });
        });
    </script>-->

<script type="text/javascript" src="js/jquery.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"
        integrity="sha384-W8fXfP3gkOKtndU4JGtKDvXbO53Wy8SZCQHczT5FMiiqmQfUpWbYdTil/SxwZgAN"
crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.min.js"
        integrity="sha384-skAcpIdS7UcVUC05LJ9Dxay8AXcDYfBJqt1CJ85S/CFujBsIzCIv+l9liuYLaMQ/"
crossorigin="anonymous"></script>

<script src="resources/js/eventDetail.js">

</script>

</body>

</html>