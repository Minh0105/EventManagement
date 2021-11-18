<%@page import="fptu.swp.entity.user.UserDTO"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link rel='stylesheet' type='text/css' media='screen' href='resources/css/view_profile_style.css'>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <%@include file="nav_bar.jsp" %>

        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row">      
                <div id="information_card" class="col-12 col-lg-8">
                    <c:set var="role" value="${sessionScope.USER.roleName}"></c:set>
                    <div id="big_avatar_container">
                        <img id="big_avatar" src="${sessionScope.USER.avatar}" />
                        <p id="txt_role">${role}</p>
                    </div>
                    <div id="personal_infor_container">
                        <h3 id="big_title">Thông tin cá nhân</h3>
                        <div id="infor_part">
                            <div id="title_container" class="personal_infor d-none d-md-flex">
                                <p>Tên</p>
                                <p>Email</p>
                                <p>Số điện thoại</p>
                                <p>Địa chỉ</p>
                                <%
                                    UserDTO user = (UserDTO) session.getAttribute("USER");
                                    String role = user.getRoleName();
                                    if (role.equals("CLUB'S LEADER") || role.equals("DEPARTMENT'S MANAGER")) {
                                %>
                                        <p>Miêu tả</p>
                                <%
                                    }
                                %>
                            </div>

                            <div id="infor_container" class="personal_infor">
                                <p>${sessionScope.USER.name}</p>
                                <p>${sessionScope.USER.email}</p>

                                <%  
                                    String userPhone = user.getPhoneNum();
                                    if (userPhone != null) {
                                        userPhone = userPhone.trim();
                                        if (userPhone.length() == 0) {
                                            userPhone = null;
                                        }
                                    }
                                    if (userPhone != null) {
                                %> 
                                        <p>${sessionScope.USER.phoneNum}</p>
                                <%
                                    } else {
                                %> 
                                        <p class="place_holder">Chưa có</p>
                                <%
                                    }
                                %>

                                <c:if test="${empty sessionScope.USER.address}" >
                                    <p class="place_holder">Chưa có</p>
                                </c:if>
                                    
                                <c:if test="${not empty sessionScope.USER.address}" >
                                    <p>${sessionScope.USER.address}</p>
                                </c:if>

                                <%
                                    if (role.equals("CLUB'S LEADER") || role.equals("DEPARTMENT'S MANAGER")) {
                                        String description =  user.getDescription();
                                        if (description.trim().length() > 0) {
                                %> 
                                        <p>${sessionScope.USER.description}</p>   
                                <%    
                                        } else {
                                %>
                                        <p class="place_holder">Chưa có</p>
                                <%
                                        }   
                                    }
                                %>
                                

                            </div>
                        </div>

                        <form action="UpdateProfilePage">
                            <button id="btn_edit">
                                <img id="icon_crayon" src="resources/icon/icon_crayon.svg">
                                <span>Chỉnh sửa</span>
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>     

        <%@include file="footer.jsp" %>
    </body>
</html>
