/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import site.viosmash.model.User;

/**
 *
 * @author FPT
 */
public class UserDao {
    
    private List<User> TABLE = new ArrayList<>(List.of(
            new User(UUID.randomUUID().toString(), "admin", "admin", "quang phu")
    ));
    
    public UserDao() {
        
    }
    
    public User save(User user) {
        TABLE.add(user);
        return user;
    }
    
    
    public User findByUsernameAndPassword(String username, String password) {
        /**
         * sql
         */
        String sql = "SELECT id, username, password, fullName FROM users where username = ? and password = ?";
        
        //fake data
        return TABLE.stream().filter(r -> r.getUsername().equals(username) && r.getPassword().equals(password))
                .findFirst().orElse(null);
    }
    public User findById(String id) {
        String sql = "SELECT id, username, password, fullName FROM "
                + "users where id = ?";

        return TABLE.stream()
                .filter(r -> r.getId().equals(id))
                .findFirst().orElse(null);
    }
    
}
