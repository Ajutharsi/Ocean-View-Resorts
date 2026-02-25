/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import DAO.UserDAO;



/**
 *
 * @author Oyslans
 */
public class AuthService {
      private UserDAO dao = new UserDAO();

    public boolean login(String username, String password) {
        return dao.validateUser(username, password);
    }
}
