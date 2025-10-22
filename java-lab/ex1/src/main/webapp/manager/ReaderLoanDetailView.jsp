<%@page import="site.viosmash.libman.model.Librarian"%>
<%@page import="site.viosmash.libman.model.Reader"%>
<%@page import="site.viosmash.libman.model.Loan"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
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
            .btn:hover {
                background-color: #ddd;
            }

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
                <a href="javascript:history.back()" class="back-btn">Quay lại</a>
            </div>

            <h1>Chi tiết độc giả mượn</h1>

            <%
                Loan[] loans = (Loan[]) request.getAttribute("loans");
                Reader reader = null;

                if (loans != null && loans.length > 0) {
                    reader = loans[0].getReader();
                }
            %>

            <% if (reader != null) { %>
            <div class="reader-info">
                <div><strong>Mã độc giả:</strong> <%= reader.getReaderId()%></div>
                <div><strong>Tên độc giả:</strong> <%= reader.getFullName() %></div>
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
                    <tr><td colspan="7">Không có dữ liệu mượn nào.</td></tr>
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
                                <button type="submit" class="btn">Xem</button>
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
