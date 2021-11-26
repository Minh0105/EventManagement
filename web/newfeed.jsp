<%-- 
    Document   : studentNewfeed
    Created on : Sep 30, 2021, 4:02:20 PM
    Author     : triet
--%>

<%@page import="fptu.swp.entity.user.UserDTO"%>
<%@page import="fptu.swp.entity.event.EventCardDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang Chủ</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css"
              integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">

        <!--        <script src='bootstrap/js/bootstrap.js'></script>-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="resources/sweetalert2.all.min.js"></script> 

        <link rel="stylesheet" type="text/css" href="resources/css/newfeed.css"/>
        <link rel="stylesheet" type="text/css" href="resources/css/mybutton.css"/>
    </head>

    <body>

        <%@include file="nav_bar.jsp" %>

        <%
            UserDTO logedInUser = (UserDTO) session.getAttribute("USER");
            String userRoleName = logedInUser.getRoleName();
        %>

        <!-- FILTER BAR -->

        <div class="d-flex">
            <section id="filter_bar">

                <% if (userRoleName.equals("STUDENT") || userRoleName.equals("LECTURER")) { %>
                    <div id="decorating_text">
                        Khám phá sự kiện
                    </div>
                <% } else { %>
                    <div id="decorating_text">
                        Sự kiện của bạn
                    </div>
                <% } %>

                <div id="filter_button_container">
                    <% if (userRoleName.equals("STUDENT")) { %>
                        <div class="filter_button">
                            <button class="chosen_button" onclick="showAllEvents(this)">Tất cả</button>
                        </div>
                        
                        <div class="filter_button">
                            <button onclick="showTopEvents(this)">Nổi bật</button>
                        </div>

                        <div class="filter_button">
                            <button onclick="showThisWeekEvents(this)">Tuần này</button>
                        </div>

                        <div class="filter_button">
                            <button onclick="showThisMonthEvents(this)">Tháng này</button>
                        </div>

                        <div class="filter_button">
                            <button onclick="showStudentFollowedEvents(this)">Đã quan tâm</button>
                        </div>

                        <div class="filter_button">
                            <button onclick="showStudentJoinedEvents(this)">Đã tham gia</button>
                        </div>

                    <% } else if (userRoleName.equals("CLUB'S LEADER") || userRoleName.equals("DEPARTMENT'S MANAGER")) { %>


                        <div class="filter_button">
                            <button id="btn_incoming_event" class="chosen_button" onclick="showOrganizerIncomingEvents(this)">Sắp diễn ra</button>
                        </div>
                        <div class="filter_button">
                            <button onclick="showOrganizedRegisterClosedEvents(this)">Đóng đăng kí</button>
                        </div>
                        <div class="filter_button">
                            <button onclick="showOrganizedEndedEvents(this)">Kết thúc</button>
                        </div>
                        <div class="filter_button">
                            <button onclick="showOrganizerCanceledEvents(this)">Đã bị dừng</button>
                        </div>

                    <% } else if (userRoleName.equals("LECTURER")) { %>
                       

                        <div class="filter_button">
                            <button class="chosen_button" onclick="showAllEvents(this)">Tất cả</button>
                        </div>
                        <div class="filter_button">
                            <button onclick="showLecturerInvitedEvents(this)">Các sự kiện được mời</button>
                        </div>
                    <% } %>
                </div>
            </section>

            <% if (userRoleName.equals("CLUB'S LEADER") || userRoleName.equals("DEPARTMENT'S MANAGER")) { %>
                <% if (session.getAttribute("CHANGING_EVENT_ID") != null) { %>
                    <a id="btn_create_event" href="searchLocation?txtSearch=">
                        <img src="resources/icon/icon_create_new_event.svg" />
                        <button >Tiếp tục sửa sự kiện</button>
                    </a>
                    <a id="btn_create_event" href="cancelUpdateEvent">
                        <img src="resources/icon/icon_create_new_event.svg" />
                        <button >Hủy sửa đổi sự kiện</button>
                    </a>
                <% } else { %>
                    <a id="btn_create_event" href="searchLocation?txtSearch=">
                        <img src="resources/icon/icon_create_new_event.svg" />
                        <button >Tạo sự kiện mới</button>
                    </a>
                <% } %>
            <% } %>

        </div>

        <!-- CART CONTAINER -->
        <div id="card_container" class="container-fluid">
            <div id="card_container_row" class="row gx-1 gy-4">
            <%
                List<EventCardDTO> listCard = (List<EventCardDTO>) request.getAttribute("LIST_CARD");
                List<EventCardDTO> listFollowingCard = (List<EventCardDTO>) request.getAttribute("LIST_FOLLOWING_CARD");
                List<EventCardDTO> listJoiningCard = (List<EventCardDTO>) request.getAttribute("LIST_JOINING_CARD");
                List<EventCardDTO> listLecturerInvitedCard = (List<EventCardDTO>) request.getAttribute("LIST_EVENT_CARD_LECTURER");
                    
                if (listCard != null) {
                    for (EventCardDTO card : listCard) {
            %>
                <div class="col-12 col-md-6 col-lg-4 event_card" 
                <% if (card.getStatusId() != 1 && card.getStatusId() != 2) { %> 
                    style="display: none"
                <% } %>>
                    
                    <p class="event_infor event_date"><%= card.getDate()%></p>
                    <p class="event_infor event_follow"><%= card.getFollowing()%></p>
                    <p class="event_infor event_join"><%= card.getJoining()%></p>
                    <p class="event_infor event_status"><%= card.getStatusId()%></p>
                    
                    <%
                        boolean hasFollow = false;
                        if (listFollowingCard != null) {
                            for (EventCardDTO event : listFollowingCard) {
                                if (event.getId() == card.getId()) {
                                    hasFollow = true;
                                    break;
                                }
                            }
                        }
                        if (hasFollow) { %>
                            <p class="event_infor follow_tag"></p>
                    <%  }

                        boolean hasJoin = false;
                        if (listJoiningCard != null) {
                            for (EventCardDTO event : listJoiningCard) {
                                if (event.getId() == card.getId()) {
                                    hasJoin = true;
                                    break;
                                }
                            }
                        }
                        if (hasJoin) { %> 

                            <p class="event_infor join_tag"></p>

                        <% } %>

                        <% 
                        
                            boolean hasInvited = false;
                            if (listLecturerInvitedCard != null) {
                                for (EventCardDTO event : listLecturerInvitedCard) {
                                    if (event.getId() == card.getId()) {
                                        hasInvited = true;
                                        break;
                                    }
                                }
                            }
                            if (hasInvited) { %> 
                                <p class="event_infor invited_tag"></p>
                            <% } %>

                    <div class="item">
                        <% if (card.getStatusId() == 1) { %>  
                            <div class="card_status">
                                <div class="status_rect bg-green"></div>
                            </div>
                        <% } else if (card.getStatusId() == 2) { %> 
                            <div class="card_status">
                                <div class="status_rect bg-yellow"></div>
                            </div>
                        <% } else if (card.getStatusId() == 3) { %> 
                            <div class="card_status">
                                <div class="status_rect bg-red"></div>
                            </div>
                        <% } else if (card.getStatusId() == 4) { %> 
                            <div class="card_status">
                                <div class="status_rect bg-grey"></div>
                            </div>
                        <% } %>

                        <div class="image_and_infor_container">
                            <img class="event_image" src="data:image/jpg;base64,<%= card.getPoster()%>" alt="">
                            <div class="infor_container">
                                <p class="event_date_and_loc"><%= card.getDate()%> - <%= card.getLocation()%></p>
                                <p class="event_name"><%= card.getName()%></p>
                                <p class="event_organizer_name"><%= card.getOrganizerName()%></p>
                            </div>
                        </div>
                        <div class="other_infor_container">
                            <div class="care_infor_container">
                                <div class="care_infor care_part">
                                    <img src="resources/icon/icon_care_blue.svg" alt="">
                                    <p><%= card.getFollowing()%> lượt quan tâm</p>
                                </div>
                                <div class="care_infor join_part">
                                    <img src="resources/icon/icon_join_orange.svg" alt="">
                                    <p><%= card.getJoining()%> bạn sẽ tham gia</p>
                                </div>
                            </div>
                            <form action="viewEventDetail">
                                <input class ="btnViewDetail mybutton btn-blue" type="submit" value="Chi tiết">
                                <input type="hidden" name="eventId" value="<%= card.getId()%>">
                            </form>
                        </div>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>

        <%@include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"
                integrity="sha384-W8fXfP3gkOKtndU4JGtKDvXbO53Wy8SZCQHczT5FMiiqmQfUpWbYdTil/SxwZgAN"
        crossorigin="anonymous"></script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.min.js"
                integrity="sha384-skAcpIdS7UcVUC05LJ9Dxay8AXcDYfBJqt1CJ85S/CFujBsIzCIv+l9liuYLaMQ/"
        crossorigin="anonymous"></script>

        <script type="text/javascript" src="resources/js/newfeed_function.js" ></script>

        <script>
            document.getElementById("btn_incoming_event").click();
        </script>

    </body>

</html>
