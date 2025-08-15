<%-- 
    Document   : login
    Created on : Aug 15, 2025, 8:26:01 AM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login page</title>
    </head>
    <body>
        <%
            String error = (String)request.getAttribute("error");
        %>
        <form action="/ex1/auth/login", method="POST">
            Username: <input type='text' name='username'/>
            <br/>
            Password: <input type='password' name='password'/>
            
            <br/>
            <h4 style="color:red"><%= (error == null || error.isEmpty() ? "" : error) %></h4>
            <button type='submit'>Login</button>

        </form>


    </body>



</html>
