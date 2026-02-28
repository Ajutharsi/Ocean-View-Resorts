<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Guest Home - Ocean View Resort</title>
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

        .header-left h1 { font-size: 1.6em; }
        .header-left span { font-size: 0.85em; opacity: 0.8; }

        .header-right {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-badge {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.15);
            padding: 8px 18px;
            border-radius: 25px;
        }

        .avatar {
            width: 35px;
            height: 35px;
            background: #667eea;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1em;
        }

        .logout-btn {
            padding: 9px 22px;
            background: rgba(255,255,255,0.2);
            border: 2px solid white;
            color: white;
            border-radius: 25px;
            cursor: pointer;
            font-size: 0.9em;
            font-weight: 600;
            transition: all 0.3s;
            text-decoration: none;
        }

        .logout-btn:hover {
            background: white;
            color: #2a5298;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 60px 40px;
            text-align: center;
        }

        .hero h2 { font-size: 2.5em; margin-bottom: 12px; }
        .hero p  { font-size: 1.15em; opacity: 0.9; margin-bottom: 30px; }

        .hero-btn {
            display: inline-block;
            padding: 14px 35px;
            background: white;
            color: #667eea;
            border-radius: 30px;
            font-size: 1.05em;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }

        .hero-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 30px;
        }

        .section-title {
            font-size: 1.7em;
            color: #2a5298;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Action Cards */
        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 25px;
            margin-bottom: 45px;
        }

        .action-card {
            background: white;
            padding: 30px 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.07);
            text-decoration: none;
            color: inherit;
            display: block;
            border: 2px solid transparent;
            transition: all 0.3s;
            text-align: center;
        }

        .action-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.13);
            border-color: #667eea;
        }

        .card-icon { font-size: 3em; margin-bottom: 15px; display: block; }

        .action-card h3 {
            font-size: 1.2em;
            color: #2a5298;
            margin-bottom: 8px;
        }

        .action-card p {
            color: #777;
            font-size: 0.9em;
            line-height: 1.6;
        }

        /* Room Types */
        .rooms-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 45px;
        }

        .room-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.07);
            transition: all 0.3s;
        }

        .room-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.13);
        }

        .room-img {
            height: 160px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 5em;
        }

        .standard-bg  { background: linear-gradient(135deg, #74b9ff, #0984e3); }
        .deluxe-bg    { background: linear-gradient(135deg, #a29bfe, #6c5ce7); }
        .suite-bg     { background: linear-gradient(135deg, #ffeaa7, #fdcb6e); }
        .family-bg    { background: linear-gradient(135deg, #55efc4, #00b894); }

        .room-info { padding: 20px; }

        .room-info h3 {
            font-size: 1.2em;
            color: #2a5298;
            margin-bottom: 8px;
        }

        .room-info p {
            color: #777;
            font-size: 0.88em;
            margin-bottom: 12px;
            line-height: 1.5;
        }

        .room-price {
            font-size: 1.3em;
            font-weight: 700;
            color: #667eea;
        }

        .room-price span {
            font-size: 0.7em;
            color: #aaa;
            font-weight: 400;
        }

        /* Info Section */
        .info-section {
            background: white;
            padding: 35px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.07);
            margin-bottom: 30px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .info-item {
            text-align: center;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }

        .info-item .info-icon { font-size: 2.5em; margin-bottom: 10px; }
        .info-item h4 { color: #2a5298; margin-bottom: 5px; }
        .info-item p  { color: #777; font-size: 0.9em; }

        /* Alert */
        .alert-success {
            background: #d4edda;
            color: #155724;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            border-left: 4px solid #28a745;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Footer */
        footer {
            background: #2a5298;
            color: white;
            text-align: center;
            padding: 20px;
            font-size: 0.9em;
            opacity: 0.9;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header { flex-direction: column; gap: 12px; padding: 15px 20px; }
            .hero { padding: 40px 20px; }
            .hero h2 { font-size: 1.8em; }
            .container { padding: 25px 15px; }
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
    String guestName    = (String) session.getAttribute("guestName");
    String guestEmail   = (String) session.getAttribute("guestEmail");
%>

<!-- Header -->
<header class="header">
    <div class="header-left">
        <h1>🏖️ Ocean View Resort</h1>
        <span>Guest Portal</span>
    </div>
    <div class="header-right">
        <div class="user-badge">
            <div class="avatar">👤</div>
            <div>
                <div style="font-weight:600;"><%=guestName%></div>
                <div style="font-size:0.8em; opacity:0.8;"><%=guestEmail%></div>
            </div>
        </div>
        <a href="<%=request.getContextPath()%>/GuestLogout" class="logout-btn">
            🚪 Logout
        </a>
    </div>
</header>

<!-- Hero -->
<div class="hero">
    <h2>Welcome, <%=guestName%>! 🌊</h2>
    <p>Experience luxury beachside living at Ocean View Resort, Galle</p>
    <a href="<%=request.getContextPath()%>/Views/AddReservation.jsp" class="hero-btn">
        📅 Book a Room Now
    </a>
</div>

<!-- Main Container -->
<div class="container">

    <%
        String msg = request.getParameter("msg");
        if ("booked".equals(msg)) {
    %>
    <div class="alert-success">
        ✅ <strong>Reservation confirmed!</strong> Check your bookings below.
    </div>
    <% } %>

    <!-- Quick Actions -->
    <h2 class="section-title">⚡ Quick Actions</h2>
    <div class="action-grid">

        <a href="<%=request.getContextPath()%>/Views/BookRoom.jsp" class="action-card">
            <span class="card-icon">📅</span>
            <h3>Book a Room</h3>
            <p>Select your room type, dates, and confirm your reservation instantly.</p>
        </a>

        <a href="<%=request.getContextPath()%>/Views/GuestViewReservations.jsp" class="action-card">
            <span class="card-icon">📋</span>
            <h3>My Reservations</h3>
            <p>View all your bookings, check-in details and reservation status.</p>
        </a>

        <a href="<%=request.getContextPath()%>/Views/GuestViewBill.jsp" class="action-card">
            <span class="card-icon">💳</span>
            <h3>My Bills</h3>
            <p>View and download your invoices and payment details.</p>
        </a>

        <a href="<%=request.getContextPath()%>/Views/GuestHelp.jsp" class="action-card">
            <span class="card-icon">❓</span>
            <h3>Help & Support</h3>
            <p>Need assistance? Check our FAQs or contact resort staff.</p>
        </a>

    </div>

    <!-- Room Types -->
    <h2 class="section-title">🛏️ Our Rooms</h2>
    <div class="rooms-grid">

        <div class="room-card">
            <div class="room-img standard-bg">🛏️</div>
            <div class="room-info">
                <h3>Standard Room</h3>
                <p>Comfortable room with garden view, AC, WiFi and all essentials.</p>
                <div class="room-price">LKR 8,500 <span>/ night</span></div>
            </div>
        </div>

        <div class="room-card">
            <div class="room-img deluxe-bg">🏨</div>
            <div class="room-info">
                <h3>Deluxe Room</h3>
                <p>Spacious room with ocean view, premium amenities and king bed.</p>
                <div class="room-price">LKR 12,000 <span>/ night</span></div>
            </div>
        </div>

        <div class="room-card">
            <div class="room-img suite-bg">👑</div>
            <div class="room-info">
                <h3>Suite</h3>
                <p>Luxury suite with private balcony, jacuzzi and panoramic sea view.</p>
                <div class="room-price">LKR 22,000 <span>/ night</span></div>
            </div>
        </div>

        <div class="room-card">
            <div class="room-img family-bg">👨‍👩‍👧‍👦</div>
            <div class="room-info">
                <h3>Family Room</h3>
                <p>Extra large room with 2 beds, kids area and beach access.</p>
                <div class="room-price">LKR 18,000 <span>/ night</span></div>
            </div>
        </div>

    </div>

    <!-- Resort Info -->
    <div class="info-section">
        <h2 class="section-title">ℹ️ Resort Information</h2>
        <div class="info-grid">
            <div class="info-item">
                <div class="info-icon">🕐</div>
                <h4>Check-in Time</h4>
                <p>From 2:00 PM onwards</p>
            </div>
            <div class="info-item">
                <div class="info-icon">🕑</div>
                <h4>Check-out Time</h4>
                <p>Before 12:00 PM</p>
            </div>
            <div class="info-item">
                <div class="info-icon">📍</div>
                <h4>Location</h4>
                <p>Beach Road, Galle, Sri Lanka</p>
            </div>
            <div class="info-item">
                <div class="info-icon">📞</div>
                <h4>Contact</h4>
                <p>+94 91 234 5678</p>
            </div>
            <div class="info-item">
                <div class="info-icon">🍽️</div>
                <h4>Restaurant</h4>
                <p>Open 7 AM - 11 PM</p>
            </div>
            <div class="info-item">
                <div class="info-icon">🏊</div>
                <h4>Pool</h4>
                <p>Open 6 AM - 9 PM</p>
            </div>
        </div>
    </div>

</div>

<!-- Footer -->
<footer>
    <p>&copy; 2026 Ocean View Resort. All rights reserved.</p>
</footer>

</body>
</html>
```

