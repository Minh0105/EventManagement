<%-- 
    Document   : firebase
    Created on : Oct 8, 2021, 4:47:14 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="profile" href="<c:url value='http://gmpg.org/xfn/11' />" />
        <script src="<c:url value='https://code.jquery.com/jquery-1.10.2.js' />"></script>
        <script src="<c:url value='https://cdn.firebase.com/v0/firebase.js' />"></script>
    </head>
    <body>
        <h1>JSON</h1>
        <form onSubmit="return false;">
                        <input type="text" name="commentID" id="" value="" />
                        <input type="text" name="contents" id="" value="" />
                        <input type="text" name="eventId" id="" value="" />
                        <input type="text" name="userID" id="" value="" />
                        <input type="text" name="userAvatar" id="" value="" />
                        <input type="text" name="userName" id="" value="" />
                        <input type="text" name="isQuestion" id="" value="" />
                        <input type="text" name="commentDatetime" id="" value="" />
                        <input type="text" name="userRoleName" id="" value="" />
                        <input type="text" name="replyList" id="" value="" />
                        <input type="text" name="statusId" id="" value="" />
            <!--<input type="text" name="txt" value="" />-->
            <input  type="submit" onclick="sendCmt(this.form)" />
        </form>

        <div id="messages">

        </div>
        <script src="<c:url value="resources/js/function.js" />"></script>
        
    </body>
</html>
