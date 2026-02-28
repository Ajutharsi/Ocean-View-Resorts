package Service;
import DAO.GuestDAO;
import Models.Guest;

public class GuestService {
    private GuestDAO dao = new GuestDAO();

    public String registerGuest(Guest g) {
        if (g.getFullName().isEmpty() || g.getEmail().isEmpty() || g.getPassword().isEmpty()) {
            return "All fields are required!";
        }
        if (g.getPassword().length() < 6) {
            return "Password must be at least 6 characters!";
        }
        if (dao.emailExists(g.getEmail())) {
            return "Email already registered!";
        }
        boolean result = dao.insertGuest(g);
        return result ? "success" : "Registration failed!";
    }

    public Guest loginGuest(String email, String password) {
        if (email.isEmpty() || password.isEmpty()) return null;
        return dao.getGuestByEmailAndPassword(email, password);
    }
}