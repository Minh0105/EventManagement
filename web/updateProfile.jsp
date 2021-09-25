<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset='utf-8'>
        <meta http-equiv='X-UA-Compatible' content='IE=edge'>
        <title>Profile</title>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link rel='stylesheet' type='text/css' media='screen' href='css/style.css'>
        <script src='bootstrap/js/bootstrap.js'></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <nav class="navbar navbar-expand-md navbar-light bg-light sticky-top">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <img src="image/FPTlogo.png">
                </a>

            </div>
        </nav>
        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row">
                <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <span class="text-black-50">Student</span><span> </span>
                        <img class="round " src="image/Avatar.jpg">
                    </div>
                </div>
                <div class="col-md-5 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-right">Cáº­p Nháº­t ThÃ´ng Tin CÃ¡ NhÃ¢n</h4>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-12"><label class="labels">Name</label><input type="text" class="form-control" placeholder="your name" value=""></div>

                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12"><label class="labels">Phone Number</label><input type="text" class="form-control" placeholder="enter phone number" value=""></div>
                            <div class="col-md-12"><label class="labels">Address</label><input type="text" class="form-control" placeholder="enter address" value=""></div>
                            <div class="col-md-12"><label class="labels">Email</label><input type="text" class="form-control" placeholder="enter email id" value=""></div>

                        </div>

                        <div class="mt-5 text-right"><button class="btn btn-primary profile-button" type="button"><img src="image/LogoUpdate.png"> Cáº­p Nháº­t</button></div>
                    </div>
                </div>    
            </div>
        </div>
</body>
</html>