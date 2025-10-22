/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.libman.servlet;

import site.viosmash.libman.dao.ReaderStatisticDao;
import site.viosmash.libman.model.ReaderStatistic;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.Arrays;

/**
 *
 * @author Nguyen Quang Phu
 */
@WebServlet(urlPatterns = "/readerStatistics/*")
public class ReaderStatisticServlet extends HttpServlet {

    private ReaderStatisticDao readerStatisticDao;

    @Override
    public void init() throws ServletException {
//       / super.init(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
        this.readerStatisticDao = new ReaderStatisticDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
//        
//            RequestDispatcher requestDispatcher = req.getRequestDispatcher("login.jsp");
//            requestDispatcher.forward(req, resp);
        if (path.equals("/loanCount")) {
            String startDate = req.getParameter("start");
            String endDate = req.getParameter("end");
//
            ReaderStatistic[] statistics = readerStatisticDao.getList(Date.valueOf(startDate), Date.valueOf(endDate));
//
            req.setAttribute("statistics", statistics);
            req.setAttribute("totalLoanCount", Arrays.stream(statistics).mapToInt(r -> r.getCountLoan()).sum());

            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/manager/ReaderReportByLoanCountView.jsp");
            requestDispatcher.forward(req, resp);
        }
    }
}
