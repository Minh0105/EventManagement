function sendMsg(frm) {
  //get message
  var msg = frm.txt.value;
  //add new data to firebase location
  ref.push({ time: new Date().toUTCString(), msg: msg });
  //clear input text
  frm.txt.value = "";
}
function sendReply(cmtID) {
    
    // reply object 
    var id;
    var contents;
    var userId;
    var userAvatar;
    var userName;
    var userRoleName;
    var replyDatetime;
    var statusId;
    ref = new Firebase(
        "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/comments/" + cmtID + "/replyList"
      );
    ref.push({  id:id, 
                contents: contents, 
                userId:userId, 
                userAvatar:userAvatar, 
                userName:userName, 
                userRoleName:userRoleName,
                replyDatetime:  replyDatetime,
                statusId : statusId 
            });
}

function sendCmt() { // return the id of comment in firebase, need for reply
    var commentID;
    var contents;
    var eventId;
    var userID;
    var userAvatar;
    var userName;
    var isQuestion;
    var commentDatetime;
    var userRoleName;
    var replyList;
    var statusId;
    ref = new Firebase(
        "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/comments"
      );
    ref.push({
        commentID:commentID,
        contents:contents,
        eventId:eventId,
        userID:userID,
        userAvatar:userAvatar,
        userName:userName,
        isQuestion:isQuestion,
        commentDatetime:commentDatetime,
        userRoleName:userRoleName,
        replyList:replyList,
        statusId:statusId
    });

    return ref.name();
}


var ref = new Firebase(
  "https://react-getting-started-30bc6-default-rtdb.firebaseio.com/comments"
);
ref.on("child_added", function (snapshot) {
  //We'll fill this in later.
  var message = snapshot.val();
  $("#messages").append(
    $("<div/>")
      .css({ border: "1px solid yellow" })
      .html(JSON.stringify(message['userID'] +" : " + message['contents']))
  );
});

