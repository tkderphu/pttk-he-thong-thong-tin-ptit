/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.libman.servlet;

import site.viosmash.libman.dao.ItemDao;
import site.viosmash.libman.model.Item;

import javax.servlet.RequestDispatcher;
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
@WebServlet(urlPatterns = "/items/*")
public class ItemServlet extends HttpServlet {

    private ItemDao itemDao;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if(pathInfo.equals("/getListByDocumentId")) {
            int documentId = Integer.parseInt(req.getParameter("documentId"));

            Item[] items = itemDao.getListByDocumentId(documentId);
            req.setAttribute("items", items);
            RequestDispatcher requestDispatcher = req
                    .getRequestDispatcher("/view/reader/DocumentDetailsView.jsp");
            requestDispatcher.forward(req, resp);
        }
    }

    @Override
    public void init() throws ServletException {
        itemDao = new ItemDao();
    }
}
