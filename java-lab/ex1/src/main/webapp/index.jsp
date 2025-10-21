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
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pttk?useSSL=false&serverTimezone=UTC",
                    "root",
                    "root"
            );
            
            if(conn != null) {
                %>
                <h1>fuck</h1>
                <%
            }
        %>
    </body>
</html>
