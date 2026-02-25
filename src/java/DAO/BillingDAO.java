/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import DBAccess.DBConnection;
import Models.Bill;
import Models.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Oyslans
 */
public class BillingDAO {
    
      public boolean insertBill(Bill bill) {
        String sql = "INSERT INTO bills " +
                "(reservation_id, guest_name, contact_number, email, room_type, " +
                "check_in, check_out, nights, guests, rate_per_night, room_charges, " +
                "tax_amount, service_charge, discount, additional_charges, " +
                "additional_charges_desc, total_amount, payment_status, payment_method, " +
                "generated_by, remarks) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, bill.getReservationId());
            ps.setString(2, bill.getGuestName());
            ps.setString(3, bill.getContactNumber());
            ps.setString(4, bill.getEmail());
            ps.setString(5, bill.getRoomType());
            ps.setDate(6, bill.getCheckIn());
            ps.setDate(7, bill.getCheckOut());
            ps.setInt(8, bill.getNights());
            ps.setInt(9, bill.getGuests());
            ps.setDouble(10, bill.getRatePerNight());
            ps.setDouble(11, bill.getRoomCharges());
            ps.setDouble(12, bill.getTaxAmount());
            ps.setDouble(13, bill.getServiceCharge());
            ps.setDouble(14, bill.getDiscount());
            ps.setDouble(15, bill.getAdditionalCharges());
            ps.setString(16, bill.getAdditionalChargesDescription());
            ps.setDouble(17, bill.getTotalAmount());
            ps.setString(18, bill.getPaymentStatus());
            ps.setString(19, bill.getPaymentMethod());
            ps.setString(20, bill.getGeneratedBy());
            ps.setString(21, bill.getRemarks());

            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    bill.setBillId(rs.getInt(1));
                }
                return true;
            }
            return false;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get bill by bill ID
     */
    public Bill getBillById(int billId) {
        String sql = "SELECT * FROM bills WHERE bill_id = ?";
        Bill bill = null;

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, billId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                bill = extractBillFromResultSet(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bill;
    }

    /**
     * Get bill by reservation ID
     */
    public Bill getBillByReservationId(int reservationId) {
        String sql = "SELECT * FROM bills WHERE reservation_id = ? ORDER BY generated_date DESC LIMIT 1";
        Bill bill = null;

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, reservationId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                bill = extractBillFromResultSet(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bill;
    }

    /**
     * Get all bills
     */
    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills ORDER BY created_at DESC";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                bills.add(extractBillFromResultSet(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bills;
    }

    /**
     * Update bill payment status
     */
    public boolean updatePaymentStatus(int billId, String paymentStatus, String paymentMethod) {
        String sql = "UPDATE bills SET payment_status = ?, payment_method = ? WHERE bill_id = ?";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, paymentStatus);
            ps.setString(2, paymentMethod);
            ps.setInt(3, billId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete bill
     */
    public boolean deleteBill(int billId) {
        String sql = "DELETE FROM bills WHERE bill_id = ?";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, billId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Check if bill exists for reservation
     */
    public boolean billExistsForReservation(int reservationId) {
        String sql = "SELECT COUNT(*) FROM bills WHERE reservation_id = ?";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, reservationId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Get bills by payment status
     */
    public List<Bill> getBillsByPaymentStatus(String paymentStatus) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills WHERE payment_status = ? ORDER BY generated_date DESC";

        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, paymentStatus);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bills.add(extractBillFromResultSet(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bills;
    }

    /**
     * Extract Bill object from ResultSet
     */
    private Bill extractBillFromResultSet(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(rs.getInt("bill_id"));
        bill.setReservationId(rs.getInt("reservation_id"));
        bill.setGuestName(rs.getString("guest_name"));
        bill.setContactNumber(rs.getString("contact_number"));
        bill.setEmail(rs.getString("email"));
        bill.setRoomType(rs.getString("room_type"));
        bill.setCheckIn(rs.getDate("check_in"));
        bill.setCheckOut(rs.getDate("check_out"));
        bill.setNights(rs.getInt("nights"));
        bill.setGuests(rs.getInt("guests"));
        bill.setRatePerNight(rs.getDouble("rate_per_night"));
        bill.setRoomCharges(rs.getDouble("room_charges"));
        bill.setTaxAmount(rs.getDouble("tax_amount"));
        bill.setServiceCharge(rs.getDouble("service_charge"));
        bill.setDiscount(rs.getDouble("discount"));
        bill.setAdditionalCharges(rs.getDouble("additional_charges"));
        bill.setAdditionalChargesDescription(rs.getString("additional_charges_desc"));
        bill.setTotalAmount(rs.getDouble("total_amount"));
        bill.setPaymentStatus(rs.getString("payment_status"));
        bill.setPaymentMethod(rs.getString("payment_method"));
        bill.setGeneratedDate(rs.getTimestamp("created_at"));
        bill.setGeneratedBy(rs.getString("generated_by"));
        bill.setRemarks(rs.getString("remarks"));
        return bill;
    }
}
