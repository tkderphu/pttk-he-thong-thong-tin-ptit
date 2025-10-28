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
import java.util.Arrays;
import java.util.stream.Collectors;

/**
 *
 * @author FPT
 */
public class udp1 {

    public static void main(String[] args) throws Exception {
        DatagramSocket socket = new DatagramSocket();
        String studentId = "B22DCCN621";
        String qCode = "voBcEaEG";
        String sendRequest = ";" + studentId + ";" + qCode;

        InetAddress inetAddress = Inet4Address.getByName("203.162.10.109");

        DatagramPacket packet = new DatagramPacket(
                sendRequest.getBytes(), sendRequest.length(),
                inetAddress, 2208
        );

        socket.send(packet);

        byte[] buffer = new byte[1024];
        DatagramPacket inPack = new DatagramPacket(buffer, buffer.length);

        socket.receive(inPack);

        String[] words = new String(inPack.getData(), 0, inPack.getLength())
                .split(";");

        String collect = Arrays.stream(words[1].split("\\s+"))
                .map(r -> r.substring(0, 1).toUpperCase() + r.substring(1).toLowerCase())
                .collect(Collectors.joining(" "));

        String ref = words[0] + ";" + collect;
        DatagramPacket pac1 = new DatagramPacket(
                ref.getBytes(), ref.length(),
                inetAddress, 2208
        );
        
        System.out.println("result: "+ ref);
        socket.send(pac1);

    }
}
