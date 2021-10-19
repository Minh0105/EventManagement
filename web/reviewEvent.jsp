<%-- 
    Document   : reviewEvent
    Created on : Oct 6, 2021, 12:53:55 AM
    Author     : triet
--%>

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
        <%
            EventDetailDTO detail = (EventDetailDTO) session.getAttribute("EVENT_DETAIL_REVIEW");
            List<LecturerBriefInfoDTO> listLecturer = (List<LecturerBriefInfoDTO>) session.getAttribute("ChosenLecturerList");
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
        <section class="fast">
            <div class="fastWord">
                <marquee direction="up" behavior="slide" loop = "2" scrollamount="5" word-break: keep-all;">
                         <%= detail.getName()%>
            </marquee>
            <p><%= detail.getOrganizerName()%></p>
        </div>
    </section>

    <div id="grey_line"></div>
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
    <a href="createEvent">CREATE EVENT</a>
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
//        var d = new Date();
//        var thang = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
//        document.getElementById("date").innerHTML = "COVID-19, "
//                + d.getDate() + "/" + thang[d.getMonth()] + "/" +
//                +d.getFullYear();
    </script>
    <script type="text/javascript" src="js/jquery.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"
            integrity="sha384-W8fXfP3gkOKtndU4JGtKDvXbO53Wy8SZCQHczT5FMiiqmQfUpWbYdTil/SxwZgAN"
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.min.js"
            integrity="sha384-skAcpIdS7UcVUC05LJ9Dxay8AXcDYfBJqt1CJ85S/CFujBsIzCIv+l9liuYLaMQ/"
    crossorigin="anonymous"></script>

    <script src="resources/js/eventDetail.js"></script>
</body>


</html>

