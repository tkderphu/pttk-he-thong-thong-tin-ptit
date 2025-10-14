/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.libman.dao;

import site.viosmash.libman.model.Document;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nguyen Quang Phu
 */
public class DocumentDao extends Dao{
    public Document[] getListByKeyword(String keyword) {
        String sql = "SELECT id, title, description, " +
                     "author, publisher, category " +
                     "FROM tblDocument WHERE title LIKE '%?%'";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, keyword);
            ResultSet resultSet = statement.executeQuery();

            List<Document> documents = new ArrayList<>();
            while(resultSet.next()) {
                Document document = new Document();
                document.setId(resultSet.getInt(1));
                document.setTitle(resultSet.getString(2));
                document.setDescription(resultSet.getString(3));
                document.setAuthor(resultSet.getString(4));
                document.setPublisher(resultSet.getString(5));
                document.setCategory(resultSet.getString(6));

                documents.add(document);
            }

            return documents.toArray(new Document[0]);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public Document getById(int documentId) {
        String sql = "SELECT id, title, description, author, publisher, category FROM tblDocument WHERE id = ?";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, documentId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                Document document = new Document();
                document.setId(resultSet.getInt("id"));
                document.setTitle(resultSet.getString("title"));
                document.setDescription(resultSet.getString("description"));
                document.setAuthor(resultSet.getString("author"));
                document.setPublisher(resultSet.getString("publisher"));
                document.setCategory(resultSet.getString("category"));
                return document;
            } else {
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
