<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="site.viosmash.libman.dao.DocumentDao" %>
<%@ page import="site.viosmash.libman.dao.ItemDao" %>
<%@ page import="site.viosmash.libman.model.Document" %>
<%@ page import="site.viosmash.libman.model.Item" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết tài liệu</title>
    <style>
        * {
            box-sizing: border-box;
        }

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

        .info-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            border-radius: 8px;
            overflow: hidden;
        }

        .info-table td {
            border: 1px solid #e5e7eb;
            padding: 10px 12px;
            vertical-align: top;
        }

        .info-table td:first-child {
            background-color: #f1f5f9;
            font-weight: bold;
            color: #1e293b;
            width: 220px;
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
            background-color: #f8fafc;
            font-weight: bold;
            color: #1e293b;
        }

        tr:nth-child(even) {
            background-color: #f9fafb;
        }

        tr:hover {
            background-color: #e0e7ff;
        }

        footer {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
            color: #6b7280;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 600px) {
            .container {
                width: 90%;
                padding: 20px;
            }

            .info-table td:first-child {
                width: 40%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="top-bar">
            <a href="javascript:history.back()" class="back-btn">Quay lại</a>
            <h2>Chi tiết tài liệu</h2>
            <div style="width: 100px;"></div>
        </div>

        <%
            Object obj = request.getAttribute("items");
            Item[] items = null;
            Document document = null;

            if (obj != null) {
                items = (Item[]) obj;
                if (items.length > 0) {
                    document = items[0].getDocument();
                }
            }

            if (document != null) {
        %>

        <!-- Document Info -->
        <table class="info-table">
            <tr>
                <td>Tên tài liệu</td>
                <td><%= document.getTitle() %></td>
            </tr>
            <tr>
                <td>Mô tả</td>
                <td><%= document.getDescription() %></td>
            </tr>
            <tr>
                <td>Tác giả</td>
                <td><%= document.getAuthor() %></td>
            </tr>
            <tr>
                <td>Nhà xuất bản</td>
                <td><%= document.getPublisher() %></td>
            </tr>
            <tr>
                <td>Thể loại</td>
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
                if (items != null && items.length > 0) {
                    for (Item item : items) {
            %>
            <tr>
                <td><%= item.getBarcode() %></td>
                <td><%= item.getLocation()%></td>
                <td><%= item.getStatus() %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="3" style="color:#6b7280;">Không có bản sao nào</td>
            </tr>
            <%
                }
            %>
        </table>

        <%
            } else {
        %>
        <p style="text-align:center; color:#6b7280;">Không tìm thấy tài liệu.</p>
        <%
            }
        %>

        <footer>Thư viện điện tử - 2025</footer>
    </div>
</body>
</html>