/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lap.trinh.mang;

import java.util.List;
import student.*;

/**
 *
 * @author FPT
 */
public class student {

    public static void main(String[] args) {
        ObjectService_Service ob_s = new ObjectService_Service();
        ObjectService obs = ob_s.getObjectServicePort();

        String id = "B22DCCN621";
        String qCode = "HudKVmKm";

        List<Student> requestListStudent = obs.requestListStudent(id, qCode)
                .stream().filter(student -> {
                    if(student.getScore() >= 8.0 || student.getScore() < 5.0) {
                        return true;
                    }
                    return false;
                }).toList();

        obs.submitListStudent(id, qCode, requestListStudent);
    }
}
