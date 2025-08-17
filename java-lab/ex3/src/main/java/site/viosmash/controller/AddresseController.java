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
import site.viosmash.dao.AddressDao;
import site.viosmash.model.Address;
import site.viosmash.model.User;

/**
 *
 * @author FPT
 */
@WebServlet(urlPatterns = "/addresses/*")
public class AddresseController extends HttpServlet {

    private AddressDao addressDao;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /**
         * findAllByUser
         */
        String path = req.getPathInfo();
        if (path.equals("/delete")) {
            String addressId = req.getParameter("id");
            addressDao.deleteById(addressId);
            resp.sendRedirect(req.getContextPath() + "/address.jsp");
        } else {
            User user = (User) req.getSession().getAttribute("user");
            if (user != null) {
                List<Address> addresses = addressDao.findAllByUserId(user.getId());
                req.setAttribute("addresses", addresses);
                dispatcher(req, resp, "address.jsp");
                
            }
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
