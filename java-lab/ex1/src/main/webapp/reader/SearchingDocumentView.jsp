<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="site.viosmash.libman.model.Document" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tìm kiếm tài liệu</title>
    <style>
        body {
            font-family: "Times New Roman", serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #fff;
            margin: 0;
        }

        .container {
            border: 1px solid #000;
            padding: 20px 30px;
            width: 800px;
            text-align: center;
        }

        h2 {
            font-weight: bold;
            margin-bottom: 20px;
        }

        .search-box {
            margin-bottom: 20px;
        }

        input[type="text"] {
            padding: 5px;
            width: 200px;
        }

        .btn {
            background-color: #f0f0f0;
            border: 1px solid #999;
            padding: 5px 15px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn:hover {
            background-color: #e0e0e0;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #000;
            padding: 6px;
            text-align: center;
        }

        th {
            background-color: #f8f8f8;
            font-weight: bold;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="top-bar">
            <form action="reader_home.jsp" method="get" style="margin: 0;">
                <button type="submit" class="btn">Quay lại</button>
            </form>
            <h2>Tìm kiếm tài liệu</h2>
            <div style="width: 70px;"></div>
        </div>

        <!-- Search form -->
        <form action="/ex1/documents/searching" method="get" class="search-box">
            <input type="text" name="keyword" placeholder="Nhập keyword"
                   value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>" />
            <button type="submit" class="btn">Tìm kiếm</button>
        </form>

        <%
            String keyword = request.getParameter("keyword");
            Document[] documents = null;
            Object obj = request.getAttribute("documents");

            if (obj != null) {
             documents = (Document[]) obj;
            }
        %>

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
                if (documents != null && documents.length > 0) {
                    for (Document d : documents) {
            %>
                        <tr>
                            <td><%= d.getId() %></td>
                            <td><%= d.getTitle() %></td>
                            <td><%= d.getAuthor() %></td>
                            <td><%= d.getPublisher() %></td>
                            <td><%= d.getCategory() %></td>
                            <td>
                                <form action="/ex1/items/getListByDocumentId" method="get" style="margin:0;">
                                    <input type="hidden" name="documentId" value="<%= d.getId() %>" />
                                    <button type="submit" class="btn">Chi tiết</button>
                                </form>
                            </td>
                        </tr>
            <%
                    }
                } else if (keyword != null && (documents == null || documents.length == 0)) {
            %>
                    <tr>
                        <td colspan="6">Không tìm thấy tài liệu nào</td>
                    </tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>
