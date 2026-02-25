/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

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



/**
 *
 * @author Oyslans
 */
@WebServlet("/AddReservation")
public class AddReservation extends HttpServlet {

    private ReservationService service = new ReservationService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String guestName = request.getParameter("guestName");
            String contact = request.getParameter("contactNumber");
            String email = request.getParameter("email");
            String idNumber = request.getParameter("idNumber");
            String address = request.getParameter("address");
            String special = request.getParameter("specialRequests");

            Date checkIn = Date.valueOf(request.getParameter("check_in"));
            Date checkOut = Date.valueOf(request.getParameter("check_out"));
            int guests = Integer.parseInt(request.getParameter("guests"));
            int nights = Integer.parseInt(request.getParameter("nights"));
            String roomType = request.getParameter("room_type");

            double rate = getRate(roomType);
            double total = rate * nights;

            Reservation r = new Reservation(
                guestName, contact, email, idNumber, address, special,
                checkIn, checkOut, nights, guests, roomType, rate, total
            );

            boolean success = service.addReservation(r);

           if (success) {
    response.sendRedirect(request.getContextPath() + "/Views/Dashboard.jsp?msg=success");
} else {
    response.sendRedirect(request.getContextPath() + "/Views/AddReservation.jsp?msg=error");
}

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AddReservation.jsp?msg=error");
        }
    }

    private double getRate(String roomType) {
        switch (roomType) {
            case "standard": return 8000;
            case "deluxe": return 12000;
            case "suite": return 20000;
            case "presidential": return 35000;
            default: return 0;
        }
    }
}

