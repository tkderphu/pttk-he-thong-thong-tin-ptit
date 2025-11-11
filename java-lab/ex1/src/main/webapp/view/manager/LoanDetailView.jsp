<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="site.viosmash.libman.model.Loan" %>
<%@ page import="site.viosmash.libman.model.LoanDetail" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Libman - Chi tiết phiếu mượn</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", "Times New Roman", serif;
            background: linear-gradient(135deg, #f3f4f6, #e0e7ff);
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px 0;
            color: #333;
            margin: 0;
            min-height: 100vh;
        }

        .container {
            background-color: #fff;
            padding: 40px 60px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            width: 900px;
            animation: fadeIn 0.5s ease;
        }

        h1 {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            color: #1e3a8a;
            margin-bottom: 30px;
        }

        .top-bar {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 20px;
        }

        .btn {
            background-color: #1e40af;
            color: #fff;
            border: none;
            padding: 10px 22px;
            font-size: 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
        }

        .btn.secondary {
            background-color: #e5e7eb;
            color: #111827;
        }

        .btn.secondary:hover {
            background-color: #d1d5db;
        }

        .loan-info {
            background-color: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            padding: 20px 30px;
            margin-bottom: 30px;
            font-size: 15px;
            line-height: 1.8;
        }

        .loan-info p {
            margin: 6px 0;
        }

        .loan-info strong {
            display: inline-block;
            width: 160px;
            color: #1e3a8a;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            text-align: center;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #e5e7eb;
            padding: 12px;
            font-size: 15px;
        }

        th {
            background-color: #f9fafb;
            color: #1e3a8a;
        }

        tr:nth-child(even) {
            background-color: #f9fafb;
        }

        tbody tr:hover {
            background-color: #f1f5ff;
        }

        .empty {
            text-align: center;
            padding: 25px;
            color: #666;
            font-style: italic;
        }

        footer {
            margin-top: 30px;
            font-size: 14px;
            color: #666;
            text-align: center;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="container">

    <%
        Loan loan = (Loan) request.getAttribute("loan");
        LoanDetail[] loanDetails = (loan != null) ? loan.getLoanDetails() : null;

        if (loan == null) {
    %>
    <p class="empty">Không có thông tin phiếu mượn.</p>
    <%
        } else {
    %>

    <div class="top-bar">
        <a href="javascript:history.back()" class="btn secondary">⬅ Quay lại</a>
    </div>

    <h1>📄 Chi tiết phiếu mượn</h1>

    <div class="loan-info">
        <p><strong>Mã phiếu mượn:</strong> <%= loan.getId() %></p>
        <p><strong>Ngày mượn:</strong> <%= loan.getLoanDate() %></p>
        <p><strong>Hạn trả:</strong> <%= loan.getDueDate() %></p>
        <p><strong>Ngày trả:</strong> <%= loan.getReturnDate() != null 
                ? loan.getReturnDate() : "null" %></p>
        <p><strong>Trạng thái:</strong> <%= loan.getStatus() %></p>
    </div>

    <table>
        <thead>
        <tr>
            <th>STT</th>
            <th>Mã vạch tài liệu</th>
            <th>Tên tài liệu</th>
            <th>Vị trí</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (loanDetails != null && loanDetails.length > 0) {
                int index = 1;
                for (LoanDetail detail : loanDetails) {
        %>
        <tr>
            <td><%= index++ %></td>
            <td><%= detail.getItem().getBarcode() %></td>
            <td style="text-align:left;"><%= detail.getItem().getDocument().getTitle() %></td>
            <td><%= detail.getItem().getLocation() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4" class="empty">Không có tài liệu nào trong phiếu mượn này.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <footer>Hệ thống thư viện Libman - 2025</footer>

    <%
        }
    %>

</div>
</body>
</html>
