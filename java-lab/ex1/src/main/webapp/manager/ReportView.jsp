<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Libman - Xem báo cáo</title>
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
            position: relative;
            width: 500px;
            animation: fadeIn 0.5s ease;
        }

        h1 {
            color: #1e3a8a;
            font-weight: bold;
            margin-bottom: 30px;
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
            margin: 10px 0;
        }

        .btn:hover {
            background-color: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
        }

        .back {
            background-color: #e5e7eb;
            color: #111827;
            border: none;
            padding: 10px 25px;
            font-size: 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: absolute;
            top: 10px;
            left: 10px;
        }

        .back:hover {
            background-color: #d1d5db;
            transform: translateY(-1px);
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
        <form action="/ex1/manager/ManagerView.jsp" method="get">
        <button type="submit" class="back">← Quay lại</button>
    </form>
        <h1 style="margin-top: 20px">Xem báo cáo</h1>

        <form action="/ex1/manager/ReaderReportByLoanCountView.jsp" method="get">
            <button type="submit" class="btn">Thống kê độc giả theo lượt mượn</button>
        </form>

        <footer>Hệ thống thư viện - 2025</footer>
    </div>
</body>
</html>
