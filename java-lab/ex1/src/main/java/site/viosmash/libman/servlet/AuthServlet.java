package site.viosmash.libman.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import site.viosmash.libman.dao.MemberDao;
import site.viosmash.libman.model.Member;

/**
 * @author Nguyen Quang Phu
 * @since 16/10/2025
 */

@WebServlet(urlPatterns = "/login")
public class AuthServlet extends HttpServlet {

    private MemberDao memberDao =new MemberDao();;

    
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Member member = memberDao.findByUsernameAndPassword(username, password);
        if (member != null) {
            HttpSession session = request.getSession();
            session.setAttribute("fullName", member.getFullName());
            session.setAttribute("role", member.getRole());
            if(member.getRole().equals("MANAGER")) {
                response.sendRedirect("/ex1/view/manager/ManagerView.jsp");
            } else if(member.getRole().equals("READER")) {
                response.sendRedirect("/ex1/view/reader/ReaderHomeView.jsp");
            }
        } else {
            response.sendRedirect("login.jsp?error=true");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    @Override
    public void init() throws ServletException {
        //super.init(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
        this.memberDao = new MemberDao();
    }
    
    
    
}
