
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tổng hợp sự kiện</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>  
        <link rel="stylesheet" href="resources/css/admin.css" >
        <link rel="stylesheet" href="resources/css/mybutton.css" >
        <link rel="stylesheet" href="resources/css/nav_bar.css" >
    </head>
    <body>

        <%@include file="nav_bar.jsp" %>
        <div id="body_container" style="padding: 0 1vw;">

            <section id="filter_bar">
                <div class="top_title">
                    <h3 class="right_title">Tra Cứu Sự Kiện</h3>
                </div>
        </section>

        <div class="col-md-6">
            <h5 style="font-weight: 400">Tìm event theo: </h5>
        </div>

        <!--           ĐÃ LOAD LIST ALL ORGANIZER, Select o day là khi nguoi dùng ho chon option nào thì mình show LIST ORGANIZER-->
                            <form action="filterEvent">
                                <div class="col-md-6">
                                    <label class="labels">Chức vụ</label>
                                    <select class="form-control" name="organizerType" id="organizerType"
                                        onchange="organizerTypeHandler(this)">
                                        <option value="allOrganizer">Tất cả</option>
                                        <!-- (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                                        <option value="CL">Club's leader</option>
                                        <option value="DM">Department's manager</option>
                                    </select>
                                </div>
                                <br>
                                <script>
                                    var items = document.getElementById("organizerType").options;
                                    for (var i = 0; i < items.length; i++) {
                                        if (items[i].value == "${param.organizerType}") {
                                            items[i].selected = true;
                                        }
                                    }
                                </script>

                                <div id="filter_organizer">

                                    <div id="organizer_name">
                                        <!--           Neu chon "Tất cả" ở cái select trên  (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                                        <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label>
                                            <select
                                                class="form-control" name="idOrganizer">
                                                <option value="0">Tất cả</option>
                                                <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER_EVENT}">
                                                    <c:if test="${param.idOrganizer eq organizer.id}">
                                                        <option value="${organizer.id}" selected>${organizer.name}
                                                        </option>
                                                    </c:if>
                                                    <c:if test="${param.idOrganizer ne organizer.id}">
                                                        <option value="${organizer.id}">${organizer.name}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <br>

                                    <div class="row mx-0">
                                        <div class="col-md-6"> <label class="labels">Tình trạng sự kiện:</label> <select
                                                class="form-control" name="eventStatus" id="eventStatus">
                                                <option value="0">Tất cả</option>
                                                <option value="1">Sắp diễn ra</option>
                                                <option value="2">Đóng đăng kí</option>
                                                <option value="3">Đã kết thúc</option>
                                                <option value="4">Đã hủy</option>
                                            </select>
                                        </div>
                                        <script>
                                            var items = document.getElementById("eventStatus").options;
                                            for (var i = 0; i < items.length; i++) {
                                                if (items[i].value == "${param.eventStatus}") {
                                                    items[i].selected = true;
                                                }
                                            }
                                        </script>
                                        <div class="col-md-4 ml-2 d-flex align-items-end">
                                            <input type="submit" style="height: fit-content" value="Tìm kiếm" class="mybutton btn-orange" />
                                        </div>
                                    </div>
                                </div>
                            </form>
            
            
            
            
            
                            <div id="allOrganizer">
                                <!--           Neu chon "Tất cả" ở cái select trên  (ĐÂY LÀ MAC ĐINH KHI BAM VÀO "Event Management"-->
                                <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label>
                                    <select
                                        class="form-control" name="idOrganizer">
                                        <option value="0">Tất cả</option>
                                        <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER_EVENT}">
                                            <c:if test="${param.idOrganizer eq organizer.id}">
                                                <option value="${organizer.id}" selected>${organizer.name}</option>
                                            </c:if>
                                            <c:if test="${param.idOrganizer ne organizer.id}">
                                                <option value="${organizer.id}">${organizer.name}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
            <!--           Nếu chọn "Club's leader" ở cái select trên-->
                            <div id="CL">
                                <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label>
                                    <select
                                        class="form-control" name="idOrganizer">
                                        <option value="-1">Tất cả</option>
                                        <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER_EVENT}">
                                            <c:if test="${organizer.roleName eq 'CL'}">
                                                <c:if test="${param.idOrganizer eq organizer.id}">
                                                    <option value="${organizer.id}" selected>${organizer.name}</option>
                                                </c:if>
                                                <c:if test="${param.idOrganizer ne organizer.id}">
                                                    <option value="${organizer.id}">${organizer.name}</option>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

            <!--           Nếu chọn "Department's manager" ở cái select trên-->
                            <div id="DM">
                                <div class="col-md-6"> <label class="labels">Tên nhà tổ chức:</label>
                                    <select
                                        class="form-control" name="idOrganizer">
                                        <option value="-2">Tất cả</option>
                                        <c:forEach var="organizer" items="${requestScope.LIST_ORGANIZER_EVENT}">
                                            <c:if test="${organizer.roleName eq 'DM'}">
                                                <c:if test="${param.idOrganizer eq organizer.id}">
                                                    <option value="${organizer.id}" selected>${organizer.name}</option>
                                                </c:if>
                                                <c:if test="${param.idOrganizer ne organizer.id}">
                                                    <option value="${organizer.id}">${organizer.name}</option>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
            <br>
        <div>
            <c:if test="${requestScope.LIST_EVENT ne null}">
                <div class="service" style="overflow-x:scroll; margin-top: 1.5rem">
                    <table class="table table-bordered text-center">
                        <thead class="thead-light">
                            <tr class="service1">
                                <th>STT</th>
                                <th>Tên</th>
                                <th>Địa điểm</th>
                                <th>Ngày</th>
                                <th>Giờ</th>
                                <th>Người tổ chức</th>
                                <th>Quan tâm</th>
                                <th>Tham gia</th>
                                <th>Trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="event" items="${requestScope.LIST_EVENT}" varStatus="status">
                                <tr class="service2">
                                    <td><p>${status.count}</p></td>
                                    <td>
                                        <a href="viewEventDetail?eventId=${event.id}">${event.name}</a>
                                    </td>
                                    <td>
                                        <p>${event.location}</p>
                                    </td> 
                                    <td>
                                        <p>${event.date}</p>
                                    </td>
                                    <td>
                                        <p>${event.time}</p>
                                    </td>
                                    <td>
                                        <p>${event.organizerName}</p>
                                    </td>
                                    <td>
                                        <p>${event.following}</p>
                                    </td>
                                    <td>
                                        <p>${event.joining}</p>
                                    </td>
                                    <td>
                                        <p>${event.statusId}</p>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
    </div>

    <%@include file="footer.jsp" %>

    <script>
        var organizerTypeSelect = document.getElementById("organizerType");
        document.getElementById("allOrganizer").style.display = "none";
        document.getElementById("CL").style.display = "none";
        document.getElementById("DM").style.display = "none";
        function organizerTypeHandler(organizerTypeSelect) {
            document.getElementById("organizer_name").innerHTML = "";
            var organizerType = organizerTypeSelect.value;
            var allOrganizer = document.getElementById("allOrganizer").innerHTML;
            var CL = document.getElementById("CL").innerHTML;
            var DM = document.getElementById("DM").innerHTML;

            if (organizerType == 'allOrganizer') {
                document.getElementById("organizer_name").innerHTML = allOrganizer;
            } else if (organizerType == 'CL') {
                document.getElementById("organizer_name").innerHTML = CL;
            } else if (organizerType == 'DM') {
                document.getElementById("organizer_name").innerHTML = DM;
            }
        }
    </script>
</body>
</html>
