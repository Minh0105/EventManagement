<%-- Document : appendEventDetail Created on : Oct 3, 2021, 3:34:20 PM Author : admin --%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Create Event</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='resources/css/create_event.css'>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        history.forward();
    </script>
</head>

<body>
    <div class="row"> 
        <c:forEach var="locationDTO" items="${sessionScope.ChosenLocationList}" >          
            
            <div class="card" style="width: 12rem;">           
            <div class="card-body">${locationDTO.name}</div>
            </div>

        </c:forEach>      

        <div class="col-2" >         
            <p> ${sessionScope.ChosenDate}</p>
            <p> ${sessionScope.ChosenTimeRange}</p>
        </div>

    </div>

    <!-- DELETED: <form action="handleMultipart" method="POST" enctype="multipart/form-data"> -->
    <h2>Thông Tin Sự Kiện</h2>
    <c:set var="eventDetail" value="${sessionScope.EVENT_DETAIL_REVIEW}" />

    <h5>Tên Sự Kiện</h5>
    <input id="input_event_name" type="text" name="eventName" value="${eventDetail.name}"
           style="width: 700px;">
   
    <h5>Nội Dung Sự Kiện</h5>
    <textarea id="input_event_description" rows="5" type="text" name="description"
              style="width: 700px;">${eventDetail.description}</textarea>
    
    <h5>Ảnh sự kiện</h5>
    <br>
    <div class="container">

        <figure id="figure_image" class="image-container">
            <img id="chosen-image">
            <figcaption id="file-name"></figcaption>
        </figure>

        <input type="file" id="upload-button" accept="image/*" name="fileUp" value="">

        <label for="upload-button">
            <i class="fas fa-upload"></i>
        </label>

    </div>
    <!-- DELETED: </form> -->

    <h5>Lecturer list</h5><br>
    <h5>Choosed: </h5><br>

    <div id="chosen_lecturer_container">
        
    </div>
    
    <input style="width: 700px;" type="text" id="myInput" onkeyup="myFunction()"
        placeholder="Search for names.." title="Type in a name">

    <ul id="myUL">
        <c:forEach var="lec" items="${sessionScope.LecturerList}">
            <li>
                <button onclick="onChooseLecturer(this)" class="lecturer_infor" value="${lec.id}" style="width: 700px;"
                        class="d-flex justify-content-start">
                    
                    <img class="rounded-circle lec-avatar" src="${lec.avatar}"> 
                    <span class="lec_name">${lec.name}</span>
                </button>
            </li>
        </c:forEach>
    </ul>

    </div>

    <!-- FORM SEARCH TEN GIANG VIEN
    <form action="searchLecturer">
        <input type="submit" value="Submit" />
    </form> -->

    <div id="submiter">

    </div>

    <script src="resources/js/create_event.js"></script>
    <span class="btn-primary p-3" onclick="sendDataToServer()">Review</span>

</body>

</html>