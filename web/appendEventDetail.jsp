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
    <script src='bootstrap/js/bootstrap.js'></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        history.forward();
    </script>
</head>

<body>
 
<div id="body" class="container-fluid">

        <!-- <c:forEach var="locationDTO" items="${sessionScope.ChosenLocationList}" >     

            <div class="date_pill col-6 col-md-4">           
                <span class="date_content">${locationDTO.name}</span>
            </div>           

        </c:forEach>       -->

    <div class="row"> 

        <div id="chosen_date_container" class="col-12 col-md-7 col-lg-6 container-fluid">
            <div class="row gx-1 gy-3">
                <div class="date_pill col-6 col-md-4">           
                    <span class="date_content">Hội trường A</span>
                </div>
    
                <div class="date_pill col-6 col-md-4">           
                    <span class="date_content">Hội trường B</span>
                </div>
    
                <div class="date_pill col-6 col-md-4">           
                    <span class="date_content">Hội trường C</span>
                </div>
            </div>
        </div>

        <!-- <div class="col-2" >         
            <p> ${sessionScope.ChosenDate}</p>
            <p> ${sessionScope.ChosenTimeRange}</p>
        </div> -->

        <div id="chosen_date_time_container" class="col-7 col-md-3 col-lg-5">
            <p id="chosen_date"> 20/09/2001 </p>
            <p id="chosen_time"> 1 - 3 (7:00 AM - 12:00 AM)</p>
        </div>

        <div class="col-5 col-md-2 col-lg-1">
            <button id="btn_back" class="button btn-primary" onclick="goBackToDateAndTimeScreen()">
                Quay trở lại
            </button>
        </div>

    </div>

    <!-- DELETED: <form action="handleMultipart" method="POST" enctype="multipart/form-data"> -->
    <c:set var="eventDetail" value="${sessionScope.EVENT_DETAIL_REVIEW}" />

    <h5>Tên Sự Kiện</h5>
    <!-- value="${eventDetail.name}" -->
    <input id="input_event_name" type="text" 
           name="eventName" style="width: 700px;">
   
    <h5>Nội Dung Sự Kiện</h5>
    <textarea id="input_event_description" rows="5" type="text"
              name="description" style="width: 700px;">
              <!-- ${eventDetail.description} -->
    </textarea>
    
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
        <c:forEach var="chosenLec" items="${sessionScope.ChosenLecturerList}">
            <p>
                 <img class="rounded-circle lec-avatar " src="${chosenLec.avatar}"> 
                 <span>${chosenLec.name}</span>
                 <button onclick="onRemoveChosenLecturerClick(this)" name="removeLec">X</button>
                 <input class="chosen_lecturer" type="hidden" name="chosen_lecturer" value="${chosenLec.id}"/>
            </p>
        </c:forEach>
    </div>
    
    <input style="width: 700px;" type="text" id="myInput" onkeyup="myFunction()"
        placeholder="Search for names.." title="Type in a name">

    <ul id="myUL">
        <c:forEach var="lec" items="${sessionScope.LecturerList}">
            <c:if test="${not sessionScope.ChosenLecturerList.contains(lec)}" >
                <li>
                    <button onclick="onChooseLecturer(this)" class="lecturer_infor" value="${lec.id}" style="width: 700px;"
                            class="d-flex justify-content-start">

                        <img class="rounded-circle lec-avatar" src="${lec.avatar}"> 
                        <span class="lec_name">${lec.name}</span>
                    </button>
                </li>
            </c:if>
                
            <!--HIDING CHOSEN LECTURER, watch li display will be "none"-->
            <c:if test="${sessionScope.ChosenLecturerList.contains(lec)}" >
                <li style="display: none">
                    <button onclick="onChooseLecturer(this)" class="lecturer_infor" value="${lec.id}" style="width: 700px;"
                            class="d-flex justify-content-start">

                        <img class="rounded-circle lec-avatar" src="${lec.avatar}"> 
                        <span class="lec_name">${lec.name}</span>
                    </button>
                </li>
            </c:if>
            
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

</div>

</body>

</html>