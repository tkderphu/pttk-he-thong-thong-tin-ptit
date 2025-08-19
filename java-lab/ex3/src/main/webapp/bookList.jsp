<%-- 
    Document   : bookList
    Created on : Aug 19, 2025, 7:49:37 PM
    Author     : FPT
--%>

<%@page import="site.viosmash.model.Book"%>
<%@page import="java.util.List"%>
<%@page import="site.viosmash.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book List Page</title>
    </head>
    <body>
        <form action="/ex3/orders/create" method='post'>
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
                    <th>Order</th>
                </tr>
            </thead>
            <tbody>

                <%

                    List<Book> books = (List<Book>) request.getAttribute("books");
                    if (books != null) {
                        for (Book book : books) {
                %>
                <tr>
                    <td><%= book.getId()%></td>
                    <td><%= book.getName()%></td>
                    <td><%= book.getDescription()%></td>
                    <td><%= book.getCategory()%></td>
                    <td><%= book.getAuthor()%></td>
                    <td><a href='books/update?id=<%= book.getId()%>' >update</a></td>
                    <td>>
                        <a href='books/delete?id=<%= book.getId()%>' >Delete</a>
                    </td>
                    <td><input type="checkbox" value="<%= book.getId()%>" name="bookId"/></td>
                </tr>

                <%
                        }
                    }
                %>
            </tbody>
        </table>
            <button type='submit'>Order</button>
        </form>
    </body>
</html>
