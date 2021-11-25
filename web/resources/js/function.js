
// Initialize Firebase
firebase.initializeApp(firebaseConfig);
var database = firebase.database();
var cmtRef = database.ref('comments');

var app_eventId;
var app_userId;
var app_userName;
var app_userAvatar;
var app_userRoleName;

function setEventId (eventId) {
  app_eventId = eventId;
}

function setUserId (userId) {
    app_userId = userId;
}
function setUserAvatar (userAvatar) {
    app_userAvatar = userAvatar;
}
function setUserRoleName (userRoleName) {
    app_userRoleName = userRoleName;
}

function setUserName (userName) {
    app_userName = userName;
}

function sendReply(commentID, btnReply) {
  var replyForm = btnReply.parentNode;
  var replyInput = replyForm.getElementsByClassName("input_reply")[0];
  var content = replyInput.value;

  if (content === "") {
    return;
  }

  var cmtID = commentID;
  var userId = app_userId;
  var userAvatar = app_userAvatar;
  var userName = app_userName;
  var userRoleName = app_userRoleName;

  var replyInfor = {  
    content: content, 
    userId:userId, 
    userAvatar:userAvatar, 
    userName:userName, 
    userRoleName:userRoleName,
    statusId:"AC"
  };

  database.ref('comments/'+ cmtID +'/replyList').push(replyInfor);

  replyInput.value = "";
}


function sendCmt() { // return the id of comment in firebase, need for replyObject

  var commentInput = document.getElementById("input_comment");
  var content = commentInput.value; 

  if (content === "") {
    return;
  }

  var eventId = app_eventId; 
  var userAvatar = app_userAvatar; 
  var userId = app_userId; 
  var userName = app_userName; 
  var userRoleName = app_userRoleName;

  cmtRef.push({
    content:content,
    eventId:eventId,
    userAvatar:userAvatar,
    userId:userId,
    userName:userName,
    userRoleName:userRoleName,
    statusId:"AC"
  });

  commentInput.value = "";
}


function startOnAddCommentListener () { 

    // ADD COMMENT INTO PAGE
    cmtRef.orderByChild('eventId').equalTo(app_eventId).on("child_added", function (snapshot) {

      var commentContent = snapshot.val();

      var commentID = snapshot.key; 
      var content = commentContent['content']; 
      var eventId = commentContent['eventId']; 
      var userId = commentContent['userId'];

      var isNotValidComment = commentContent['statusId'] == "DA";
      if (isNotValidComment) {
        return;
      }

      var replyList = commentContent['replyList'];    
      var userAvatar = commentContent['userAvatar']; 
      var userName = commentContent['userName']; 
      var userRoleName = commentContent['userRoleName']; 

      var comment_container = document.getElementById("comment");
      var comment_item_html = '';

      //#region Comment Item Html Code
      comment_item_html += createCommentItem(userId, commentID, userAvatar, userName, userRoleName, content, commentID, eventId);

      //#endregion

      // Add Comment Section
      comment_container.innerHTML = comment_item_html + comment_container.innerHTML;

      // PROCESS REPLY LIST
      var objectReplyList;
      if (replyList == undefined) {
        // Empty list
        objectReplyList = new Array();

      } else {
        // Convert JSON Object Array into Javascript Object Array
          objectReplyList = Object.keys(replyList).map(cmtID => {
                                                        var comment = replyList[cmtID];
                                                        comment.commentID = cmtID;    
                                                        return comment;
                                                      });
      }
      

      // Create Reply Container
      var replyContainerHtmlCode = '';
      replyContainerHtmlCode += '<div class="reply_container"> \n'

        for (var replyObject of objectReplyList) {
          
          var replyId = replyObject.commentID;
          var replyUserId = replyObject['userId'];
          var content = replyObject['content'];
          var userAvatar = replyObject['userAvatar'];
          var userName = replyObject['userName'];
          var userRoleName = replyObject['userRoleName'];
          var isNotValidComment = replyObject['statusId'] == "DA";
          if (isNotValidComment) {
            continue;
          }

          replyContainerHtmlCode += createReplyElement(replyUserId, replyId, userAvatar, userName, content, userRoleName, commentID);
        }

      replyContainerHtmlCode += '</div>'

      // Above comment item, it is created above
      var commentItemDiv = document.getElementById(commentID);
      commentItemDiv.innerHTML += replyContainerHtmlCode;
    });
}


function createCommentItem (userId, commentID, userAvatar, userName, userRoleName, content, commentID, eventId) {
  var comment_item_html = "";
  comment_item_html +=' <div id="'+ commentID +'" class="comment_item">'
  comment_item_html +='     <div class="comment_infor_section">'
  comment_item_html +='         <div class="avatar_container">'
  comment_item_html +='             <img class="organizer_ava" src="'+ userAvatar +'" alt="" referrerpolicy="no-referrer">'
  comment_item_html +='         </div>'
  comment_item_html +=''
  comment_item_html +='         <div class="comment_infor">'
  comment_item_html +='             <p class="comment_username">' + userName + ' - ' + userRoleName + '</p>'
  comment_item_html +='             <p class="comment_content">'+content+'</p>'
  comment_item_html +='             <p class="btn_show_reply d-inline-block" onclick="showReplyBox(this)">Trả lời</p>'
  if (userId == app_userId) {
    comment_item_html += '<button type="button" class="btn_delete_question" onclick="confirmDeleteComment(\''+commentID+'\')">Xóa</button>'
  }
  comment_item_html +='         </div>'
  comment_item_html +='     </div>'
  comment_item_html +=''
  comment_item_html +='     <div class="reply_box" action ="replyObject">'
  comment_item_html +='         <input class="input_reply" type="text" name="content" placeholder="Trả lời..." required/>'
  comment_item_html +='         <input type="hidden" name="commentId" value = "'+commentID+'"/>'
  comment_item_html +='         <input type="hidden" name="eventId" value = "'+eventId+'"/>'
  comment_item_html +='         <button type="button" onclick="sendReply(\''+ commentID +'\', this)" class="btn_reply mybutton btn-blue">Gửi</button>'
  comment_item_html +='         <button onclick="hideReplyBox(this)" class="btn_hide_reply mybutton btn-grey">Hủy</button>'
  comment_item_html +='     </div>'
  comment_item_html +=' </div>'

      return comment_item_html;
}

function createReplyElement (userId, replyId, userAvatar, userName, content, userRoleName, commentId) {
  var replyElementHtml = '';
      replyElementHtml += '    <div id="'+ replyId +'" class="repComment2"> \n'
      replyElementHtml += '        <div class="repComment2a"> \n'
      replyElementHtml += '            <img src="'+ userAvatar +'" class="organizer_ava" alt="" referrerpolicy="no-referrer"> \n'
      replyElementHtml += '        </div> \n'
      replyElementHtml += '        <div class="repComment2b"> \n'
      replyElementHtml += '            <p class="comment_username">' + userName + ' - ' + userRoleName + '</p> \n'
      replyElementHtml += '            <p class="comment_content">'+ content + '</p> \n'
      if (userId == app_userId) {
          replyElementHtml += '<button type="button" class="btn_delete_question" onclick="confirmDeleteReply(\''+replyId+'\',\''+commentId+'\')">Xóa</button>';
      }
      replyElementHtml += '        </div> \n'
      replyElementHtml += '    </div> \n'

  return replyElementHtml;
}

function confirmDeleteComment (commentId) {
  console.log(commentId);
  if (window.confirm("Bạn muốn xóa bình luận?") == true) {
    removeComment(commentId);
  }
}

function confirmDeleteReply (replyId, commentId) {
  if (window.confirm("Bạn muốn xóa bình luận?") == true) {
    removeReply(replyId, commentId);
  }
}

function startOnAddReplyListener () {
  cmtRef.orderByChild('eventId').equalTo(app_eventId).on("child_changed", function (snapshot) {
    var commentContent = snapshot.val();
    var commentID = snapshot.key;
    var isNotValidComment = commentContent['statusId'] == "DA";
    var userId = commentContent['userId'];
    if (isNotValidComment) {
      return;
    }

    var commentItem = document.getElementById(commentID);
    var replyContainer = commentItem.getElementsByClassName("reply_container")[0];
    replyContainer.innerHTML = "";
    var replyList = commentContent['replyList'];
  
    if (replyList != null && replyList != undefined) {

      var replyObjectList = Object.keys(replyList).map(replyId => replyList[replyId])
      
      replyContainer.innerHTML = '';
      for (var replyObject of replyObjectList) {
        var isNotValidComment = replyObject['statusId'] == "DA";
        if (isNotValidComment) {
          continue;
        }
        var replyId = replyObject.commentID;
        var replyUserId = replyObject['userId'];
        var userName = replyObject['userName'];
        var userRoleName = replyObject['userRoleName'];
        var userAvatar = replyObject['userAvatar'];
        var content = replyObject['content'];
        replyContainer.innerHTML += createReplyElement (replyUserId, replyId, userAvatar, userName, content, userRoleName, commentID);
      }

    }
  });
}


function startOnRemoveCommentListener () { 

  // ADD COMMENT INTO PAGE
  cmtRef.orderByChild('eventId').equalTo(app_eventId).on("child_removed", function (snapshot) {
    var commentID = snapshot.key; 

    var commentItemList = document.getElementsByClassName("comment_item");

    for (var item of commentItemList) {
      console.log(item.id + " == " + commentID + ": " + (item.id == commentID));
      if (item.id == commentID) {
        item.parentNode.removeChild(item);
        console.log("On Removed Success");
        break;
      }
    }
  });

}

function removeComment(commentId) {
  console.log(commentId);
  if (commentId != undefined) {
    database.ref("comments/" + commentId).remove();
  } 
}

function removeReply (replyId, commentId) {
  console.log(replyId);
  if (replyId != undefined) {
    var link = "comments/" + commentId + "/replyList/" + replyId;
    database.ref(link).remove();
  } 
}






