package site.viosmash.libman.dao;

import site.viosmash.libman.model.ReaderStatistic;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReaderStatisticDao extends Dao {

    public ReaderStatistic[] getList(String start, String end) {
        String sql =
                "SELECT r.id AS reader_id, " +
                        "       m.id AS member_id, m.username, m.fullName, m.phoneNumber, " +
                        "       m.dateOfBirth, m.address, " +
                        "       COUNT(l.id) AS countLoan " +
                        "FROM tblLoan l " +
                        "JOIN tblReader r ON l.readerId = r.id " +
                        "JOIN tblMember m ON r.memberId = m.id " +
                        "WHERE l.loanDate BETWEEN ? AND ? " +
                        "GROUP BY r.id, m.id, m.username, m.fullName, m.phoneNumber, m.dateOfBirth, m.address " +
                        "ORDER BY countLoan DESC";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, start);
            ps.setString(2, end);
            ResultSet rs = ps.executeQuery();

            List<ReaderStatistic> stats = new ArrayList<>();

            while (rs.next()) {
                ReaderStatistic stat = new ReaderStatistic();
                stat.setId(rs.getInt("reader_id"));
                stat.setCountLoan(rs.getInt("countLoan"));

                // Fill member info (inherited from Reader → Member)
                stat.setUsername(rs.getString("username"));
                stat.setFullName(rs.getString("fullName"));
                stat.setPhoneNumber(rs.getString("phoneNumber"));
                stat.setDateOfBirth(rs.getString("dateOfBirth"));
                stat.setAddress(rs.getString("address"));

                stats.add(stat);
            }

            return stats.toArray(new ReaderStatistic[0]);

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching reader statistics", e);
        }
    }
}
