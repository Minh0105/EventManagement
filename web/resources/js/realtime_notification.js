
firebase.initializeApp(firebaseConfig);
var database = firebase.database();
var eventNotifRef = database.ref('notifications/event');
var notifContainer = document.getElementById("notif_body");

function listenNotification (userId) {
    eventNotifRef.orderByChild("userId").equalTo(parseInt(userId)).on("child_added", function (snapshot) {
        var notifContent = snapshot.val();
        console.log(notifContent);
        var eventName = notifContent['eventName'];
        var organizerAvatar = notifContent['organizerAvatar'];
        var eventId = notifContent['eventId'];
        var message = notifContent['message'];

        var notif_Element = createNotificationElement(eventName, organizerAvatar, eventId, message);
        notifContainer.insertBefore(notif_Element, notifContainer.firstChild);
    });
}

function createNotificationElement (eventName, organizerAvatar, eventId, message) {
    var notifHtml = "";
    notifHtml += '<a class="notif_item d-block" href="viewEventDetail?eventId='+eventId+'">\n';
    notifHtml += '    <div class="sender_infor">\n';
    notifHtml += '        <img class="sender_ava" src="'+organizerAvatar+'" >\n';
    notifHtml += '        <span class="sender_name">'+eventName+'</span>\n';
    notifHtml += '    </div>\n';
    notifHtml += '    <p class="content">\n';
    notifHtml += '        ' + message + "\n";
    notifHtml += '    </p>\n';
    notifHtml += '</a>\n';
    return createElementFromHtml(notifHtml);
}

function createElementFromHtml (html) {
    var element = document.createElement("div");
    element.innerHTML = html;
    return element.firstChild;
}
