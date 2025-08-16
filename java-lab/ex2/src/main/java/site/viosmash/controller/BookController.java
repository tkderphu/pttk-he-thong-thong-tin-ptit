/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.controller;

import java.io.IOException;
import java.util.List;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import site.viosmash.dao.BookDao;
import site.viosmash.model.Book;

/**
 *
 * @author Phu
 */
@WebServlet(urlPatterns = "/books/*")
public class BookController extends HttpServlet {

    private BookDao bookDao;

    @Override
    public void init() throws ServletException {
        this.bookDao = new BookDao(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path.equals("/update")) {
            Book book = new Book(
                    req.getParameter("id"),
                    req.getParameter("name"),
                    req.getParameter("description"),
                    req.getParameter("category"),
                    req.getParameter("author"));

            bookDao.update(book);
            resp.sendRedirect(req.getContextPath() + "/books");

        } else if (path.equals("/create")) {
            Book book = new Book(
                    UUID.randomUUID().toString(),
                    req.getParameter("name"),
                    req.getParameter("description"),
                    req.getParameter("category"),
                    req.getParameter("author"));

            bookDao.save(book);
            resp.sendRedirect(req.getContextPath() + "/books");
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if (path == null || path.isEmpty()) {
            List<Book> books = bookDao.findAll(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
            req.setAttribute("books", books);
            dispatcher(req, resp, "book.jsp");
        } else if (path.contains("/update")) {
            String id = req.getParameter("id");

            Book book = bookDao.findById(id);
            req.setAttribute("book", book);
            dispatcher(req, resp, "updateBook.jsp");
        } else if (path.contains("/delete")) {
            String id = req.getParameter("id");
            bookDao.deleteById(id);
            resp.sendRedirect(req.getContextPath() + "/books");
        }

    }

    private void dispatcher(HttpServletRequest req, HttpServletResponse res, String jsp) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/" + jsp);
        requestDispatcher.forward(req, res);

    }

}
