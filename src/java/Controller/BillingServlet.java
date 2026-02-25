/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import Models.Bill;
import Service.BillingService;
import java.io.IOException;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;

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

@WebServlet("/GenerateBill")
public class BillingServlet extends HttpServlet {
    
    private BillingService billingService = new BillingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "generate";
        }
        
        switch (action) {
            case "view":
                viewBill(request, response);
                break;
            case "viewByReservation":
                viewBillByReservation(request, response);
                break;
            default:
                showGeneratePage(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("generate".equals(action)) {
            generateBill(request, response);
        } else if ("payment".equals(action)) {
            processPayment(request, response);
        }
    }

    /**
     * Show the bill generation page
     */
    private void showGeneratePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/Views/Generatebill.jsp");
        rd.forward(request, response);
    }

    /**
     * Generate a new bill
     */
    private void generateBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get parameters
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            double discount = 0.0;
            double additionalCharges = 0.0;
            String additionalChargesDesc = "";
            
            // Get optional parameters
            String discountStr = request.getParameter("discount");
            if (discountStr != null && !discountStr.trim().isEmpty()) {
                discount = Double.parseDouble(discountStr);
            }
            
            String additionalChargesStr = request.getParameter("additionalCharges");
            if (additionalChargesStr != null && !additionalChargesStr.trim().isEmpty()) {
                additionalCharges = Double.parseDouble(additionalChargesStr);
            }
            
            additionalChargesDesc = request.getParameter("additionalChargesDesc");
            if (additionalChargesDesc == null) {
                additionalChargesDesc = "";
            }
            
            String generatedBy = (String) request.getSession().getAttribute("username");
            if (generatedBy == null) {
                generatedBy = "Admin";
            }
            
            // Check if bill already exists
            if (billingService.billExists(reservationId)) {
                request.setAttribute("error", "Bill already exists for this reservation!");
                RequestDispatcher rd = request.getRequestDispatcher("/Views/Generatebill.jsp");
                rd.forward(request, response);
                return;
            }
            
            // Generate bill
            Bill bill;
            if (discount > 0 || additionalCharges > 0) {
                bill = billingService.generateCustomBill(reservationId, discount, 
                        additionalCharges, additionalChargesDesc, generatedBy);
            } else {
                bill = billingService.generateAndSaveBill(reservationId, generatedBy);
            }
            
            if (bill != null) {
                // Success - redirect to view bill
                response.sendRedirect(request.getContextPath() + 
                        "/GenerateBill?action=view&billId=" + bill.getBillId());
            } else {
                request.setAttribute("error", "Failed to generate bill. Please check reservation ID.");
                RequestDispatcher rd = request.getRequestDispatcher("/Views/GenerateBill.jsp");
                rd.forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format. Please check your entries.");
            RequestDispatcher rd = request.getRequestDispatcher("/Views/GenerateBill.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/Views/GenerateBill.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * View a specific bill
     */
    private void viewBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int billId = Integer.parseInt(request.getParameter("billId"));
            Bill bill = billingService.getBillById(billId);
            
            if (bill != null) {
                request.setAttribute("bill", bill);
                RequestDispatcher rd = request.getRequestDispatcher("/Views/Viewbill.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("error", "Bill not found!");
                RequestDispatcher rd = request.getRequestDispatcher("/Views/Generatebill.jsp");
                rd.forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid bill ID.");
            RequestDispatcher rd = request.getRequestDispatcher("/Views/Generatebill.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * View bill by reservation ID
     */
    private void viewBillByReservation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            Bill bill = billingService.getBillByReservationId(reservationId);
            
            if (bill != null) {
                request.setAttribute("bill", bill);
                RequestDispatcher rd = request.getRequestDispatcher("/Views/Viewbill.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("error", "No bill found for this reservation!");
                RequestDispatcher rd = request.getRequestDispatcher("/Views/Generatebill.jsp");
                rd.forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid reservation ID.");
            RequestDispatcher rd = request.getRequestDispatcher("/Views/Generatebill.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * Process payment for a bill
     */
    private void processPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int billId = Integer.parseInt(request.getParameter("billId"));
            String paymentMethod = request.getParameter("paymentMethod");
            
            if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
                paymentMethod = "Cash";
            }
            
            boolean success = billingService.processPayment(billId, paymentMethod);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + 
                        "/GenerateBill?action=view&billId=" + billId + "&paid=true");
            } else {
                request.setAttribute("error", "Failed to process payment.");
                viewBill(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing payment.");
            RequestDispatcher rd = request.getRequestDispatcher("/Views/Generatebill.jsp");
            rd.forward(request, response);
        }
    }
}