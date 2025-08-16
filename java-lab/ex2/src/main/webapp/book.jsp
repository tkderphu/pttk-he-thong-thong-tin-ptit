<%-- 
    Document   : book
    Created on : Aug 16, 2025, 2:52:12 PM
    Author     : FPT
--%>

<%@page import="site.viosmash.model.Book"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book management</title>
    </head>
    <body>
        <h1>List book</h1>
        
        <a href='/ex2/createBook.jsp'>Create new book</a>
        <table>
        <thead>
            <tr>
                <th>id</th>
            <th>name</th>
            <th>description</th>
            <th>category</th>
            <th>author</th>            
            <th>Update</th>
            <th>Delete</th>

            </tr>

        </thead>
        <tbody>
            <%
                List<Book> books = (List<Book>) request.getAttribute("books");
                for (Book book : books) {
            %>
            <tr>
                <td><%= book.getId()%></td>
                <td><%= book.getName()%></td>
                <td><%= book.getDescription()%></td>
                <td><%= book.getCategory()%></td>
                <td><%= book.getAuthor()%></td>
                <td><a href='books/update?id=<%= book.getId() %>' >update</a></td>
                <td>>
                    <a href='books/delete?id=<%= book.getId() %>' >Delete</a>
                    
                </td>
            </tr>

            <%
                }
            %>

        </tbody>
    </table>
</body>
</html>
