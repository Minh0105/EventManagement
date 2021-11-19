
firebase.initializeApp(firebaseConfig);
var database = firebase.database();
var eventNotifRef = database.ref('notifications/event');
var notifContainer = document.getElementById("notif_body");

function listenNotification (userId) {
    eventNotifRef.orderByChild("userId").equalTo(parseInt(userId)).on("child_added", function (snapshot) {
        var notifContent = snapshot.val();
        var notifId = snapshot.key;
        var eventName = notifContent['eventName'];
        var organizerAvatar = notifContent['organizerAvatar'];
        var eventId = notifContent['eventId'];
        var message = notifContent['message'];
        var hasSeenSign = notifContent['seen'];
        var hasSeen;
        if (hasSeenSign != undefined) {
            hasSeen = true;
        } else {
            hasSeen = false;
            showUnSeenNotifBadge();
        }

        var notif_Element = createNotificationElement(notifId, eventName, organizerAvatar, eventId, message, hasSeen);
        notifContainer.insertBefore(notif_Element, notifContainer.firstChild);
        $('#no_notif_text').hide();
    });
}

function createNotificationElement (notifId, eventName, organizerAvatar, eventId, message, hasSeen) {
    var notifHtml = "";

    notifHtml += '<a class="notif_item d-block" href="viewEventDetail?eventId='+eventId+'">\n';
    
    if (hasSeen) { 
        notifHtml += '<p class="seen_tag d-none">1</p>'
    } else {
        notifHtml += '<p class="seen_tag d-none">0</p>'
    }

    notifHtml += '<p class="id_tag d-none">' + notifId + '</p>'
    notifHtml += '    <div class="sender_infor">\n';
    notifHtml += '        <img class="sender_ava" src="'+organizerAvatar+'" >\n';
    if (hasSeen) {
        notifHtml += '        <span class="sender_name">'+eventName+'</span>\n';
    } else {
        notifHtml += '        <span class="sender_name new_notif">'+eventName+'</span>\n';
    }
    notifHtml += '    </div>\n';
    notifHtml += '    <p class="content">\n';
    notifHtml += '        ' + message + "\n";
    notifHtml += '    </p>\n';
    notifHtml += '</a>\n';

    return createElementFromHtml(notifHtml);
}

function showUnSeenNotifBadge () {
    document.getElementById("new_notification_badge").style.display = "inline-block";
}

function hideUnSeenNotifBadge () {
    document.getElementById("new_notification_badge").style.display = "none";
}

function createElementFromHtml (html) {
    var element = document.createElement("div");
    element.innerHTML = html;
    return element.firstChild;
}

function seenAllNotification () {
    var notifications = document.getElementsByClassName("notif_item");
    var seen_tag;
    for (var notif of notifications) {
        seen_tag = notif.getElementsByClassName("seen_tag")[0].innerHTML;
        var hasNotSeen = parseInt(seen_tag) == 0;
        if (hasNotSeen) {
            var eventId = getNotifIdFromNotifiElement(notif);
            console.log(eventId);
            seenNotif(eventId);
        }
    }
    hideUnSeenNotifBadge();
}

function resetAllSeenState () {
    var notifications = document.getElementsByClassName("notif_item");
    for (var notif of notifications) {
        var newEventTag = notif.getElementsByClassName("sender_name new_notif")[0];
        if (newEventTag != undefined) {
            newEventTag.className = "sender_name";
        }
    }
}

function seenNotif (notificationId) {
    var updateNotification = {};
    updateNotification['notifications/event/' + notificationId + "/seen"] = 'true';
    database.ref().update(updateNotification);
}

function getNotifIdFromNotifiElement (notifELement) {
    return notifELement.getElementsByClassName("id_tag")[0].innerHTML;
}
