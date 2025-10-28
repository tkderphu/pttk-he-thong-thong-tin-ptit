/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lap.trinh.mang;

/**
 *
 * @author FPT
 */
import cs1.*;
import java.util.List;

public class Ex2 {

    public static void main(String[] args) {
        String id = "B22DCCN621";
        String qCode = "BSb0JpjX";

        DataService_Service d = new DataService_Service();
        DataService dataService = d.getDataServicePort();

        List<Integer> data = dataService.getData(id, qCode);

        List<String> toList = data.stream().map(number -> {
            String octal =Integer.toOctalString(number);
            String hex = Integer.toHexString(number);
            System.out.println(octal + " → " + hex);
            
            return (octal + "|" + hex).toUpperCase();
        }).toList();
        
        dataService.submitDataStringArray(id, qCode, toList);
    }
}
