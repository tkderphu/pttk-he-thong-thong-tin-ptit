<%-- 
    Document   : login
    Created on : Aug 18, 2025, 9:13:58 AM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <%
            String errMessage = (String)request.getAttribute("error");
            %>
        <form action='/ex3/auth/login' method='post'>
            username: <input type="text" name="username"/>
            <br/>
            password: <input type='input' name='password'/>
            <button type='submit'>Submit</button>
        </form>
        <span style="color: red"><%= errMessage != null && !errMessage.isEmpty() ? errMessage : "" %></span>
    </body>
</html>
