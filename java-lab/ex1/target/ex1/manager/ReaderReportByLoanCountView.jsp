<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, site.viosmash.libman.model.ReaderStatistic" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thống kê độc giả theo lượt mượn</title>
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
            width: 900px;
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
            margin-bottom: 30px;
        }
        .btn {
            font-size: 15px;
            padding: 8px 18px;
            border: 1px solid #bbb;
            border-radius: 5px;
            background-color: #f2f2f2;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            color: #333;
        }
        .btn:hover {
            background-color: #007BFF;
            color: #fff;
        }
        .form-row {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 20px;
        }
        input[type="date"] {
            padding: 6px 10px;
            font-size: 14px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            text-align: center;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
        }
        th {
            background-color: #f9fafb;
        }
        tfoot td {
            font-weight: bold;
            background-color: #f5f5f5;
        }
        .pagination {
            text-align: center;
            margin-top: 25px;
        }
        .pagination a, .pagination span {
            margin: 0 4px;
            padding: 8px 14px;
            border-radius: 6px;
            border: 1px solid #ccc;
            background-color: #f7f7f7;
            text-decoration: none;
            color: #333;
            font-size: 14px;
        }
        .pagination a:hover {
            background-color: #007BFF;
            color: #fff;
        }
        .pagination .active {
            background-color: #007BFF;
            color: #fff;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">

    <div class="top-bar">
        <form action="/ex1/manager/ReportView.jsp" method="get">
            <button class="btn">⬅ Quay lại</button>
        </form>
    </div>

    <h1>📊 Thống kê độc giả theo lượt mượn</h1>

    <form action="/ex1/readerStatistics/loanCount" method="get">
        <div class="form-row">
            <div>
                <label>Từ ngày</label><br>
                <input type="date" name="start" value="<%= request.getParameter("start") %>" required>
            </div>
            <div>
                <label>Đến ngày</label><br>
                <input type="date" name="end" value="<%= request.getParameter("end") %>" required>
            </div>
        </div>
        <div style="text-align:center;">
            <button type="submit" class="btn">Xem thống kê</button>
        </div>
    </form>

    <%
        ReaderStatistic[] readerStatistics = null;

        Object obj = request.getAttribute("statistics");

        if (obj != null) {
            readerStatistics = (ReaderStatistic[]) obj;
        }
    %>

    <%
        if (readerStatistics != null && readerStatistics.length > 0) {

            int itemsPerPage = 5;
            int currentPage = 1;

            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            int totalItems = readerStatistics.length;
            int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages) currentPage = totalPages;

            int startIndex = (currentPage - 1) * itemsPerPage;
            int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

            int pageTotal = 0;
    %>

    <table>
        <thead>
            <tr>
                <th>Mã độc giả</th>
                <th>Tên độc giả</th>
                <th>Tổng số lần mượn</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <% for (int i = startIndex; i < endIndex; i++) {
                ReaderStatistic r = readerStatistics[i];
                pageTotal += r.getCountLoan();
            %>
            <tr>
                <td><%= r.getReaderId() %></td>
                <td style="text-align:left;"><%= r.getFullName() %></td>
                <td><%= r.getCountLoan() %></td>
                <td>
                    <form action="/ex1/loans/readerLoanDetail" method="get">
                        <input type="hidden" name="readerId" value="<%= r.getReaderId() %>">
                        <button type="submit" class="btn">Chi tiết</button>
                    </form>
                </td>
            </tr>
            <% } %>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="2" style="text-align:right;">Tổng trong trang này</td>
                <td colspan="2"><%= pageTotal %> lượt mượn</td>
            </tr>
        </tfoot>
    </table>

    <!-- Pagination -->
    <div class="pagination">
        <% if (currentPage > 1) { %>
            <a href="?page=<%= currentPage - 1 %>&start=<%= request.getParameter("start") %>&end=<%= request.getParameter("end") %>">&lt;</a>
        <% } %>

        <%
            int startPage = Math.max(1, currentPage - 2);
            int endPage = Math.min(totalPages, startPage + 4);
            for (int i = startPage; i <= endPage; i++) {
        %>
            <% if (i == currentPage) { %>
                <span class="active"><%= i %></span>
            <% } else { %>
                <a href="?page=<%= i %>&start=<%= request.getParameter("start") %>&end=<%= request.getParameter("end") %>"><%= i %></a>
            <% } %>
        <% } %>

        <% if (currentPage < totalPages) { %>
            <a href="?page=<%= currentPage + 1 %>&start=<%= request.getParameter("start") %>&end=<%= request.getParameter("end") %>">&gt;</a>
        <% } %>
    </div>

    <% } else { %>
        <p style="text-align:center; margin-top:20px;">Không có dữ liệu thống kê trong khoảng thời gian này.</p>
    <% } %>

</div>
</body>
</html>
