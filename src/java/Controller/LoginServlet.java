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
 * @author Oyslans
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
    
    
    
    
    }

   


