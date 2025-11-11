/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.libman.servlet;

import site.viosmash.libman.dao.LoanDao;
import site.viosmash.libman.model.Loan;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/loans/*")
public class LoanServlet extends HttpServlet {

    private LoanDao loanDao;

    @Override
    protected void doGet(HttpServletRequest req,
            HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo != null && pathInfo.equals("/readerLoanDetail")) {
            String readerId = (req.getParameter("readerId"));
            Loan[] loans = loanDao.getListByReaderId(readerId);
            req.setAttribute("loans", loans);
            req.getRequestDispatcher("/view/manager/ReaderLoanDetailView.jsp")
                    .forward(req, resp);
        } else if (pathInfo != null && pathInfo.equals("/loanDetail")) {
            int loanId = Integer.parseInt(req.getParameter("loanId"));
            Loan loan = loanDao.getById(loanId);
            req.setAttribute("loan", loan);
            req.getRequestDispatcher("/view/manager/LoanDetailView.jsp")
                    .forward(req, resp);
        }
    }

    @Override
    public void init() throws ServletException {
        this.loanDao = new LoanDao();
    }
}
