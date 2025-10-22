package site.viosmash.libman.dao;

import site.viosmash.libman.model.Document;
import site.viosmash.libman.model.Item;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDao extends Dao {

    public ItemDao() {
        super();
    }

    public Item[] getListByDocumentId(int documentId) {
        String sql = "SELECT i.id AS item_id, i.barcode, i.status, i.position, "
                   + "d.id AS doc_id, d.title, d.description, d.author, d.publisher, d.category "
                   + "FROM tblItem i "
                   + "JOIN tblDocument d ON i.document_id = d.id "
                   + "WHERE d.id = ?";

        List<Item> items = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, documentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    items.add(map(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving items by document ID: " + documentId, e);
        }

        return items.toArray(new Item[0]);
    }

    private Item map(ResultSet rs) throws SQLException {
        Item i = new Item();
        i.setId(rs.getInt("item_id"));
        i.setBarcode(rs.getString("barcode"));
        i.setStatus(rs.getString("status"));
        i.setLocation(rs.getString("position"));

        Document d = new Document();
        d.setId(rs.getInt("doc_id"));
        d.setTitle(rs.getString("title"));
        d.setDescription(rs.getString("description"));
        d.setAuthor(rs.getString("author"));
        d.setPublisher(rs.getString("publisher"));
        d.setCategory(rs.getString("category"));

        i.setDocument(d);
        return i;
    }
}
