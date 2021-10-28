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
    </head>
    <body>

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
                        <p id="day_render"></p>
                    </div>
                </div>

                <!-- CARE PART  -->
                <div id="care_infor_part">
                    <p class="care_infor_text"> <%= detail.getFollowing() %> người đã quan tâm</p> 
                    <div id="dot"></div>
                    <p class="care_infor_text"> <%= detail.getJoining() %> người sẽ tham gia</p>
                </div>

            </div>
        </section>

        <!-- COPY PART -->
        <!-- EVENT ORGANIZER BUTTONS  -->
    <%
        if (("CLUB'S LEADER".equals(loginUser.getRoleName()) || "DEPARTMENT'S MANAGER".equals(loginUser.getRoleName())) && (detail.getStatusId() == 1 || detail.getStatusId() == 2)) {
    %>
            <div id="menu_container">   
                <div id="menu_panel">   
        
                    <div id="btn_edit_event_details" class="menu_button">
                        <p>Chỉnh sửa thông tin sự kiện</p>
                    </div>

                        <div id="btn_edit_event_content" class="menu_sub_button">
                            <p>Nội dung sự kiện</p>
                        </div>

                        <div id="btn_edit_event_poster" class="menu_sub_button">
                            <p>Ảnh bìa</p>
                        </div>

                        <div id="btn_edit_event_time_and_lock" class="menu_sub_button">
                            <p>Thời gian và địa điểm</p>
                        </div>


                    <div type="button" data-toggle="modal" data-target="#setEvtStatus" id="btn_update_event_status" class="menu_button">
                        <p>Cập nhật trạng thái sự kiện</p>
                    </div>


                    <div id="btn_add_summary" class="menu_button">
                        <a href="addSummaryContent?eventId=1"><p>Thêm nội dung tổng kết</p></a>
                    </div>
                    

                    <div id="btn_view_member" class="menu_button">
                        <a href="viewMember?eventId=1"><p>Xem danh sách thành viên</p></a>
                    </div>

                </div>
            </div>

            <!-- Modal-->
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
                        <h5 class="my_modal_title"><%= detail.getName() %></h5>
                        <span class="status_dot green_dot"></span>
                        <span class="status_text">Sắp diễn ra</span>
                    </div>

                    <div class="modal-footer">
                      <button type="button" class="mybutton btn_close_register">Đóng đăng kí</button>
                      <button type="button" class="mybutton btn_cancel_event">Ngừng sự kiện</button>
                    </div>
                  </div>
                </div>
              </div>
    <%
        }
    %>

        <!-- COPY PART -->
                
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
                                <button onclick="waitingForSubmit(this)" class="hight" type="submit" id="a">
                                    <%
                                        if (checkJoining) {
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
                                <button onclick="waitingForSubmit(this)" class="hight" id="b">
                                    <%
                                        if (checkFollowed) {
                                    %>
                                        <img src="resources/icon/icon_cancel_white.svg" alt="">
                                        <p>Hủy Quan Tâm</p>
                                    <%
                                        } else { 
                                    %>
                                        <img src="resources/icon/icon_care_white.svg" alt="">
                                        <p>Quan Tâm</p>
                                    <%
                                        }
                                    %>
                                </button>
                            </div>
                        </form>
                    </div>
            <%
                } else if (("CLUB'S LEADER".equals(loginUser.getRoleName())) || ("DEPARTMENT'S MANAGER".equals(loginUser.getRoleName()))) {
            %> 
                    <img onclick="onMenuIconClick()" id="btn_event_operation_menu" src="resources/icon/icon_orange_hamburger_button.svg">
            <%
                }
            %>
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
            <ul class="nav nav-tabs" id="tab_container">

                <li class="nav-item" id="first_tab_button">
                    <a class="nav-link" id="home-tab" data-bs-toggle="tab" data-bs-target="#end"
                    role="tab" aria-controls="home" aria-selected="true">Tổng kết</a>
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

            <div class="tab-content" id="myTabContent">
                <!-- Tổng kết -->
                <div class="tab-pane fade show" id="end" role="tabpanel" aria-labelledby="end-tab">
                    <img id="post_image" src="resources/image/eventDetail 9.png"/>
                    <section class="navWord">
                        <h2 class="content_title w-full-parent text-center">Tổng kết sự kiện</h3>
                        <!-- <p><%= detail.getDescription()%></p> -->
                        <p>Nội dung tổng kết sự kiện ở đây. Tôi là Tăng Tấn Tài, xin chào mọi người, hy vọng sau sự kiện mọi người đã có được những giây phút thư giãn giải trí, hy vọng mọi người donate cho team chúng tôi thật nhiều để sau này còn có nhiều show hơn</p>
                    </section>   

                </div>

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
                    
                    <form id="comment_box" action="comment" name="loginBox" target="#here">
                        <input id="input_comment" type="text" placeholder="Vui lòng nhập bình luận của bạn" name="content" required/>
                        <input type="hidden" name="eventId" value="<%= detail.getId()%>"/>
                        <input onclick="sendCmt()" id="btn_enter_comment" type="button" value="Bình luận"/>
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
                        %> 
                    </div> -->
                
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
                                    <p class="btn_show_reply" onclick="showReply(this)">Trả lời</p>
                                    <form class="reply_box" action ="reply" >
                                        <input class="input_reply" type="text" name="content" placeholder="Nhập nội dung câu trả lời" required/>
                                        <input type="hidden" name="commentId" value = "<%= question.getCommentId()%>"/>
                                        <input type="hidden" name="eventId" value = "<%= detail.getId()%>"/>
                                        <input onclick="sendReply()" class="btn_reply" value="Gửi"/>
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
        let dateDOM = document.getElementById('date_render'); // 1,2,3,4,.. 31
        let dayDOM = document.getElementById('day_render'); // Mon, Tue,..
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


    <script type="text/javascript" src="js/jquery.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"
        integrity="sha384-W8fXfP3gkOKtndU4JGtKDvXbO53Wy8SZCQHczT5FMiiqmQfUpWbYdTil/SxwZgAN"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.min.js"
        integrity="sha384-skAcpIdS7UcVUC05LJ9Dxay8AXcDYfBJqt1CJ85S/CFujBsIzCIv+l9liuYLaMQ/"
        crossorigin="anonymous"></script>

    <script src="resources/js/eventDetail.js"></script>


    <!-- COPY PART -->

    <link rel="profile" href="<c:url value='http://gmpg.org/xfn/11' />" />
    <script src="https://www.gstatic.com/firebasejs/7.2.0/firebase-app.js""></script>
    <script src="https://www.gstatic.com/firebasejs/7.2.0/firebase-database.js""></script>
    <script src="resources/js/configFirebase.js"></script>
    <script src="resources/js/function.js""></script>

    <script>
        setEventId ('<%= detail.getId() %>');
        setUserId ('<%= loginUser.getId() %>');
        setUserAvatar ('<%= loginUser.getAvatar() %>');
        setUserRoleName ('<%= loginUser.getRoleName() %>');
        setUserName ('<%= loginUser.getName() %>');
        startOnAddCommentListener();
        startOnAddReplyListener();
    </script>

    <!-- COPY PART -->
<div id ="update_name_desciption">

    <input type='hidden' name="action" value="name and description"/>
    <!-- EVENT NAME -->
    <h5 class="title col-12">Tên Sự Kiện</h5>
    <input class="col-12 col-lg-7" id="input_event_name" type="text"  
           name="eventName" value="<%= detail.getName()%>">

    <!-- EVENT DESCRIPTION        -->
    <h5 class="title col-12">Nội Dung Sự Kiện</h5>
    <textarea class="col-12 col-lg-7" id="input_event_description" rows="7" cols="12"
              type="text"><%= detail.getDescription()%></textarea>
    <div id="update-desciption">
    </div>
    <button onclick="updateNameAndDescription()">Update</button>
    <form action="updateEvent" id="update-name-description-form">
    </form>
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
        function updateNameAndDescription() {
            var eventDescriptionTest = CKEDITOR.instances.input_event_description.getData();
            var eventName = document.getElementById("input_event_name").value;
            var form = document.createElement("form");
            document.body.appendChild(form);
            //form.method = "POST";
            form.action = "updateEvent";
            var inputEventId = document.createElement("INPUT");
            inputEventId.name = "eventId";
            inputEventId.value = '<%= detail.getId()%>';
            inputEventId.type = 'hidden'
            form.appendChild(inputEventId);
            var inputEventName = document.createElement("INPUT");
            inputEventName.name = "eventName";
            inputEventName.value = eventName;
            inputEventName.type = 'text';
            form.appendChild(inputEventName);
            var inputDescription = document.createElement("INPUT");
            inputDescription.name = "description";
            inputDescription.value = eventDescriptionTest;
            inputDescription.type = 'text';
            form.appendChild(inputDescription);
            form.submit();
        }
    </script>
</div>
            
            <!-- EVENT IMAGE  -->
            <h5 class="title col-12">Ảnh sự kiện</h5>

            <div id="image_container" class="col-12 col-lg-7">
                <figure id="figure_image" >
                    <img id="chosen-image" src="data:image/jpg;base64,<%= detail.getPoster() %>">
                </figure>

                <input class="d-none" type="file" id="upload-button" 
                       accept="image/*" name="fileUp" value="" style="visibility:hidden;">

                <label id="btn_upload_image" for="upload-button">
                    Chọn hình ảnh
                </label>
                <button id="btn_review" class="mt-0" onclick="sendDataToServer2()">Cập nhật</button>
            </div>
                <div id="submiter"></div>
                <script src="resources/js/create_event.js"></script>
        <script>
            function sendDataToServer2 () {
            var form = '<form id="submit_form" action="changePoster" method="POST" enctype="multipart/form-data">'
            form += '<input type="hidden" name="eventId" value="<%= detail.getId()%>" />'
            form += "</form>"    

            var eventImageBackgroundInput = document.getElementById("upload-button").cloneNode();
            eventImageBackgroundInput.style.display = "none";

            document.getElementById("submiter").innerHTML = form;
            document.getElementById("submit_form").appendChild(eventImageBackgroundInput);
            console.log(document.getElementById("submit_form").innerHTML);

            // Trigger send Request
            document.getElementById("submit_form").submit();
        }
        </script>
        <a href="changeDetailByCreatingNewEvent?stage=start&eventId=<%= detail.getId() %>">Thứ nulo mắc gì chọn datetimelocation ngoo gòi bắt t lòi l làm cho cái chức năng sửa z</a>
</body>

</html>
