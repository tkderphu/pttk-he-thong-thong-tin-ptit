<%@page import="site.viosmash.libman.model.Librarian"%>
<%@page import="site.viosmash.libman.model.Reader"%>
<%@page import="site.viosmash.libman.model.Loan"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Libman - Chi tiết độc giả mượn</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #f4f6f9;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 40px;
            color: #333;
        }

        .container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
            width: 950px;
        }

        h1 {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 25px;
            color: #222;
        }

        .top-bar {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 25px;
        }

        .btn, .back-btn {
            font-size: 15px;
            padding: 8px 18px;
            border: 1px solid #bbb;
            border-radius: 6px;
            background-color: #f2f2f2;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            color: #333;
        }

        .btn:hover, .back-btn:hover {
            background-color: #007BFF;
            color: #fff;
        }

        .reader-info {
            background: #f9fafb;
            border-radius: 8px;
            padding: 15px 25px;
            margin-bottom: 30px;
            /*display: flex;*/
            justify-content: space-between;
            line-height: 1.8;
            font-size: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            margin-top: 15px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
        }

        th {
            background-color: #f9fafb;
        }

        tbody tr:hover {
            background-color: #f1f7ff;
        }

        td form {
            margin: 0;
        }

        .no-data {
            text-align: center;
            color: #777;
            padding: 15px 0;
        }
    </style>
</head>
<body>
    <div class="container">

        <div class="top-bar">
            <a href="javascript:history.back()" class="back-btn">⬅ Quay lại</a>
        </div>

        <h1>📚 Chi tiết độc giả mượn</h1>

        <%
            Loan[] loans = (Loan[]) request.getAttribute("loans");
            Reader reader = null;
            if (loans != null && loans.length > 0) {
                reader = loans[0].getReader();
            }
        %>

        <% if (reader != null) { %>
        <div class="reader-info">
            <p><strong>Mã độc giả:</strong> <%= reader.getReaderId() %></p>
            <p><strong>Tên độc giả:</strong> <%= reader.getFullName() %></p>
        </div>
        <% } %>

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
                <%
                    if (loans == null || loans.length == 0) {
                %>
                <tr>
                    <td colspan="7" class="no-data">Không có dữ liệu mượn nào.</td>
                </tr>
                <%
                    } else {
                        for (Loan loan : loans) {
                            Librarian lb = loan.getLibrarian();
                %>
                <tr>
                    <td><%= loan.getId() %></td>
                    <td><%= loan.getLoanDate() %></td>
                    <td><%= (lb != null ? lb.getFullName() : "-") %></td>
                    <td><%= loan.getStatus() %></td>
                    <td><%= loan.getDueDate() %></td>
                    <td><%= (loan.getReturnDate() == null ? "-" : loan.getReturnDate()) %></td>
                    <td>
                        <form action="/ex1/loans/loanDetail" method="get">
                            <input type="hidden" name="loanId" value="<%= loan.getId() %>">
                            <button type="submit" class="btn">Chi tiết</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>

    </div>
</body>
</html>
