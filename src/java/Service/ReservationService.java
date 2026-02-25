/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;
import Models.Reservation;
import java.util.List;



import DAO.ReservationDAO;

/**
 *
 * @author Oyslans
 */
public class ReservationService {
      private ReservationDAO dao = new ReservationDAO();

    public boolean addReservation(Reservation r) {
        
        return dao.insertReservation(r);
    }
    
    
    public List<Reservation> getAllReservations() {
        return dao.getAllReservations();
    }

}
