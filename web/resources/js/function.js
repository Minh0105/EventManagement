function sendMsg(frm) {
  //get message
  var msg = frm.value;
  //add new data to firebase location
  ref.push({ time: new Date().toUTCString(), msg: msg });
  //clear input text
  frm.value = "";
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

function sendCmt(frm) { // return the id of comment in firebase, need for reply
    var commentID = frm.commentID.value;
    var contents = frm.contents.value;
    var eventId = frm.eventId.value;
    var userID = frm.userID.value;
    var userAvatar = frm.userAvatar.value;
    var userName = frm.userName.value;
    var isQuestion = frm.isQuestion.value;
    var commentDatetime = frm.commentDatetime.value;
    var userRoleName = frm.userRoleName.value;
    // var replyList = frm.replyList;
    var statusId = frm.statusId.value;
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
        replyList:{"repId":1,"repId":2},
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
      .css({ border: "1px solid red" })
      .html(JSON.stringify(message['userName'] + " : " + message['contents']))
  );
});

