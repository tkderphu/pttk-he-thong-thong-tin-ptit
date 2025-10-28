package site.viosmash.libman.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import site.viosmash.libman.model.Member;

/**
 * @author Nguyen Quang Phu
 * @since 16/10/2025
 */
public class MemberDao extends Dao {


    public Member findByUsernameAndPassword(String username, String password) {
        String sql = "select id, username, phoneNumber, "
                + "fullName, address, role from tblMember "
                + "where username = ? and password = ?";

        try {
            PreparedStatement prepareStatement = this.conn.prepareStatement(sql);

            prepareStatement.setString(1, username);
            prepareStatement.setString(2, password);

            ResultSet rs = prepareStatement.executeQuery();
            if (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setUsername(rs.getString("username"));
                member.setPhoneNumber(rs.getString("phoneNumber"));
                member.setFullName(rs.getString("fullName"));
                member.setAddress(rs.getString("address"));
                member.setRole(rs.getString("role"));
                return member;
            }
            return null;
        } catch(Exception ex) {
            return null;
        }

    }
}
