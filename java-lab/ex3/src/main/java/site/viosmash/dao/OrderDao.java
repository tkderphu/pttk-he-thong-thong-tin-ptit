/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.dao;

import java.util.List;
import site.viosmash.model.Order;

/**
 *
 * @author FPT
 */
public class OrderDao {
    
    public OrderDao() {
        
    }
    
    public List<Order> findAllByUserId(String userId) {
        return null;
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
        return null;
    }
    
}
