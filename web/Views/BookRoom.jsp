<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book a Room - Ocean View Resort</title>
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
        .header-right { display: flex; gap: 12px; }

        .btn-outline {
            padding: 9px 22px;
            border: 2px solid white;
            color: white;
            border-radius: 25px;
            font-size: 0.9em;
            font-weight: 600;
            text-decoration: none;
            background: rgba(255,255,255,0.15);
            transition: all 0.3s;
        }
        .btn-outline:hover { background: white; color: #2a5298; }

        /* Container */
        .container {
            max-width: 900px;
            margin: 35px auto;
            padding: 0 20px 40px;
        }

        .page-title {
            font-size: 1.8em;
            color: #2a5298;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Room Selector */
        .room-selector {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }

        .room-option {
            background: white;
            border: 3px solid #e0e0e0;
            border-radius: 15px;
            padding: 20px 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
        }

        .room-option:hover {
            border-color: #667eea;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(102,126,234,0.2);
        }

        .room-option.selected {
            border-color: #667eea;
            background: linear-gradient(135deg, #f0f2ff, #e8ecff);
            box-shadow: 0 8px 20px rgba(102,126,234,0.25);
        }

        .room-option .r-icon  { font-size: 2.5em; margin-bottom: 10px; }
        .room-option .r-name  { font-weight: 700; color: #2a5298; margin-bottom: 5px; }
        .room-option .r-price {
            font-size: 1.1em;
            font-weight: 700;
            color: #667eea;
        }
        .room-option .r-price span {
            font-size: 0.75em;
            color: #aaa;
            font-weight: 400;
        }

        /* Form Card */
        .form-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .form-section {
            padding: 30px 35px;
            border-bottom: 1px solid #f0f0f0;
        }

        .form-section:last-child { border-bottom: none; }

        .section-label {
            font-size: 0.85em;
            color: #aaa;
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 20px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .form-group { display: flex; flex-direction: column; }
        .form-group.full { grid-column: 1 / -1; }

        label {
            font-size: 0.88em;
            color: #666;
            font-weight: 600;
            margin-bottom: 7px;
        }

        input, select, textarea {
            padding: 12px 15px;
            border: 2px solid #e8e8e8;
            border-radius: 10px;
            font-size: 0.97em;
            font-family: inherit;
            outline: none;
            transition: border 0.3s, box-shadow 0.3s;
            background: #fafafa;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102,126,234,0.1);
        }

        textarea { resize: vertical; min-height: 80px; }

        /* Bill Preview */
        .bill-preview {
            background: linear-gradient(135deg, #f8f9ff, #f0f2ff);
            border: 2px solid #e0e5ff;
            border-radius: 15px;
            padding: 22px 25px;
            margin-top: 5px;
        }

        .bill-preview h4 {
            color: #2a5298;
            margin-bottom: 15px;
            font-size: 1em;
        }

        .bill-row {
            display: flex;
            justify-content: space-between;
            padding: 7px 0;
            font-size: 0.93em;
            color: #555;
            border-bottom: 1px dashed #dde;
        }

        .bill-row:last-child { border-bottom: none; }

        .bill-row.total {
            font-size: 1.15em;
            font-weight: 700;
            color: #2a5298;
            border-top: 2px solid #c5ccf5;
            margin-top: 8px;
            padding-top: 12px;
            border-bottom: none;
        }

        /* Submit */
        .submit-section {
            padding: 25px 35px;
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }

        .submit-btn {
            padding: 13px 35px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 1.05em;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102,126,234,0.4);
        }

        .cancel-btn {
            padding: 13px 30px;
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            border-radius: 25px;
            font-size: 1.05em;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }

        .cancel-btn:hover { background: #667eea; color: white; }

        /* Error / Success */
        .alert-error {
            background: #ffe0e0;
            color: #c0392b;
            padding: 14px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            border-left: 4px solid #e74c3c;
        }

        /* Responsive */
        @media (max-width: 650px) {
            .header      { flex-direction: column; gap: 10px; padding: 15px; }
            .form-grid   { grid-template-columns: 1fr; }
            .form-section { padding: 20px; }
            .submit-section { flex-direction: column; padding: 20px; }
            .submit-btn, .cancel-btn { text-align: center; }
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
    String guestContact = (String) session.getAttribute("guestContact");
    String guestAddress = (String) session.getAttribute("guestAddress");

    // Pre-selected room from GuestHome
    String selectedRoom = (String) request.getAttribute("selectedRoom");
    if (selectedRoom == null) selectedRoom = "standard";
%>

<!-- Header -->
<header class="header">
    <h1>🏖️ Ocean View Resort</h1>
    <div class="header-right">
        <a href="<%=request.getContextPath()%>/guest/GuestHome.jsp" class="btn-outline">
            ← Home
        </a>
        <a href="<%=request.getContextPath()%>/GuestLogout" class="btn-outline">
            🚪 Logout
        </a>
    </div>
</header>

<div class="container">

    <h2 class="page-title">📅 Book a Room</h2>

    <!-- Error -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
    <div class="alert-error">❌ <%=error%></div>
    <% } %>

    <!-- Room Type Selector -->
    <h3 style="color:#555; margin-bottom:15px; font-size:1em;">
        Select Room Type:
    </h3>
    <div class="room-selector">
        <div class="room-option" id="opt-standard" onclick="selectRoom('standard', 8500)">
            <div class="r-icon">🛏️</div>
            <div class="r-name">Standard</div>
            <div class="r-price">LKR 8,500 <span>/ night</span></div>
        </div>
        <div class="room-option" id="opt-deluxe" onclick="selectRoom('deluxe', 12000)">
            <div class="r-icon">🏨</div>
            <div class="r-name">Deluxe</div>
            <div class="r-price">LKR 12,000 <span>/ night</span></div>
        </div>
        <div class="room-option" id="opt-suite" onclick="selectRoom('suite', 22000)">
            <div class="r-icon">👑</div>
            <div class="r-name">Suite</div>
            <div class="r-price">LKR 22,000 <span>/ night</span></div>
        </div>
        <div class="room-option" id="opt-family" onclick="selectRoom('family', 18000)">
            <div class="r-icon">👨‍👩‍👧‍👦</div>
            <div class="r-name">Family</div>
            <div class="r-price">LKR 18,000 <span>/ night</span></div>
        </div>
    </div>

    <!-- Booking Form -->
    <form action="<%=request.getContextPath()%>/GuestBookRoom" method="post" id="bookingForm">

        <!-- Hidden fields -->
        <input type="hidden" name="room_type" id="room_type" value="<%=selectedRoom%>"/>

        <div class="form-card">

            <!-- Guest Details -->
            <div class="form-section">
                <div class="section-label">👤 Guest Details</div>
                <div class="form-grid">
                    <div class="form-group">
                        <label>Full Name *</label>
                        <input type="text" name="guest_name"
                               value="<%=guestName != null ? guestName : ""%>"
                               required placeholder="Your full name"/>
                    </div>
                    <div class="form-group">
                        <label>Contact Number *</label>
                        <input type="text" name="contact_number"
                               value="<%=guestContact != null ? guestContact : ""%>"
                               required placeholder="07X XXXXXXX"/>
                    </div>
                    <div class="form-group">
                        <label>Email Address *</label>
                        <input type="email" name="email"
                               value="<%=guestEmail != null ? guestEmail : ""%>"
                               required placeholder="your@email.com"/>
                    </div>
                    <div class="form-group">
                        <label>NIC / Passport Number *</label>
                        <input type="text" name="id_number"
                               required placeholder="NIC or Passport"/>
                    </div>
                    <div class="form-group full">
                        <label>Address</label>
                        <input type="text" name="address"
                               value="<%=guestAddress != null ? guestAddress : ""%>"
                               placeholder="Your address"/>
                    </div>
                </div>
            </div>

            <!-- Stay Details -->
            <div class="form-section">
                <div class="section-label">📅 Stay Details</div>
                <div class="form-grid">
                    <div class="form-group">
                        <label>Check-in Date *</label>
                        <input type="date" name="check_in" id="check_in"
                               required onchange="calculateBill()"/>
                    </div>
                    <div class="form-group">
                        <label>Check-out Date *</label>
                        <input type="date" name="check_out" id="check_out"
                               required onchange="calculateBill()"/>
                    </div>
                    <div class="form-group">
                        <label>Number of Guests *</label>
                        <select name="guests" required>
                            <option value="1">1 Guest</option>
                            <option value="2" selected>2 Guests</option>
                            <option value="3">3 Guests</option>
                            <option value="4">4 Guests</option>
                            <option value="5">5 Guests</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Special Requests</label>
                        <input type="text" name="special_requests"
                               placeholder="e.g. Sea view, Early check-in"/>
                    </div>
                </div>

                <!-- Bill Preview -->
                <div class="bill-preview" id="billPreview" style="display:none; margin-top:20px;">
                    <h4>📊 Estimated Cost</h4>
                    <div class="bill-row">
                        <span id="previewRoomLabel">Room Charges</span>
                        <span id="previewRoomAmt">LKR 0</span>
                    </div>
                    <div class="bill-row">
                        <span>Tax (12%)</span>
                        <span id="previewTax">LKR 0</span>
                    </div>
                    <div class="bill-row">
                        <span>Service Charge (10%)</span>
                        <span id="previewService">LKR 0</span>
                    </div>
                    <div class="bill-row total">
                        <span>Estimated Total</span>
                        <span id="previewTotal">LKR 0</span>
                    </div>
                </div>
            </div>

            <!-- Submit -->
            <div class="submit-section">
                <a href="<%=request.getContextPath()%>/guest/GuestHome.jsp"
                   class="cancel-btn">Cancel</a>
                <button type="submit" class="submit-btn">
                    ✅ Confirm Booking
                </button>
            </div>

        </div>
    </form>
</div>

<footer style="background:#2a5298; color:white; text-align:center;
               padding:18px; font-size:0.9em;">
    <p>&copy; 2026 Ocean View Resort. All rights reserved.</p>
</footer>

<script>
    // Room rates - match with RoomFactory.java
    const rates = {
        standard : 8500,
        deluxe   : 12000,
        suite    : 22000,
        family   : 18000
    };

    let currentRate = rates['<%=selectedRoom%>'];
    let currentRoom = '<%=selectedRoom%>';

    // Init - select default room
    window.onload = function() {
        selectRoom(currentRoom, currentRate);

        // Set min date = today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('check_in').min  = today;
        document.getElementById('check_out').min = today;
    };

    function selectRoom(type, rate) {
        // Remove selected from all
        document.querySelectorAll('.room-option').forEach(el => {
            el.classList.remove('selected');
        });

        // Add selected to clicked
        document.getElementById('opt-' + type).classList.add('selected');

        // Update hidden input
        document.getElementById('room_type').value = type;

        currentRate = rate;
        currentRoom = type;

        calculateBill();
    }

    function calculateBill() {
        const checkIn  = document.getElementById('check_in').value;
        const checkOut = document.getElementById('check_out').value;

        if (!checkIn || !checkOut) return;

        const d1     = new Date(checkIn);
        const d2     = new Date(checkOut);
        const nights = Math.round((d2 - d1) / (1000 * 60 * 60 * 24));

        if (nights <= 0) {
            document.getElementById('billPreview').style.display = 'none';
            return;
        }

        const roomCharges = currentRate * nights;
        const tax         = roomCharges * 0.12;
        const service     = roomCharges * 0.10;
        const total       = roomCharges + tax + service;

        const fmt = (n) => 'LKR ' + n.toLocaleString('en-US', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        });

        document.getElementById('previewRoomLabel').textContent =
            'Room Charges (LKR ' + currentRate.toLocaleString() + ' × ' + nights + ' nights)';
        document.getElementById('previewRoomAmt').textContent = fmt(roomCharges);
        document.getElementById('previewTax').textContent     = fmt(tax);
        document.getElementById('previewService').textContent = fmt(service);
        document.getElementById('previewTotal').textContent   = fmt(total);

        document.getElementById('billPreview').style.display = 'block';
    }
</script>

</body>
</html>
```
