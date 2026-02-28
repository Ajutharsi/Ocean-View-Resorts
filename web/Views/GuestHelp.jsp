<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Help & Support - Ocean View Resort</title>
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

        /* Hero */
        .hero {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 50px 40px;
            text-align: center;
        }
        .hero h2 { font-size: 2.2em; margin-bottom: 10px; }
        .hero p  { font-size: 1.05em; opacity: 0.9; }

        /* Container */
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 40px 25px 60px;
        }

        .section-title {
            font-size: 1.5em;
            color: #2a5298;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Quick Links */
        .quick-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 40px;
        }

        .quick-card {
            background: white;
            padding: 22px 18px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid transparent;
        }

        .quick-card:hover {
            border-color: #667eea;
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(102,126,234,0.2);
        }

        .quick-card .icon  { font-size: 2.2em; margin-bottom: 10px; }
        .quick-card h4     { color: #2a5298; font-size: 0.95em; }

        /* Steps Section */
        .steps-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            padding: 30px 35px;
            margin-bottom: 30px;
        }

        .step {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
            align-items: flex-start;
        }

        .step:last-child { margin-bottom: 0; }

        .step-num {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.1em;
            flex-shrink: 0;
        }

        .step-content h4 {
            color: #2a5298;
            margin-bottom: 5px;
            font-size: 1.05em;
        }

        .step-content p {
            color: #666;
            font-size: 0.93em;
            line-height: 1.6;
        }

        .step-divider {
            width: 2px;
            height: 20px;
            background: #e0e5ff;
            margin-left: 19px;
        }

        /* FAQ Section */
        .faq-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            margin-bottom: 30px;
            overflow: hidden;
        }

        .faq-item {
            border-bottom: 1px solid #f0f0f0;
        }

        .faq-item:last-child { border-bottom: none; }

        .faq-question {
            padding: 18px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            transition: background 0.2s;
        }

        .faq-question:hover { background: #f8f9ff; }

        .faq-question h4 {
            color: #333;
            font-size: 0.98em;
            font-weight: 600;
        }

        .faq-arrow {
            font-size: 1.2em;
            transition: transform 0.3s;
            color: #667eea;
        }

        .faq-answer {
            display: none;
            padding: 0 25px 18px 25px;
            color: #666;
            font-size: 0.93em;
            line-height: 1.7;
            border-top: 1px dashed #eee;
        }

        .faq-answer.open { display: block; }
        .faq-arrow.open  { transform: rotate(180deg); }

        /* Contact Section */
        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .contact-card {
            background: white;
            padding: 25px 20px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            text-align: center;
            transition: all 0.3s;
        }

        .contact-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.12);
        }

        .contact-card .c-icon { font-size: 2.5em; margin-bottom: 12px; }
        .contact-card h4      { color: #2a5298; margin-bottom: 6px; }
        .contact-card p       { color: #666; font-size: 0.9em; }
        .contact-card a       { color: #667eea; text-decoration: none; font-weight: 600; }

        /* Info Box */
        .info-box {
            background: linear-gradient(135deg, #f0f2ff, #e8ecff);
            border: 2px solid #d0d8ff;
            border-radius: 12px;
            padding: 20px 25px;
            margin-bottom: 30px;
            display: flex;
            gap: 15px;
            align-items: flex-start;
        }

        .info-box .info-icon { font-size: 2em; flex-shrink: 0; }

        .info-box h4 { color: #2a5298; margin-bottom: 5px; }
        .info-box p  { color: #555; font-size: 0.92em; line-height: 1.6; }

        /* Policy Table */
        .policy-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07);
            margin-bottom: 30px;
        }

        .policy-table th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 14px 20px;
            text-align: left;
            font-size: 0.92em;
        }

        .policy-table td {
            padding: 13px 20px;
            border-bottom: 1px solid #f0f0f0;
            color: #555;
            font-size: 0.92em;
        }

        .policy-table tr:last-child td { border-bottom: none; }
        .policy-table tr:hover td { background: #f8f9ff; }

        /* Footer */
        footer {
            background: #2a5298;
            color: white;
            text-align: center;
            padding: 18px;
            font-size: 0.9em;
        }

        /* Responsive */
        @media (max-width: 650px) {
            .header     { flex-direction: column; gap: 10px; padding: 15px; }
            .hero       { padding: 35px 20px; }
            .hero h2    { font-size: 1.6em; }
            .container  { padding: 25px 15px 40px; }
            .steps-card { padding: 20px; }
        }
    </style>
</head>
<body>

<%
    if (session.getAttribute("isGuest") == null) {
        response.sendRedirect(request.getContextPath() + "/guest/GuestLogin.jsp");
        return;
    }
    String guestName = (String) session.getAttribute("guestName");
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

<!-- Hero -->
<div class="hero">
    <h2>❓ Help & Support</h2>
    <p>Everything you need to know about using the Ocean View Resort Guest Portal</p>
</div>

<div class="container">

    <!-- Quick Links -->
    <h2 class="section-title">⚡ Quick Links</h2>
    <div class="quick-grid">
        <div class="quick-card" onclick="scrollTo('howToBook')">
            <div class="icon">📅</div>
            <h4>How to Book</h4>
        </div>
        <div class="quick-card" onclick="scrollTo('viewRes')">
            <div class="icon">📋</div>
            <h4>View Reservations</h4>
        </div>
        <div class="quick-card" onclick="scrollTo('billing')">
            <div class="icon">💳</div>
            <h4>Billing Info</h4>
        </div>
        <div class="quick-card" onclick="scrollTo('policies')">
            <div class="icon">📜</div>
            <h4>Policies</h4>
        </div>
        <div class="quick-card" onclick="scrollTo('faq')">
            <div class="icon">💬</div>
            <h4>FAQs</h4>
        </div>
        <div class="quick-card" onclick="scrollTo('contact')">
            <div class="icon">📞</div>
            <h4>Contact Us</h4>
        </div>
    </div>

    <!-- How to Book -->
    <div id="howToBook"></div>
    <h2 class="section-title">📅 How to Make a Reservation</h2>
    <div class="steps-card">
        <div class="step">
            <div class="step-num">1</div>
            <div class="step-content">
                <h4>Login to Guest Portal</h4>
                <p>Use your registered email and password to login. 
                   New guest? Click "Create Account" to register first.</p>
            </div>
        </div>
        <div class="step-divider"></div>
        <div class="step">
            <div class="step-num">2</div>
            <div class="step-content">
                <h4>Click "Book a Room"</h4>
                <p>From the home page, click the "Book a Room" button 
                   or select from Quick Actions.</p>
            </div>
        </div>
        <div class="step-divider"></div>
        <div class="step">
            <div class="step-num">3</div>
            <div class="step-content">
                <h4>Select Room Type</h4>
                <p>Choose from Standard (LKR 8,500), Deluxe (LKR 12,000), 
                   Suite (LKR 22,000), or Family Room (LKR 18,000) per night.</p>
            </div>
        </div>
        <div class="step-divider"></div>
        <div class="step">
            <div class="step-num">4</div>
            <div class="step-content">
                <h4>Enter Your Details</h4>
                <p>Fill in your name, contact number, email, NIC/Passport, 
                   check-in and check-out dates, number of guests.</p>
            </div>
        </div>
        <div class="step-divider"></div>
        <div class="step">
            <div class="step-num">5</div>
            <div class="step-content">
                <h4>Confirm Booking</h4>
                <p>Review the estimated cost shown and click 
                   "Confirm Booking". You will be redirected to 
                   your reservations page.</p>
            </div>
        </div>
    </div>

    <!-- View Reservations -->
    <div id="viewRes"></div>
    <h2 class="section-title">📋 How to View Your Reservations</h2>
    <div class="steps-card">
        <div class="step">
            <div class="step-num">1</div>
            <div class="step-content">
                <h4>Go to "My Reservations"</h4>
                <p>Click "My Reservations" from the home page Quick Actions.</p>
            </div>
        </div>
        <div class="step-divider"></div>
        <div class="step">
            <div class="step-num">2</div>
            <div class="step-content">
                <h4>View Your Bookings</h4>
                <p>All your reservations will be listed with check-in, 
                   check-out dates, room type and total amount.</p>
            </div>
        </div>
        <div class="step-divider"></div>
        <div class="step">
            <div class="step-num">3</div>
            <div class="step-content">
                <h4>View Bill</h4>
                <p>Click "View Bill" on any reservation to see 
                   the full invoice breakdown.</p>
            </div>
        </div>
    </div>

    <!-- Billing Info -->
    <div id="billing"></div>
    <h2 class="section-title">💳 Billing Information</h2>
    <div class="info-box">
        <div class="info-icon">💡</div>
        <div>
            <h4>How is my bill calculated?</h4>
            <p>Your bill includes Room Charges (rate × nights) + 
               12% VAT Tax + 10% Service Charge. 
               Discounts or additional charges may be applied by staff. 
               Until the official bill is generated by our staff, 
               you will see an estimated breakdown.</p>
        </div>
    </div>

    <table class="policy-table">
        <tr>
            <th>Charge Type</th>
            <th>Rate</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>Standard Room</td>
            <td>LKR 8,500 / night</td>
            <td>Garden view, AC, WiFi</td>
        </tr>
        <tr>
            <td>Deluxe Room</td>
            <td>LKR 12,000 / night</td>
            <td>Ocean view, King bed</td>
        </tr>
        <tr>
            <td>Suite</td>
            <td>LKR 22,000 / night</td>
            <td>Balcony, Jacuzzi, Sea view</td>
        </tr>
        <tr>
            <td>Family Room</td>
            <td>LKR 18,000 / night</td>
            <td>2 beds, Kids area</td>
        </tr>
        <tr>
            <td>VAT Tax</td>
            <td>12%</td>
            <td>Applied on room charges</td>
        </tr>
        <tr>
            <td>Service Charge</td>
            <td>10%</td>
            <td>Applied on room charges</td>
        </tr>
    </table>

    <!-- Policies -->
    <div id="policies"></div>
    <h2 class="section-title">📜 Resort Policies</h2>
    <table class="policy-table">
        <tr>
            <th>Policy</th>
            <th>Details</th>
        </tr>
        <tr>
            <td>⏰ Check-in Time</td>
            <td>From 2:00 PM onwards</td>
        </tr>
        <tr>
            <td>⏰ Check-out Time</td>
            <td>Before 12:00 PM (Noon)</td>
        </tr>
        <tr>
            <td>❌ Cancellation</td>
            <td>Contact resort 48 hours before check-in</td>
        </tr>
        <tr>
            <td>🍽️ Breakfast</td>
            <td>Available 7:00 AM – 10:30 AM (Extra charge)</td>
        </tr>
        <tr>
            <td>🏊 Pool Access</td>
            <td>Open 6:00 AM – 9:00 PM for all guests</td>
        </tr>
        <tr>
            <td>🚗 Parking</td>
            <td>Free parking available for all guests</td>
        </tr>
        <tr>
            <td>🐾 Pets</td>
            <td>Not allowed inside the resort</td>
        </tr>
        <tr>
            <td>🚭 Smoking</td>
            <td>Only in designated outdoor areas</td>
        </tr>
    </table>

    <!-- FAQ -->
    <div id="faq"></div>
    <h2 class="section-title">💬 Frequently Asked Questions</h2>
    <div class="faq-card">

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                <h4>How do I make a reservation?</h4>
                <span class="faq-arrow">▼</span>
            </div>
            <div class="faq-answer">
                Go to Home → Book a Room → Select room type → 
                Fill your details → Click Confirm Booking. 
                Your reservation will be saved immediately.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                <h4>Can I view my reservation after booking?</h4>
                <span class="faq-arrow">▼</span>
            </div>
            <div class="faq-answer">
                Yes! Go to Home → My Reservations to see all your 
                bookings with full details including room type, 
                dates and total amount.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                <h4>When will my bill be generated?</h4>
                <span class="faq-arrow">▼</span>
            </div>
            <div class="faq-answer">
                Your official bill will be generated by our staff 
                before or at check-out. Until then, you can view 
                an estimated breakdown in My Reservations → View Bill.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                <h4>What payment methods are accepted?</h4>
                <span class="faq-arrow">▼</span>
            </div>
            <div class="faq-answer">
                We accept Cash, Credit/Debit Cards, and Bank Transfer. 
                Payment is processed at the resort front desk during check-out.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                <h4>Can I cancel my reservation?</h4>
                <span class="faq-arrow">▼</span>
            </div>
            <div class="faq-answer">
                To cancel, please contact our resort directly via phone 
                or email at least 48 hours before your check-in date 
                to avoid cancellation charges.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                <h4>I forgot my password. What should I do?</h4>
                <span class="faq-arrow">▼</span>
            </div>
            <div class="faq-answer">
                Please contact our front desk staff with your registered 
                email address. They will assist you in resetting your 
                guest portal password.
            </div>
        </div>

        <div class="faq-item">
            <div class="faq-question" onclick="toggleFaq(this)">
                <h4>Is WiFi available in all rooms?</h4>
                <span class="faq-arrow">▼</span>
            </div>
            <div class="faq-answer">
                Yes! Complimentary high-speed WiFi is available in all 
                rooms and common areas throughout the resort.
            </div>
        </div>

    </div>

    <!-- Contact -->
    <div id="contact"></div>
    <h2 class="section-title">📞 Contact Us</h2>
    <div class="contact-grid">
        <div class="contact-card">
            <div class="c-icon">📞</div>
            <h4>Phone</h4>
            <p><a href="tel:+94912345678">+94 91 234 5678</a></p>
            <p style="color:#aaa; font-size:0.85em; margin-top:5px;">
                24/7 Front Desk
            </p>
        </div>
        <div class="contact-card">
            <div class="c-icon">📧</div>
            <h4>Email</h4>
            <p><a href="mailto:info@oceanviewresort.lk">
                info@oceanviewresort.lk
            </a></p>
            <p style="color:#aaa; font-size:0.85em; margin-top:5px;">
                Reply within 24 hours
            </p>
        </div>
        <div class="contact-card">
            <div class="c-icon">📍</div>
            <h4>Location</h4>
            <p style="color:#555;">Beach Road, Galle</p>
            <p style="color:#555;">Sri Lanka</p>
        </div>
        <div class="contact-card">
            <div class="c-icon">🕐</div>
            <h4>Front Desk Hours</h4>
            <p style="color:#555;">Open 24 Hours</p>
            <p style="color:#555;">7 Days a Week</p>
        </div>
    </div>

</div>

<footer>
    <p>&copy; 2026 Ocean View Resort. All rights reserved.</p>
</footer>

<script>
    // FAQ Toggle
    function toggleFaq(el) {
        const answer = el.nextElementSibling;
        const arrow  = el.querySelector('.faq-arrow');
        answer.classList.toggle('open');
        arrow.classList.toggle('open');
    }

    // Smooth Scroll
    function scrollTo(id) {
        document.getElementById(id).scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    }
</script>

</body>
</html>
```

