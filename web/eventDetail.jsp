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
            <div class="container-fluid " >
                <a class="navbar-branch" href="#">
                    <img src="resources/image/FPTlogo.png" height="50">
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" 
                        data-target="#navbarResponsive">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto nav-margin">
                        <li class="nav-item">
                            <a class="nav-link active rounded-circle" href="ViewInfoPage"> <img class="nav-avatar rounded-circle" src="${sessionScope.USER.avatar}"> ${sessionScope.USER.name}</img></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="white" class="bi bi-bell-fill" viewBox="0 0 22 22">
                                <path class="titleRight2Bell" d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>

                                </svg>
                            </a>
                        </li>
                        <li class="nav-item dropdown">

                            <a class="nav-link  toggle" href="#" id="navbarDropdown " role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="white" class="bi bi-list" viewBox="0 0 22 22">
                                <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
                                </svg>
                            </a>   

                            <form action="logout" class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                                <button class="btn btn-outline-light profile-button logout " type="submit"><img src="resources/icon/log_out_logo.png">Log Out</button> 
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
                    <img src="resources/image/eventDetail1.png" alt="">

  <!------------------Thêm ngày  và thứ ------------------------------------------------------->
                     <div class="numberDay">
                    <h3 id="dateRender"> <%= detail.getDate()%></h3>
                    <p id="dayRender"></p>
                </div>
  
 <!---------------------------------------------------------------------------------------------->
                </div>

                <div class="second2Line">
                    <div class="second2Line1">
                        <div class="dot"></div>
                        <p class="people"> <%= detail.getFollowing()%> người đã quan tâm</p> 
                    </div>
                    <div class="second2Line1">
                        <div class="dot"></div>
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
                if ("STUDENT".equals(loginUser.getRoleName())) {
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
                            <img src="resources/image/eventDetail 2.png" alt="">
                            <p>Hủy Tham Gia</p>
                            <%
                            } else {
                            %>
                            <img src="resources/image/eventDetail 2.png" alt="">
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
                            <img src="resources/image/eventDetail 3.png" alt="">
                            <p>Hủy Quan Tâm</p>
                            <%
                            } else { %>
                            <img src="resources/image/eventDetail 3.png" alt="">
                            <p>Quan Tâm</p>
                            <%
                                    }
                                }
                            %>
                        </button>
                    </div>
                </form>
            </div>

        </section>

        <section class="fast">
            <div class="fastWord">
                <marquee direction="up" behavior="slide" loop = "2" scrollamount="5" style="font-size: 50px; word-break: keep-all;">
                    <%= detail.getName()%>
                </marquee>
                <p><%= detail.getOrganizerName()%></p>
            </div>
        </section>
        <!-- nav -->
        <section class="text">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button"
                            role="tab" aria-controls="home" aria-selected="true">Giới Thiệu </button>
                </li>

                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button"
                            role="tab" aria-controls="profile" aria-selected="false">Thảo Luận</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#contact" type="button"
                            role="tab" aria-controls="contact" aria-selected="false">Hỏi Đáp</button>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <!-- Giới Thiệu -->
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                    <section class="navWord">
                        <h3>Nội Dung Sự Kiện</h3>
                        <p><%= detail.getDescription()%></p>
                    </section>   
                    <!-- Giảng Viên -->
                    <section class="single">
                        <h3>
                            Giảng Viên
                        </h3>
                    </section>
                    <!-- Thẻ -->
                    <section>
                        <div class="container">
                            <div class="row">
                                <%
                                    for (LecturerBriefInfoDTO lecturer : listLecturer) {
                                %>
                                <div class="col-lg-4 col-md-6 col-sm-12 col-xs-6">
                                    <div class="item">
                                        <div>
                                            <img src="<%= lecturer.getAvatar()%>" class="rounded-circle" alt="">
                                        </div>
                                        <h5><%= lecturer.getName()%></h5>
                                        <p><%= lecturer.getDescription()%></p>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </section>
                    <!-- người tổ chức -->
                    <section class="next">
                        <div class="next1">
                            <h4>Người Tổ Chức</h4>
                        </div>

                        <div class="next2">
                            <img src="<%= detail.getOrganizerAvatar()%>" class="rounded-circle" alt="">
                            <div class="next2Document">
                                <h5><%= detail.getOrganizerName()%></h5>
                                <p><%= detail.getOrganizerDescription()%></p>
                            </div>
                        </div>
                    </section> 
                </div>
                <!-- Comment -->
                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                    <div class="comment">
                        <form action ="comment" name="loginBox" target="#here">
                            <input type="text" placeholder="Vui lòng nhập bình luận của bạn" name="content" required/>
                            <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                            <input type="submit" value="Comment"/>
                        </form>
                        <%
                            List<CommentDTO> listComment = (List<CommentDTO>) request.getAttribute("LIST_COMMENT");
                            for (CommentDTO comment : listComment) {
                        %>
                        <div class="avatarComment">
                            <div class="avatarComment1">
                                <img src="<%= comment.getUserAvatar()%>" class="rounded-circle " alt="">
                            </div>

                            <div class="avatarComment2">
                                <h5><%= comment.getUserName()%> - <%= comment.getUserRoleName()%></h5>
                                <p><%= comment.getContents()%></p>

                                <form action ="reply" >
                                    <input type="text" name="content" placeholder="Trả lời..." required/>
                                    <input type="hidden" name="commentId" value = "<%= comment.getCommentId()%>"/>
                                    <input type="hidden" name="eventId" value = "<%= detail.getId()%>"/>
                                    <input type="submit" value="Gửi"/>
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
                                <h5><%= reply.getUserName()%> - <%= reply.getUserRoleName()%></h5>
                                <p><%= reply.getContents()%></p>
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
                            <textarea type="text" placeholder="Vui lòng nhập câu hỏi của bạn....." name="content" required></textarea>
                            <div style="width: 100%; display:flex; justify-content:flex-end">
                                <button type="submit" class="sendButton">Gửi</button>
                            </div>
                            <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>

                        </form>
                        <%
                            }
                            List<CommentDTO> listQuestion = (List<CommentDTO>) request.getAttribute("LIST_QUESTION");
                            for (CommentDTO question : listQuestion) {
                        %>
                        <div class="avatarComment">
                            <div class="avatarComment1">
                                <img src="<%= question.getUserAvatar()%>" class="rounded-circle" alt="">
                            </div>

                            <div class="avatarComment2">
                                <h5><%= question.getUserName()%> - <%= question.getUserRoleName()%></h5>
                                <p><%= question.getContents()%></p>

                                <%
                                    if (!"STUDENT".equals(loginUser.getRoleName())) {
                                %>
                                <form action ="reply" >
                                    <input type="text" name="content" placeholder="Trả lời..." required/>
                                    <input type="hidden" name="commentId" value = "<%= question.getCommentId()%>"/>
                                    <input type="hidden" name="eventId" value = "<%= detail.getId()%>"/>
                                    <input type="submit" value="Gửi"/>
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
                                <img src="<%= reply.getUserAvatar()%>" class="rounded-circle" alt="">
                            </div>

                            <div class="repComment2b">
                                <h5><%= reply.getUserName()%> - <%= reply.getUserRoleName()%></h5>
                                <p><%= reply.getContents()%></p>
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
            + d.getFullYear();
    </script>

    <!-- click chuột đổi màu button  -->
    <script type="text/javascript" id="a">
        $('#a').click(function () {
            if (!$(this).hasClass('red')) {
                $(this).removeClass('blue').addClass('red');
            } else {
                $(this).removeClass('red').addClass('blue');;
            }

        }); $('#b').click(function () {
            if (!$(this).hasClass('red')) {
                $(this).removeClass('blue').addClass('red');
            } else {
                $(this).removeClass('red').addClass('blue');;
            }

        });

    </script>


<!--     comment ko dùng nút gửi  
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


</body>

</html>