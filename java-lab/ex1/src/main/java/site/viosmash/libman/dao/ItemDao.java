/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.libman.dao;

import site.viosmash.libman.model.Document;
import site.viosmash.libman.model.Item;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nguyen Quang Phu
 */
public class ItemDao extends Dao {


    
    public Item[] getListByDocumentId(int documentId) {
    String sql = "SELECT i.id AS item_id, i.barcode, i.status, i.position, "
               + "d.id AS doc_id, d.title, d.description, d.author, d.publisher, d.category "
               + "FROM tblItem i "
               + "JOIN tblDocument d ON i.document_id = d.id "
               + "WHERE d.id = ?";

    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        statement = conn.prepareStatement(sql);
        statement.setInt(1, documentId);
        resultSet = statement.executeQuery();

        List<Item> items = new ArrayList<>();

        while (resultSet.next()) {
            Item item = new Item();
            item.setId(resultSet.getInt("item_id"));
            item.setBarcode(resultSet.getString("barcode"));
            item.setStatus(resultSet.getString("status"));
            item.setPosition(resultSet.getString("position"));

            Document document = new Document();
            document.setId(resultSet.getInt("doc_id"));
            document.setTitle(resultSet.getString("title"));
            document.setDescription(resultSet.getString("description"));
            document.setAuthor(resultSet.getString("author"));
            document.setPublisher(resultSet.getString("publisher"));
            document.setCategory(resultSet.getString("category"));

            item.setDocument(document);
            items.add(item);
        }

        return items.toArray(new Item[0]);
    } catch (SQLException e) {
        throw new RuntimeException("Error retrieving items by document ID: " + documentId, e);
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


}
