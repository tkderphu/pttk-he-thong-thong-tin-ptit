<%-- 
    Document   : register
    Created on : Aug 18, 2025, 9:14:08 AM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
    </head>
    <body>
         <form action='/ex3/users/create' method='post'>
            username: <input type="text" name="username"/>
            <br/>
            password: <input type='input' name='password'/>    
            <br/>
            full name:  <input type='input' name='fullName'/>

            <button type='submit'>Submit</button>
        </form>
    </body>
</html>
