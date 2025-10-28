package RMI;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import RMI.ByteService; // interface từ server
import java.util.ArrayList;
import java.util.List;

public class run {
    public static void main(String[] args) {
        try {
            // --- Thông tin sinh viên và mã câu hỏi ---
            String studentCode = "B22DCCN621";
            String qCode = "COnUa2i6";

            // --- Kết nối tới RMI Registry ---
            Registry registry = LocateRegistry.getRegistry("203.162.10.109", 1099); // IP server và cổng mặc định RMI

            // --- Lấy đối tượng từ xa ---
            ByteService service = (ByteService) registry.lookup("RMIByteService");

            // --- (a) Gọi phương thức requestData ---
            byte[] data = service.requestData(studentCode, qCode);
            System.out.println("✅ Đã nhận mảng dữ liệu: " + data.length + " byte");

            // --- (b) Phân chia mảng: chẵn trước, lẻ sau ---
            List<Byte> evenList = new ArrayList<>();
            List<Byte> oddList = new ArrayList<>();

            for (byte b : data) {
                if ((b & 1) == 0) evenList.add(b);  // byte chẵn
                else oddList.add(b);                // byte lẻ
            }

            byte[] result = new byte[data.length];
            int idx = 0;
            for (byte b : evenList) result[idx++] = b;
            for (byte b : oddList) result[idx++] = b;

            // --- (c) Gửi dữ liệu trở lại server ---
            service.submitData(studentCode, qCode, result);
            System.out.println("✅ Đã gửi mảng dữ liệu sau khi xử lý chẵn-lẻ về server.");

            // --- (d) Kết thúc ---
            System.out.println("🏁 Hoàn thành chương trình client.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
