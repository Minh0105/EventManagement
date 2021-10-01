<%-- 
    Document   : studentNewfeed
    Created on : Sep 30, 2021, 4:02:20 PM
    Author     : triet
--%>

<%@page import="fptu.swp.entity.event.EventCard"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang Chủ</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css"
              integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <link rel="stylesheet" href="../css/student.css">
    </head>

    <body>
        <nav class="navbar navbar-expand-md navbar-light navbar-color sticky-top">
            <div class="container-fluid ">
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
                            <a class="nav-link" href="#"><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="white" class="bi bi-bell-fill" viewBox="0 0 22 22">
                                <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
                                </svg></a>
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
        <section class="button">
            <div class="buttonWord">
                Discover the event world
            </div>

            <div class="buttonAction">

                <div class="buttonAction1">
                    <button>Top</button>
                </div>

                <div class="buttonAction2">
                    <button>This week</button>
                </div>

                <div class="buttonAction2">
                    <button>Followed</button>
                </div>
            </div>
        </section>

        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
                    <%
                        List<EventCard> listCard = (List<EventCard>) request.getAttribute("LIST_CARD");
                        if (listCard != null) {
                            for (EventCard card : listCard){
                           %>
                    <div class="item">
                        <div class="item1">
                            <img src="<%= card.getPoster() %>" alt="">
                            <div class="item1Word">
                                <p><%= card.getDate() %> - <%= card.getLocation() %> </p>
                                <h4><%= card.getName() %></h4>
                                <p><%= card.getOrganizerName()%></p>
                            </div>
                        </div>

                        <div class="item2">
                            <div class="item2Img">
                                <div class="item2Img1">
                                    <img src="../image/student4.png" alt="">
                                    <p><%= card.getFollowing()%> lượt quan tâm</p>
                                </div>
                                <div class="item2Img1">
                                    <img src="../image/student5.png" alt="">
                                    <p><%= card.getJoining()%> bạn sẽ tham gia</p>
                                </div>
                            </div>

                            <div class="item2Button">
                                <form action="viewEventDetail"
                                <input type="submit" value ="Chi tiết"> 
                                <input type="hidden" name="eventId" value="${card.id}">
                            </div>
                        </div>
                    </div>
                    <% }
                    %>
                </div>





        </div>
        <%
            }
        %>
        <section class="end">
            <h4>Developed By Aladudu Group</h4>
            <p>COVID-19, 20/9/2021</p>
        </section>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"
                integrity="sha384-W8fXfP3gkOKtndU4JGtKDvXbO53Wy8SZCQHczT5FMiiqmQfUpWbYdTil/SxwZgAN"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.min.js"
                integrity="sha384-skAcpIdS7UcVUC05LJ9Dxay8AXcDYfBJqt1CJ85S/CFujBsIzCIv+l9liuYLaMQ/"
        crossorigin="anonymous"></script>
    </body>

</html>