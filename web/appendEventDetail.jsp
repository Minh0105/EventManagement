<%-- 
    Document   : appendEventDetail
    Created on : Oct 3, 2021, 3:34:20 PM
    Author     : admin
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    </div>
      </div>
      <form action="handleMultipart" method="POST" enctype="multipart/form-data">
      <h2>Thông Tin Sự Kiện</h2>
      <h5>Lecturer list</h5><br>
       <h5>Choosed: </h5><br>
   
        <c:forEach var="lec" items="${sessionScope.ChosenLecturerList}" >
            <p><img class="rounded-circle lec-avatar " src="${lec.avatar}"> ${lec.name} <button type="submit" name="removeLec" value="${lec.id}">X</button></p>        
        </c:forEach>
    
    <input style="width: 700px;"  type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for names.." title="Type in a name">
     
    <ul id="myUL">
        <c:forEach var="lec" items="${sessionScope.LecturerList}" >
         <li>
                <button name="addLec" value="${lec.id}" type="submit" style="width: 700px;"  class="d-flex justify-content-start"><img class="rounded-circle lec-avatar " src="${lec.avatar}"> ${lec.name}</button>
            </li>
        </c:forEach> 
</ul>

     </div>
        <!--        FORM SEARCH TEN GIANG VIEN-->
        <!--        <form action="searchLecturer">
                    
                    <input type="submit" value="Submit" />
                </form>-->


        <!--        FORM DUA DU LIEU VE CHO ReviewEventController-->
        
            <c:set var = "eventDetail" value = "${sessionScope.EVENT_DETAIL_REVIEW}"/>
      
               <h5>Tên Sự Kiện</h5><input  type ="text" name ="eventName" value="${eventDetail.name}" style="width: 700px;">
             
               <h5>Nội Dung Sự Kiện</h5><textarea  rows="5"  type ="text" name ="description" style="width: 700px;">${eventDetail.description}</textarea>  
               <h5>Ảnh sự kiện</h5><br>
                  <div class="container">
        <figure class="image-container">
            <img id="chosen-image">
            <figcaption id="file-name"></figcaption>
        </figure>
        <input type="file" id="upload-button" accept="image/*" name="fileUp" value="">
        <label for="upload-button">
            <i class="fas fa-upload"></i> 
        </label>
     </div>
              
     <script src="resources/js/create_event.js"></script>
 <input class="btn-primary" type="submit" name="action" value="Review" />

        </form>
       
    </body>
</html>
