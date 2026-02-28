package Controller;


import Models.Guest;
import Models.Reservation;
import Models.RoomFactory;
import Models.RoomInfo;

import Service.ReservationService;
import java.io.*;
import java.sql.Date;

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

@WebServlet("/GuestBookRoom")
public class BookRoomServlet extends HttpServlet {

    private ReservationService reservationService = new ReservationService();

    // GET - Show booking form
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isGuest") == null) {
            response.sendRedirect(request.getContextPath() + "/guest/GuestLogin.jsp");
            return;
        }

        // Pre-fill room type if coming from GuestHome
        String roomType = request.getParameter("room");
        if (roomType != null) {
            request.setAttribute("selectedRoom", roomType);
        }

        request.getRequestDispatcher("/guest/BookRoom.jsp")
               .forward(request, response);
    }

    // POST - Process booking
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isGuest") == null) {
            response.sendRedirect(request.getContextPath() + "/guest/GuestLogin.jsp");
            return;
        }

        try {
            // Get form values
            String guestName      = request.getParameter("guest_name").trim();
            String contact        = request.getParameter("contact_number").trim();
            String email          = request.getParameter("email").trim();
            String idNumber       = request.getParameter("id_number").trim();
            String address        = request.getParameter("address").trim();
            String specialReq     = request.getParameter("special_requests");
            String roomType       = request.getParameter("room_type");
            String checkInStr     = request.getParameter("check_in");
            String checkOutStr    = request.getParameter("check_out");
            int    numGuests      = Integer.parseInt(request.getParameter("guests"));

            // Validation
            if (guestName.isEmpty() || contact.isEmpty() || 
                checkInStr.isEmpty() || checkOutStr.isEmpty()) {
                request.setAttribute("error", "Please fill all required fields!");
                request.getRequestDispatcher("/guest/BookRoom.jsp")
                       .forward(request, response);
                return;
            }

            // Date conversion
            Date checkIn  = Date.valueOf(checkInStr);
            Date checkOut = Date.valueOf(checkOutStr);

            // Check out must be after check in
            if (!checkOut.after(checkIn)) {
                request.setAttribute("error", "Check-out date must be after check-in date!");
                request.getRequestDispatcher("/guest/BookRoom.jsp")
                       .forward(request, response);
                return;
            }

            // Calculate nights
            long diff   = checkOut.getTime() - checkIn.getTime();
            int  nights = (int) (diff / (1000 * 60 * 60 * 24));

            // Use Factory Pattern to get room rate
            RoomInfo roomInfo = RoomFactory.createRoom(roomType);
            double   rate     = roomInfo.getRatePerNight();
            double   total    = rate * nights;

            // Build Reservation object - existing model use pani
            Reservation reservation = new Reservation(
                guestName, contact, email, idNumber,
                address, specialReq != null ? specialReq : "",
                checkIn, checkOut, nights, numGuests,
                roomType, rate, total
            );

            // Save using existing ReservationService
            boolean success = reservationService.addReservation(reservation);

            if (success) {
//                response.sendRedirect(request.getContextPath() +
//                    "GuestViewReservations.jsp?msg=booked");
                 response.sendRedirect(request.getContextPath() + "/Views/GuestViewReservations.jsp?msg=success");
            } else {
                request.setAttribute("error", "Booking failed! Please try again.");
                request.getRequestDispatcher("/Views/BookRoom.jsp")
                       .forward(request, response);
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid room type selected!");
            request.getRequestDispatcher("/Views/BookRoom.jsp")
                   .forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong: " + e.getMessage());
            request.getRequestDispatcher("/Views/BookRoom.jsp")
                   .forward(request, response);
        }
    }
}