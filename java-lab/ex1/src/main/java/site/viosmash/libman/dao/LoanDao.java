package site.viosmash.libman.dao;

import site.viosmash.libman.model.*;
import java.sql.*;
import java.util.*;

public class LoanDao extends Dao {

    public LoanDao() {
        super();
    }

    public Loan getById(int loanId) {
        String sql = "SELECT l.id AS loan_id, l.loanDate, l.dueDate, l.returnDate, l.status, "
                + "r.readerId AS reader_id, m.username AS reader_username, m.fullName AS reader_name, "
                + "m.phoneNumber AS reader_phone, m.address AS reader_address, "
                + "lb.id AS librarian_id, lm.username AS librarian_username, lm.fullName AS librarian_name, "
                + "lm.phoneNumber AS librarian_phone, lm.address AS librarian_address, "
                + "ld.id AS loan_detail_id, "
                + "i.id AS item_id, i.barcode AS item_barcode, i.status AS item_status, "
                + "d.id AS document_id, d.title AS document_title, d.author AS document_author, "
                + "d.publisher AS document_publisher, d.category AS document_category "
                + "FROM tblLoan l "
                + "LEFT JOIN tblReader r ON l.tblReaderid = r.readerId "
                + "LEFT JOIN tblMember m ON r.tblMemberid = m.id "
                + "LEFT JOIN tblLibrarian lb ON l.tblLibrarianid = lb.id "
                + "LEFT JOIN tblMember lm ON lb.tblMemberid = lm.id "
                + "LEFT JOIN tblLoanDetail ld ON l.id = ld.tblLoanid "
                + "LEFT JOIN tblItem i ON ld.tblItemid = i.id "
                + "LEFT JOIN tblDocument d ON i.tblDocumentid = d.id "
                + "WHERE l.id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, loanId);
            try (ResultSet rs = ps.executeQuery()) {
                Loan loan = null;
                List<LoanDetail> details = new ArrayList<>();

                while (rs.next()) {
                    if (loan == null) {
                        loan = new Loan();
                        loan.setId(rs.getInt("loan_id"));
                        loan.setLoanDate(rs.getDate("loanDate"));
                        loan.setDueDate(rs.getDate("dueDate"));
                        loan.setReturnDate(rs.getDate("returnDate"));
                        loan.setStatus(rs.getString("status"));

                        Reader reader = new Reader();
                        reader.setReaderId(rs.getString("reader_id"));
                        reader.setUsername(rs.getString("reader_username"));
                        reader.setFullName(rs.getString("reader_name"));
                        reader.setPhoneNumber(rs.getString("reader_phone"));
                        reader.setAddress(rs.getString("reader_address"));
                        loan.setReader(reader);

                        Librarian librarian = new Librarian();
                        librarian.setId(rs.getInt("librarian_id"));
                        librarian.setUsername(rs.getString("librarian_username"));
                        librarian.setFullName(rs.getString("librarian_name"));
                        librarian.setPhoneNumber(rs.getString("librarian_phone"));
                        librarian.setAddress(rs.getString("librarian_address"));
                        loan.setLibrarian(librarian);
                    }

                    int detailId = rs.getInt("loan_detail_id");
                    if (detailId > 0) {
                        LoanDetail detail = new LoanDetail();
                        detail.setId(detailId);

                        Item item = new Item();
                        item.setId(rs.getInt("item_id"));
                        item.setBarcode(rs.getString("item_barcode"));
                        item.setStatus(rs.getString("item_status"));

                        Document doc = new Document();
                        doc.setId(rs.getInt("document_id"));
                        doc.setTitle(rs.getString("document_title"));
                        doc.setAuthor(rs.getString("document_author"));
                        doc.setPublisher(rs.getString("document_publisher"));
                        doc.setCategory(rs.getString("document_category"));

                        item.setDocument(doc);
                        detail.setItem(item);
                        details.add(detail);
                    }
                }

                if (loan != null) loan.setLoanDetails(details.toArray(new LoanDetail[0]));
                return loan;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Loan[] getListByReaderId(String readerId) {
        String sql = "SELECT l.id AS loan_id, l.loanDate, l.dueDate, l.returnDate, l.status, "
                + "r.readerId AS reader_id, m.username AS reader_username, m.fullName AS reader_name, "
                + "m.phoneNumber AS reader_phone, m.address AS reader_address, "
                + "lb.id AS librarian_id, lm.username AS librarian_username, lm.fullName AS librarian_name, "
                + "lm.phoneNumber AS librarian_phone, lm.address AS librarian_address "
                + "FROM tblLoan l "
                + "LEFT JOIN tblReader r ON l.tblReaderid = r.readerId "
                + "LEFT JOIN tblMember m ON r.tblMemberid = m.id "
                + "LEFT JOIN tblLibrarian lb ON l.tblLibrarianid = lb.id "
                + "LEFT JOIN tblMember lm ON lb.tblMemberid = lm.id "
                + "WHERE l.tblReaderid = ?";

        List<Loan> loans = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, readerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Loan loan = new Loan();
                    loan.setId(rs.getInt("loan_id"));
                    loan.setLoanDate(rs.getDate("loanDate"));
                    loan.setDueDate(rs.getDate("dueDate"));
                    loan.setReturnDate(rs.getDate("returnDate"));
                    loan.setStatus(rs.getString("status"));

                    Reader reader = new Reader();
                    reader.setReaderId(rs.getString("reader_id"));
                    reader.setUsername(rs.getString("reader_username"));
                    reader.setFullName(rs.getString("reader_name"));
                    reader.setPhoneNumber(rs.getString("reader_phone"));
                    reader.setAddress(rs.getString("reader_address"));
                    loan.setReader(reader);

                    Librarian librarian = new Librarian();
                    librarian.setId(rs.getInt("librarian_id"));
                    librarian.setUsername(rs.getString("librarian_username"));
                    librarian.setFullName(rs.getString("librarian_name"));
                    librarian.setPhoneNumber(rs.getString("librarian_phone"));
                    librarian.setAddress(rs.getString("librarian_address"));
                    loan.setLibrarian(librarian);
                    
                    loans.add(loan);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching loans by readerId", e);
        }

        return loans.toArray(new Loan[0]);
    }
}