
var eventContainer = document.getElementById("card_container_row")
var allEventList = document.getElementsByClassName("event_card");
var sortedAsDefault = true;
sortToDefaultOrderAndShow();

// STUDENT
function showAllEvents (button) {
    processFilterClick(button);

    if (sortedAsDefault == false) {
        sortToDefaultOrderAndShow();
        sortedAsDefault = true;
    } else {
        var eventCollection = getAllEvents();
        for (var event of eventCollection) {
            event.style.display = "block";
        }
    }
}


function sortToDefaultOrderAndShow () {

    var eventCollection = getAllEvents();
    var sortedEventArray = Array.from(eventCollection);

    // Descending Sort
    sortedEventArray.sort((eventA, eventB) => { 
        var dateA = getDateFromEvent(eventA);
        var dateB = getDateFromEvent(eventB);
        if (dateB > dateA) {
            return 1;
        } else if (dateA == dateB) {
            return 0;
        } else if (dateB < dateA) { 
            return -1; 
        }
    })

    re_showEvents(sortedEventArray);
}


function showTopEvents(button) {
    processFilterClick(button);

    var eventCollection = getAllEvents();
    var sortedEventArray = Array.from(eventCollection);
    
    // Descending Sort
    sortedEventArray.sort((eventA, eventB) => { 
        return getFollowFromEvent(eventB) - getFollowFromEvent(eventA);
    })

    re_showEvents(sortedEventArray);
    sortedAsDefault = false;
}


function re_showEvents (eventList) {
    for (var event of eventList) {
        event.style.display = "block";
        eventContainer.removeChild(event);
        eventContainer.appendChild(event);
    }
}


function getFollowFromEvent (event) {
    var event_follow = event.getElementsByClassName("event_follow")[0].innerHTML;
    return parseInt(event_follow);
}


function showThisWeekEvents(button) {
    var eventCollection = getAllEvents();
    var startDate = getStartDayOfWeek();
    var endDate = getEndDayOfWeek();
    for (var event of eventCollection) {
        var eventDate = getDateFromEvent(event);
        if (startDate <= eventDate && eventDate <= endDate) {
            event.style.display = "block";
        } else {
            event.style.display = "none";
        }
    }
    processFilterClick(button);
}


function showThisMonthEvents(button) {
    var eventCollection = getAllEvents();
    var today = new Date();
    for (var event of eventCollection) {
        var thisMonth = today.getMonth();
        var thisYear = today.getFullYear();
        var eventDate = getDateFromEvent(event);
        if (thisMonth == eventDate.getMonth() && (thisYear == eventDate.getFullYear())) {
            event.style.display = "block";
        } else {
            event.style.display = "none";
        }
    }

    processFilterClick(button);
}


function showStudentCaredEvents(button) {
    processFilterClick(button);
}


// LECTURER
function showLecturerJoinedEvents (button) { 
    processFilterClick(button);
}


// ORGANIZER
function showOrganizerCreatedEvents (button) {
    processFilterClick(button);
}


function processFilterClick (button) {
    var filterContainer = document.getElementById("filter_button_container");
    var buttonCollection = filterContainer.getElementsByTagName("button");
    for (var filterButton of buttonCollection) {
        if (filterButton != button) {
            filterButton.className = "";
        }
    }

    button.className = "chosen_button";
}


function getAllEvents () {
    var eventContainer = document.getElementById("card_container_row");
    var eventCollection = eventContainer.getElementsByClassName("event_card");
    return eventCollection;
}


// DATE PROCESS
function getDateFromEvent(event) {
    var eventDate = event.getElementsByClassName("event_date")[0].innerHTML; 
    var eventDateInfor = eventDate.split(", ");
    var day = eventDateInfor[0];
    var date = eventDateInfor[1];

    var dateInfor = date.split("/");
    var day = dateInfor[0];
    var month = dateInfor[1];
    var year = dateInfor[2];

    var resultDate = new Date(year, month - 1, day);
    return resultDate;
}


function getStartDayOfWeek () {
    var date = new Date();
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

    return startDate;
}


function getEndDayOfWeek () {
    var date = new Date();
    var currentDayOfWeek = date.getDay();
    var dayOfMonth = date.getDate();
    var month = date.getMonth();
    var year = date.getFullYear();
    if (currentDayOfWeek == 0) {
        currentDayOfWeek = 7;
    }

    var endWeekDate = (dayOfMonth + (7 - currentDayOfWeek));
    var endDate = new Date(year, month, endWeekDate, 0, 0, 0, 0);
    var endDateBelongToNextYear = endDate.getFullYear() > year;
    if (endDateBelongToNextYear) {
        endDate = getLastDayOfTheYear(year);
    }

    return endDate;
}
// DATE PROCESS



