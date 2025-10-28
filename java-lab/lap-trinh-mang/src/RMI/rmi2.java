package RMI;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import RMI.CharacterService;  // Interface từ server
import java.util.LinkedHashMap;
import java.util.Map;

public class rmi2 {
    public static void main(String[] args) {
        try {
            // --- Thông tin sinh viên và mã câu hỏi ---
            String studentCode = "B22DCCN621";
            String qCode = "RsCJOfch";

            // --- Kết nối tới RMI Registry ---
            Registry registry = LocateRegistry.getRegistry("203.162.10.109", 1099);

            // --- Lấy đối tượng từ xa ---
            CharacterService service = (CharacterService) registry.lookup("RMICharacterService");

            // --- (a) Gọi phương thức requestCharacter ---
            String input = service.requestCharacter(studentCode, qCode);
            System.out.println("✅ Chuỗi đầu vào nhận được từ server: " + input);

            // --- (b) Đếm tần số xuất hiện theo thứ tự ---
            Map<Character, Integer> freqMap = new LinkedHashMap<>();
            for (char c : input.toCharArray()) {
                freqMap.put(c, freqMap.getOrDefault(c, 0) + 1);
            }

            // Tạo chuỗi kết quả, theo định dạng A3B2C1
            StringBuilder result = new StringBuilder();
            for (Map.Entry<Character, Integer> entry : freqMap.entrySet()) {
                result.append(entry.getKey()).append(entry.getValue());
            }

            // --- (c) Gửi chuỗi kết quả trở lại server ---
            service.submitCharacter(studentCode, qCode, result.toString());
            System.out.println("✅ Đã gửi kết quả về server: " + result);

            // --- (d) Kết thúc chương trình ---
            System.out.println("🏁 Hoàn thành RMI Client (CharacterService)");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
