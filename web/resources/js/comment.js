  // Initialize Firebase
firebase.initializeApp(firebaseConfig);
var database = firebase.database();
  
function banComment(cmtId, button) {
    var submitForm = button.parentNode.parentNode;
    var inputText = submitForm.getElementsByClassName("input_message")[0];
    if (inputText.value != "") {
      submitForm.submit();
      var updateComment = {};
      updateComment['comments/' + cmtId + '/statusId'] = 'DA';
      database.ref().update(updateComment);
    } else {
      alert("Vui lòng nhập lí do xóa bình luận");
    }
}

function banReply(cmtId, replyId) {
    var updateReply = {};
    updateReply['comments/' + cmtId + '/replyList/' + replyId + '/statusId'] = 'DA';
    database.ref().update(updateReply);
}