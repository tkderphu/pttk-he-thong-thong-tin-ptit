<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="site.viosmash.libman.model.Document" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm tài liệu</title>
    <style>
        * { box-sizing: border-box; }

        body {
            font-family: "Segoe UI", "Times New Roman", serif;
            background: linear-gradient(135deg, #f3f4f6, #e0e7ff);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 40px 0;
        }

        .container {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            width: 900px;
            padding: 40px 50px;
            animation: fadeIn 0.5s ease;
        }

        h2 {
            color: #1e3a8a;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .btn {
            background-color: #1e40af;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 3px 6px rgba(0,0,0,0.15);
        }

        .search-box {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 25px;
        }

        input[type="text"] {
            padding: 8px 12px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 15px;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #e5e7eb;
            padding: 10px 8px;
            text-align: center;
        }

        th {
            background-color: #f1f5f9;
            font-weight: bold;
            color: #1e293b;
        }

        tr:nth-child(even) {
            background-color: #f9fafb;
        }

        tr:hover {
            background-color: #e0e7ff;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 5px;
            background-color: #f1f5f9;
            border-radius: 5px;
            color: #1e40af;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .pagination a.active {
            background-color: #1e40af;
            color: #fff;
            font-weight: bold;
        }

        .pagination a:hover {
            background-color: #2563eb;
            color: #fff;
        }

        footer {
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
            color: #6b7280;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="top-bar">
        <form action="/ex1/reader/ReaderHomeView.jsp" method="get" style="margin:0;">
            <button type="submit" class="btn">⬅ Quay lại</button>
        </form>
        <h2>Tìm kiếm tài liệu</h2>
        <div style="width: 100px;"></div>
    </div>

    <%
        String keyword = request.getParameter("keyword");
        Document[] documents = null;
        Object obj = request.getAttribute("documents");

        if (obj != null) {
            documents = (Document[]) obj;
        }

        int pageNumber = 1;
        int recordsPerPage = 5; // Hiển thị 5 tài liệu mỗi trang
        if (request.getParameter("page") != null) {
            pageNumber = Integer.parseInt(request.getParameter("page"));
        }

        int totalRecords = (documents != null) ? documents.length : 0;
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        int start = (pageNumber - 1) * recordsPerPage;
        int end = Math.min(start + recordsPerPage, totalRecords);
    %>

    <!-- Search form -->
    <form action="/ex1/documents/searching" method="get" class="search-box">
        <input type="text" name="keyword" placeholder="Nhập từ khóa tài liệu..."
               value="<%= (keyword != null) ? keyword : "" %>">
        <button type="submit" class="btn">🔍 Tìm kiếm</button>
    </form>

    <table>
        <tr>
            <th>Mã</th>
            <th>Tên</th>
            <th>Tác giả</th>
            <th>Nhà sản xuất</th>
            <th>Thể loại</th>
            <th>Hành động</th>
        </tr>

        <%
            if (documents != null && totalRecords > 0) {
                for (int i = start; i < end; i++) {
                    Document d = documents[i];
        %>
        <tr>
            <td><%= d.getId() %></td>
            <td><%= d.getTitle() %></td>
            <td><%= d.getAuthor() %></td>
            <td><%= d.getPublisher() %></td>
            <td><%= d.getCategory() %></td>
            <td>
                <form action="/ex1/items/getListByDocumentId" method="get" style="margin:0;">
                    <input type="hidden" name="documentId" value="<%= d.getId() %>">
                    <button type="submit" class="btn">📘 Chi tiết</button>
                </form>
            </td>
        </tr>
        <%
                }
            } else if (keyword != null) {
        %>
        <tr>
            <td colspan="6" style="color:#6b7280;">Không tìm thấy tài liệu nào</td>
        </tr>
        <%
            }
        %>
    </table>

    <!-- Pagination -->
    <%
        if (totalPages > 1) {
    %>
    <div class="pagination">
        <%
            for (int i = 1; i <= totalPages; i++) {
                if (i == pageNumber) {
        %>
            <a href="?keyword=<%= (keyword != null ? keyword : "") %>&page=<%= i %>" class="active"><%= i %></a>
        <%
                } else {
        %>
            <a href="?keyword=<%= (keyword != null ? keyword : "") %>&page=<%= i %>"><%= i %></a>
        <%
                }
            }
        %>
    </div>
    <%
        }
    %>

    <footer>Thư viện điện tử - 2025</footer>
</div>
</body>
</html>