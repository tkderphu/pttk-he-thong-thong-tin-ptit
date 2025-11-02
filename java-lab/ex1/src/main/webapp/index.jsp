<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Start Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            Object role = request.getSession().getAttribute("role");
            if (role == null) {
                response.sendRedirect("login.jsp");
            } else {
                if (role.equals("MANAGER")) {
                    response.sendRedirect("/ex1/manager/ManagerView.jsp");
                } else if (role.equals("READER")) {
                    response.sendRedirect("/ex1/reader/ReaderHomeView.jsp");
                }
            }
        %>
    </body>
</html>
