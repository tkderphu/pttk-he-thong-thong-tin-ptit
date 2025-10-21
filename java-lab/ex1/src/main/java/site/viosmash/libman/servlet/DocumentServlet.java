package site.viosmash.libman.servlet;

import site.viosmash.libman.dao.DocumentDao;
import site.viosmash.libman.model.Document;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = "/documents/*")
public class DocumentServlet extends HttpServlet {

    private DocumentDao documentDao;

    @Override
    public void init() throws ServletException {
        this.documentDao  = new DocumentDao();
//        super.init(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
    
    

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
   
        
        String path = req.getPathInfo();
        if(path != null && path.equals("/searching")) {
            String keyword = req.getParameter("keyword");
            Document[] documents
                    = this.documentDao.getListByKeyword(keyword);
            
            req.setAttribute("documents", documents);
            
                 RequestDispatcher dispatcher
                = req.getRequestDispatcher("/reader/SearchingDocumentView.jsp");
        dispatcher.forward(req, resp);
        }
        
    }
}
