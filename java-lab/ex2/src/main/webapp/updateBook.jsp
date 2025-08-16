<%-- 
    Document   : updateBook
    Created on : Aug 16, 2025, 3:32:07 PM
    Author     : FPT
--%>

<%@page import="site.viosmash.model.Book"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Book book = (Book) request.getAttribute("book");

        %>
        <form action='/ex2/books/update', method="post">
            <input type='hidden' name='id' value='<%= book.getId() %>'/>
            name: <input type='text' name='name' value="<%= book.getName()%>" /> <br/>
            description: <input type='text' name='name' value="<%= book.getDescription()%>" /> <br/>
            category: <input type='text' name='name' value="<%= book.getCategory()%>" /> <br/>
            author: <input type='text' name='name' value="<%= book.getAuthor()%>" /> <br/><!-- comment -->

            <button>Edit</button>
        </form>

    </body>
</html>
