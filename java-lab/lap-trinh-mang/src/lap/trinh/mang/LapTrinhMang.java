/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package lap.trinh.mang;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import characterservice.*;
/**
 *
 * @author FPT
 */
public class LapTrinhMang {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        CharacterService_Service sv = new CharacterService_Service();
        CharacterService characterServicePort = sv.getCharacterServicePort();
        
        String respData = characterServicePort.requestString("B22DCCN621", "QgAz616S");
        
        
        String[] words = respData.split("[_\\s]+");
        
        List<String> result = new ArrayList<>();
        
        result .add(Arrays.stream(words)
                .map(r -> r.substring(0, 1).toUpperCase() + r.substring(1).toLowerCase())
                .collect(Collectors.joining()));
        
        String camel = Arrays.stream(words)
                .map(r -> r.substring(0, 1).toUpperCase() + r.substring(1).toLowerCase())
                .collect(Collectors.joining());
        result .add(camel.substring(0, 1).toLowerCase() + camel.substring(1));
        
        result.add(Arrays.stream(words)
                .map(r -> r.toLowerCase())
                .collect(Collectors.joining("_")));
        
        characterServicePort.submitCharacterStringArray("B22DCCN621", "QgAz616S", result);
        
        String s = "test";
        
    }
    
}
