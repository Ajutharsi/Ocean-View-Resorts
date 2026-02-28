package DAO;

import DBAccess.DBConnection;
import Models.Bill;
import java.sql.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    public Bill getBillByReservationId(int reservationId) {
        String sql = "SELECT * FROM bills WHERE reservation_id = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, reservationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Bill b = new Bill();
                b.setBillId(rs.getInt("bill_id"));
                b.setReservationId(rs.getInt("reservation_id"));
                b.setGuestName(rs.getString("guest_name"));
                b.setContactNumber(rs.getString("contact_number"));
                b.setEmail(rs.getString("email"));
                b.setRoomType(rs.getString("room_type"));
                b.setCheckIn(rs.getDate("check_in"));
                b.setCheckOut(rs.getDate("check_out"));
                b.setNights(rs.getInt("nights"));
                b.setGuests(rs.getInt("guests"));
                b.setRatePerNight(rs.getDouble("rate_per_night"));
                b.setRoomCharges(rs.getDouble("room_charges"));
                b.setTaxAmount(rs.getDouble("tax_amount"));
                b.setServiceCharge(rs.getDouble("service_charge"));
                b.setDiscount(rs.getDouble("discount"));
                b.setAdditionalCharges(rs.getDouble("additional_charges"));
                
                b.setAdditionalChargesDescription(rs.getString("additional_charges_desc"));
                b.setTotalAmount(rs.getDouble("total_amount"));
                b.setPaymentStatus(rs.getString("payment_status"));
                b.setPaymentMethod(rs.getString("payment_method"));
                b.setGeneratedBy(rs.getString("generated_by"));
                b.setRemarks(rs.getString("remarks"));
               b.setGeneratedDate(rs.getTimestamp("created_at"));
                return b;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}