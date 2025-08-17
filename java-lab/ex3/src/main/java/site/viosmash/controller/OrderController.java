/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.controller;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import site.viosmash.dao.OrderDao;
import site.viosmash.model.Order;
import site.viosmash.model.User;

/**
 *
 * @author FPT
 */
@WebServlet(urlPatterns = "/orders/*")
public class OrderController extends HttpServlet{
    private OrderDao orderDao;
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if(path == null || path.isEmpty()) {
            String userId = ((User)req.getSession().getAttribute("user")).getId();
            
            List<Order> orders = orderDao.findAllByUserId(userId);
            req.setAttribute("orders", orders);
            dispatcher(req, resp, "orderList.jsp");
        } else if(path.equals("/delete")) {
            String id = req.getParameter("id");
            orderDao.deleteById(id);
            resp.sendRedirect(req.getContextPath() + "/orderList.jsp");
        } else {
            String id = req.getParameter("id");
            Order order = orderDao.findById(id);
            req.setAttribute("order", order);
            dispatcher(req, resp, "orderDetail.jsp");
        }
        
    }
    
    public void dispatcher(HttpServletRequest req, HttpServletResponse resp, String jsp) {
         RequestDispatcher requestDispatcher = req.getRequestDispatcher("/" + jsp);
        try {
            requestDispatcher.forward(req, resp);
        } catch (ServletException ex) {
            Logger.getLogger(AuthController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(AuthController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
