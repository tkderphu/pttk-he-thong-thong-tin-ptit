<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết lần mượn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 95vh;
        }
        .container {
            background-color: #fff;
            padding: 30px 60px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            width: 750px;
        }
        h1 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 25px;
        }
        .btn {
            font-size: 15px;
            padding: 8px 18px;
            border: 1px solid #999;
            border-radius: 5px;
            background-color: #f2f2f2;
            cursor: pointer;
        }
        .btn:hover { background-color: #ddd; }

        .top-bar {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 20px;
        }

        .loan-info {
            margin-bottom: 25px;
            display: flex;
            justify-content: center;
            font-size: 16px;
            gap: 50px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
