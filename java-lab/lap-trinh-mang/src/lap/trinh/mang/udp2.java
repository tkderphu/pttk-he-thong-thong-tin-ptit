/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lap.trinh.mang;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author FPT
 */
public class udp2 {

    public static void main(String[] args) throws Exception {
        DatagramSocket socket = new DatagramSocket();
        String studentId = "B22DCCN621";
        String qCode = "95zU7CbF";
        String sendRequest = ";" + studentId + ";" + qCode;

        InetAddress inetAddress = Inet4Address.getByName("203.162.10.109");

        DatagramPacket packet = new DatagramPacket(
                sendRequest.getBytes(), sendRequest.length(),
                inetAddress, 2207
        );

        socket.send(packet);

        byte[] buffer = new byte[1024];
        DatagramPacket inPack = new DatagramPacket(buffer, buffer.length);

        socket.receive(inPack);

        String[] words = new String(inPack.getData(), 0, inPack.getLength())
                .split(";");

        int n =Integer.parseInt(words[1]);
        int k = Integer.parseInt(words[2]);
        List<Integer> maxs = new ArrayList();
        for(int i =0; i < n; i++) {
            if(i + k <= n) {
                maxs.add(findMax(i, i + k, words[3]));
            }
        }
        
        String ref = words[0]+ ";"+ maxs.stream().map(r ->r + "").collect(Collectors.joining(","));
        DatagramPacket pac1 = new DatagramPacket(
                ref.getBytes(), ref.length(),
                inetAddress, 2207
        );
        
        System.out.println("result: "+ ref);
        socket.send(pac1);

    }
    
    public static int findMax(int x, int n, String s) {
        String words[] = s.split(",");
        List<Integer> f = Arrays.stream(words)
                .map(r -> Integer.parseInt(r))
                .toList();
        int max = 0;
        for(int i = x; i < n; i++) {
            if(f.size() > i && max < f.get(i)) {
                max = f.get(i);
            }
        }
        return max;
    }
}
