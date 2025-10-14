package site.viosmash.libman.dao;

import site.viosmash.libman.model.*;
import java.sql.*;
import java.util.*;

public class LoanDao extends Dao {

    public Loan getById(int loanId) {
        String sql = "SELECT l.id AS loan_id, l.loan_date, l.due_date, l.return_date, l.status, "
                + "r.id AS reader_id, r.username AS reader_username, r.fullname AS reader_name, "
                + "r.phoneNumber AS reader_phone, r.address AS reader_address, "
                + "lb.id AS librarian_id, lb.username AS librarian_username, lb.fullname AS librarian_name, "
                + "lb.phoneNumber AS librarian_phone, lb.address AS librarian_address, "
                + "ld.id AS loan_detail_id, "
                + "i.id AS item_id, i.barcode AS item_barcode, i.status AS item_status, "
                + "d.id AS document_id, d.title AS document_title, d.author AS document_author, "
                + "d.publisher AS document_publisher, d.category AS document_category "
                + "FROM tblLoan l "
                + "LEFT JOIN tblReader r ON l.reader_id = r.id "
                + "LEFT JOIN tblLibrarian lb ON l.librarian_id = lb.id "
                + "LEFT JOIN tblLoanDetail ld ON l.id = ld.loan_id "
                + "LEFT JOIN tblItem i ON ld.item_id = i.id "
                + "LEFT JOIN tblDocument d ON i.document_id = d.id "
                + "WHERE l.id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, loanId);
            ResultSet rs = ps.executeQuery();

            Loan loan = null;
            List<LoanDetail> loanDetails = new ArrayList<>();

            while (rs.next()) {
                if (loan == null) {
                    loan = new Loan();
                    loan.setId(rs.getInt("loan_id"));
                    loan.setLoanDate(rs.getDate("loan_date"));
                    loan.setDueDate(rs.getDate("due_date"));
                    loan.setReturnDate(rs.getDate("return_date"));
                    loan.setStatus(rs.getString("status"));

                    // Reader
                    Reader reader = new Reader();
                    reader.setId(rs.getInt("reader_id"));
                    reader.setUsername(rs.getString("reader_username"));
                    reader.setFullName(rs.getString("reader_name"));
                    reader.setPhoneNumber(rs.getString("reader_phone"));
                    reader.setAddress(rs.getString("reader_address"));
                    loan.setReader(reader);

                    // Librarian
                    Librarian librarian = new Librarian();
                    librarian.setId(rs.getInt("librarian_id"));
                    librarian.setUsername(rs.getString("librarian_username"));
                    librarian.setFullName(rs.getString("librarian_name"));
                    librarian.setPhoneNumber(rs.getString("librarian_phone"));
                    librarian.setAddress(rs.getString("librarian_address"));
                    loan.setLibrarian(librarian);
                }

                int loanDetailId = rs.getInt("loan_detail_id");
                if (loanDetailId > 0) {
                    LoanDetail detail = new LoanDetail();
                    detail.setId(loanDetailId);

                    Item item = new Item();
                    item.setId(rs.getInt("item_id"));
                    item.setBarcode(rs.getString("item_barcode"));
                    item.setStatus(rs.getString("item_status"));

                    Document document = new Document();
                    document.setId(rs.getInt("document_id"));
                    document.setTitle(rs.getString("document_title"));
                    document.setAuthor(rs.getString("document_author"));
                    document.setPublisher(rs.getString("document_publisher"));
                    document.setCategory(rs.getString("document_category"));

                    item.setDocument(document);
                    detail.setItem(item);

                    loanDetails.add(detail);
                }
            }

            if (loan != null) {
                loan.setLoanDetails(loanDetails.toArray(new LoanDetail[0]));
            }

            return loan;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Loan[] getListByReaderId(String readerId) {
        String sql = "SELECT l.id AS loan_id, l.loan_date, l.due_date, l.return_date, l.status, "
                + "r.id AS reader_id, r.username AS reader_username, r.fullname AS reader_name, "
                + "r.phoneNumber AS reader_phone, r.address AS reader_address, "
                + "lb.id AS librarian_id, lb.username AS librarian_username, lb.fullname AS librarian_name, "
                + "lb.phoneNumber AS librarian_phone, lb.address AS librarian_address "
                + "FROM tblLoan l "
                + "LEFT JOIN tblReader r ON l.reader_id = r.id "
                + "LEFT JOIN tblLibrarian lb ON l.librarian_id = lb.id "
                + "WHERE l.reader_id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, readerId);
            ResultSet rs = ps.executeQuery();

            List<Loan> loans = new ArrayList<>();

            while (rs.next()) {
                Loan loan = new Loan();
                loan.setId(rs.getInt("loan_id"));
                loan.setLoanDate(rs.getDate("loan_date"));
                loan.setDueDate(rs.getDate("due_date"));
                loan.setReturnDate(rs.getDate("return_date"));
                loan.setStatus(rs.getString("status"));

                // Reader info
                Reader reader = new Reader();
                reader.setId(rs.getInt("reader_id"));
                reader.setUsername(rs.getString("reader_username"));
                reader.setFullName(rs.getString("reader_name"));
                reader.setPhoneNumber(rs.getString("reader_phone"));
                reader.setAddress(rs.getString("reader_address"));
                loan.setReader(reader);

                // Librarian info
                Librarian librarian = new Librarian();
                librarian.setId(rs.getInt("librarian_id"));
                librarian.setUsername(rs.getString("librarian_username"));
                librarian.setFullName(rs.getString("librarian_name"));
                librarian.setPhoneNumber(rs.getString("librarian_phone"));
                librarian.setAddress(rs.getString("librarian_address"));
                loan.setLibrarian(librarian);

                // Optionally load loan details (optional, you can remove if not needed)
                loan.setLoanDetails(getLoanDetailsByLoanId(loan.getId()));

                loans.add(loan);
            }

            return loans.toArray(new Loan[0]);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    private LoanDetail[] getLoanDetailsByLoanId(int loanId) {
        String sql = "SELECT ld.id AS loan_detail_id, i.id AS item_id, i.barcode, i.status AS item_status, "
                + "d.id AS document_id, d.title, d.author, d.publisher, d.category "
                + "FROM tblLoanDetail ld "
                + "LEFT JOIN tblItem i ON ld.item_id = i.id "
                + "LEFT JOIN tblDocument d ON i.document_id = d.id "
                + "WHERE ld.loan_id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, loanId);
            ResultSet rs = ps.executeQuery();

            List<LoanDetail> details = new ArrayList<>();

            while (rs.next()) {
                LoanDetail detail = new LoanDetail();
                detail.setId(rs.getInt("loan_detail_id"));

                Item item = new Item();
                item.setId(rs.getInt("item_id"));
                item.setBarcode(rs.getString("barcode"));
                item.setStatus(rs.getString("item_status"));

                Document doc = new Document();
                doc.setId(rs.getInt("document_id"));
                doc.setTitle(rs.getString("title"));
                doc.setAuthor(rs.getString("author"));
                doc.setPublisher(rs.getString("publisher"));
                doc.setCategory(rs.getString("category"));

                item.setDocument(doc);
                detail.setItem(item);

                details.add(detail);
            }

            return details.toArray(new LoanDetail[0]);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
