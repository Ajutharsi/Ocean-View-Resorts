package Models;

import java.sql.Date;

public class Reservation {

    private int id;

    private String guestName;
    private String contactNumber;
    private String email;
    private String idNumber;
    private String address;
    private String specialRequests;
    private Date checkIn;
    private Date checkOut;
    private int nights;
    private int guests;
    private String roomType;
    private double rate;
    private double total;

    // ✅ No-argument constructor (IMPORTANT for DAO)
    public Reservation() {
    }

    // ✅ Full constructor (used when inserting)
    public Reservation(String guestName, String contactNumber, String email, String idNumber,
                       String address, String specialRequests, Date checkIn, Date checkOut,
                       int nights, int guests, String roomType, double rate, double total) {

        this.guestName = guestName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.idNumber = idNumber;
        this.address = address;
        this.specialRequests = specialRequests;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.nights = nights;
        this.guests = guests;
        this.roomType = roomType;
        this.rate = rate;
         this.total = rate * nights;
    }

    // ---------- Getters & Setters ----------

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getIdNumber() { return idNumber; }
    public void setIdNumber(String idNumber) { this.idNumber = idNumber; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getSpecialRequests() { return specialRequests; }
    public void setSpecialRequests(String specialRequests) { this.specialRequests = specialRequests; }

    public Date getCheckIn() { return checkIn; }
    public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }

    public Date getCheckOut() { return checkOut; }
    public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }

    public int getNights() { return nights; }
    public void setNights(int nights) { this.nights = nights; }

    public int getGuests() { return guests; }
    public void setGuests(int guests) { this.guests = guests; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public double getRate() { return rate; }
    public void setRate(double rate) { this.rate = rate; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
}
