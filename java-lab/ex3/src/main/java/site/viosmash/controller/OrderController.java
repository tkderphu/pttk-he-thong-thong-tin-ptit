/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import site.viosmash.dao.BookDao;
import site.viosmash.dao.OrderDao;
import site.viosmash.model.Order;
import site.viosmash.model.OrderItem;
import site.viosmash.model.User;

/**
 *
 * @author FPT
 */
@WebServlet(urlPatterns = "/orders/*")
public class OrderController extends HttpServlet {

    private OrderDao orderDao;
    private BookDao bookDao;

    @Override
    public void init() {
        this.bookDao = new BookDao();
        this.orderDao = new OrderDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path.equals("/create")) {
            String[] bookIds = req.getParameterValues("bookId");
            User user = (User) req.getSession().getAttribute("user");
            if (user != null) {
                
                List<OrderItem> orderItems = new ArrayList<>();
                for(String bookId : bookIds) {
                    OrderItem orderItem = new OrderItem();
                    orderItem.setBook(bookDao.findById(bookId));
                    orderItem.setId(UUID.randomUUID().toString());
                    orderItems.add(orderItem);
                }
                
                Order order = new Order(UUID.randomUUID().toString(), 
                        user, Timestamp.valueOf(LocalDateTime.now()),
                        orderItems);
                
                orderDao.save(order);
                
                resp.sendRedirect(req.getContextPath() + "/orders/list");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path.equals("/list")) {
            String userId = ((User) req.getSession().getAttribute("user")).getId();

            List<Order> orders = orderDao.findAllByUserId(userId);
            req.setAttribute("orders", orders);
            dispatcher(req, resp, "orderList.jsp");
        } else if (path.equals("/delete")) {
            String id = req.getParameter("id");
            orderDao.deleteById(id);
            resp.sendRedirect(req.getContextPath() + "/orderList.jsp");
        } else if(path.equals("/by-id")) {
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
