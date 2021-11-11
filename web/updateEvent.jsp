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
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link rel='stylesheet' type='text/css' media='screen' href='resources/css/create_event.css'>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="resources/ckeditor/ckeditor.js"></script>
    </head>
    <body>

        <nav class="navbar navbar-expand-md navbar-light navbar-color sticky-top">
            <div id="nav_content" class="container-fluid">
                <div id="navbar_branch">
                    <img id="app_icon" src="resources/icon/app_icon.svg">
                    <h5 class="d-none d-md-block">Chỉnh sửa thông tin sự kiện</h5>
                </div>		
            </div>
        </nav>

        <%
            EventDetailDTO detail = (EventDetailDTO) request.getAttribute("UPDATING_EVENT");
        %>

        <div id="body" class="container-fluid">

            <div id ="update_name_desciption">

                <input type='hidden' name="action" value="name and description"/>
    
                <!-- EVENT NAME -->
                <h5 class="title col-12">Tên Sự Kiện</h5>
                <input class="col-12 my-text-input" id="input_event_name" type="text"  
                       name="eventName" value="<%= detail.getName()%>">
    
                <!-- EVENT DESCRIPTION        -->
                <h5 class="title col-12">Nội Dung Sự Kiện</h5>
                <textarea
                        class="col-12 my-text-input" id="input_event_description" 
                
                        rows="7" cols="12"
                          type="text"><%= detail.getDescription()%></textarea>
    
                <div id="update-desciption">
                </div>
    
                <form action="updateEvent" id="update-name-description-form">
                </form>
    
                <script src="resources/js/setUpCKEditor.js"></script>
                <script>
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
    
            <div id="image_container" class="col-12">
                <figure id="figure_image" >
                    <img id="chosen-image" src="data:image/jpg;base64,<%= detail.getPoster()%>">
                </figure>
    
                <input class="d-none" type="file" id="upload-button" 
                       accept="image/*" name="fileUp" value="" style="visibility:hidden;">
    
                <div id="button_section" class="text-right">
                    <label id="btn_upload_image" class="mybutton btn-big btn-blue" for="upload-button">
                        Chọn hình ảnh
                    </label>

                    <button id="btn_review" class="mybutton btn-big btn-orange" onclick="sendUpdateInfor()">Cập nhật</button>
                </div>
            </div>
        </div>

        <div id="submiter"></div>

        <%@include file="footer.jsp" %>

        <script src="resources/js/create_event.js"></script>

        <script>
                function sendUpdateInfor () {
                    updateNameAndDescription()
                    updatePoster();
                }

                function updatePoster() {
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
    </body>
</html>
