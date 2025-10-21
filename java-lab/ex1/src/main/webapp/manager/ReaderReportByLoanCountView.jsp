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
        .btn:hover { background-color: #ddd; }
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
        <form action="reportView.jsp" method="get">
            <button class="btn">Quay lại</button>
        </form>
    </div>

    <h1>Thống kê độc giả theo lượt mượn</h1>

    <form action="readerReport.jsp" method="get">
        <div class="form-row">
            <div>
                <label>Start date</label><br>
                <input type="date" name="start" required>
            </div>
            <div>
                <label>End date</label><br>
                <input type="date" name="end" required>
            </div>
        </div>
        <div style="text-align:center;">
            <button type="submit" class="btn">Xem thống kê</button>
        </div>
    </form>

    <%
        // === DEMO DATA (replace this with DAO later) ===
        List<ReaderStatistic> list = new ArrayList<>();
        ReaderStatistic r1 = new ReaderStatistic();
        r1.setId("R100");
        r1.setFullName("Nguyen Quang Phu");
        r1.setCountLoan(6);
        list.add(r1);

        ReaderStatistic r2 = new ReaderStatistic();
        r2.setId("R200");
        r2.setFullName("Nguyen Quang Phong");
        r2.setCountLoan(5);
        list.add(r2);

        int total = 0;
        for (ReaderStatistic r : list) total += r.getCountLoan();
    %>

    <table>
        <thead>
        <tr>
            <th>Mã độc giả</th>
            <th>Tên độc giả</th>
            <th>Số lần mượn</th>
            <th>Hành động</th>
        </tr>
        </thead>
        <tbody>
        <% for (ReaderStatistic r : list) { %>
            <tr>
                <td><%= r.getId() %></td>
                <td><%= r.getFullName() %></td>
                <td><%= r.getCountLoan() %></td>
                <td>
                    <form action="readerDetail.jsp" method="get">
                        <input type="hidden" name="readerId" value="<%= r.getId() %>">
                        <button type="submit" class="btn">Click</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="2">Tổng cộng</td>
            <td colspan="2"><%= total %> lượt mượn</td>
        </tr>
        </tfoot>
    </table>
</div>
</body>
</html>
