package Controller;
import Models.Guest;
import Service.GuestService;
import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import Service.ReservationService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import java.sql.Date;
import Models.Reservation;


@WebServlet("/GuestRegister")
public class GuestRegisterServlet extends HttpServlet {

    private GuestService guestService = new GuestService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName     = request.getParameter("full_name").trim();
        String email        = request.getParameter("email").trim();
        String password     = request.getParameter("password").trim();
        String confirmPass  = request.getParameter("confirm_password").trim();
        String contact      = request.getParameter("contact_number");
        String address      = request.getParameter("address");

        // Password match check
        if (!password.equals(confirmPass)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/Views/GuestRegister.jsp")
                   .forward(request, response);
            return;
        }

        Guest g = new Guest(fullName, email, password, contact, address);
        String result = guestService.registerGuest(g);

        if ("success".equals(result)) {
            response.sendRedirect(request.getContextPath() + 
                                  "/Views/GuestLogin.jsp?msg=registered");
        } else {
            request.setAttribute("error", result);
            request.getRequestDispatcher("/Views/GuestRegister.jsp")
                   .forward(request, response);
        }
    }
}