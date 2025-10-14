<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ bạn đọc</title>
    <style>
        body {
            font-family: "Times New Roman", serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #ffffff;
        }

        .container {
            border: 1px solid #000;
            padding: 30px 60px;
            text-align: center;
        }

        h2 {
            font-weight: bold;
            margin-bottom: 20px;
        }

        .btn {
            background-color: #f0f0f0;
            border: 1px solid #999;
            padding: 8px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Trang chủ bạn đọc</h2>
        <form action="searchDocument.jsp" method="get">
            <button type="submit" class="btn">Tìm kiếm tài liệu</button>
        </form>
    </div>
</body>
</html>
