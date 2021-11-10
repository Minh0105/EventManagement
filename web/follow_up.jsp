<%-- 
    Document   : follow_up
    Created on : Nov 10, 2021, 10:26:24 AM
    Author     : triet
--%>
<%@page import="fptu.swp.entity.event.EventDetailDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tiến trình sự kiện</title>
        <script src='resources/followup/ckeditor/ckeditor.js'></script>
        
    </head>
    <body>
                <%
            EventDetailDTO detail = (EventDetailDTO) request.getAttribute("UPDATING_EVENT");
        %>
                <!-- EVENT SUMMARY        -->
    <h5 class="title col-12">Tiến trình</h5>
    <textarea class="col-12 col-lg-7" id="input_follow_up" rows="7" cols="12"
              type="text"><%= detail.getFollowUp() %></textarea>
<!--    <div id="update-desciption">
    </div>-->
    <button onclick="updateFollowUp()">Sửa</button>
    <form id="add_follow_up_form">
    </form>
    <script>
        CKEDITOR.replace('input_follow_up');
        
        function updateFollowUp() {
            var eventFollowUp = CKEDITOR.instances.input_follow_up.getData();
            
            var form = document.getElementById("add_follow_up_form");
            
            form.method = "POST";
            form.action = "updateFollowUp";
            var inputEventId = document.createElement("INPUT");
            inputEventId.name = "eventId";
            inputEventId.value = '<%= detail.getId() %>';
            inputEventId.type = 'hidden'
            form.appendChild(inputEventId);

            var inputSummary = document.createElement("INPUT");
            inputSummary.name = "followUp";
            inputSummary.value = eventFollowUp;
            inputSummary.type = 'hidden';
            form.appendChild(inputSummary);
            form.submit();
        }
    </script>
    </body>
</html>