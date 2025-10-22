package site.viosmash.libman.dao;

import site.viosmash.libman.model.Document;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentDao extends Dao {

    public DocumentDao() {
        super();
    }

    public Document[] getListByKeyword(String keyword) {
        // Use UPPER() to ignore case
        String sql = "SELECT id, title, description, author, publisher, category " +
                     "FROM tblDocument " +
                     "WHERE UPPER(title) LIKE UPPER(?) OR UPPER(description) LIKE UPPER(?)";
        List<Document> documents = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String param = "%" + keyword + "%";
            ps.setString(1, param);
            ps.setString(2, param);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    documents.add(map(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving documents by keyword: " + keyword, e);
        }

        return documents.toArray(new Document[0]);
    }

    public Document getById(int documentId) {
        String sql = "SELECT id, title, description, author, publisher, category FROM tblDocument WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, documentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving document with ID: " + documentId, e);
        }
        return null;
    }

    private Document map(ResultSet rs) throws SQLException {
        Document d = new Document();
        d.setId(rs.getInt("id"));
        d.setTitle(rs.getString("title"));
        d.setDescription(rs.getString("description"));
        d.setAuthor(rs.getString("author"));
        d.setPublisher(rs.getString("publisher"));
        d.setCategory(rs.getString("category"));
        return d;
    }
}