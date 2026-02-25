/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import Service.ReservationService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import Models.Reservation;
import java.util.List;
import jakarta.servlet.RequestDispatcher;


/**
 *
 * @author Oyslans
 */

@WebServlet("/ViewReservation")
public class ViewReservationServlet extends HttpServlet {

    private ReservationService service = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Reservation> list = service.getAllReservations();
        request.setAttribute("reservations", list);

       
        RequestDispatcher rd = request.getRequestDispatcher("/Views/ViewReservation.jsp");
        rd.forward(request, response);
    }
}




