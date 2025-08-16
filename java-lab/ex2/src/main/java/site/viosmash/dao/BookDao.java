/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import site.viosmash.model.Book;

/**
 *
 * @author FPT
 */
public class BookDao {

    private List<Book> TABLE = new ArrayList<>(List.of(new Book(
            "vcl",
            "Head first design patterns",
            "This book give you behind the scene how structure code reuse and maintainable",
            "Jim weston",
            "coding")
    ));

    
    public Book findById(String id) {
        return TABLE.stream().filter(r -> r.getId().equals(id))
                .findFirst()
                .orElse(null);
    }
    public Book save(Book book) {
        TABLE.add(book);
        return book;
    }

    public Book update(Book book) {
       
        return null;
    }

    public List<Book> findAll() {
       return TABLE;
    }

    public void deleteById(String id) {
        TABLE.removeIf(book -> book.getId().equals(id));
    }
}
