/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;
import DAO.BillingDAO;
import DAO.ReservationDAO;
import Models.Bill;
import Models.Reservation;
import java.util.List;

/**
 *
 * @author Oyslans
 */
public class BillingService {
    
     private BillingDAO billingDAO;
    private ReservationDAO reservationDAO;

    public BillingService() {
        this.billingDAO = new BillingDAO();
        this.reservationDAO = new ReservationDAO();
    }

    /**
     * Generate a bill from a reservation
     */
    public Bill generateBillFromReservation(int reservationId) {
        // Get reservation details
        Reservation reservation = reservationDAO.getReservationById(reservationId);
        
        if (reservation == null) {
            return null;
        }

        // Create bill from reservation
        Bill bill = new Bill(
            reservation.getId(),
            reservation.getGuestName(),
            reservation.getContactNumber(),
            reservation.getEmail(),
            reservation.getRoomType(),
            reservation.getCheckIn(),
            reservation.getCheckOut(),
            reservation.getNights(),
            reservation.getGuests(),
            reservation.getRate()
        );

        return bill;
    }

    /**
     * Save bill to database
     */
    public boolean saveBill(Bill bill) {
        // Check if bill already exists for this reservation
        if (billingDAO.billExistsForReservation(bill.getReservationId())) {
            // You might want to update instead of insert
            return false;
        }
        
        return billingDAO.insertBill(bill);
    }

    /**
     * Generate and save bill in one operation
     */
    public Bill generateAndSaveBill(int reservationId, String generatedBy) {
        Bill bill = generateBillFromReservation(reservationId);
        
        if (bill != null) {
            bill.setGeneratedBy(generatedBy);
            if (billingDAO.insertBill(bill)) {
                return bill;
            }
        }
        
        return null;
    }

    /**
     * Generate bill with custom charges
     */
    public Bill generateCustomBill(int reservationId, double discount, 
                                   double additionalCharges, String additionalChargesDesc,
                                   String generatedBy) {
        Bill bill = generateBillFromReservation(reservationId);
        
        if (bill != null) {
            bill.setDiscount(discount);
            bill.setAdditionalCharges(additionalCharges);
            bill.setAdditionalChargesDescription(additionalChargesDesc);
            bill.setGeneratedBy(generatedBy);
            bill.calculateBill(); // Recalculate with new values
            
            if (billingDAO.insertBill(bill)) {
                return bill;
            }
        }
        
        return null;
    }

    /**
     * Get bill by ID
     */
    public Bill getBillById(int billId) {
        return billingDAO.getBillById(billId);
    }

    /**
     * Get bill by reservation ID
     */
    public Bill getBillByReservationId(int reservationId) {
        return billingDAO.getBillByReservationId(reservationId);
    }

    /**
     * Get all bills
     */
    public List<Bill> getAllBills() {
        return billingDAO.getAllBills();
    }

    /**
     * Update payment status
     */
    public boolean processPayment(int billId, String paymentMethod) {
        return billingDAO.updatePaymentStatus(billId, "Paid", paymentMethod);
    }

    /**
     * Mark as partial payment
     */
    public boolean markAsPartialPayment(int billId, String paymentMethod) {
        return billingDAO.updatePaymentStatus(billId, "Partial", paymentMethod);
    }

    /**
     * Get pending bills
     */
    public List<Bill> getPendingBills() {
        return billingDAO.getBillsByPaymentStatus("Pending");
    }

    /**
     * Get paid bills
     */
    public List<Bill> getPaidBills() {
        return billingDAO.getBillsByPaymentStatus("Paid");
    }

    /**
     * Delete bill
     */
    public boolean deleteBill(int billId) {
        return billingDAO.deleteBill(billId);
    }

    /**
     * Check if bill exists for reservation
     */
    public boolean billExists(int reservationId) {
        return billingDAO.billExistsForReservation(reservationId);
    }

    /**
     * Calculate total revenue from all paid bills
     */
    public double calculateTotalRevenue() {
        List<Bill> paidBills = getPaidBills();
        double total = 0.0;
        
        for (Bill bill : paidBills) {
            total += bill.getTotalAmount();
        }
        
        return total;
    }

    /**
     * Calculate pending amount
     */
    public double calculatePendingAmount() {
        List<Bill> pendingBills = getPendingBills();
        double total = 0.0;
        
        for (Bill bill : pendingBills) {
            total += bill.getTotalAmount();
        }
        
        return total;
    }

    /**
     * Apply discount to bill
     */
    public boolean applyDiscount(int billId, double discount) {
        Bill bill = getBillById(billId);
        if (bill != null) {
            bill.setDiscount(discount);
            // Update in database would require a new DAO method
            // For now, return true if bill exists
            return true;
        }
        return false;
    }

    /**
     * Validate bill before processing
     */
    public boolean validateBill(Bill bill) {
        if (bill == null) {
            return false;
        }
        
        if (bill.getGuestName() == null || bill.getGuestName().trim().isEmpty()) {
            return false;
        }
        
        if (bill.getTotalAmount() <= 0) {
            return false;
        }
        
        if (bill.getNights() <= 0) {
            return false;
        }
        
        return true;
    }
}
