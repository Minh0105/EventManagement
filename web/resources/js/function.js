
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
      comment_item_html +=' <div id="'+ commentID +'" class="comment_item">'
      comment_item_html +='     <div class="comment_infor_section">'
      comment_item_html +='         <div class="avatar_container">'
      comment_item_html +='             <img class="rounded-circle lec_avatar" src="'+ userAvatar +'" alt="">'
      comment_item_html +='         </div>'
      comment_item_html +=''
      comment_item_html +='         <div class="comment_infor">'
      comment_item_html +='             <p class="comment_username">' + userName + ' - ' + userRoleName + '</p>'
      comment_item_html +='             <p class="comment_content">'+content+'</p>'
      comment_item_html +='             <p class="btn_show_reply" onclick="showReplyBox(this)">Trả lời</p>'
      comment_item_html +='         </div>'
      comment_item_html +='     </div>'
      comment_item_html +=''
      comment_item_html +='     <div class="reply_box" action ="replyObject">'
      comment_item_html +='         <input class="input_reply" type="text" name="content" placeholder="Trả lời..." required/>'
      comment_item_html +='         <input type="hidden" name="commentId" value = "'+commentID+'"/>'
      comment_item_html +='         <input type="hidden" name="eventId" value = "'+eventId+'"/>'
      comment_item_html +='         <button onclick="sendReply(\''+ commentID +'\', this)" class="btn_reply">Gửi</button>'
      comment_item_html +='         <button onclick="hideReplyBox(this)" class="btn_hide_reply">Hủy</button>'
      comment_item_html +='     </div>'
      comment_item_html +=' </div>'

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

        var content = replyObject['content'];
        var userAvatar = replyObject['userAvatar'];
        var userName = replyObject['userName'];
        var userRoleName = replyObject['userRoleName'];
        var isNotValidComment = replyObject['statusId'] == "DA";
        if (isNotValidComment) {
          continue;
        }

        //#region Reply Html Code
        replyContainerHtmlCode += '    <div class="repComment2"> \n'
        replyContainerHtmlCode += '        <div class="repComment2a"> \n'
        replyContainerHtmlCode += '            <img src="'+ userAvatar +'" class="rounded-circle lec_avatar" alt=""> \n'
        replyContainerHtmlCode += '        </div> \n'
        replyContainerHtmlCode += '        <div class="repComment2b"> \n'
        replyContainerHtmlCode += '            <p class="comment_username">' + userName + ' - ' + userRoleName + '</p> \n'
        replyContainerHtmlCode += '            <p class="comment_content">'+ content +'</p> \n'
        replyContainerHtmlCode += '        </div> \n'
        replyContainerHtmlCode += '    </div> \n'
        //#endregion
      
      }
      replyContainerHtmlCode += '</div>'

      // Above comment item, it is created above
      var commentItemDiv = document.getElementById(commentID);
      commentItemDiv.innerHTML += replyContainerHtmlCode;
    });
}

function startOnAddReplyListener () {
  cmtRef.orderByChild('eventId').equalTo(app_eventId).on("child_changed", function (snapshot) {
    var commentContent = snapshot.val();
    var commentID = snapshot.key;
    var isNotValidComment = commentContent['statusId'] == "DA";
    if (isNotValidComment) {
      return;
    }

    var commentItem = document.getElementById(commentID);
    var replyList = commentContent['replyList'];
  
    if (replyList != null && replyList != undefined) {

      var replyObjectList = Object.keys(replyList).map(replyId => replyList[replyId])
  
      var replyContainer = commentItem.getElementsByClassName("reply_container")[0];
      replyContainer.innerHTML = '';
      for (var replyObject of replyObjectList) {
        var isNotValidComment = replyObject['statusId'] == "DA";
        if (isNotValidComment) {
          continue;
        }

        var userName = replyObject['userName'];
        var userRoleName = replyObject['userRoleName'];
        var userAvatar = replyObject['userAvatar'];
        var content = replyObject['content'];
        replyContainer.innerHTML += createComment(userName, userRoleName, userAvatar, content);
      }

    }
  });
  
  
  function createComment (userName, userRoleName, userAvatar, content) {
    var commentHtml = '';
  
    commentHtml += '    <div class="repComment2"> \n'
    commentHtml += '        <div class="repComment2a"> \n'
    commentHtml += '            <img src="'+ userAvatar +'" class="rounded-circle lec_avatar" alt=""> \n'
    commentHtml += '        </div> \n'
    commentHtml += '        <div class="repComment2b"> \n'
    commentHtml += '            <p class="comment_username">' + userName + ' - ' + userRoleName + '</p> \n'
    commentHtml += '            <p class="comment_content">'+ content +'</p> \n'
    commentHtml += '        </div> \n'
    commentHtml += '    </div> \n'
  
    return commentHtml;
  }
}

