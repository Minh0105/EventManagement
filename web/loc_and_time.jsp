<%-- 
    Document   : location
    Created on : Sep 28, 2021, 4:19:06 PM
    Author     : admin
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="fptu.swp.entity.datetimelocation.RangeDateDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <link rel="stylesheet" href="<c:url value='resources/html/bootstrap/bootstrap.min.css' />" >
        <link rel="stylesheet" href="<c:url value='resources/css/loc_and_time_style.css' />">
    </head>
    <body>
        
        <c:set var="startDate" value="${param.startDate}"></c:set>    
        <c:set var="txtSearch" value="${param.txtSearch}"></c:set>
        
        <c:set var="chosenSlotList" value="${requestScope.ChosenSlotList}"></c:set>
        <c:set var="chosenLocationList" value="${sessionScope.ChosenLocationList}"></c:set>
        <c:set var="searchedLocationList" value="${requestScope.SearchedLocationList}"></c:set>
       
        
        <!-- BEGIN: TOP BAR -->
        <nav class="container-fluid">
            <div id="top-bar-row" class="row">
                <!-- BEGIN: TITLE -->
                <div id="title" 
                     class="col-12 col-lg-5 d-flex flex-row align-item-center">
                    <img src="resources/icon/app_icon.svg">
                    <p id="txt_title" class="text-white">
                        Chọn thời gian và địa điểm
                    </p>
                </div>
                <!-- END: TITLE -->

                <!-- BEGIN: BUTTON SECTION -->
                <div id="buttons_section" class="col-12 col-lg-7 d-flex px-0 pt-6px">
                    <div style="width: 19%" class="pl-6px">
                        <button id="btn_continue" onclick="sendGetRequest('appendEventDetail')" class="top-btn btn bg-mn-orange text-white wh-full-parent">
                            Tiếp tục
                        </button>
                    </div>
                    <div style="width: 62%" class="px-6px">
                        <input id="input_location" class="wh-full-parent" type="text" placeholder="Nhập địa điểm" value="${txtSearch}">
                    </div>

                    <div style="width: 19%" class="pr-6px">
                        <button onclick="sendGetRequest('viewSlotAndTimeFree')" class="top-btn btn btn-secondary wh-full-parent ">
                            Tìm kiếm
                        </button>
                    </div>
                </div>
                <!-- END: BUTTON SECTION -->
            </div>
        </nav>
        <!-- END: TOP BAR -->

        <!-- BEGIN: CHOOSE LOCATION & DATE SECTION -->
        <div class="w-full-parent d-flex flex-row">
            <div style="width: 88.916%" class="mt-12px">
                <!-- BEGIN: CHOSEN LOCATIONS SECTION -->
                <div style="height:46px" class="w-full-parent d-flex">
                    <span style="width: 2px" class="bg-black d-block ml-12px mb-0"></span>
                    <span style="min-width: 70px;"class="d-block mx-12px">
                        <b>Đã chọn</b>
                    </span>
                    <div class="scrollmenu mx-6px">
                        
                        <c:if test="${empty chosenLocationList}">
                                <div class="loc_slot focused"> 
                                    <p class="invisible">*</p>
                                 </div>
                        </c:if>

                        <c:if test="${not empty chosenLocationList}">
                            <c:forEach var="loc" items="${chosenLocationList}">
                                <div class="loc_slot filled"> 
                                    <p>${loc.name}</p>
                                    <span style="width: 1px; height: 45px;" class="bg-white"></span>
                                    <div onclick="onDeleteLocationClick('${loc.id}','${loc.name}')" class="btn_delete_loc">
                                        <img src="resources/icon/delete_location_icon.svg" class="m-auto">
                                    </div>
                                </div>
                            </c:forEach>
                            
                            <div onclick="focusNewTab()" class="loc_slot unfilled next">
                                <div class="btn_add_loc">
                                    <img src="resources/icon/add_location_icon.svg" class="m-auto">
                                </div>
                            </div>
                            
                        </c:if>
                        
                    </div>
                </div>
                <!-- END: CHOSEN LOCATIONS SECTION -->

                
                <!-- BEGIN: DATE & SLOT TABLE -->
                <div id="date_and_slot_section">
                    <div id="date_and_slot_disable_layer">
                        <h4 class="d-block mx-auto">Chọn địa điểm</h4>
                    </div>
                    <table id="date_and_slot_table" class="wh-full-parent">
                        <thead id="date_and_slot_table_header">
                            <tr id="day_row">
                                <th id="week_infor_cell">
                                <div> 
                                    <span style="width: 40%;">Year</span>
                                    
                                    <select onchange="onYearChange(this)" style="width: 60%; float: right;" id="year_option" class="inline-block">

                                    </select>

                                    <select onchange="onWeekChange(this)" id="week_option" class="w-full-parent">
                                        
                                    </select>
                                </div>
                                </th>
                            </tr>
                        </thead>
                        <tbody id="date_and_slot_table_body">
                        
                            <%! 
                                private final int DECEMBER_LAST_DATE = 31;
                                private final int JANUARY_FIRST_DATE = 1;
                                private final int MONDAY = 2;
                                private final int SUNDAY = 8;
                                private final int SLOT_1 = 1;
                                private final int LAST_SLOT = 8;
                                private int getValidLastDayOfWeek(String date) { 
                                    int lastDay = -1;
                                    String[] dateInfor = date.split("-");
                                    int dateOfMonth = Integer.parseInt(dateInfor[2]);
                                    int month = Integer.parseInt(dateInfor[1]);
                                    if (month < 12) {
                                        return SUNDAY;
                                    } else if (month == 12) {
                                        if ((DECEMBER_LAST_DATE - dateOfMonth + 1) >= 7) {
                                            lastDay = SUNDAY;
                                        } else {
                                            lastDay = DECEMBER_LAST_DATE - dateOfMonth + 2;
                                        }
                                    }
                                    return lastDay;
                                }

                                private int getValidFirstDayOfWeek(String date) { 
                                    String[] dateInfor = date.split("-");
                                    int dateOfMonth = Integer.parseInt(dateInfor[2]);
                                    int month = Integer.parseInt(dateInfor[1]);
                                    int year = Integer.parseInt(dateInfor[0]);
                                    int dayOfWeek = -1;

                                    if (month > 1) {
                                        return MONDAY;
                                    }

                                    try {
                                        Date dateObject = new SimpleDateFormat("yyyy-MM-dd").parse(date);
                                        dayOfWeek = dateObject.getDay();
                                        System.out.println("DAYYYYYY: " + dayOfWeek);
                                        if (dayOfWeek == 0) {
                                            dayOfWeek = SUNDAY;
                                        } else {
                                            dayOfWeek = dayOfWeek + 1;
                                        }
                                    } catch (ParseException ex) {
                                       ex.printStackTrace();
                                    }

                                    return dayOfWeek;
                                }
                            %>

                        <%
                            ArrayList<String> slotList = (ArrayList<String>) request.getAttribute("SlotList");
                            ArrayList<String> chosenSlotList = (ArrayList<String>) request.getAttribute("ChosenSlotList");
                            ArrayList<RangeDateDTO> listBusySlot = (ArrayList<RangeDateDTO>) request.getAttribute("BusySlotList");
                            String startDate = request.getParameter("startDate");
                            if (startDate == null) {
                                Calendar calendar = Calendar.getInstance();
                                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                simpleDateFormat.setTimeZone(calendar.getTimeZone());
                                startDate = simpleDateFormat.format(calendar.getTime());
                            }
                            int lastDayOfWeek = getValidLastDayOfWeek(startDate);
                            int firstDayOfWeek = getValidFirstDayOfWeek(startDate);
                            for (int slot = SLOT_1; slot <= LAST_SLOT; slot++) {
                        %>
                                <tr class="slot_row">
                                    <!-- BEGIN: SLOT 1 -->
                                    <td class="slot_cell">
                                        <div>
                                            <span class="slot_span">Slot <%=slot%><span>
                                            <span class="time_range_span"><%= slotList.get(slot - 1)%></span>
                                        </div>
                                    </td>
                        <%
                                for (int day = MONDAY; day <= SUNDAY; day++) {
                                    
                                    if ((listBusySlot != null) && listBusySlot.contains(new RangeDateDTO(slot, day))) { 
                        %>
                                        <td class="busy_slot_cell disabled_cell" ></td>
                        <%
                                        continue;
                                    }

                                    if (day < firstDayOfWeek || day > lastDayOfWeek) { 
                                        if (day == SUNDAY) {
                        %>
                                            <td class="busy_slot_cell last_row_cell disabled_cell" ></td>
                        <%
                                        } else {
                        %>
                                            <td class="busy_slot_cell disabled_cell" ></td>
                        <%
                                        }

                                        continue;
                                    }

                                    if ((chosenSlotList != null) && chosenSlotList.contains(new RangeDateDTO(slot, day))) {
                        %>
                                        <td onclick="onSlotClick(this)" style="background-color:#A7E591" id="<%=slot%>-<%=day%>"></td>
                        <%
                                        continue;
                                    }
                                    
                                    if (day != SUNDAY) {
                        %>
                                        <td onclick="onSlotClick(this)" id="<%=slot%>-<%=day%>" >
                                        </td>
                        <%
                                    } else {
                        %>
                                        <td  class="last_row_cell" onclick="onSlotClick(this)" id="<%=slot%>-<%=day%>">
                                        </td>
                        <%
                                    }
                                }
                            }
                        %>
                                </tr>
                        </tbody>
                    </table>
                </div>
                <!-- END: DATE & SLOT TABLE -->
            </div >

            <!-- BEGIN: LOCATION LIST -->
            <div id="location_list_section" style="width: 11.084%">
                <div id="loc_list_disable_layer"></div>
                <ul id="location_list" class="list-unstyled mr-6px mt-6px">
                    <c:forEach var="loc" items="${searchedLocationList}">
                        <li> 
                            <div id="${loc.id}" onclick="onAddLocationClick(this)" class="loc_item">
                                <p class="m-auto text-white">${loc.name}</p>
                            </div>
                        </li>    
                    </c:forEach>
                </ul>
            </div>
            <!-- END: LOCATION LIST -->
        </div>
        <!-- END: CHOOSE LOCATION & DATE SECTION -->

        <div id="submit_form">
            <span class="d-none">dynamic_content_created_by_javascript</span>
        </div>
        
        
        
    <script src="resources/html/bootstrap/bootstrap.min.js"></script>
    <script src="resources/js/loc_and_time.js"></script>
    
    <!-- << Add location to JS chosenLocationList -->
    <c:forEach var="loc" items="${chosenLocationList}">
        <script>
            var locInfor = "${loc.id}-${loc.name}";
            addChosenLocation(locInfor);
        </script>
    </c:forEach>
    <!-- Add location to JS chosenLocationList >> -->    
        
        <c:if test="${not empty chosenSlotList}">
            <script>
                activeContinueButton();
            </script>
            <c:forEach var="slot" items="${chosenSlotList}">
                <script>
                    addChosenSlot("${slot.rangeId}-${slot.dayOfWeek}")
                </script>
            </c:forEach>
        </c:if>   

        <c:if test="${empty chosenSlotList}">
            <script>
                deactiveContinueButton();
            </script>
        </c:if>  
    
    <script>
        setUp_HideAllChosenLocationInList();
    </script>
    
    <!-- BEGIN: Set up Date & Slot table Header-->
    <c:if test="${empty startDate}">
        <script>
            setUp_DateThings(today());
        </script>
    </c:if>
    <c:if test="${not empty startDate}">
        <script>
            let _date = createDate_From_StartDateString("${startDate}");
            setUp_DateThings(_date);
        </script>
    </c:if>    
    <!--END: Set up Date & Slot table Header-->
        
        
    <c:if test="${not empty chosenLocationList}">
        <script>
            activeChooseSlot();
            deactiveChooseLocation();
        </script>
    </c:if>

    </body>
</html>