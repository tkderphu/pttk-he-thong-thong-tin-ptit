/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.libman.dao;

import java.sql.Connection;
import java.sql.DriverManager;
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
public class DocumentDao extends Dao {

      public DocumentDao() {
        super(); // calls Dao() constructor → automatically sets conn
    }

    
    public Document[] getListByKeyword(String keyword) {
        String sql = "SELECT id, title, description, author, publisher, category "
                + "FROM tblDocument WHERE title LIKE ?";
        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, "%" + keyword + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                List<Document> documents = new ArrayList<>();

                while (resultSet.next()) {
                    Document document = new Document();
                    document.setId(resultSet.getInt("id"));
                    document.setTitle(resultSet.getString("title"));
                    document.setDescription(resultSet.getString("description"));
                    document.setAuthor(resultSet.getString("author"));
                    document.setPublisher(resultSet.getString("publisher"));
                    document.setCategory(resultSet.getString("category"));
                    documents.add(document);
                }

                return documents.toArray(new Document[0]);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving documents by keyword: " + keyword, e);
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
