<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="site.viosmash.libman.dao.DocumentDao" %>
<%@ page import="site.viosmash.libman.dao.ItemDao" %>
<%@ page import="site.viosmash.libman.model.Document" %>
<%@ page import="site.viosmash.libman.model.Item" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết tài liệu</title>
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

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 10px;
        }

        th, td {
            border: 1px solid #000;
            padding: 6px;
            text-align: left;
        }

        th {
            background-color: #f8f8f8;
            font-weight: bold;
            text-align: center;
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

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .info-table td:first-child {
            font-weight: bold;
            width: 200px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="top-bar">
            <form action="searchDocument.jsp" method="get" style="margin: 0;">
                <button type="submit" class="btn">Quay lại</button>
            </form>
            <h2>Chi tiết tài liệu</h2>
            <div style="width: 70px;"></div>
        </div>

        <%
            String idParam = request.getParameter("id");
            if (idParam != null) {
                int documentId = Integer.parseInt(idParam);

                DocumentDao docDao = new DocumentDao();
                Document document = docDao.getById(documentId);

                ItemDao itemDao = new ItemDao();
                List<Item> items = Arrays.asList(itemDao.getListByDocumentId(documentId));

                if (document != null) {
        %>

        <!-- Document Info -->
        <table class="info-table">
            <tr>
                <td>Tên tài liệu</td>
                <td><%= document.getTitle() %></td>
            </tr>
            <tr>
                <td>Tác giả</td>
                <td><%= document.getAuthor() %></td>
            </tr>
            <tr>
                <td>Nhà sản xuất</td>
                <td><%= document.getPublisher() %></td>
            </tr>
            <tr>
                <td>Năm xuất bản</td>
                <td><%= document.getCategory() %></td>
            </tr>
        </table>

        <!-- Item List -->
        <table>
            <tr>
                <th>Barcode</th>
                <th>Vị trí</th>
                <th>Trạng thái</th>
            </tr>
            <%
                if (items != null && !items.isEmpty()) {
                    for (Item item : items) {
            %>
                <tr>
                    <td><%= item.getBarcode() %></td>
                    <td><%= item.getDocument() != null ? item.getDocument().getDescription() : "" %></td>
                    <td><%= item.getStatus() %></td>
                </tr>
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="3" style="text-align:center;">Không có bản sao nào</td>
                </tr>
            <%
                }
            %>
        </table>

        <%
                } else {
        %>
            <p>Không tìm thấy tài liệu.</p>
        <%
                }
            } else {
        %>
            <p>Thiếu mã tài liệu.</p>
        <%
            }
        %>
    </div>
</body>
</html>
