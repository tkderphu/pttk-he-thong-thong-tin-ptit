/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package site.viosmash.controller;

import java.io.IOException;
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
import site.viosmash.model.Book;

/**
 *
 * @author FPT
 */
@WebServlet(urlPatterns = "/books/*")
public class BookController extends HttpServlet{
    private BookDao bookDao;
    
    @Override
    public void init() {
        this.bookDao = new BookDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          String path = req.getPathInfo();
          if(path.equals("/create")) {
              String name = req.getParameter("name");
              String author = req.getParameter("author");
              String description = req.getParameter("description");
              String category = req.getParameter("category");
              Book book = new Book();
              book.setAuthor(author);
              book.setName(name);
              book.setCategory(category);
              book.setDescription(description);
              book.setId(UUID.randomUUID().toString());
              bookDao.save(book);
              resp.sendRedirect(req.getContextPath() + "/books/list");
          }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String path = req.getPathInfo();
       if(path.equals("/list")) {
           System.out.println("booklist");
           req.setAttribute("books", bookDao.findAll());
           dispatcher(req, resp, "bookList.jsp");
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
