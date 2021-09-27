<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset='utf-8'>
        <meta http-equiv='X-UA-Compatible' content='IE=edge'>
        <title>Profile</title>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link rel='stylesheet' type='text/css' media='screen' href='resources/css/style.css'>
        <script src='bootstrap/js/bootstrap.js'></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="resources/sweetalert2.all.min.js"></script> 
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
	             <ul class="navbar-nav ml-auto">
		<li class="nav-item">
                                        <a class="nav-link active rounded-circle" href="ViewInfoPage"> <img class="nav-avatar rounded-circle" src="${sessionScope.USER.avatar}"> ${sessionScope.USER.name}</img></a>
		</li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#"><svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="white" class="bi bi-bell-fill" viewBox="0 0 22 22">
                                <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zm.995-14.901a1 1 0 1 0-1.99 0A5.002 5.002 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901z"/>
                              </svg></a>
	           </li>
                            <li class="nav-item dropdown">
                              
                                 <a class="nav-link" href="#" id="navbarDropdown " role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row">
                <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <span class="text-black-50">${sessionScope.USER.roleName}</span><span> </span>
                        <img class="round " src="${sessionScope.USER.avatar}">
                    </div>
                </div>
                <div class="col-md-5 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h2 class="text-right">Update Profile</h2>
                        </div>
                        <div class="row mt-2"> </div>
                            <form action="updateProfile">
                                    <div class="row mt-3">       
                            <div class="col-md-12"><label class="labels">Name</label><input type="text" class="form-control" placeholder="your name" name ="name" value="${sessionScope.USER.name}"></div>                                           
                            <div class="col-md-12"><label class="labels">Phone Number</label><input type="text" class="form-control" placeholder="enter phone number" name="phoneNum" value="${sessionScope.USER.phoneNum}"></div>
                            <div class="col-md-12"><label class="labels">Address</label><input type="text" class="form-control" placeholder="enter address" name="address" value="${sessionScope.USER.address}" ></div>
                            <div class="col-md-12"><label class="labels">Email</label><input type="text" class="form-control" placeholder="${sessionScope.USER.email}" value="" readonly=""></div>

                        </div>
                              
                        <div class="mt-5 text-right"><button class="btn btn-primary profile-button" type="submit"><img src="resources/image/LogoUpdate.png"> Update</button></div>
                        </form>
                    </div>
                </div>    
            </div>
        </div>
</body>
</html>