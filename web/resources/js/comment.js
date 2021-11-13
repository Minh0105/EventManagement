  // Initialize Firebase
firebase.initializeApp(firebaseConfig);
var database = firebase.database();
  
function banComment(cmtId) {
    
    var updateComment = {};
    updateComment['comments/' + cmtId + '/statusId'] = 'DA';
    database.ref().update(updateComment);
}

function banReply(cmtId, replyId) {
    
    var updateReply = {};
    updateReply['comments/' + cmtId + '/replyList/' + replyId + '/statusId'] = 'DA';
    database.ref().update(updateReply);
}