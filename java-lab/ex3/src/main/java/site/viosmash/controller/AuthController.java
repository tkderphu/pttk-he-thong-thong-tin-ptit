/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.controller;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import site.viosmash.dao.UserDao;
import site.viosmash.model.User;

/**
 *
 * @author FPT
 */
@WebServlet(urlPatterns = "/auth/*")
public class AuthController extends HttpServlet {

    private UserDao userDao;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
        if (path.equals("/login")) {
            String username = req.getParameter("username");
            String passwrod = req.getParameter("password");
            User user = userDao.findByUsernameAndPassword(username, passwrod);

            if (user == null) {
                String message = "Username or password invalid";
                req.setAttribute("error", message);
                dispatcher(req, resp, "login.jsp");
            } else {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                resp.sendRedirect(req.getContextPath() + "/" + "index.jsp");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path.equals("/logout")) {
            req.setAttribute("user", null);
            resp.sendRedirect(req.getContextPath() + "/" + "index.jsp");

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
