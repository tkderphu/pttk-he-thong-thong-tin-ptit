/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lap.trinh.mang;

import UDP.Employee;
import com.sun.xml.messaging.saaj.util.ByteInputStream;
import com.sun.xml.messaging.saaj.util.ByteOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutput;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.nio.file.Files;
import java.text.Collator;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author FPT
 */
public class udp3 {

    public static void main(String[] args) throws Exception {
        DatagramSocket socket = new DatagramSocket();
        String studentId = "B22DCCN621";
        String qCode = "Zs4fwTUz";
        String sendRequest = ";" + studentId + ";" + qCode;

        InetAddress inetAddress = Inet4Address.getByName("203.162.10.109");

        DatagramPacket packet = new DatagramPacket(
                sendRequest.getBytes(), sendRequest.length(),
                inetAddress, 2209
        );

        socket.send(packet);

        byte[] buffer = new byte[1024];
        DatagramPacket inPack = new DatagramPacket(buffer, buffer.length);

        socket.receive(inPack);

        InputStream ins = new ByteInputStream(inPack.getData(), 8, inPack.getLength());
        ObjectInputStream ois = new ObjectInputStream(ins);

        Employee em = (Employee) ois.readObject();

        em.setName(Arrays.stream(em.getName().split("\\s+")).map(r -> r.substring(0, 1).toUpperCase() + r.substring(1).toLowerCase()).collect(Collectors.joining(" ")));

        String[] date = em.getHireDate().split("-");

        int x_percent = 0;
        for (int i = 0; i < date[0].length(); i++) {
            x_percent += Integer.parseInt(date[0].charAt(i) + "");
        }

        em.setSalary(em.getSalary() + (em.getSalary() * x_percent) / 100);
        em.setHireDate(date[2] + "/" + date[1] + "/" + date[0]);

        ByteOutputStream os = new ByteOutputStream();
        ObjectOutputStream out = new ObjectOutputStream(os);
        out.writeObject(em);

        byte[] input = inPack.getData();
        byte[] obByte=os.getBytes();
        byte[] newBuff = new byte[8 + obByte.length];

        System.arraycopy(input, 0, newBuff, 0, 8);
        System.arraycopy(obByte, 0, newBuff, 8, obByte.length);
        
        
        DatagramPacket pac1 = new DatagramPacket(
                newBuff, newBuff.length,
                inetAddress, 2209
        );

        System.out.println("result: ");
        socket.send(pac1);

    }

}
