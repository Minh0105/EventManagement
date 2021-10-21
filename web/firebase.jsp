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
            CommentID <input type="text" name="commentID" id="" value="" /><br>
                        Content <input type="text" name="contents" id="" value="" /><br>
                        Username <input type="text" name="userName" id="" value="" /><br>
            <!--<input type="text" name="txt" value="" />-->
            <input  type="submit" onclick="sendCmt(this.form)" />
            
        </form>
        <form onsubmit="return false;">
            CMT ID <input type="text" style="border: 1px green solid;" name="CmtID" value=""> 
            <input  type="submit" onclick="sendReply(this.form)" value="Reply"/>
        </form>
        
        <div id="messages">

        </div>
        
        
        <script src="<c:url value="https://www.gstatic.com/firebasejs/7.2.0/firebase-app.js" />"></script>
        <script src="<c:url value="https://www.gstatic.com/firebasejs/7.2.0/firebase-database.js" />"></script>
        <script src="resources/js/function.js"></script>
        
    </body>
</html>
