/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.dao;

import java.util.ArrayList;
import java.util.List;
import site.viosmash.model.Order;

/**
 *
 * @author FPT
 */
public class OrderDao {
    
    private List<Order> orders = new ArrayList<>(List.of());
    
    
    
    public List<Order> findAllByUserId(String userId) {
        return orders.stream().filter(r -> r.getUser().getId().equals(userId))
                .toList();
    }
    
    public Order findById(String id) {
        return null;
    }
    
    /**
     *    /**
    * 0: pending
    * 1: processing
    * 2: delivered
        */
    public List<Order> findAllByStatus(int status) {
        return null;
    }
    
    public void deleteById(String id) {
        
    }
    
    public void updateStatusById(String id, int status) {
        
    }
    public Order save(Order order) {
        orders.add(order);
        return order;
    }
    
}
