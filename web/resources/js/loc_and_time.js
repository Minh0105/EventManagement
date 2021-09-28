///////////////////////|
///// JSP SET UP //////|
///////////////////////|


function setUp_DateThings(aDate) {
    var selectedYear = aDate.getFullYear();
    setUp_CreateDateSlotTableHeader(aDate);
    setUp_YearAndWeekOption(aDate, selectedYear);
}

// DATE AND SLOT TABLE SET UP
function setUp_CreateDateSlotTableHeader (aDate) {
    createDayOfWeekList(aDate);
    var htmlContent = document.getElementById("day_row").innerHTML;
    var dayCellHtml;
    for (var i = 0; i <= 6; i++) {
        var isLastDay = (i == 6);
        var dayIsValid = chosenWeekDayList[i] != undefined;

        if (dayIsValid) {
            if (isLastDay) {
                dayCellHtml = '<th class="day_cell last_day_cell"> <div>';
                dayCellHtml += '<span class="day">Chủ nhật<span>';
            } else {
                dayCellHtml = '<th class="day_cell"> <div>';
                dayCellHtml += '<span class="day">Thứ ' + (i + 2) + '<span>';
            }
            dayCellHtml += '<span class="date">' + chosenWeekDayList[i] + '</span>';

        } else {
            if (isLastDay) {
                dayCellHtml = '<th class="day_cell last_day_cell disabled_cell"> <div>';
            } else {
                dayCellHtml = '<th class="day_cell disabled_cell"> <div>';
            }
        }
         

        dayCellHtml += '</div> </th>'; 
        htmlContent += dayCellHtml;
    }
    document.getElementById("day_row").innerHTML = htmlContent;
}

// YEAR AND WEEK OPTION SET UP
function setUp_YearAndWeekOption (date, selectedYear) {
    createWeekOption(date);
    createYearOption(selectedYear);
}


function createYearOption (selectedYear) {
    var currentYear = today().getFullYear();
    var optionContent;
    var htmlContent;
    for (var i = -1; i <= 1; i++) {
        console.log("(" + i + " + " + currentYear + ") == " +  selectedYear + ": " + ((i + currentYear) == selectedYear))
        if ((i + currentYear) == selectedYear) {
            optionContent = "<option selected>" + (currentYear + i) + "</option>";
        } else {
            optionContent = "<option>" + (currentYear + i) + "</option>";
        }
        htmlContent += optionContent;
    }
    document.getElementById("year_option").innerHTML = htmlContent;
}

function createWeekOption (aDayOfYear) {
    var firstDayOfYear = getFirstDayOfTheYear(aDayOfYear.getFullYear());

    var dayOfMonth = firstDayOfYear.getDate();
    var month = firstDayOfYear.getMonth();
    var year = firstDayOfYear.getFullYear();
   
    var hasSetWeekOptionValue = false;
     
    var date;
    var weekOption;
    var optionContent;
    var htmlContent;
    var i = 0;
    
    var isFirstDayOfYearIsMonday = (firstDayOfYear.getDay() == 1);

    for (;i <= 52; i++) {
        date = new Date(year, month, dayOfMonth + i * 7, 0, 0, 0, 0);
        weekOption = getWeekStringFromDate(date);
        var lastWeekDay = getSundayDateFromWeekString(weekOption, year);
        var gotChosenWeek = isDay2BiggerDay1(aDayOfYear, lastWeekDay);
        if (!hasSetWeekOptionValue && gotChosenWeek) {
            optionContent = "<option selected>" + weekOption + "</option>";
            hasSetWeekOptionValue = true;
        } else {
            optionContent = "<option>" + weekOption + "</option>";
        }
        htmlContent += optionContent;
        if (isTheLastWeekOfTheYear(date)) {
            break;  
        } 
    }
    
    document.getElementById("week_option").innerHTML = htmlContent;
}

function isDay2BiggerDay1 (day1, day2) {
    day1.setHours(0);
    day1.setMinutes(0);
    day1.setSeconds(0);
    day1.setMilliseconds(0);
    
    day2.setHours(0);
    day2.setMinutes(0);
    day2.setSeconds(0);
    day2.setMilliseconds(0);
    
    return day2 >= day1
}

function getFirstDayOfTheYear(year) {
    return new Date (year, 0, 1, 0, 0, 0, 0);
}

function getLastDayOfTheYear(year) {
    return new Date (year, 11, 31, 0, 0, 0, 0);
}

function getSundayDateFromWeekString (weekString, year) {
    var sundayPart = weekString.split(" - ")[1];
    var sundayInfor = sundayPart.split("/");
    var sundayDate = sundayInfor[0];
    var sundayMonth = sundayInfor[1];
    return new Date(year, sundayMonth - 1, sundayDate, 0, 0, 0, 0);
}

function isTheLastWeekOfTheYear (date) {
    var currentDayOfWeek = date.getDay();
    var dayOfMonth = date.getDate();
    var month = date.getMonth();
    var year = date.getFullYear();

    var endWeekDate = (dayOfMonth + (7 - currentDayOfWeek));
    var endDate = new Date(year, month, endWeekDate, 0, 0, 0, 0);

    if (endDate.getFullYear() > year) {
        return true;
    }

    if (endDate.getMonth() + 1 == 12) {
        if (endDate.getDate() == 31) {
            return true;
        }
    }

    return false;
}

function getWeekStringFromDate (date) {
    var currentDayOfWeek = date.getDay();
    var dayOfMonth = date.getDate();
    var month = date.getMonth();
    var year = date.getFullYear();
    if (currentDayOfWeek == 0) {
        currentDayOfWeek = 7;
    }
    
    var startWeekDate = (dayOfMonth - currentDayOfWeek + 1);
    var startDate = new Date(year, month, startWeekDate, 0, 0, 0, 0);
    var startDateBelongToLastYear = startDate.getFullYear() < year;
    if (startDateBelongToLastYear) {
        startDate = getFirstDayOfTheYear(year);
    }

    var endWeekDate = (dayOfMonth + (7 - currentDayOfWeek));
    var endDate = new Date(year, month, endWeekDate, 0, 0, 0, 0);
    var endDateBelongToNextYear = endDate.getFullYear() > year;
    if (endDateBelongToNextYear) {
        endDate = getLastDayOfTheYear(year);
    }

    var startDay = startDate.getDate();
    startDay = get2DigitFormat(startDay);

    var startMonth = startDate.getMonth() + 1;
    startMonth = get2DigitFormat(startMonth);

    var endDay = endDate.getDate();
    endDay = get2DigitFormat(endDay);
    
    var endMonth = endDate.getMonth() + 1;
    endMonth = get2DigitFormat(endMonth);

    var result = startDay+"/"+startMonth+" - "+endDay+"/"+endMonth;
    return result;
}


function createDate_From_StartDateString (startDateString) {
    var dateInfor = startDateString.split("-");
    var year = dateInfor[0];
    var month = dateInfor[1];
    var day = dateInfor[2];
    console.log(dateInfor);
    return new Date(year, month - 1, day, 0, 0, 0, 0);
}

//LOCATION SET UP

function setUp_HideAllChosenLocationInList () {
    var chosenLocationElementList = document.getElementsByClassName("loc_slot filled");
    for (var locElement of chosenLocationElementList) {
        if (locElement != undefined) {
            hideChosenLocationInList(locElement)
        }
    }
}


////////////////////////|
//// CREATE TABLE ////|
//////////////////////|

var chosenWeekDayList = new Array();
var chosenStartDate;
var slotMap = {};

function createDateSlotTableBody () {
    
    var tableBodyHtml = "";
    for (let slotNum = 1; slotNum <= 8; slotNum++) {
        tableBodyHtml += createASlotRow(slotNum, slotMap[slotNum]);
    }

    document.getElementById("date_and_slot_table_body").innerHTML = tableBodyHtml;
}

function createASlotRow (slotNumber, timeRange) {
    // <tr class="slot_row">
    //     <!-- BEGIN: SLOT 1 -->
    //     <td class="slot_cell">
    //         <div>
    //             <span class="slot_span">Slot 1<span>
    //             <span class="time_range_span">7:00 - 8:30</span>
    //         </div>
    //     </td>

    //     <td onclick="onSlotClick(this)" id="1-1" >

    //     </td>
    // </tr>
    var rowContent;
    rowContent = '<tr class="slot_row"> \n'; 
    rowContent +=  '<!-- BEGIN: SLOT 1 --> \n'; 
    rowContent +=     '<td class="slot_cell"> \n'; 
    rowContent +=         '<div> \n'; 
    rowContent +=            '<span class="slot_span">Slot'+ slotNumber +'<span> \n';
    rowContent +=            '<span class="time_range_span">' + timeRange + '</span> \n';   
    rowContent +=         '</div> \n';  
    rowContent +=     '</td> \n';  


    for (let dayNumber = 2; dayNumber <= 8; dayNumber++) {
        let id = slotNumber+'-'+dayNumber;
        rowContent += '<td onclick="onSlotClick(this)" ';
        if (dayNumber != 8) {
            rowContent += 'id="' + id + '"></td> \n'
        } else {
            rowContent += 'id="' + id + '" class="last_row_cell"></td> \n'
        }
    }

    rowContent += '</tr> \n'
    return rowContent;
}

function createDayOfWeekList (currentDate) {
    var currentDayOfWeek = currentDate.getDay();
    var dayOfMonth = currentDate.getDate();
    var month = currentDate.getMonth();
    var year = currentDate.getFullYear();
    if (currentDayOfWeek == 0) {
        currentDayOfWeek = 7;
    }

    var startWeekDate = (dayOfMonth - currentDayOfWeek + 1);
    var startDate = new Date(year, month, startWeekDate, 0, 0, 0, 0);
    
    for (var i = 0; i <= 6; i++) {
        var date = 
            new Date(startDate.getFullYear(), 
                    startDate.getMonth(), 
                    startDate.getDate() + i, 0, 0, 0, 0);

        if (date.getFullYear() != year) {
            chosenWeekDayList[i] = undefined;
            continue;
        }
        
        var day = date.getDate();
        day = get2DigitFormat(day);

        var month = date.getMonth() + 1;
        month = get2DigitFormat(month);

        chosenWeekDayList[i] = day + "/" + month;
    }
    
    for (var day of chosenWeekDayList) {
        if (day != undefined) {
            chosenStartDate = day;
            break;
        }
    }
    
}

function onWeekChange (weekSelectTag) {
    var chosenWeek = weekSelectTag.value;
    var startDay = chosenWeek.slice(0, 5);
    var startDateInfor = startDay.split("/");

    var day = startDateInfor[0];
    var month = startDateInfor[1];
    chosenStartDate = day + "/" + month;
    sendGetRequestWithoutChosenSlot('viewSlotAndTimeFree');
}

function get2DigitFormat (number) {
    if (number < 10) {
        return "0" + number;
    }
    
    return number;
}

function today() {
    return new Date();
}

/////////////////////////////|
//// WEEK & YEAR PROCESS ////|
/////////////////////////////|


function onYearChange (yearSelect) {  
    chosenStartDate = "01/01";
    sendGetRequestWithoutChosenSlot('viewSlotAndTimeFree');
}


///////////////////////////|
//// ADD / REMOVE SLOT ////|
///////////////////////////|

var chosenSlotList = new Array();
var firstChosenSlot = undefined;

// ***
function onSlotClick (element) {
    var chooseNewSlot = chosenSlotList.includes(element.id) == false;

    if (chooseNewSlot) {
        if (chosenSlotList.length != 0) {
            if (checkIsNewSlotValid(element.id) == false) {
                return;
            } 
        }
        element.style.backgroundColor = '#A7E591';
        addChosenSlot(element.id);
        activeContinueButton();

    } else { // Remove slot
        if (checkIsDeletedSlotValid(element.id) == false) {
            console.log("Delete Invalid " + element.id);
            return;
        }

        element.style.backgroundColor = 'white';  
        removeChosenSlot(element.id);
        if (chosenSlotList.length == 0) {
            deactiveContinueButton();
            firstChosenSlot = undefined;
        } 
    }
}

function addChosenSlot (id) {

    if (firstChosenSlot == undefined) {
        firstChosenSlot = id;
    }
    
    chosenSlotList.push(id);
}

function removeChosenSlot (id) { 
    let index = chosenSlotList.indexOf(id);
    if (index > -1) {
        chosenSlotList.splice(index, 1);
    }
}

// << Check new slot valid

function checkIsNewSlotValid (slotData) {
    var slotInfor = slotData.split("-");
    var slot = slotInfor[0];
    var dayOfWeek = slotInfor[1];
    var numberSlot = parseInt(slot);
    return isChosenSlotSameDay(dayOfWeek) && isNewSlotContinuos(numberSlot);
}

function isChosenSlotSameDay (chosenSlotDayOfWeek) {
    var firstSlotInfor = firstChosenSlot.split("-");
    var dayOfWeek = firstSlotInfor[1];
    return chosenSlotDayOfWeek == dayOfWeek;
}

function isNewSlotContinuos (chosenSlot) {
    var lowestPos = getTheLowestPosChosenSlot();
    var highestPos = getTheHighestPosChosenSLot();
    return (Math.abs(chosenSlot - lowestPos) == 1) || (Math.abs(chosenSlot - highestPos) == 1);
}

function getTheLowestPosChosenSlot () {

    var lowestPosChosenSlot = 8;
    for (var slot of chosenSlotList) {
        var slotNumber = parseInt(slot.split("-")[0]);
        if (slotNumber < lowestPosChosenSlot) {
            lowestPosChosenSlot = slotNumber;
        }
    }

    return lowestPosChosenSlot;
}

function getTheHighestPosChosenSLot () {
    var highestPosChosenSlot = -1;
    for (var slot of chosenSlotList) {
        var slotNumber = parseInt(slot.split("-")[0]);
        if (slotNumber > highestPosChosenSlot) {
            highestPosChosenSlot = slotNumber;
        }
    }
    return highestPosChosenSlot;
}

// Check new slot valid >>

// << Check deleted slot valid
function checkIsDeletedSlotValid (slotData) {
    var numberSlot = parseInt(slotData.split("-")[0]);
    var lowestPos = getTheLowestPosChosenSlot();
    var highestPos = getTheHighestPosChosenSLot();

    return (numberSlot == lowestPos) || (numberSlot == highestPos);    
}
// Check deleted slot valid >>

// ***
function activeContinueButton () {
    if (document.getElementById("btn_continue").disabled == true){
        document.getElementById("btn_continue").disabled = false;
    }
}

// ***
function deactiveContinueButton () {
    if (document.getElementById("btn_continue").disabled == false){
        document.getElementById("btn_continue").disabled = true;
    }
}

///////////////////////////////|
//// ADD / REMOVE LOCATION ////|
///////////////////////////////|

var chosenLocationList = new Array();

// ***
function focusNewTab () {
    var collections = document.getElementsByClassName("loc_slot unfilled next");
    var addButtonDiv = collections[0];

    // Model tag:
    // <div class="loc_slot focused"> 
    //    <p class="invisible">*</p>
    // </div>
    var focusedDiv = document.createElement("div");
    focusedDiv.className = "loc_slot focused";

    var invisibleP = document.createElement("p");
    invisibleP.innerHTML = "*";
    invisibleP.className = "invisible";

    focusedDiv.appendChild(invisibleP);

    addButtonDiv.parentNode.appendChild(focusedDiv);
    addButtonDiv.parentNode.removeChild(addButtonDiv);

    activeChooseLocation ();
}

function activeChooseLocation () {
    document.getElementById("loc_list_disable_layer").style.display = "none";
}

function deactiveChooseLocation () {
    document.getElementById("loc_list_disable_layer").style.display = "block";
}

// ***
function onAddLocationClick (element) {
    
    var locInfor = element.id + "-" + getLocationFromLocItem(element);
    
    // Fill Slot
    addChosenLocation(locInfor);
//    << Xử lí sau trên JSP

//    var collections = document.getElementsByClassName("loc_slot focused");
//    var focusedButtonDiv = collections[0];

//    let filledLocationTab = createFilledLocationTab(element);
//    focusedButtonDiv.parentNode.appendChild(filledLocationTab);
//
//    let addSlotButtonDiv = createAddSlotButton();    
//
//    focusedButtonDiv.parentNode.appendChild(addSlotButtonDiv);
//    focusedButtonDiv.parentNode.removeChild(focusedButtonDiv);
//    deactiveChooseLocation();
//    activeChooseSlot();
//    hideChosenLocationInList(element);
    // Xử lí sau trên JSP >>

    sendGetRequestWithoutChosenSlot('modifyLocation');
}

function createFilledLocationTab (locationElement) {
    var locationName = getLocationFromLocItem(locationElement);
    // MODEL
    // <div class="loc_slot filled"> 
    //     <p>Thư viện tầng 3</p>
    //     <span style="width: 1px; height: 45px;"></span>
    //     <div class="btn_delete_loc">
    //         <img src="../icon/delete_location_icon.svg" class="m-auto">
    //     </div>
    // </div>
    
    let filledLocationTab = document.createElement("div");
    filledLocationTab.className = "loc_slot filled";
    
    let label = document.createElement("p");
    label.innerHTML = locationName;

    let line = document.createElement("span");
    line.style.width = "1px";
    line.style.height = "45px";
    line.className = "bg-white";

    let btnDeleteLocDiv = document.createElement("div");
    btnDeleteLocDiv.className = "btn_delete_loc"
    btnDeleteLocDiv.setAttribute("onclick", "onDeleteLocationClick('" + locationElement.id + "','" + locationName + "')");
    
    let deleteIcon = document.createElement("img");
    deleteIcon.src = "resources/icon/delete_location_icon.svg";
    deleteIcon.className = "m-auto";

    btnDeleteLocDiv.appendChild(deleteIcon);
    filledLocationTab.appendChild(label);
    filledLocationTab.appendChild(line);
    filledLocationTab.appendChild(btnDeleteLocDiv);

    return filledLocationTab;
}

function hideChosenLocationInList (locationElement) {
    var locationName = getLocationFromLocItem(locationElement);
    var locItemList = document.getElementsByClassName("loc_item");
    for (var locItem of locItemList) {
        var matched = getLocationFromLocItem(locItem) == locationName;
        if (matched) {
            locItem.style.display = "none";
        }
    }
}


function getLocationFromLocItem (loc_item) {
    for (var element of loc_item.childNodes) {
        if (element.innerHTML != undefined) {
            return element.innerHTML;
        }
    }

    return undefined;
}

function activeChooseSlot () {
    if (document.getElementById("date_and_slot_disable_layer").style.display != "none") {
        document.getElementById("date_and_slot_disable_layer").style.display = "none";
    }
}

// ***
function onDeleteLocationClick (locationId, location) {

//    << Xử lí sau trên JSP
//    var chosenLocationDivs = document.getElementsByClassName("loc_slot filled");
//    for (var div of chosenLocationDivs) {
//        console.log(" - " + getLocationFromLocItem(div));
//        if (getLocationFromLocItem(div) == location) {
//            div.parentNode.removeChild(div);
//        }
//    }
    // Xử lí sau trên JSP >>
    
    var locInfor = locationId + "-" + location;
    removeChosenLocation(locInfor);
//  << Xử lí sau trên JSP

//    
//    if (chosenLocationList.length == 0) {
//        focusNewTab();
//        deactiveChooseSlot();
//        activeChooseLocation();
//    }

//    showChosenLocationInList(location);
//  Xử lí sau trên JSP >>

    if (chosenLocationList.length != 0) {
        sendGetRequestWithoutChosenSlot('modifyLocation');
    } else {
        sendGetRequestWithoutChosenSlot('searchLocation');
    }
}

function showChosenLocationInList (location) {
    var locItemList = document.getElementsByClassName("loc_item");
    for (var locItem of locItemList) {
        var matched = getLocationFromLocItem(locItem) == location;
        if (matched) {
            locItem.style.display = "flex";
        }
    }
}

function deactiveChooseSlot () {
    if (document.getElementById("date_and_slot_disable_layer").style.display != "flex") {
        document.getElementById("date_and_slot_disable_layer").style.display = "flex";
    }
}

// ***
function createAddSlotButton () {
    // Create new Empty Slot
    // MODEL
    // <div onclick="focusNewTab()" class="loc_slot unfilled next"> 
    //     <div class="btn_add_loc">
    //         <img src="../icon/add_location_icon.svg" class="m-auto">
    //     </div>
    // </div>

    let addSlotButtonDiv = document.createElement("div");
    addSlotButtonDiv.onclick = function () {
        focusNewTab();
    };
    addSlotButtonDiv.className = "loc_slot unfilled next";

    let btnAddLocDiv = document.createElement("div");
    btnAddLocDiv.className = "btn_add_loc";
    
    let iconAdd = document.createElement("img");
    iconAdd.src = "resources/icon/add_location_icon.svg";
    iconAdd.className = "m-auto";

    btnAddLocDiv.appendChild(iconAdd);
    addSlotButtonDiv.appendChild(btnAddLocDiv);

    return addSlotButtonDiv;
}

function addChosenLocation (locationInfor) {
    chosenLocationList.push(locationInfor);
}

function removeChosenLocation (locationId) { 
    let index = chosenLocationList.indexOf(locationId);
    if (index > -1) {
        chosenLocationList.splice(index, 1);
    }
}

function getChosenLocationsFromDiv (loc_div) {
    return loc_div.childNodes[0].innerHTML;
}

//////////////////////|
//// SEND REQUEST ////|
//////////////////////|

// ***
function sendGetRequest (action) {
    var submitContent = "<form id='submiter' method='GET' action=" + action + ">";

    submitContent += createChosenSlotFormsHtml();
    submitContent += createChosenLocationFormsHmtl();
    submitContent += createStartDateFormHtml();
    submitContent += createTextSearchFormHtml();

    submitContent += "</form>";
    document.getElementById("submit_form").innerHTML = submitContent;
    console.log(document.getElementById("submit_form"));

    document.getElementById("submiter").submit();
}

function sendGetRequestWithoutChosenSlot (action) {
    var submitContent = "<form id='submiter' method='GET' action=" + action + ">";

    submitContent += createChosenLocationFormsHmtl();
    submitContent += createStartDateFormHtml();
    submitContent += createTextSearchFormHtml();

    submitContent += "</form>";
    document.getElementById("submit_form").innerHTML = submitContent;
    console.log(document.getElementById("submit_form"));
    document.getElementById("submiter").submit();//
}

function createChosenSlotFormsHtml () {
    var html = "";
    for (const slot of chosenSlotList) {
        html += 
        "<input type='hidden' name='chosenSlot' value='" + slot +"'>";
    }
    return html;
}

function createChosenLocationFormsHmtl () {
    var html = "";
    for (const slot of chosenLocationList) {
        html += 
        "<input type='hidden' name='chosenLocationId' value='" + slot +"'>";
    }
    return html;
}

function createStartDateFormHtml () {
    var startDateInfor = chosenStartDate.split("/");
    var day = startDateInfor[0]; 
    var month = startDateInfor[1]; 
    var year = document.getElementById("year_option").value;
    var startDateParam = year + "-" + month + "-" + day;
    return "<input type='hidden' name='startDate' value='" + startDateParam +"'>";
}

function createTextSearchFormHtml () {
    var txtSearch = document.getElementById("input_location").value;
    return "<input type='hidden' name='txtSearch' value='" + txtSearch +"'>";
}