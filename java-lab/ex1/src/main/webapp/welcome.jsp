<%-- 
    Document   : welcome
    Created on : Aug 15, 2025, 8:55:29 AM
    Author     : FPT
--%>
<%@page import="site.viosmash.models.User"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Page</title>
    </head>
    <body>
        <%
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            } else {
        %>
        <h2>Welcome, <%= ((User)session.getAttribute("user")).getUsername()%>!</h2>
        <%
            }
        %>
           
        <form action='auth/logout' method='POST'>
            <button type='submit'>Logout</button>
        </form>
    </body>
</html>
