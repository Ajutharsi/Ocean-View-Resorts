package Controller;

import DAO.ReservationDAO;
import Models.Reservation;
import java.io.*;
import java.util.List;
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



@WebServlet("/GuestViewReservations")
public class GuestViewReservationServlet extends HttpServlet {

    private ReservationDAO dao = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isGuest") == null) {
            response.sendRedirect(request.getContextPath() + "/guest/GuestLogin.jsp");
            return;
        }

        String guestContact = (String) session.getAttribute("guestContact");
        String guestName    = (String) session.getAttribute("guestName");

        List<Reservation> reservations = dao.getReservationsByContact(guestContact);

        request.setAttribute("reservations", reservations);
        request.setAttribute("guestName", guestName);
        request.getRequestDispatcher("/guest/GuestViewReservations.jsp")
               .forward(request, response);
    }
}