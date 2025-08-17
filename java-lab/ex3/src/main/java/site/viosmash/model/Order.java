/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.model;

import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author FPT
 */
public class Order {
   private String id;
   private User user;
   private Timestamp createdAt;
   private List<OrderItem> items;
   private Address address;
   /**
    * -1: canceled
    * 0: pending
    * 1: processing
    * 2: delivered
    */
   private int status; 
    public Order(String id, User user, Timestamp createdAt, List<OrderItem> items) {
        this.id = id;
        this.user = user;
        this.createdAt = createdAt;
        this.items = items;
    }

    public int quantity() {
        return items == null ? 0 : items.size();
    }
   
    public int totalPrice() {
        return items == null ? 0 : items.stream().mapToInt(r -> r.getBook().getPrice()).sum();
    }
   
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
   
   
}
