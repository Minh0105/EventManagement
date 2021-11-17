<%-- Document : follow_up Created on : Nov 10, 2021, 10:26:24 AM Author : triet --%>
    <%@page import="fptu.swp.entity.event.EventDetailDTO" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Tiến trình sự kiện</title>
                <script src='resources/followup/ckeditor/ckeditor.js'></script>
                <link rel="stylesheet" href="resources/css/follow_up.css">
                <link rel="stylesheet" href="resources/css/mybutton.css">
            </head>

            <body>
                <%@include file="nav_bar.jsp" %>

                <% EventDetailDTO detail=(EventDetailDTO) request.getAttribute("UPDATING_EVENT"); %>
                <div id="body" class="container-fluid">
                    <div id="body_content" class="container-fluid">
                        <h5 class="title col-12 px-0">Tiến trình</h5>
                        
                        <textarea class="col-12 px-0" id="input_follow_up" style="min-height: 100vh" row="20" cols="12"
                            type="text"><%=detail.getFollowUp()%>
                        </textarea>

                        <div class="col-12 text-right px-0">
                            <button onclick="updateFollowUp()" class="mybutton btn-blue mt-3">Cập nhật</button>
                        </div>
                    </div>
                </div>
 
                <form id="add_follow_up_form">
                </form>

                
                <script src='resources/js/setUpCKEditor.js'></script>
                <script>
                        CKEDITOR.replace('input_follow_up', {
                            width: '100%',
                            height: '80vh'
                        });

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