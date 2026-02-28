<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Reservation, java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Reservations - Ocean View Resort</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f5f6fa;
            min-height: 100vh;
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: white;
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 15px rgba(0,0,0,0.2);
        }

        .header h1 { font-size: 1.6em; }

        .header-right {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .back-btn, .logout-btn {
            padding: 9px 22px;
            border: 2px solid white;
            color: white;
            border-radius: 25px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            background: rgba(255,255,255,0.15);
        }

        .back-btn:hover, .logout-btn:hover {
            background: white;
            color: #2a5298;
        }

        /* Container */
        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 35px 25px;
        }

        .page-title {
            font-size: 1.8em;
            color: #2a5298;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Summary Cards */
        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 35px;
        }

        .summary-card {
            background: white;
            padding: 22px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .summary-card h3 {
            color: #888;
            font-size: 0.85em;
            text-transform: uppercase;
            margin-bottom: 6px;
        }

        .summary-card .num {
            font-size: 2em;
            font-weight: 700;
            color: #2a5298;
        }

        .summary-card .icon {
            font-size: 2.5em;
            opacity: 0.25;
        }

        /* Reservation Cards */
        .reservation-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            margin-bottom: 20px;
            overflow: hidden;
            transition: all 0.3s;
            border: 2px solid transparent;
        }

        .reservation-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.12);
            border-color: #667eea;
        }

        .card-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h3 { font-size: 1.1em; }

        .res-id {
            background: rgba(255,255,255,0.25);
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
        }

        .card-body {
            padding: 22px 25px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 18px;
        }

        .detail-item label {
            display: block;
            color: #999;
            font-size: 0.82em;
            text-transform: uppercase;
            margin-bottom: 4px;
            font-weight: 600;
        }

        .detail-item span {
            color: #333;
            font-size: 1em;
            font-weight: 500;
        }

        .card-footer {
            background: #f8f9fa;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #eee;
        }

        .total-amount {
            font-size: 1.3em;
            font-weight: 700;
            color: #2a5298;
        }

        .view-bill-btn {
            padding: 9px 22px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }

        .view-bill-btn:hover {
            opacity: 0.85;
            transform: translateY(-2px);
        }

        /* Room Type Badge */
        .room-badge {
            display: inline-block;
            padding: 4px 14px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            color: white;
        }

        .standard { background: #0984e3; }
        .deluxe   { background: #6c5ce7; }
        .suite    { background: #fdcb6e; color: #333; }
        .family   { background: #00b894; }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
        }

        .empty-state .empty-icon { font-size: 5em; margin-bottom: 20px; }

        .empty-state h3 {
            color: #2a5298;
            font-size: 1.5em;
            margin-bottom: 10px;
        }

        .empty-state p { color: #888; margin-bottom: 25px; }

        .book-now-btn {
            display: inline-block;
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
        }

        .book-now-btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        /* Alert */
        .alert-success {
            background: #d4edda;
            color: #155724;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 4px solid #28a745;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header { flex-direction: column; gap: 12px; padding: 15px; }
            .container { padding: 20px 15px; }
            .card-body { grid-template-columns: 1fr 1fr; }
            .card-footer { flex-direction: column; gap: 12px; }
        }
    </style>
</head>
<body>

<%
    // Session check
    if (session.getAttribute("isGuest") == null) {
        response.sendRedirect(request.getContextPath() + "/guest/GuestLogin.jsp");
        return;
    }
    String guestName = (String) session.getAttribute("guestName");
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
    
    int totalBookings  = reservations != null ? reservations.size() : 0;
    double totalSpent  = 0;
    if (reservations != null) {
        for (Reservation r : reservations) totalSpent += r.getTotal();
    }
%>

<!-- Header -->
<header class="header">
    <h1>🏖️ Ocean View Resort</h1>
    <div class="header-right">
        <a href="<%=request.getContextPath()%>/guest/GuestHome.jsp" class="back-btn">
            ← Back to Home
        </a>
        <a href="<%=request.getContextPath()%>/GuestLogout" class="logout-btn">
            🚪 Logout
        </a>
    </div>
</header>

<!-- Container -->
<div class="container">

    <h2 class="page-title">📋 My Reservations</h2>

    <%
        String msg = request.getParameter("msg");
        if ("booked".equals(msg)) {
    %>
    <div class="alert-success">✅ <strong>Reservation confirmed successfully!</strong></div>
    <% } %>

    <!-- Summary -->
    <div class="summary-grid">
        <div class="summary-card">
            <div>
                <h3>Total Bookings</h3>
                <div class="num"><%=totalBookings%></div>
            </div>
            <div class="icon">📋</div>
        </div>
        <div class="summary-card">
            <div>
                <h3>Total Spent</h3>
                <div class="num" style="font-size:1.4em;">
                    LKR <%=String.format("%,.0f", totalSpent)%>
                </div>
            </div>
            <div class="icon">💰</div>
        </div>
        <div class="summary-card">
            <div>
                <h3>Guest Name</h3>
                <div class="num" style="font-size:1.1em;"><%=guestName%></div>
            </div>
            <div class="icon">👤</div>
        </div>
    </div>

    <!-- Reservations List -->
    <%
        if (reservations == null || reservations.isEmpty()) {
    %>
    <div class="empty-state">
        <div class="empty-icon">🏨</div>
        <h3>No Reservations Found</h3>
        <p>You haven't made any bookings yet. Start your Ocean View experience!</p>
        <a href="<%=request.getContextPath()%>/guest/BookRoom.jsp" class="book-now-btn">
            📅 Book a Room Now
        </a>
    </div>
    <%
        } else {
            for (Reservation r : reservations) {
                String badgeClass = r.getRoomType().toLowerCase().replace(" ", "");
    %>
    <div class="reservation-card">

        <div class="card-header">
            <h3>🏨 <%=r.getRoomType()%></h3>
            <span class="res-id">#RES-<%=r.getId()%></span>
        </div>

        <div class="card-body">
            <div class="detail-item">
                <label>Guest Name</label>
                <span><%=r.getGuestName()%></span>
            </div>
            <div class="detail-item">
                <label>Contact</label>
                <span><%=r.getContactNumber()%></span>
            </div>
            <div class="detail-item">
                <label>Check-in</label>
                <span>📅 <%=r.getCheckIn()%></span>
            </div>
            <div class="detail-item">
                <label>Check-out</label>
                <span>📅 <%=r.getCheckOut()%></span>
            </div>
            <div class="detail-item">
                <label>Nights</label>
                <span>🌙 <%=r.getNights()%> nights</span>
            </div>
            <div class="detail-item">
                <label>Guests</label>
                <span>👥 <%=r.getGuests()%> guests</span>
            </div>
            <div class="detail-item">
                <label>Room Type</label>
                <span class="room-badge <%=badgeClass%>"><%=r.getRoomType()%></span>
            </div>
            <div class="detail-item">
                <label>Rate/Night</label>
                <span>LKR <%=String.format("%,.0f", r.getRate())%></span>
            </div>
        </div>

        <div class="card-footer">
            <div class="total-amount">
                Total: LKR <%=String.format("%,.0f", r.getTotal())%>
            </div>
            <a href="<%=request.getContextPath()%>/GuestViewBill?id=<%=r.getId()%>"
               class="view-bill-btn">
                💳 View Bill
            </a>
        </div>

    </div>
    <%
            }
        }
    %>

</div>

<!-- Footer -->
<footer style="background:#2a5298; color:white; text-align:center; padding:18px; font-size:0.9em;">
    <p>&copy; 2026 Ocean View Resort. All rights reserved.</p>
</footer>

</body>
</html>
```
