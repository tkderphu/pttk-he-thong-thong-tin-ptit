<%-- 
    Document   : orderList
    Created on : Aug 18, 2025, 9:22:01 AM
    Author     : FPT
--%>

<%@page import="site.viosmash.model.User"%>
<%@page import="site.viosmash.model.Order"%>
<%@page import="site.viosmash.model.Book"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order list</title>
    </head>
    <body>
        <table>
            <thead>
                <tr>
                    <th>id</th>
                    <th>items</th>
                    <th>address</th>
                </tr>

            </thead>
            <tbody>

                <%
                    Object obj = request.getSession().getAttribute("user");
                    if (obj != null) {
                        List<Order> books = (List<Order>) request.getAttribute("orders");
                        String bookIds = "";
                        if (books != null) {
                            for (int i = 0; i < books.size(); i++) {

                                Order book = books.get(i);
                %>
                <tr>
                    <td><%= book.getId()%></td>
                    <td><%= book.products()%></td>
                    <td><%= book.getAddress()%></td>

                </tr>
                <%
                            }
                        }
                    }
                %>
            </tbody>
        </table>

    </body>
</html>
