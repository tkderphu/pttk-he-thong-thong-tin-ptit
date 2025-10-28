<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem báo cáo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 90vh;
            background-color: #f7f7f7;
        }

        .container {
            text-align: center;
            background: #fff;
            padding: 40px 80px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        h1 {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .btn {
            font-size: 16px;
            padding: 10px 20px;
            margin: 10px;
            border: 1px solid #999;
            border-radius: 5px;
            cursor: pointer;
            background-color: #f2f2f2;
            transition: all 0.2s ease-in-out;
        }

        .btn:hover {
            background-color: #ddd;
        }

        .back {
            float: left;
            margin-top: -30px;
            margin-left: -40px;
        }
    </style>
</head>
<body>
    <div class="container">
        <form action="/ex1/ManagerHomeView.jsp" method="get">
            <button type="submit" class="btn back">Quay lại</button>
        </form>

        <h1>Xem báo cáo</h1>

        <form action="/ex1/manager/ReaderReportByLoanCountView.jsp" method="get">
            <button type="submit" class="btn">Thống kê độc giả theo lượt mượn</button>
        </form>
    </div>
</body>
</html>
