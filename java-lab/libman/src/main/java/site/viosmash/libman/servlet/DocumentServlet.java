/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.libman.servlet;

import site.viosmash.libman.dao.DocumentDao;
import site.viosmash.libman.model.Document;

import javax.servlet.RequestDispatcher;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author Nguyen Quang Phu
 */
@WebServlet(urlPatterns = "/documents")
public class DocumentServlet extends HttpServlet {

    private DocumentDao documentDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if(path.equals("/search")) {
            String keyword = req.getParameter("keyword");
            Document[] documents = documentDao.getListByKeyword(keyword);
            req.setAttribute("documents", documents);

            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/reader/SearchingDocumentView.jsp");
            requestDispatcher.forward(req, resp);
        }
    }

    @Override
    public void init() throws ServletException {
        documentDao = new DocumentDao();
    }
}
