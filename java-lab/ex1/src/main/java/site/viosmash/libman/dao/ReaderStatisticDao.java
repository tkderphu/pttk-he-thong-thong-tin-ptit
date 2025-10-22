package site.viosmash.libman.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import site.viosmash.libman.model.ReaderStatistic;

public class ReaderStatisticDao extends Dao {

    public ReaderStatistic[] getList(Date start, Date end) {
        String sql = 
            "SELECT " +
            "    r.readerId AS reader_id, " +
            "    m.id AS member_id, " +
            "    m.username, " +
            "    m.fullName, " +
            "    m.phoneNumber, " +
            "    m.dateOfBirth, " +
            "    m.address, " +
            "    COUNT(l.id) AS countLoan " +
            "FROM tblLoan l " +
            "JOIN tblReader r ON l.tblReaderid = r.readerId " +
            "JOIN tblMember m ON r.tblMemberid = m.id " +
            "WHERE l.loanDate BETWEEN ? AND ? " +
            "GROUP BY r.readerId, m.id, m.username, m.fullName, m.phoneNumber, m.dateOfBirth, m.address " +
            "ORDER BY countLoan DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, start);
            ps.setDate(2, end);

            try (ResultSet rs = ps.executeQuery()) {
                List<ReaderStatistic> stats = new ArrayList<>();

                while (rs.next()) {
                    ReaderStatistic stat = new ReaderStatistic();
                    stat.setReaderId(rs.getString("reader_id"));
                    stat.setId(rs.getInt("member_id"));
                    stat.setUsername(rs.getString("username"));
                    stat.setFullName(rs.getString("fullName"));
                    stat.setPhoneNumber(rs.getString("phoneNumber"));
                    stat.setDateOfBirth(rs.getString("dateOfBirth"));
                    stat.setAddress(rs.getString("address"));
                    stat.setCountLoan(rs.getInt("countLoan"));
                    stats.add(stat);
                }

                return stats.toArray(new ReaderStatistic[0]);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error fetching reader statistics", e);
        }
    }
}