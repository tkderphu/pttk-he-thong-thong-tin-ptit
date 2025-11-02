<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="site.viosmash.libman.model.Loan" %>
<%@ page import="site.viosmash.libman.model.LoanDetail" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết phiếu mượn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 20px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
        }
        th {
            background-color: #eee;
        }
        h2 {
            margin-bottom: 20px;
        }
        .container {
            max-width: 1000px;
            margin: auto;
        }
        .back-btn {
            margin-bottom: 20px;
            display: inline-block;
            padding: 6px 12px;
            background-color: #4285f4;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
        }

        .center {
            text-align: center;
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
    <p>Không có thông tin phiếu mượn.</p>
    <%
        } else {
    %>

    <a href="javascript:history.back()" class="back-btn">← Quay lại</a>

    <h2>Chi tiết phiếu mượn - Mã: <%= loan.getId() %></h2>
    <p>Ngày mượn: <%= loan.getLoanDate() %></p>
    <p>Hạn trả: <%= loan.getDueDate() %></p>
    <p>Ngày trả: <%= loan.getReturnDate() != null ? loan.getReturnDate() : "Chưa trả" %></p>
    <p>Trạng thái: <%= loan.getStatus() %></p>

    <table>
        <thead>
        <tr>
            <th class="center">STT</th>
            <th class="center">Mã vạch tài liệu</th>
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
            <td class="center"><%= index++ %></td>
            <td class="center"><%= detail.getItem().getBarcode() %></td>
            <td><%= detail.getItem().getDocument().getTitle() %></td>
            <td><%= detail.getItem().getLocation() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="5" class="center">Không có tài liệu nào trong phiếu mượn này.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

    <%
        }
    %>

</div>
</body>
</html>
