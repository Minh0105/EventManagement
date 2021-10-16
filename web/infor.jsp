<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link rel='stylesheet' type='text/css' media='screen' href='resources/css/view_profile_style.css'>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row">      
                <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <span class="text-black-50">${sessionScope.USER.roleName}</span>
                        <img id="big_avatar" src="${sessionScope.USER.avatar}">
                    </div>
                </div>
                <div class="col-md-5 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h2 class="text-right">Thông Tin Cá Nhân</h2>
                        </div>
                        <div class="row mt-2"> </div>             
                        <div class="row mt-3">       

                            <div class="col-md-12"><h3>${sessionScope.USER.name}</h3></div>
                            <div class="col-md-12"><h5> Email:</h5>${sessionScope.USER.email}</div>    
                            <div class="col-md-12"> <h5>Phone Number:</h5> ${sessionScope.USER.phoneNum}</div>
                            <div class="col-md-12"><h5>Address:</h5>${sessionScope.USER.address}</div>
                            <c:if test = "${sessionScope.USER.roleName ne 'STUDENT'}">
                                <div class="col-md-12"><h5>Description:</h5>${sessionScope.USER.description}</div>
                            </c:if>
                            <form class="col-md-12" action="UpdateProfilePage">
                                <button class="btn btn-primary profile-button" type="submit"><img src="resources/image/LogoUpdate.png"> Update</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>     
    </body>
</html>
