<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, site.viosmash.libman.model.ReaderStatistic" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Libman - Thống kê độc giả theo lượt mượn</title>
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

            .form-row {
                display: flex;
                justify-content: center;
                gap: 30px;
                margin-bottom: 25px;
            }

            input[type="date"] {
                padding: 8px 12px;
                font-size: 15px;
                border-radius: 8px;
                border: 1px solid #ccc;
                outline: none;
                transition: border-color 0.2s ease;
            }

            input[type="date"]:focus {
                border-color: #2563eb;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 25px;
                text-align: center;
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

            tfoot td {
                font-weight: bold;
                background-color: #f3f4f6;
            }

            .pagination {
                text-align: center;
                margin-top: 30px;
            }

            .pagination a, .pagination span {
                margin: 0 5px;
                padding: 8px 14px;
                border-radius: 8px;
                border: 1px solid #ccc;
                background-color: #f7f7f7;
                text-decoration: none;
                color: #333;
                font-size: 14px;
                transition: all 0.2s ease;
            }

            .pagination a:hover {
                background-color: #2563eb;
                color: #fff;
            }

            .pagination .active {
                background-color: #1e40af;
                color: #fff;
                font-weight: bold;
            }

            footer {
                margin-top: 30px;
                font-size: 14px;
                color: #666;
                text-align: center;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="top-bar">
                <form action="/ex1/view/manager/ReportView.jsp" method="get">
                    <button class="btn secondary">⬅ Quay lại</button>
                </form>
            </div>

            <h1>📊 Thống kê độc giả theo lượt mượn</h1>

            <form action="/ex1/readerStatistics/loanCount" method="get">
                <div class="form-row">
                    <div>
                        <label>Từ ngày</label><br>
                        <input type="date" name="start" 
                               value="<%= request.getParameter("start")%>" 
                               required>
                    </div>
                    <div>
                        <label>Đến ngày</label><br>
                        <input type="date" name="end" 
                               value="<%= request.getParameter("end")%>" 
                               required>
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
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                    if (currentPage > totalPages) {
                        currentPage = totalPages;
                    }

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
                        <td><%= r.getReaderId()%></td>
                        <td style="text-align:left;"><%= r.getFullName()%></td>
                        <td><%= r.getCountLoan()%></td>
                        <td>
                            <form action="/ex1/loans/readerLoanDetail" method="get">
                                <input type="hidden" name="readerId" 
                                       value="<%= r.getReaderId()%>">
                                <button type="submit" class="btn">Chi tiết</button>
                            </form>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="2" style="text-align:right;">
                            Tổng trong trang này</td>
                        <td colspan="2"><%= pageTotal%> lượt mượn</td>
                    </tr>
                </tfoot>
            </table>

            <div class="pagination">
                <% if (currentPage > 1) {%>
                <a href="?page=<%= currentPage - 1%>&start=
                   <%= request.getParameter("start")%>&end=
                   <%= request.getParameter("end")%>">&lt;</a>
                <% } %>

                <%
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, startPage + 4);
                    for (int i = startPage; i <= endPage; i++) {
                %>
                <% if (i == currentPage) {%>
                <span class="active"><%= i%></span>
                <% } else {%>
                <a href="?page=<%= i%>&start=
                   <%= request.getParameter("start")%>&end=
                   <%= request.getParameter("end")%>"><%= i%></a>
                <% } %>
                <% } %>

                <% if (currentPage < totalPages) {%>
                <a href="?page=<%= currentPage + 1%>&start=
                   <%= request.getParameter("start")%>&end=
                   <%= request.getParameter("end")%>">&gt;</a>
                <% } %>
            </div>

            <% } else { %>
            <p style="text-align:center; margin-top:20px;">
                Không có dữ liệu thống kê trong khoảng thời gian này.</p>
                <% }%>

            <footer>Hệ thống thư viện Libman - 2025</footer>
        </div>
    </body>
</html>
