<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Bill, Models.Reservation"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Bill - Ocean View Resort</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f5f6fa;
            min-height: 100vh;
        }

        .header {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: white;
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 15px rgba(0,0,0,0.2);
        }

        .header h1 { font-size: 1.6em; }

        .header-right { display: flex; gap: 12px; }

        .btn-outline {
            padding: 9px 22px;
            border: 2px solid white;
            color: white;
            border-radius: 25px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: 600;
            text-decoration: none;
            background: rgba(255,255,255,0.15);
            transition: all 0.3s;
        }

        .btn-outline:hover { background: white; color: #2a5298; }

        .container {
            max-width: 800px;
            margin: 35px auto;
            padding: 0 20px;
        }

        /* Bill Card */
        .bill-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        /* Bill Header */
        .bill-header {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: white;
            padding: 35px 40px;
            text-align: center;
        }

        .bill-header .resort-name {
            font-size: 1.8em;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .bill-header .resort-address {
            font-size: 0.9em;
            opacity: 0.8;
            margin-bottom: 20px;
        }

        .bill-number {
            display: inline-block;
            background: rgba(255,255,255,0.2);
            padding: 8px 25px;
            border-radius: 25px;
            font-size: 1.1em;
            font-weight: 600;
        }

        /* Status Badge */
        .status-section {
            padding: 15px 40px;
            background: #f8f9fa;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 20px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 700;
        }

        .paid     { background: #d4edda; color: #155724; }
        .pending  { background: #fff3cd; color: #856404; }
        .unpaid   { background: #ffe0e0; color: #c0392b; }
        .estimate { background: #cce5ff; color: #004085; }

        /* Guest Info */
        .section {
            padding: 25px 40px;
            border-bottom: 1px solid #f0f0f0;
        }

        .section-title {
            font-size: 0.85em;
            color: #999;
            text-transform: uppercase;
            font-weight: 700;
            margin-bottom: 15px;
            letter-spacing: 1px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .info-item label {
            display: block;
            color: #aaa;
            font-size: 0.82em;
            margin-bottom: 3px;
        }

        .info-item span {
            color: #333;
            font-weight: 500;
            font-size: 0.98em;
        }

        /* Charges Table */
        .charges-table {
            width: 100%;
            border-collapse: collapse;
        }

        .charges-table tr td {
            padding: 12px 0;
            border-bottom: 1px dashed #f0f0f0;
        }

        .charges-table tr:last-child td { border-bottom: none; }

        .charges-table .label { color: #555; }

        .charges-table .amount {
            text-align: right;
            font-weight: 500;
            color: #333;
        }

        .charges-table .discount-row .label  { color: #28a745; }
        .charges-table .discount-row .amount { color: #28a745; }

        /* Total Row */
        .total-section {
            padding: 20px 40px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
        }

        .total-section .total-label { font-size: 1.2em; font-weight: 600; }

        .total-section .total-amount { font-size: 2em; font-weight: 700; }

        /* Payment Info */
        .payment-section {
            padding: 20px 40px;
            background: #f8f9fa;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .payment-method {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #555;
        }

        /* Print Button */
        .actions {
            padding: 25px 40px;
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .print-btn {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 600;
            transition: all 0.3s;
        }

        .print-btn:hover { opacity: 0.9; transform: translateY(-2px); }

        .back-btn-bottom {
            padding: 12px 30px;
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }

        .back-btn-bottom:hover {
            background: #667eea;
            color: white;
        }

        /* No Bill State */
        .estimate-banner {
            background: #cce5ff;
            color: #004085;
            padding: 12px 40px;
            text-align: center;
            font-size: 0.95em;
            font-weight: 500;
        }

        /* Print styles */
        @media print {
            .header, .actions, .btn-outline { display: none !important; }
            body { background: white; }
            .container { margin: 0; max-width: 100%; }
            .bill-card { box-shadow: none; }
        }

        @media (max-width: 600px) {
            .header { flex-direction: column; gap: 12px; padding: 15px; }
            .section { padding: 20px; }
            .bill-header { padding: 25px 20px; }
            .info-grid { grid-template-columns: 1fr; }
            .total-section { padding: 15px 20px; }
            .actions { flex-direction: column; padding: 20px; }
        }
    </style>
</head>
<body>

<%
    if (session.getAttribute("isGuest") == null) {
        response.sendRedirect(request.getContextPath() + "/guest/GuestLogin.jsp");
        return;
    }

    Bill bill             = (Bill) request.getAttribute("bill");
    Reservation res       = (Reservation) request.getAttribute("reservation");
    boolean hasBill       = (bill != null);
    boolean hasReservation = (res != null);

    // Use bill data if available, else use reservation data
    String  guestName     = hasBill ? bill.getGuestName()     : (hasReservation ? res.getGuestName()     : "N/A");
    String  contact       = hasBill ? bill.getContactNumber() : (hasReservation ? res.getContactNumber() : "N/A");
    String  email         = hasBill ? bill.getEmail()         : (hasReservation ? res.getEmail()         : "N/A");
    String  roomType      = hasBill ? bill.getRoomType()      : (hasReservation ? res.getRoomType()      : "N/A");
    String  checkIn       = hasBill ? String.valueOf(bill.getCheckIn())  : (hasReservation ? String.valueOf(res.getCheckIn())  : "N/A");
    String  checkOut      = hasBill ? String.valueOf(bill.getCheckOut()) : (hasReservation ? String.valueOf(res.getCheckOut()) : "N/A");
    int     nights        = hasBill ? bill.getNights()  : (hasReservation ? res.getNights()  : 0);
    int     guests        = hasBill ? bill.getGuests()  : (hasReservation ? res.getGuests()  : 0);
    double  rate          = hasBill ? bill.getRatePerNight()   : (hasReservation ? res.getRate()  : 0);
    double  roomCharges   = hasBill ? bill.getRoomCharges()    : rate * nights;
    double  tax           = hasBill ? bill.getTaxAmount()      : roomCharges * 0.10;
    double  service       = hasBill ? bill.getServiceCharge()  : roomCharges * 0.05;
    double  discount      = hasBill ? bill.getDiscount()       : 0;
    double  additional    = hasBill ? bill.getAdditionalCharges() : 0;
    double  totalAmount   = hasBill ? bill.getTotalAmount()    : (roomCharges + tax + service);
    String  payStatus     = hasBill ? bill.getPaymentStatus()  : "Pending";
    String  payMethod     = hasBill ? bill.getPaymentMethod()  : "N/A";
    int     resId         = hasBill ? bill.getReservationId()  : (hasReservation ? res.getId() : 0);
    int     billId        = hasBill ? bill.getBillId() : 0;
%>

<!-- Header -->
<header class="header">
    <h1>🏖️ Ocean View Resort</h1>
    <div class="header-right">
        <a href="<%=request.getContextPath()%>/GuestViewReservations" class="btn-outline">
            ← My Reservations
        </a>
        <a href="<%=request.getContextPath()%>/GuestLogout" class="btn-outline">
            🚪 Logout
        </a>
    </div>
</header>

<div class="container">
    <div class="bill-card">

        <!-- Bill Header -->
        <div class="bill-header">
            <div class="resort-name">🏖️ Ocean View Resort</div>
            <div class="resort-address">Beach Road, Galle, Sri Lanka | +94 91 234 5678</div>
            <% if (hasBill) { %>
                <div class="bill-number">Invoice #BILL-<%=billId%></div>
            <% } else { %>
                <div class="bill-number">Estimate for Reservation #RES-<%=resId%></div>
            <% } %>
        </div>

        <!-- Estimate Banner if no bill yet -->
        <% if (!hasBill) { %>
        <div class="estimate-banner">
            ℹ️ Official bill not generated yet. This is an estimated breakdown.
        </div>
        <% } %>

        <!-- Status -->
        <div class="status-section">
            <div>
                <span style="color:#888; font-size:0.9em;">Reservation ID: </span>
                <strong>#RES-<%=resId%></strong>
            </div>
            <%
                String badgeClass = "pending";
                if ("Paid".equalsIgnoreCase(payStatus))          badgeClass = "paid";
                else if ("Unpaid".equalsIgnoreCase(payStatus))   badgeClass = "unpaid";
                else if (!hasBill)                               badgeClass = "estimate";
            %>
            <span class="status-badge <%=badgeClass%>">
                <% if (!hasBill) { %>📊 Estimate
                <% } else if ("Paid".equalsIgnoreCase(payStatus)) { %>✅ Paid
                <% } else { %>⏳ <%=payStatus%>
                <% } %>
            </span>
        </div>

        <!-- Guest Info -->
        <div class="section">
            <div class="section-title">👤 Guest Information</div>
            <div class="info-grid">
                <div class="info-item">
                    <label>Guest Name</label>
                    <span><%=guestName%></span>
                </div>
                <div class="info-item">
                    <label>Contact Number</label>
                    <span><%=contact%></span>
                </div>
                <div class="info-item">
                    <label>Email</label>
                    <span><%=email%></span>
                </div>
                <div class="info-item">
                    <label>Room Type</label>
                    <span><%=roomType%></span>
                </div>
            </div>
        </div>

        <!-- Stay Info -->
        <div class="section">
            <div class="section-title">📅 Stay Details</div>
            <div class="info-grid">
                <div class="info-item">
                    <label>Check-in</label>
                    <span><%=checkIn%></span>
                </div>
                <div class="info-item">
                    <label>Check-out</label>
                    <span><%=checkOut%></span>
                </div>
                <div class="info-item">
                    <label>Number of Nights</label>
                    <span>🌙 <%=nights%> nights</span>
                </div>
                <div class="info-item">
                    <label>Number of Guests</label>
                    <span>👥 <%=guests%> guests</span>
                </div>
            </div>
        </div>

        <!-- Charges Breakdown -->
        <div class="section">
            <div class="section-title">💰 Charges Breakdown</div>
            <table class="charges-table">
                <tr>
                    <td class="label">Room Rate (LKR <%=String.format("%,.0f", rate)%> × <%=nights%> nights)</td>
                    <td class="amount">LKR <%=String.format("%,.2f", roomCharges)%></td>
                </tr>
                <tr>
                    <td class="label">Tax (10%)</td>
                    <td class="amount">LKR <%=String.format("%,.2f", tax)%></td>
                </tr>
                <tr>
                    <td class="label">Service Charge (5%)</td>
                    <td class="amount">LKR <%=String.format("%,.2f", service)%></td>
                </tr>
                <% if (additional > 0) { %>
                <tr>
                    <td class="label">Additional Charges
                        <% if (hasBill && bill.getAdditionalChargesDescription() != null 
               && !bill.getAdditionalChargesDescription().isEmpty()) { %>
    (<%=bill.getAdditionalChargesDescription()%>)
<% } %>
                    </td>
                    <td class="amount">LKR <%=String.format("%,.2f", additional)%></td>
                </tr>
                <% } %>
                <% if (discount > 0) { %>
                <tr class="discount-row">
                    <td class="label">🎉 Discount</td>
                    <td class="amount">- LKR <%=String.format("%,.2f", discount)%></td>
                </tr>
                <% } %>
            </table>
        </div>

        <!-- Total -->
        <div class="total-section">
            <span class="total-label">💳 Total Amount</span>
            <span class="total-amount">LKR <%=String.format("%,.2f", totalAmount)%></span>
        </div>

        <!-- Payment Info -->
        <% if (hasBill) { %>
        <div class="payment-section">
            <div class="payment-method">
                💳 <span>Payment Method: <strong><%=payMethod%></strong></span>
            </div>
            <% if (bill.getRemarks() != null && !bill.getRemarks().isEmpty()) { %>
            <div style="color:#888; font-size:0.9em;">
                📝 <%=bill.getRemarks()%>
            </div>
            <% } %>
        </div>
        <% } %>

        <!-- Actions -->
        <div class="actions">
            <button class="print-btn" onclick="window.print()">
                🖨️ Print Invoice
            </button>
            <a href="<%=request.getContextPath()%>/GuestViewReservations"
               class="back-btn-bottom">
                ← Back to Reservations
            </a>
        </div>

    </div>
</div>

<footer style="background:#2a5298; color:white; text-align:center;
               padding:18px; font-size:0.9em; margin-top:30px;">
    <p>&copy; 2026 Ocean View Resort. All rights reserved.</p>
</footer>

</body>
</html>
```
