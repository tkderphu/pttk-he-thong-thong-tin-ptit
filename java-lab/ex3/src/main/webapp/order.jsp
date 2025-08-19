<%-- 
    Document   : orderList
    Created on : Aug 18, 2025, 9:22:01 AM
    Author     : FPT
--%>

<%@page import="site.viosmash.model.Book"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Page</title>
    </head>
    <body>
        <table>
        <thead>
            <tr>
                <th>id</th>
            <th>name</th>
            <th>category</th>
            <th>author</th>            
            </tr>

        </thead>
        <tbody>
            
        <%
            List<Book> books = (List<Book>)request.getAttribute("books");
            String bookIds = "";
            if(books != null) {
            for(int i = 0; i < books.size(); i++) {
                if(i != books.size() - 1) {
                   bookIds +=  books.get(i).getId() + ",";
            } else {
                bookIds += books.get(i).getId();
            }
                Book book = books.get(i);
                %>
                <tr>
                    <td><%= book.getId()%></td>
                    <td><%= book.getName()%></td>
                    <td><%= book.getCategory()%></td>
                    <td><%= book.getAuthor()%></td>

                </tr>
                <%
            }
            }
        %>
        </tbody>
        </table>
        
        <form action='/ex3/orders' method="post">
            <input type='hidden' value='<%= bookIds  %>' name='bookIds'/> 
            <button type='submit'>Place order</button>
        </form>
    </body>
</html>
