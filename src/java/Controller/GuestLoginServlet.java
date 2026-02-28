
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



@WebServlet("/GuestLogin")
public class GuestLoginServlet extends HttpServlet {

    private GuestService guestService = new GuestService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        Guest guest = guestService.loginGuest(email, password);

        if (guest != null) {
            // Session set
            HttpSession session = request.getSession();
            session.setAttribute("guestId",      guest.getGuestId());
            session.setAttribute("guestName",    guest.getFullName());
            session.setAttribute("guestEmail",   guest.getEmail());
            session.setAttribute("guestContact", guest.getContactNumber());
            session.setAttribute("isGuest",      true);

            response.sendRedirect(request.getContextPath() + "/Views/GuestHome.jsp");
        } else {
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("/Views/GuestLogin.jsp")
                   .forward(request, response);
        }
    }
}