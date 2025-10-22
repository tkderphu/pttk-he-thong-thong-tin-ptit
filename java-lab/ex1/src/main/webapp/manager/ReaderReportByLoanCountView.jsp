<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, site.viosmash.libman.model.ReaderStatistic" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thống kê độc giả theo lượt mượn</title>
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
                font-size: 26px;
                font-weight: bold;
                margin-bottom: 25px;
            }
            .top-bar {
                display: flex;
                justify-content: space-between;
                margin-bottom: 30px;
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
            .form-row {
                display: flex;
                justify-content: center;
                gap: 20px;
                margin-bottom: 20px;
            }
            input[type="date"] {
                padding: 6px 10px;
                font-size: 14px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                text-align: center;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 8px;
            }
            th {
                background-color: #f2f2f2;
            }
            tfoot td {
                font-weight: bold;
                background-color: #fafafa;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="top-bar">
                <form action="/ex1/manager/ReportView.jsp" method="get">
                    <button class="btn">Quay lại</button>
                </form>
            </div>

            <h1>Thống kê độc giả theo lượt mượn</h1>

            <form action="/ex1/readerStatistics/loanCount" method="get">
                <div class="form-row">
                    <div>
                        <label>Từ ngày</label><br>
                        <input type="date" name="start" value=<%= request.getParameter("start") %> required>
                    </div>
                    <div>
                        <label>Đến ngày</label><br>
                        <input type="date" name="end" value=<%= request.getParameter("end") %> required>
                    </div>
                </div>
                <div style="text-align:center;">
                    <button type="submit" class="btn">Xem thống kê</button>
                </div>
            </form>

            <%
                ReaderStatistic[] readerStatistics = null;
                int totalLoanCount = 0;

                Object obj = request.getAttribute("statistics");
                Object totalObj = request.getAttribute("totalLoanCount");

                if (obj != null) {
                    readerStatistics = (ReaderStatistic[]) obj;
                }

                if (totalObj != null) {
                    totalLoanCount = (int) totalObj;
                }
            %>

            <%
                if (readerStatistics != null && readerStatistics.length > 0) {
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
                    <% for (ReaderStatistic r : readerStatistics) {%>
                    <tr>
                        <td><%= r.getReaderId()%></td>
                        <td><%= r.getFullName()%></td>
                        <td><%= r.getCountLoan()%></td>
                        <td>
                            <form action="/ex1/loans/readerLoanDetail" method="get">
                                <input type="hidden" name="readerId" value="<%= r.getReaderId()%>">
                                <button type="submit" class="btn">Chi tiết</button>
                            </form>
                        </td>
                    </tr>
                    <% }%>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="2">Tổng cộng</td>
                        <td colspan="2"><%= totalLoanCount%> lượt mượn</td>
                    </tr>
                </tfoot>
            </table>
            <%
            } else {
            %>
            <p style="text-align:center; margin-top:20px;">Không có dữ liệu thống kê trong khoảng thời gian này.</p>
            <%
                }
            %>
        </div>
    </body>
</html>
