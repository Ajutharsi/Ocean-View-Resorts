/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;


import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import Service.AuthService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;





/**
 *
 * @author Tharsi
 */

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

   private AuthService service = new AuthService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws IOException, ServletException {

      
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        boolean ok = service.login(username, password);

        if (ok) {
         
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            res.sendRedirect("Views/Dashboard.jsp");
        } else {
           
            req.setAttribute("errorMessage", "Incorrect username or password!");
          
            req.getRequestDispatcher("Views/Login.jsp").forward(req, res);
        }
    }
    
    
   
//public abstract class LoginHandler {
//    protected LoginHandler next;
//    
//    public LoginHandler setNext(LoginHandler next) {
//        this.next = next;
//        return next;
//    }
//    
//    public abstract boolean handle(String username, String password);
//}
//
//
//public class NullCheckHandler extends LoginHandler {
//    public boolean handle(String u, String p) {
//        if (u == null || u.isEmpty() || p == null || p.isEmpty()) {
//            return false; 
//        }
//        return next != null ? next.handle(u, p) : true;
//    }
//}
//
//
//public class AuthCheckHandler extends LoginHandler {
//    private AuthService authService = new AuthService();
//    public boolean handle(String u, String p) {
//        return authService.login(u, p);
//    }
//}

// Servlet-ல use
LoginHandler chain = new NullCheckHandler();
chain.setNext(new AuthCheckHandler());

boolean ok = chain.handle(username, password);
    
    
    
    }

   


