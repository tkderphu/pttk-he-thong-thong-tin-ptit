<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Libman - Trang chủ quản lý</title>
    <style>
        /* Reset & Base */
        * {
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", "Times New Roman", serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #f3f4f6, #e0e7ff);
        }

        .container {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            padding: 40px 60px;
            text-align: center;
            width: 500px;
            animation: fadeIn 0.5s ease;
        }

        h2 {
            color: #1e3a8a;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .greeting {
            font-size: 18px;
            color: #333;
            margin-bottom: 25px;
        }

        .btn {
            background-color: #1e40af;
            color: #fff;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
        }

        footer {
            margin-top: 25px;
            font-size: 14px;
            color: #666;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 480px) {
            .container {
                width: 90%;
                padding: 30px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Trang chủ quản lý</h2>
        <%
            String fullName = (String) request.getSession().getAttribute("fullName");
            if (fullName == null || fullName.trim().isEmpty()) {
                fullName = "Quản lý";
            }
        %>
        <div class="greeting">Xin chào, <strong><%= fullName %></strong>!</div>
        <form action="/ex1/view/manager/ReportView.jsp" method="get">
            <button type="submit" class="btn">📊 Xem báo cáo</button>
        </form>
        <footer>Hệ thống quản lý thư viện - 2025</footer>
    </div>
</body>
</html>
