<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, site.viosmash.libman.model.Loan" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết độc giả mượn</title>
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
            padding: 30px 50px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            width: 900px;
        }
        h1 {
            text-align: center;
            font-size: 24px;
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
            transition: all 0.2s ease;
        }
        .btn:hover { background-color: #ddd; }

        .top-bar {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 25px;
        }

        .reader-info {
            margin: 10px 0 25px 0;
            display: flex;
            gap: 80px;
            justify-content: center;
            font-size: 16px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<div class="container">

    <div class="top-bar">
        <form action="readerReport.jsp" method="get">
            <button class="btn">Quay lại</button>
        </form>
    </div>

    <h1>Chi tiết độc giả mượn</h1>

    <div class="reader-info">
        <div><strong>Mã độc giả:</strong> R100</div>
        <div><strong>Tên độc giả:</strong> Nguyen Quang Phu</div>
    </div>

    <%
        // === DEMO DATA (replace this with DAO logic later) ===
        class LoanInfo {
            String id, librarian, status, dueDate, returnDate, loanDate;
            LoanInfo(String id, String librarian, String status, String dueDate, String returnDate, String loanDate) {
                this.id = id; this.librarian = librarian; this.status = status;
                this.dueDate = dueDate; this.returnDate = returnDate; this.loanDate = loanDate;
            }
        }

        List<LoanInfo> list = new ArrayList<>();
        list.add(new LoanInfo("L100", "Ha Nam", "Đang mượn", "30/09/2025", "", "25/09/2025"));
    %>

    <table>
        <thead>
        <tr>
            <th>Mã phiếu mượn</th>
            <th>Ngày mượn</th>
            <th>Nhân viên phụ trách</th>
            <th>Trạng thái</th>
            <th>Hạn trả</th>
            <th>Ngày trả</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <% for (LoanInfo l : list) { %>
            <tr>
                <td><%= l.id %></td>
                <td><%= l.loanDate %></td>
                <td><%= l.librarian %></td>
                <td><%= l.status %></td>
                <td><%= l.dueDate %></td>
                <td><%= (l.returnDate == null || l.returnDate.isEmpty()) ? "-" : l.returnDate %></td>
                <td>
                    <form action="loanDetail.jsp" method="get">
                        <input type="hidden" name="loanId" value="<%= l.id %>">
                        <button type="submit" class="btn">Click</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>

</div>
</body>
</html>
