/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.controller;

import java.io.IOException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import site.viosmash.dao.UserDao;
import site.viosmash.model.User;

/**
 *
 * @author FPT
 */
@WebServlet(urlPatterns = "/users/*")
public class UserController extends HttpServlet{
    
    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
    
    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if(path.equals("/create")) {
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String fullName = req.getParameter("fullName");
            User user = new User(UUID.randomUUID().toString(), username, password, fullName);
            userDao.save(user);
            resp.sendRedirect(req.getPathInfo() + "/login.jsp");
            //save user here
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
    }
    
}
