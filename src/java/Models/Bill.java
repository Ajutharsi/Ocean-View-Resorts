/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;
import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Oyslans
 */
public class Bill {
    
    private int billId;
    private int reservationId;
    private String guestName;
    private String contactNumber;
    private String email;
    private String roomType;
    private Date checkIn;
    private Date checkOut;
    private int nights;
    private int guests;
    private double ratePerNight;
    private double roomCharges;
    private double taxAmount;
    private double serviceCharge;
    private double discount;
    private double additionalCharges;
    private String additionalChargesDescription;
    private double totalAmount;
    private String paymentStatus; // "Paid", "Pending", "Partial"
    private String paymentMethod; // "Cash", "Card", "Bank Transfer"
    private Timestamp generatedDate;
    private String generatedBy;
    private String remarks;

    // Constructors
    public Bill() {
        this.generatedDate = new Timestamp(System.currentTimeMillis());
        this.paymentStatus = "Pending";
        this.taxAmount = 0.0;
        this.serviceCharge = 0.0;
        this.discount = 0.0;
        this.additionalCharges = 0.0;
    }

    public Bill(int reservationId, String guestName, String contactNumber, String email,
                String roomType, Date checkIn, Date checkOut, int nights, int guests,
                double ratePerNight) {
        this();
        this.reservationId = reservationId;
        this.guestName = guestName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.roomType = roomType;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.nights = nights;
        this.guests = guests;
        this.ratePerNight = ratePerNight;
        calculateBill();
    }

    // Calculate bill method
    public void calculateBill() {
        // Calculate room charges
        this.roomCharges = this.nights * this.ratePerNight;

        // Calculate tax (12% VAT)
        this.taxAmount = this.roomCharges * 0.12;

        // Calculate service charge (10%)
        this.serviceCharge = this.roomCharges * 0.10;

        // Calculate total
        this.totalAmount = this.roomCharges + this.taxAmount + this.serviceCharge 
                         + this.additionalCharges - this.discount;
    }

    // Getters and Setters
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public String getGuestName() {
        return guestName;
    }

    public void setGuestName(String guestName) {
        this.guestName = guestName;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public Date getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(Date checkIn) {
        this.checkIn = checkIn;
    }

    public Date getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(Date checkOut) {
        this.checkOut = checkOut;
    }

    public int getNights() {
        return nights;
    }

    public void setNights(int nights) {
        this.nights = nights;
    }

    public int getGuests() {
        return guests;
    }

    public void setGuests(int guests) {
        this.guests = guests;
    }

    public double getRatePerNight() {
        return ratePerNight;
    }

    public void setRatePerNight(double ratePerNight) {
        this.ratePerNight = ratePerNight;
        calculateBill();
    }

    public double getRoomCharges() {
        return roomCharges;
    }

    public void setRoomCharges(double roomCharges) {
        this.roomCharges = roomCharges;
    }

    public double getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(double taxAmount) {
        this.taxAmount = taxAmount;
    }

    public double getServiceCharge() {
        return serviceCharge;
    }

    public void setServiceCharge(double serviceCharge) {
        this.serviceCharge = serviceCharge;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
        calculateBill();
    }

    public double getAdditionalCharges() {
        return additionalCharges;
    }

    public void setAdditionalCharges(double additionalCharges) {
        this.additionalCharges = additionalCharges;
        calculateBill();
    }

    public String getAdditionalChargesDescription() {
        return additionalChargesDescription;
    }

    public void setAdditionalChargesDescription(String additionalChargesDescription) {
        this.additionalChargesDescription = additionalChargesDescription;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Timestamp getGeneratedDate() {
        return generatedDate;
    }

    public void setGeneratedDate(Timestamp generatedDate) {
        this.generatedDate = generatedDate;
    }

    public String getGeneratedBy() {
        return generatedBy;
    }

    public void setGeneratedBy(String generatedBy) {
        this.generatedBy = generatedBy;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    // Utility methods
    public double getSubTotal() {
        return roomCharges + additionalCharges;
    }

    public double getTaxAndServiceCharge() {
        return taxAmount + serviceCharge;
    }

    @Override
    public String toString() {
        return "Bill{" +
                "billId=" + billId +
                ", reservationId=" + reservationId +
                ", guestName='" + guestName + '\'' +
                ", totalAmount=" + totalAmount +
                ", paymentStatus='" + paymentStatus + '\'' +
                '}';
    }
}

