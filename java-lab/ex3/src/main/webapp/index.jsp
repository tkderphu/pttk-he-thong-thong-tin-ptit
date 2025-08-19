<%-- 
    Document   : bookList.jsp
    Created on : Aug 18, 2025, 9:14:24 AM
    Author     : FPT
--%>

<%@page import="site.viosmash.model.User"%>
<%@page import="site.viosmash.model.Book"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book List Page</title>
    </head>
    <body>
        <h1>List book</h1>

        <a href='/ex3/createBook.jsp'>Create new book</a>
                <a href='/ex3/books/list'>Book list</a>
                <a href='/ex3/orders/list'>Order</a>
        <table>

            <tbody>
                <%
                    User user = (User) request.getSession().getAttribute("user");
                    if (user != null) {
                %>
            <h3>Hello, <%= user.getFullName()%></h3>
            <form action='/ex3/auth/logout' method='get'>
                <button type='submit'>Logout</button>
            </form>
            <%} else {
                
                %>

            <a href='/ex3/login.jsp'>Login</a> <br/>
            <a href='/ex3/register.jsp'>Register<a/> <br/>
                <%    }

                %>

                </tbody>
        </table>
    </body>
</html>
