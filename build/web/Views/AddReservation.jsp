<%-- 
    Document   : AddReservation
    Created on : 14 Jan 2026, 12:06:43
    Author     : Oyslans
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Reservation - Ocean View Resort</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f6fa;
            min-height: 100vh;
        }

        /* Header */
        .header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 20px 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 1.5em;
        }

        .back-btn {
            padding: 10px 25px;
            background: rgba(255,255,255,0.2);
            border: 2px solid white;
            color: white;
            border-radius: 25px;
            cursor: pointer;
            font-size: 0.95em;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .back-btn:hover {
            background: white;
            color: #2a5298;
        }

        /* Container */
        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* Form Card */
        .form-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            padding: 40px;
            margin-bottom: 30px;
        }

        .form-title {
            color: #2a5298;
            font-size: 2em;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-subtitle {
            color: #6c757d;
            margin-bottom: 30px;
            font-size: 1.05em;
        }

        /* Progress Steps */
        .progress-steps {
            display: flex;
            justify-content: space-between;
            margin-bottom: 40px;
            position: relative;
        }

        .progress-steps::before {
            content: '';
            position: absolute;
            top: 20px;
            left: 0;
            right: 0;
            height: 3px;
            background: #dee2e6;
            z-index: 0;
        }

        .progress-line {
            position: absolute;
            top: 20px;
            left: 0;
            height: 3px;
            background: #667eea;
            z-index: 1;
            transition: width 0.3s ease;
        }

        .step {
            background: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            border: 3px solid #dee2e6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            color: #6c757d;
            position: relative;
            z-index: 2;
        }

        .step.active {
            border-color: #667eea;
            background: #667eea;
            color: white;
        }

        .step.completed {
            border-color: #28a745;
            background: #28a745;
            color: white;
        }

        /* Form Sections */
        .form-section {
            display: none;
            animation: fadeIn 0.5s ease;
        }

        .form-section.active {
            display: block;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .section-title {
            color: #2a5298;
            font-size: 1.5em;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }

        /* Form Groups */
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #495057;
            font-weight: 500;
            font-size: 0.95em;
        }

        .required {
            color: #dc3545;
            margin-left: 3px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #dee2e6;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
            outline: none;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-control.error {
            border-color: #dc3545;
        }

        .error-message {
            color: #dc3545;
            font-size: 0.85em;
            margin-top: 5px;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        /* Select Styling */
        select.form-control {
            cursor: pointer;
            background: white;
        }

        /* Room Cards */
        .room-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .room-card {
            border: 2px solid #dee2e6;
            border-radius: 10px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .room-card:hover {
            border-color: #667eea;
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
        }

        .room-card.selected {
            border-color: #667eea;
            background: #f0f4ff;
        }

        .room-card input[type="radio"] {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 20px;
            height: 20px;
        }

        .room-icon {
            font-size: 2.5em;
            margin-bottom: 10px;
        }

        .room-name {
            font-weight: 600;
            color: #2a5298;
            margin-bottom: 8px;
            font-size: 1.1em;
        }

        .room-price {
            color: #667eea;
            font-weight: bold;
            font-size: 1.2em;
            margin-bottom: 10px;
        }

        .room-features {
            font-size: 0.9em;
            color: #6c757d;
            line-height: 1.6;
        }

        /* Summary Box */
        .summary-box {
            background: #f8f9fa;
            border: 2px solid #dee2e6;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
        }

        .summary-title {
            font-size: 1.3em;
            color: #2a5298;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #dee2e6;
        }

        .summary-row:last-child {
            border-bottom: none;
        }

        .summary-label {
            color: #6c757d;
            font-weight: 500;
        }

        .summary-value {
            color: #2a5298;
            font-weight: 600;
        }

        .total-row {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 2px solid #667eea;
        }

        .total-row .summary-label {
            font-size: 1.2em;
            color: #2a5298;
        }

        .total-row .summary-value {
            font-size: 1.4em;
            color: #667eea;
        }

        /* Buttons */
        .button-group {
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        /* Alert */
        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: none;
            animation: slideDown 0.3s ease;
        }

        .alert.show {
            display: block;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .form-card {
                padding: 25px;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .progress-steps {
                flex-wrap: wrap;
                gap: 10px;
            }
        }
    </style>
</head>

<body>
    <!-- Header -->
    <header class="header">
        <h1>➕ Add New Reservation</h1>
        <a href="Dashboard.jsp" class="back-btn">← Back to Dashboard</a>
    </header>

    <!-- Container -->
    <div class="container">
        <!-- Alert Box -->
        <div id="alertBox" class="alert"></div>

        <!-- Form Card -->
        <div class="form-card">
            <div class="form-title">
                <span>📝</span>
                <span>New Reservation</span>
            </div>
            <p class="form-subtitle">Fill in the details to create a new reservation</p>

            <!-- Progress Steps -->
            <div class="progress-steps">
                <div class="progress-line" id="progressLine" style="width: 0%"></div>
                <div class="step active" id="step1">1</div>
                <div class="step" id="step2">2</div>
                <div class="step" id="step3">3</div>
                <div class="step" id="step4">4</div>
            </div>

            <!-- Form -->
            <form id="reservationForm" method="post" action="<%=request.getContextPath()%>/AddReservation">

           
                <!-- Step 1: Guest Information -->
                <div class="form-section active" id="section1">
                    <h3 class="section-title">Step 1: Guest Information</h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="guestName">Guest Name <span class="required">*</span></label>
                            <input type="text" id="guestName" name="guestName" class="form-control" placeholder="Enter full name">
                            <div class="error-message" id="guestNameError">Please enter guest name</div>
                        </div>

                        <div class="form-group">
                            <label for="contactNumber">Contact Number <span class="required">*</span></label>
                            <input type="tel" id="contactNumber" name="contactNumber" class="form-control" placeholder="+94 77 123 4567">
                            <div class="error-message" id="contactNumberError">Please enter valid contact number</div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" class="form-control" placeholder="guest@example.com">
                            <div class="error-message" id="emailError">Please enter valid email</div>
                        </div>

                        <div class="form-group">
                            <label for="idNumber">ID/Passport Number</label>
                            <input type="text" id="idNumber" name="idNumber" class="form-control" placeholder="Enter ID number">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="address">Address <span class="required">*</span></label>
                        <input type="text" id="address" name="address" class="form-control" placeholder="Enter complete address">
                        <div class="error-message" id="addressError">Please enter address</div>
                    </div>

                    <div class="form-group">
                        <label for="specialRequests">Special Requests</label>
                        <textarea id="specialRequests" name="specialRequests" class="form-control" rows="3" placeholder="Any special requirements or preferences..."></textarea>
                    </div>
                </div>
                
                
                <!-- Step 2: Booking Dates -->
                <div class="form-section" id="section2">
                    <h3 class="section-title">Step 2: Booking Dates</h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="checkInDate">Check-in Date <span class="required">*</span></label>
                            <input type="date" id="checkInDate" name="check_in" class="form-control">
                            <div class="error-message" id="checkInDateError">Please select check-in date</div>
                        </div>

                        <div class="form-group">
                            <label for="checkOutDate">Check-out Date <span class="required">*</span></label>
                            <input type="date" id="checkOutDate" name="check_out" class="form-control">
                            <div class="error-message" id="checkOutDateError">Please select check-out date</div>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="numberOfGuests">Number of Guests <span class="required">*</span></label>
                            <select id="numberOfGuests" name="guests" class="form-control">
                                <option value="">Select number of guests</option>
                                <option value="1">1 Guest</option>
                                <option value="2">2 Guests</option>
                                <option value="3">3 Guests</option>
                                <option value="4">4 Guests</option>
                                <option value="5">5 Guests</option>
                                <option value="6">6+ Guests</option>
                            </select>
                            <div class="error-message" id="numberOfGuestsError">Please select number of guests</div>
                        </div>

                        <div class="form-group">
                            <label>Number of Nights</label>
                            <input type="text" id="numberOfNights" name="nights" class="form-control" readonly value="0" style="background: #f8f9fa;">
                        </div>
                    </div>
                </div>

                <!-- Step 3: Room Selection -->
                <div class="form-section" id="section3">
                    <h3 class="section-title">Step 3: Select Room Type</h3>

                    <div class="room-grid">
                        <div class="room-card" onclick="selectRoom('standard')">
                            <input type="radio" name="room_type" value="standard" id="roomStandard">
                            <div class="room-icon">🛏️</div>
                            <div class="room-name">Standard Room</div>
                            <div class="room-price">LKR 8,000 / night</div>
                            <div class="room-features">
                                AC, WiFi, TV<br>
                                Up to 2 guests
                            </div>
                        </div>

                        <div class="room-card" onclick="selectRoom('deluxe')">
                            <input type="radio" name="room_type" value="deluxe" id="roomDeluxe">
                            <div class="room-icon">🏨</div>
                            <div class="room-name">Deluxe Room</div>
                            <div class="room-price">LKR 12,000 / night</div>
                            <div class="room-features">
                                Mini-bar, Ocean view<br>
                                Up to 3 guests
                            </div>
                        </div>

                        <div class="room-card" onclick="selectRoom('suite')">
                            <input type="radio" name="room_type" value="suite" id="roomSuite">
                            <div class="room-icon">🌟</div>
                            <div class="room-name">Suite</div>
                            <div class="room-price">LKR 20,000 / night</div>
                            <div class="room-features">
                                Jacuzzi, Balcony<br>
                                Up to 4 guests
                            </div>
                        </div>

                        <div class="room-card" onclick="selectRoom('presidential')">
                            <input type="radio" name="room_type" value="presidential" id="roomPresidential">
                            <div class="room-icon">👑</div>
                            <div class="room-name">Presidential Suite</div>
                            <div class="room-price">LKR 35,000 / night</div>
                            <div class="room-features">
                                Butler service, Terrace<br>
                                Up to 6 guests
                            </div>
                        </div>
                    </div>
                    <div class="error-message" id="roomTypeError">Please select a room type</div>
                </div>

                <!-- Step 4: Review & Confirm -->
                <div class="form-section" id="section4">
                    <h3 class="section-title">Step 4: Review & Confirm</h3>

                    <div class="summary-box">
                        <div class="summary-title">📋 Reservation Summary</div>
                        
                        <div class="summary-row">
                            <span class="summary-label">Guest Name:</span>
                            <span class="summary-value" id="summaryGuestName">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Contact:</span>
                            <span class="summary-value" id="summaryContact">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Email:</span>
                            <span class="summary-value" id="summaryEmail">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Check-in:</span>
                            <span class="summary-value" id="summaryCheckIn">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Check-out:</span>
                            <span class="summary-value" id="summaryCheckOut">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Number of Nights:</span>
                            <span class="summary-value" id="summaryNights">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Number of Guests:</span>
                            <span class="summary-value" id="summaryGuests">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Room Type:</span>
                            <span class="summary-value" id="summaryRoomType">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Rate per Night:</span>
                            <span class="summary-value" id="summaryRate">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Subtotal:</span>
                            <span class="summary-value" id="summarySubtotal">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Tax (15%):</span>
                            <span class="summary-value" id="summaryTax">-</span>
                        </div>
                        <div class="summary-row">
                            <span class="summary-label">Service Charge (10%):</span>
                            <span class="summary-value" id="summaryService">-</span>
                        </div>
                        <div class="summary-row total-row">
                            <span class="summary-label">Total Amount:</span>
                            <span class="summary-value" id="summaryTotal">-</span>
                        </div>
                    </div>
                </div>

                <!-- Navigation Buttons -->
                <div class="button-group">
                    <button type="button" class="btn btn-secondary" id="prevBtn" onclick="previousStep()" style="display: none;">
                        ← Previous
                    </button>
                    <button type="button" class="btn btn-primary" id="nextBtn" onclick="nextStep()">
                        Next →
                    </button>
                    <button type="submit" class="btn btn-primary" id="submitBtn" style="display: none;">
                        ✓ Confirm Reservation
                    </button>
                </div>
            </form>
        </div>
    </div>
    
    
    

    <script>
        // Current step
        let currentStep = 1;
        const totalSteps = 4;

        // Room prices
        const roomPrices = {
            standard: 8000,
            deluxe: 12000,
            suite: 20000,
            presidential: 35000
        };

        const roomNames = {
            standard: 'Standard Room',
            deluxe: 'Deluxe Room',
            suite: 'Suite',
            presidential: 'Presidential Suite'
        };

        // Set minimum date to today
        window.addEventListener('load', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('checkInDate').setAttribute('min', today);
            document.getElementById('checkOutDate').setAttribute('min', today);
        });

        // Calculate nights when dates change
        document.getElementById('checkInDate').addEventListener('change', calculateNights);
        document.getElementById('checkOutDate').addEventListener('change', calculateNights);

        function calculateNights() {
            const checkIn = new Date(document.getElementById('checkInDate').value);
            const checkOut = new Date(document.getElementById('checkOutDate').value);

            if (checkIn && checkOut && checkOut > checkIn) {
                const diffTime = Math.abs(checkOut - checkIn);
                const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                document.getElementById('numberOfNights').value = diffDays;
            } else {
                document.getElementById('numberOfNights').value = 0;
            }
        }

        // Select room
        function selectRoom(roomType) {
            // Remove selected class from all cards
            document.querySelectorAll('.room-card').forEach(card => {
                card.classList.remove('selected');
            });

            // Add selected class to clicked card
            event.currentTarget.classList.add('selected');

            // Check the radio button
            document.getElementById('room' + roomType.charAt(0).toUpperCase() + roomType.slice(1)).checked = true;

            // Clear error
            document.getElementById('roomTypeError').classList.remove('show');
        }

        // Next step
        function nextStep() {
            if (validateStep(currentStep)) {
                // Hide current section
                document.getElementById('section' + currentStep).classList.remove('active');
                
                // Mark current step as completed
                document.getElementById('step' + currentStep).classList.add('completed');
                
                // Move to next step
                currentStep++;
                
                // Show next section
                document.getElementById('section' + currentStep).classList.add('active');
                
                // Mark next step as active
                document.getElementById('step' + currentStep).classList.add('active');
                
                // Update progress bar
                updateProgressBar();
                
                // Update buttons
                updateButtons();
                
                // If last step, show summary
                if (currentStep === 4) {
                    showSummary();
                }
                
                // Scroll to top
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
        }

        // Previous step
        function previousStep() {
            // Hide current section
            document.getElementById('section' + currentStep).classList.remove('active');
            
            // Remove active from current step
            document.getElementById('step' + currentStep).classList.remove('active');
            
            // Move to previous step
            currentStep--;
            
            // Show previous section
            document.getElementById('section' + currentStep).classList.add('active');
            
            // Update progress bar
            updateProgressBar();
            
            // Update buttons
            updateButtons();
            
            // Scroll to top
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        // Validate step
        function validateStep(step) {
            clearErrors();
            let isValid = true;

            if (step === 1) {
                // Validate guest information
                if (!document.getElementById('guestName').value.trim()) {
                    showError('guestName', 'Please enter guest name');
                    isValid = false;
                }

                const contact = document.getElementById('contactNumber').value.trim();
                if (!contact || contact.length < 10) {
                    showError('contactNumber', 'Please enter valid contact number (min 10 digits)');
                    isValid = false;
                }

                const email = document.getElementById('email').value.trim();
                if (email && !validateEmail(email)) {
                    showError('email', 'Please enter valid email address');
                    isValid = false;
                }

                if (!document.getElementById('address').value.trim()) {
                    showError('address', 'Please enter address');
                    isValid = false;
                }
            } else if (step === 2) {
                // Validate booking dates
                const checkIn = document.getElementById('checkInDate').value;
                const checkOut = document.getElementById('checkOutDate').value;

                if (!checkIn) {
                    showError('checkInDate', 'Please select check-in date');
                    isValid = false;
                }

                if (!checkOut) {
                    showError('checkOutDate', 'Please select check-out date');
                    isValid = false;
                }

                if (checkIn && checkOut && new Date(checkOut) <= new Date(checkIn)) {
                    showError('checkOutDate', 'Check-out date must be after check-in date');
                    isValid = false;
                }

                if (!document.getElementById('numberOfGuests').value) {
                    showError('numberOfGuests', 'Please select number of guests');
                    isValid = false;
                }
            } else if (step === 3) {
                // Validate room selection
                const roomType = document.querySelector('input[name="room_type"]:checked');
                if (!roomType) {
                    showError('roomType', 'Please select a room type');
                    isValid = false;
                }
            }

            return isValid;
        }

        // Show error message
        function showError(fieldId, message) {
            const field = document.getElementById(fieldId);
            const errorMsg = document.getElementById(fieldId + 'Error');
            
            if (field) field.classList.add('error');
            if (errorMsg) {
                errorMsg.textContent = message;
                errorMsg.classList.add('show');
            }
        }

        // Clear all errors
        function clearErrors() {
            document.querySelectorAll('.form-control').forEach(field => {
                field.classList.remove('error');
            });
            document.querySelectorAll('.error-message').forEach(msg => {
                msg.classList.remove('show');
            });
        }

        // Validate email format
        function validateEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        }

        // Update progress bar
        function updateProgressBar() {
            const progress = ((currentStep - 1) / (totalSteps - 1)) * 100;
            document.getElementById('progressLine').style.width = progress + '%';
        }

        // Update navigation buttons
       function updateButtons() {
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    const submitBtn = document.getElementById('submitBtn');

    // Previous button
    prevBtn.style.display = currentStep === 1 ? 'none' : 'inline-block';

    // Next / Submit buttons
    if (currentStep === totalSteps) {
        nextBtn.style.display = 'none';
        submitBtn.style.display = 'inline-block';
    } else {
        nextBtn.style.display = 'inline-block';
        submitBtn.style.display = 'none';
    }
}

function showSummary() {

    // Get values
    const guestName = document.getElementById('guestName').value;
    const contact = document.getElementById('contactNumber').value;
    const email = document.getElementById('email').value || '-';
    const checkIn = document.getElementById('checkInDate').value;
    const checkOut = document.getElementById('checkOutDate').value;
    const nights = document.getElementById('numberOfNights').value;
    const guests = document.getElementById('numberOfGuests').value;

    const roomRadio = document.querySelector('input[name="room_type"]:checked');
    const roomType = roomRadio ? roomRadio.value : '';

    const rate = roomPrices[roomType] || 0;

    const subtotal = rate * nights;
    const tax = subtotal * 0.15;
    const service = subtotal * 0.10;
    const total = subtotal + tax + service;

    // Set summary values
    document.getElementById('summaryGuestName').textContent = guestName;
    document.getElementById('summaryContact').textContent = contact;
    document.getElementById('summaryEmail').textContent = email;
    document.getElementById('summaryCheckIn').textContent = checkIn;
    document.getElementById('summaryCheckOut').textContent = checkOut;
    document.getElementById('summaryNights').textContent = nights;
    document.getElementById('summaryGuests').textContent = guests;
    document.getElementById('summaryRoomType').textContent = roomNames[roomType];
    document.getElementById('summaryRate').textContent = "LKR " + rate.toLocaleString();
    document.getElementById('summarySubtotal').textContent = "LKR " + subtotal.toLocaleString();
    document.getElementById('summaryTax').textContent = "LKR " + tax.toLocaleString();
    document.getElementById('summaryService').textContent = "LKR " + service.toLocaleString();
    document.getElementById('summaryTotal').textContent = "LKR " + total.toLocaleString();
}



</script>