<%-- 
    Document   : invalid.jsp
    Created on : Nov 24, 2021, 3:59:29 PM
    Author     : tangtantai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error page</title>
        <style>
            #big_background {
                background-color: #FFE0C2;
                min-height: 60vh;
                width: 100%;
                display: flex;
            }
            
            #error_section {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 2rem;
                height: 60vh;
                width: fit-content;
                padding: 0 10vw;
            }

            #img_sad_face {
                height: 15vh;
                width: 15vh;
            }

            #error_message {
                font-size: 2rem;
                width: 40vw;
            }

            #trapezoid {
                height: 0;
                border-right: 0px solid transparent;
                border-left: 5vw solid transparent;
                border-bottom: 60vh solid #AD7A66;
                width: 40vw;
                height: 0;
            }
        </style>
    </head>
    <body>
        
        <%@include file="nav_bar.jsp"%>
        
        <% 
            String errorMessage = (String) session.getAttribute("errorMessage");
        %> 

        <div id="big_background">
            <div id="error_section">
                <p id="error_message"><%=errorMessage%></p>
                <p id="error_message">Tính năng này không khả dụng đối với tài khoản của bạn</p>
                <img id="img_sad_face" src="resources/image/image_sad_face.svg"> 
            </div>
            <div id="trapezoid"></div>
        </div>

        <% 
            session.removeAttribute("errorMessage");
        %>


        <%@ include file="footer.jsp" %>
    </body>
</html>
