package Controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import Service.ReservationService;
import Models.Reservation;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(urlPatterns = {"/ReservationReportServlet"})
public class ReservationReportServlet extends HttpServlet {

      private ReservationService service = new ReservationService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Optionally: filter parameters
        String roomType = request.getParameter("roomType");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        // Get reservation list
        List<Reservation> reservations = service.getReservationsFiltered(roomType, fromDate, toDate);

        // Set as request attribute
        request.setAttribute("reservations", reservations);

        // Forward to JSP
        request.getRequestDispatcher("/Views/ReservationReport.jsp").forward(request, response);
    }
}
