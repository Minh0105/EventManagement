<%-- 
    Document   : nav_bar
    Created on : Oct 16, 2021, 1:49:26 PM
    Author     : tangtantai
--%>

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

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="resources/sweetalert2.all.min.js"></script>  
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <link rel="stylesheet" type="text/css" href="resources/css/nav_bar.css"/>
        <link rel="stylesheet" type="text/css" href="resources/css/notification.css"/>
    </head>
    <body>
        <nav class="navbar navbar-expand-md navbar-light navbar-color sticky-top">
            <div id="nav_content" class="container-fluid">
                <a id="navbar_branch" href="viewNewfeed">
                    <img id="app_icon" src="resources/icon/app_icon.svg">
                    <h5 class="d-none d-md-block">FPT Event Management</h5>
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" 
                        data-target="#navbarResponsive">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul id="nav_infor_part" class="navbar-nav ml-auto nav-margin">
                        <li class="nav-item">
                            <a id="icon_name_container" class="nav-link" href="ViewInfoPage"> 
                                <img id="avatar_icon" class="rounded-circle" src="${sessionScope.USER.avatar}"  referrerpolicy="no-referrer"/>
                                <span id="avatar_name" class="text-white">${sessionScope.USER.name}</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link">
                                <img id="btn_bell" src="resources/icon/bell_icon.svg" alt="Bell_icon" />
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                        <a href="#" class="nav-link">
                            <img id="btn_menu" src="resources/icon/hamburger_button_icon.svg" alt="hamburger_button" />
                            </a>
                        </li>
                        
                        <div id="notification_board" >
                            <div id="notif_header">
                                <p>Thông báo</p>
                            </div>
                            <div id="notif_body">
                            </div>
                        </div>

                        <div id="nav_expanded_panel">

                                <div id="logout_button_panel">
                                    <a id="logout_link" href="logout">
                                        <img src="resources/icon/log_out_icon.svg" />
                                        <span id="btn_log_out">Log out</span> 
                                    </a> 
                                </div>

                                <div id="logout_button_panel">
                                    <a id="logout_link" href="redirectListEvent?action=all">
                                        <img src="resources/icon/log_out_icon.svg" />
                                        <span id="btn_log_out">View All Event</span> 
                                    </a> 
                                </div>
                            <c:if test="${sessionScope.USER.roleName eq 'STUDENT'}">
                                <div id="logout_button_panel">
                                    <a id="logout_link" href="redirectListEvent?action=joined">
                                        <img src="resources/icon/log_out_icon.svg" />
                                        <span id="btn_log_out">View Joined Event</span> 
                                    </a> 
                                </div>
                            </c:if>
                            <c:if test="${sessionScope.USER.roleName eq 'LECTURER'}">
                                <div id="logout_button_panel">
                                    <a id="logout_link" href="redirectListEvent?action=added">
                                        <img src="resources/icon/log_out_icon.svg" />
                                        <span id="btn_log_out">View Added Event</span> 
                                    </a> 
                                </div>
                            </c:if>
                        </div>   	
                    </ul>
                </div>
            </div>
        </nav>

        <script src="https://www.gstatic.com/firebasejs/7.2.0/firebase-app.js""></script>
        <script src="https://www.gstatic.com/firebasejs/7.2.0/firebase-database.js""></script>
        <script src="resources/js/nav_bar.js"></script>
        <script src="resources/js/configFirebase.js"></script>
        <script src="resources/js/realtime_notification.js"></script>
        <script>
            listenNotification("${sessionScope.USER.id}");
        </script>
</html>
