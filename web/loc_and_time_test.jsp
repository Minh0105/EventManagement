<%-- 
    Document   : loc_and_time_test
    Created on : Sep 29, 2021, 11:58:09 AM
    Author     : admin
--%>

<%@page import="fptu.swp.entity.datetimelocation.RangeDateDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div style="float: left;">
        <form action="searchLocation">
            <input type="text" name="txtSearch" value="${param.txtSearch}" />
            <input type="submit" value="Tìm Kiếm" />
            <br>
            
            <c:if test="${not empty requestScope.BusySlot}" >
                <%
                    ArrayList<RangeDateDTO> listBusySlot = (ArrayList<RangeDateDTO>) request.getAttribute("BusySlot");
                    for (int i = 1; i <= 8; i++) {
                        for (int j = 2; j <= 8; j++) {

                            if (listBusySlot.contains(new RangeDateDTO(i, j))) {
                %>
                <input style="background-color: red; " type="checkbox" name="chosenSlot" value="ON" checked="checked" disabled/> &nbsp;&nbsp;&nbsp;
                <%
                } else {
                %>
                <input style="background-color: greenyellow; " type="checkbox" name="chosenSlot" value="ON" /> &nbsp;&nbsp;&nbsp;
                <%
                        }
                    }
                %><br><%
    }

                %>
            </c:if>
            <c:if test="${empty requestScope.BusySlot}" >
                <c:forEach begin="1" end="8" >
                    <c:forEach begin="2" end="8" >
                        <input style="background-color: greenyellow; " type="checkbox" name="chosenSlot" value="ON" /> &nbsp;&nbsp;&nbsp;
                    </c:forEach>
                    <br>
                </c:forEach>

            </c:if>
        </form>
        </div>
        <div style="float: right;">
            <c:forEach var="loc" items="${requestScope.SeachedLocations}" >
                -------
                <c:url var="viewFreeSlotLink" value='viewSlotAndTimeFree' >
                    <c:param name="startDate" value="2021-09-24" />
                    <c:param name="locationId" value="${loc.id}" />
                    <c:param name="txtSearch" value="${txtSearch}" />
                </c:url>
                <p <c:if test="${requestScope.LocationId eq loc.id}" >style="color: blue;"</c:if>>LocalId: <a href="${viewFreeSlotLink}">${loc.id}</a>, locname: ${loc.name}</p>
                    -------
            </c:forEach>
        </div>


    </body>
</html>
