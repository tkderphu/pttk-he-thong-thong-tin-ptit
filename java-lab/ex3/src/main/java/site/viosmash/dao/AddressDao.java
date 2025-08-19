/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.dao;

import java.util.ArrayList;
import java.util.List;
import site.viosmash.model.Address;

/**
 *
 * @author FPT
 */
public class AddressDao {
    
    
    private List<Address> TABLE = new ArrayList<>(List.of());
    
    public Address save(Address addr) {
        TABLE.add(addr);
        return addr;
    }
    
    public List<Address> findAllByUserId(String userId) {
        return TABLE.stream().filter(r -> r.getUserId().equals(userId))
                .toList();
    }
    public void deleteById(String id) {
        TABLE.removeIf(r -> r.getId().equals(id));
    }
}
