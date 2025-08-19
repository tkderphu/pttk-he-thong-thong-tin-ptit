<%-- 
    Document   : address
    Created on : Aug 18, 2025, 9:15:14 AM
    Author     : FPT
--%>

<%@page import="site.viosmash.model.Address"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Address Page</title>
    </head>
    <body>
        <%
            List<Address> addresses = (List<Address>)request.getAttribute("addresses");
        %>
    </body>
</html>
