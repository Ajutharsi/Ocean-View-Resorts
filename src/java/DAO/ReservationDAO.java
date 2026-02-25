package DAO;
import DBAccess.DBConnection;
import Models.Reservation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

public class ReservationDAO {
    
    // ---------- INSERT ----------
    public boolean insertReservation(Reservation r) {
                        String sql = "INSERT INTO reservations " +
                "(guest_name, contact_number, email, id_number, address, special_requests," +
                " check_in, check_out, nights, guests, room_type, rate, total)" +
                " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getGuestName());
            ps.setString(2, r.getContactNumber());
            ps.setString(3, r.getEmail());
            ps.setString(4, r.getIdNumber());
            ps.setString(5, r.getAddress());
            ps.setString(6, r.getSpecialRequests());
            ps.setDate(7, r.getCheckIn());
            ps.setDate(8, r.getCheckOut());
            ps.setInt(9, r.getNights());
            ps.setInt(10, r.getGuests());
            ps.setString(11, r.getRoomType());
            ps.setDouble(12, r.getRate());
            ps.setDouble(13, r.getTotal());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // ---------- SELECT ALL ----------
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations ORDER BY reservation_id DESC";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Reservation r = new Reservation();
                r.setId(rs.getInt("reservation_id"));
                r.setGuestName(rs.getString("guest_name"));
                r.setContactNumber(rs.getString("contact_number"));
                r.setEmail(rs.getString("email"));
                r.setIdNumber(rs.getString("id_number"));
                r.setAddress(rs.getString("address"));
                r.setSpecialRequests(rs.getString("special_requests"));
                r.setCheckIn(rs.getDate("check_in"));
                r.setCheckOut(rs.getDate("check_out"));
                r.setRoomType(rs.getString("room_type"));
                r.setGuests(rs.getInt("guests"));
                r.setNights(rs.getInt("nights"));
                r.setRate(rs.getDouble("rate"));
                 r.setTotal(rs.getDouble("total"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // ---------- SELECT BY ID ----------
    public Reservation getReservationById(int id) {
        String sql = "SELECT * FROM reservations WHERE reservation_id = ?";
        Reservation r = null;
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                r = new Reservation();
                r.setId(rs.getInt("reservation_id"));
                r.setGuestName(rs.getString("guest_name"));
                r.setContactNumber(rs.getString("contact_number"));
                r.setEmail(rs.getString("email"));
                r.setIdNumber(rs.getString("id_number"));
                r.setAddress(rs.getString("address"));
                r.setSpecialRequests(rs.getString("special_requests"));
                r.setCheckIn(rs.getDate("check_in"));
                r.setCheckOut(rs.getDate("check_out"));
                r.setRoomType(rs.getString("room_type"));
                r.setGuests(rs.getInt("guests"));
                r.setNights(rs.getInt("nights"));
                r.setRate(rs.getDouble("rate_per_night"));
                r.setTotal(rs.getDouble("total_amount"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }
    
    // ---------- UPDATE ----------
    public boolean updateReservation(Reservation r) {
        String sql = "UPDATE reservations SET guest_name=?, contact_number=?, email=?, " +
                "id_number=?, address=?, special_requests=?, check_in=?, check_out=?, " +
                "nights=?, guests=?, room_type=?, rate_per_night=?, total_amount=? WHERE reservation_id=?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, r.getGuestName());
            ps.setString(2, r.getContactNumber());
            ps.setString(3, r.getEmail());
            ps.setString(4, r.getIdNumber());
            ps.setString(5, r.getAddress());
            ps.setString(6, r.getSpecialRequests());
            ps.setDate(7, r.getCheckIn());
            ps.setDate(8, r.getCheckOut());
            ps.setInt(9, r.getNights());
            ps.setInt(10, r.getGuests());
            ps.setString(11, r.getRoomType());
            ps.setDouble(12, r.getRate());
            ps.setDouble(13, r.getTotal());
            ps.setInt(14, r.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // ---------- DELETE ----------
    public boolean deleteReservation(int id) {
        String sql = "DELETE FROM reservations WHERE reservation_id = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}