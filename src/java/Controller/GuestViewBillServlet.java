package Controller;

import DAO.BillDAO;
import DAO.ReservationDAO;
import Models.Bill;
import Models.Reservation;
import java.io.*;
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


@WebServlet("/GuestViewBill")
public class GuestViewBillServlet extends HttpServlet {

    private BillDAO billDAO               = new BillDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("isGuest") == null) {
            response.sendRedirect(request.getContextPath() + "/guest/GuestLogin.jsp");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/GuestViewReservations");
            return;
        }

        int reservationId = Integer.parseInt(idParam);

        // First try to get bill from bills table
        Bill bill = billDAO.getBillByReservationId(reservationId);

        // If bill not generated yet, use reservation data
        Reservation reservation = reservationDAO.getReservationById(reservationId);

        request.setAttribute("bill",        bill);
        request.setAttribute("reservation", reservation);
        request.getRequestDispatcher("/guest/GuestViewBill.jsp")
               .forward(request, response);
    }
}