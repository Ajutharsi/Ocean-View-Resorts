package DAO;
import DBAccess.DBConnection;
import Models.Guest;
import java.sql.*;

public class GuestDAO {

    // Register
    public boolean insertGuest(Guest g) {
        String sql = "INSERT INTO guests (full_name, email, password, contact_number, address) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, g.getFullName());
            ps.setString(2, g.getEmail());
            ps.setString(3, g.getPassword());
            ps.setString(4, g.getContactNumber());
            ps.setString(5, g.getAddress());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check email exists
    public boolean emailExists(String email) {
        String sql = "SELECT guest_id FROM guests WHERE email = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Login check
    public Guest getGuestByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM guests WHERE email = ? AND password = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Guest g = new Guest();
                g.setGuestId(rs.getInt("guest_id"));
                g.setFullName(rs.getString("full_name"));
                g.setEmail(rs.getString("email"));
                g.setContactNumber(rs.getString("contact_number"));
                g.setAddress(rs.getString("address"));
                return g;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}