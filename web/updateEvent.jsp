<%-- 
    Document   : updateEvent
    Created on : Nov 10, 2021, 11:37:18 AM
    Author     : triet
--%>

<%@page import="fptu.swp.entity.event.EventDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa sự kiện</title>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="resources/sweetalert2.all.min.js"></script> 

        <!--        <script src='bootstrap/js/bootstrap.js'></script>-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="resources/css/eventDetail.css"/>
        <script src="resources/ckeditor/ckeditor.js"></script>
    </head>
    <body>

        <%
            EventDetailDTO detail = (EventDetailDTO) request.getAttribute("UPDATING_EVENT");
        %>
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
                    form.method = "POST";
                    form.action = "updateEvent";
                    var inputEventId = document.createElement("INPUT");
                    inputEventId.name = "eventId";
                    inputEventId.value = '<%= detail.getId()%>';
                    inputEventId.type = 'hidden'
                    form.appendChild(inputEventId);
                    var inputEventName = document.createElement("INPUT");
                    inputEventName.name = "eventName";
                    inputEventName.value = eventName;
                    inputEventName.type = 'hidden';
                    form.appendChild(inputEventName);
                    var inputDescription = document.createElement("INPUT");
                    inputDescription.name = "description";
                    inputDescription.value = eventDescriptionTest;
                    inputDescription.type = 'hidden';
                    form.appendChild(inputDescription);
                    form.submit();
                }
            </script>
        </div>

        <!-- EVENT IMAGE  -->
        <h5 class="title col-12">Ảnh sự kiện</h5>

        <div id="image_container" class="col-12 col-lg-7">
            <figure id="figure_image" >
                <img id="chosen-image" src="data:image/jpg;base64,<%= detail.getPoster()%>">
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
                function sendDataToServer2() {
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
        
        <a href="changeDetailByCreatingNewEvent?stage=start&eventId=<%= detail.getId()%>">Thứ nulo mắc gì chọn datetimelocation ngoo gòi bắt t lòi l làm cho cái chức năng sửa z</a>
    </body>
</html>
