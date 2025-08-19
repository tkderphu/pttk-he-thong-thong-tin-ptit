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
        <title>Create new book</title>
    </head>
    <body>
       
        <form action='/ex3/books/create', method="post">
            name: <input type='text' name='name'  /> <br/>
            description: <input type='text' name='description' /> <br/>
            category: <input type='text' name='category'  /> <br/>
            author: <input type='text' name='author'  /> <br/><!-- comment -->

            <button type='submit'>Create</button>
        </form>

    </body>
</html>
