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
public class ItemDao extends Dao{
    public Item[] getListByDocumentId(int documentId) {
        String sql = "SELECT id, barcode, status, document_id FROM tblItem WHERE document_id = ?";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, documentId);
            ResultSet resultSet = statement.executeQuery();

            List<Item> items = new ArrayList<>();
            while (resultSet.next()) {
                Item item = new Item();
                item.setId(resultSet.getInt("id"));
                item.setBarcode(resultSet.getString("barcode"));
                item.setStatus(resultSet.getString("status"));

                Document document = new Document();
                document.setId(resultSet.getInt("document_id"));
                item.setDocument(document);

                items.add(item);
            }

            return items.toArray(new Item[0]);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
