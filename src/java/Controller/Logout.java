/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;


/**
 *
 * @author Oyslans
 */



@WebServlet(name = "Logout", urlPatterns = {"/Logout"})
public class Logout extends HttpServlet {

    /**
     * Invalidates the current session and redirects to login page.
     * Uses a helper method for session invalidation for better readability.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        invalidateSession(request);
        redirectToLogin(request, response);
    }

    /**
     * Helper method to invalidate the session safely.
     */
    private void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false); 
        if (session != null) {
            session.invalidate();
        }
    }

    /**
     * Helper method to redirect to login page.
     */
    private void redirectToLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String loginPage = request.getContextPath() + "/Views/Login.jsp";
        response.sendRedirect(loginPage);
    }
}
