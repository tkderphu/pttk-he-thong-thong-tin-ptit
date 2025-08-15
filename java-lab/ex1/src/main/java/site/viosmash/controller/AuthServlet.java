/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import site.viosmash.dao.PostgreSQLConnection;
import site.viosmash.dao.UserDao;
import site.viosmash.models.User;

/**
 *
 * @author FPT
 */
@WebServlet(urlPatterns = "/auth/*")
public class AuthServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() throws ServletException {
//        userDao = new UserDao(new PostgreSQLConnection()); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody

        String path = req.getPathInfo();

        switch (path) {
            case "/login":
                handleLogin(req, resp);
                break;
            case "/logout":
                handleLogout(req, resp);
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.setAttribute("user", null);
        sendRedirect(req, resp, "");
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

//        User user = userDao.findByUsernameAndPassword(username, password);
        if (username.equals("admin") && password.equals("admin")) {
            HttpSession session = req.getSession();
            session.setAttribute("user", new User(1, "admin", "admin"));
            sendRedirect(req, resp, "welcome.jsp");
        } else {
            req.setAttribute("error", "Username or password invalid");
            forward(req, resp, "login.jsp");
        }
    }

    private void sendRedirect(HttpServletRequest req, HttpServletResponse resp, String url) throws IOException {
        resp.sendRedirect(req.getContextPath() + "/" + url);
    }

    private void forward(HttpServletRequest req, HttpServletResponse resp, String url) throws IOException, ServletException {
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/" + url);
        requestDispatcher.forward(req, resp);
    }
}
