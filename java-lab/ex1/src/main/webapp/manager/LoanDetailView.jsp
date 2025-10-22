<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="site.viosmash.libman.model.Loan" %>
<%@ page import="site.viosmash.libman.model.LoanDetail" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Loan Details</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f7f7f7;
                margin: 20px;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                background-color: #fff;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #eee;
            }
            h2 {
                margin-bottom: 20px;
            }
            .container {
                max-width: 1000px;
                margin: auto;
            }
            .back-btn {
                margin-bottom: 20px;
                display: inline-block;
                padding: 6px 12px;
                background-color: #4285f4;
                color: #fff;
                text-decoration: none;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <div class="container">

            <%
                Loan loan = (Loan) request.getAttribute("loan");
                LoanDetail[] loanDetails = (loan != null) ? loan.getLoanDetails() : null;

                if (loan == null) {
            %>
            <p>No loan information available.</p>
            <%
            } else {
            %>

            <a href="javascript:history.back()" class="back-btn">Quay lại</a>

            <h2>Loan Detail - ID: <%= loan.getId()%></h2>
            <p>Loan Date: <%= loan.getLoanDate()%></p>
            <p>Due Date: <%= loan.getDueDate()%></p>
            <p>Return Date: <%= loan.getReturnDate() != null ? loan.getReturnDate() : "Not returned yet"%></p>
            <p>Status: <%= loan.getStatus()%></p>

            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Item Barcode</th>
                        <th>Document Title</th>
                        <th>Location</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (loanDetails != null && loanDetails.length > 0) {
                            int index = 1;
                            for (LoanDetail detail : loanDetails) {
                    %>
                    <tr>
                        <td><%= index++%></td>
                        <td><%= detail.getItem().getBarcode()%></td>
                        <td><%= detail.getItem().getDocument().getTitle()%></td>
                        <td><%= detail.getItem().getLocation()%></td>
                        <td><%= detail.getItem().getStatus()%></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5">No items found for this loan.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <%
                }
            %>

        </div>
    </body>
</html>
