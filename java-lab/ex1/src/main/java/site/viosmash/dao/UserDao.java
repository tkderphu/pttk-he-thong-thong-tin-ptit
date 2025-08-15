/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.dao;

import site.viosmash.models.User;

/**
 *
 * @author FPT
 */
public class UserDao {
    private DBConnection connection;

    public UserDao(DBConnection connection) {
        this.connection = connection;
    }


    public User findByUsernameAndPassword(String username, String password) {
        String sql = "SELECT id, username  FROM users WHERE username = ? AND password = ?;";        
        return null;
    }
    
    public User save(String username, String password) {
        String sql = "SELECT id FROM users WHERE username = ?;";
        return null;
    }
   
   
}
