<%@page import="fptu.swp.entity.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset='utf-8'>
        <meta http-equiv='X-UA-Compatible' content='IE=edge'>
        <title>Profile</title>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <link rel='stylesheet' type='text/css' media='screen' href='resources/css/update_profile.css'>
        <script src='bootstrap/js/bootstrap.js'>
            
        </script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
            
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js">
            
        </script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js">
            
        </script>
        <script src="resources/sweetalert2.all.min.js">
            
        </script> 
    </head>
    <body>
        <%@include file="nav_bar.jsp" %>
                        
        <div class="container rounded bg-white m-0">
            <div class="row">
                <div id="field_container" class="col-12 col-lg-5">
                    <h3 id="big_title">Cập nhật thông tin cá nhân</h3>
                    <form action="updateProfile">
                        <div class="row mt-3">   
                            <div class="col-md-12">
                                <label class="label">Email</label>
                                <input type="text" class="form-control" placeholder="${sessionScope.USER.email}" value="" readonly="">
                            </div>
                            <div class="col-md-12">
                                <label class="label">Tên</label>
                                <input type="text" class="form-control" name ="name" value="${sessionScope.USER.name}">
                            </div>
                            <div class="col-md-12">
                                <font color="red">
                                ${requestScope.USER_ERROR.nameError}
                                </font>
                            </div>                      
                            <div class="col-md-12">
                                <label class="label">Số điện thoại</label>
                                <input type="text" class="form-control" name="phoneNum" value="${sessionScope.USER.phoneNum}">
                            </div>
                            <div class="col-md-12">
                                <font color="red">
                                ${requestScope.USER_ERROR.phoneNumError}
                                </font>
                            </div>      
                            <div class="col-md-12">
                                <label class="label">Địa chỉ</label>
                                <input type="text" class="form-control" name="address" value="${sessionScope.USER.address}" >
                            </div>
                            <div class="col-md-12">
                                <font color="red">
                                ${requestScope.USER_ERROR.addressError}
                                </font>
                            </div>    
                <%
                            UserDTO user = (UserDTO) session.getAttribute("USER");
                            if ("CLUB'S LEADER".equals(user.getRoleName()) || "DEPARTMENT'S MANAGER".equals(user.getRoleName())) {
                %>
                                <div class="col-md-12">
                                    <label class="label">Miêu tả</label>
                                    <input type="text" class="form-control" name="description" value="${sessionScope.USER.description}">
                                </div>
                <%
                            }
                %>
                        </div>

                        <button id="btn_update">
                                <img id="icon_crayon" src="resources/icon/icon_crayon_white.svg">
                                <span>Cập nhật</span>
                        </button>

                    </form>
                </div>    
            </div>
        </div>
                        
        <%@include file="footer.jsp" %>
    </body>
</html>