<%-- 
    Document   : Help
    Created on : 14 Jan 2026, 11:23:52
    Author     : Tharsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort - Help Center</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1800px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .header p {
            font-size: 1.1em;
            opacity: 0.9;
        }

        .main-content {
            display: flex;
            min-height: 600px;
        }

        .sidebar {
            width: 300px;
            background: #f8f9fa;
            border-right: 1px solid #dee2e6;
            padding: 20px;
        }

        .sidebar h2 {
            color: #2a5298;
            margin-bottom: 20px;
            font-size: 1.3em;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }

        .menu-item {
            padding: 15px;
            margin-bottom: 10px;
            background: white;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .menu-item:hover {
            background: #e9ecef;
            border-left-color: #667eea;
            transform: translateX(5px);
        }

        .menu-item.active {
            background: #667eea;
            color: white;
            border-left-color: #2a5298;
        }

        .menu-item .icon {
            font-size: 1.3em;
        }

        .content-area {
            flex: 1;
            padding: 40px;
            overflow-y: auto;
            max-height: 800px;
        }

        .help-topic {
            display: none;
            animation: fadeIn 0.5s ease;
        }

        .help-topic.active {
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

        .help-topic h2 {
            color: #2a5298;
            margin-bottom: 20px;
            font-size: 2em;
            border-bottom: 3px solid #667eea;
            padding-bottom: 10px;
        }

        .help-topic h3 {
            color: #495057;
            margin-top: 25px;
            margin-bottom: 15px;
            font-size: 1.4em;
        }

        .help-topic p {
            line-height: 1.8;
            color: #495057;
            margin-bottom: 15px;
        }

        .help-topic ul, .help-topic ol {
            margin-left: 25px;
            margin-bottom: 20px;
            line-height: 1.8;
        }

        .help-topic li {
            margin-bottom: 10px;
            color: #495057;
        }

        .info-box {
            background: #e7f3ff;
            border-left: 4px solid #2196F3;
            padding: 15px 20px;
            margin: 20px 0;
            border-radius: 5px;
        }

        .warning-box {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px 20px;
            margin: 20px 0;
            border-radius: 5px;
        }

        .success-box {
            background: #d4edda;
            border-left: 4px solid #28a745;
            padding: 15px 20px;
            margin: 20px 0;
            border-radius: 5px;
        }

        .step-box {
            background: #f8f9fa;
            padding: 15px 20px;
            margin: 15px 0;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }

        .step-box strong {
            color: #667eea;
            font-size: 1.1em;
        }

        .price-card {
            background: white;
            border: 2px solid #dee2e6;
            border-radius: 10px;
            padding: 20px;
            margin: 15px 0;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .price-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .price-card h4 {
            color: #2a5298;
            margin-bottom: 10px;
            font-size: 1.3em;
        }

        .price-card .price {
            color: #667eea;
            font-size: 1.5em;
            font-weight: bold;
            margin: 10px 0;
        }

        .contact-info {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 15px 0;
            padding: 10px;
            background: #f8f9fa;
            border-radius: 5px;
        }

        .contact-info .icon {
            font-size: 1.5em;
            color: #667eea;
        }

        .back-btn {
            background: #667eea;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-size: 1em;
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: #2a5298;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .search-box {
            margin-bottom: 20px;
            position: relative;
        }

        .search-box input {
            width: 100%;
            padding: 12px 40px 12px 15px;
            border: 2px solid #dee2e6;
            border-radius: 25px;
            font-size: 0.95em;
            transition: border-color 0.3s ease;
        }

        .search-box input:focus {
            outline: none;
            border-color: #667eea;
        }

        .search-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
        }

        @media (max-width: 768px) {
            .main-content {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                border-right: none;
                border-bottom: 1px solid #dee2e6;
            }

            .content-area {
                padding: 20px;
            }

            .header h1 {
                font-size: 1.8em;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏖️ Ocean View Resort</h1>
            <p>Help Center & User Guide</p>
        </div>

        <div class="main-content">
            <div class="sidebar">
                <h2>Help Topics</h2>
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search help topics...">
                    <span class="search-icon">🔍</span>
                </div>
                <div class="menu-item active" onclick="showTopic('getting-started')">
                    <span class="icon">🚀</span>
                    <span>Getting Started</span>
                </div>
                <div class="menu-item" onclick="showTopic('login')">
                    <span class="icon">🔐</span>
                    <span>Login & Authentication</span>
                </div>
                <div class="menu-item" onclick="showTopic('add-reservation')">
                    <span class="icon">➕</span>
                    <span>Adding Reservations</span>
                </div>
                <div class="menu-item" onclick="showTopic('view-reservation')">
                    <span class="icon">👁️</span>
                    <span>Viewing Reservations</span>
                </div>
                <div class="menu-item" onclick="showTopic('billing')">
                    <span class="icon">💰</span>
                    <span>Billing & Payments</span>
                </div>
                <div class="menu-item" onclick="showTopic('room-types')">
                    <span class="icon">🏨</span>
                    <span>Room Types & Pricing</span>
                </div>
                <div class="menu-item" onclick="showTopic('guest-management')">
                    <span class="icon">👥</span>
                    <span>Guest Management</span>
                </div>
                <div class="menu-item" onclick="showTopic('errors')">
                    <span class="icon">⚠️</span>
                    <span>Error Messages</span>
                </div>
                <div class="menu-item" onclick="showTopic('faq')">
                    <span class="icon">❓</span>
                    <span>FAQ</span>
                </div>
                <div class="menu-item" onclick="showTopic('contact')">
                    <span class="icon">📞</span>
                    <span>Contact Support</span>
                </div>
            </div>

            <div class="content-area">
                <!-- Getting Started -->
                <div id="getting-started" class="help-topic active">
                    <h2>Getting Started</h2>
                    <p>Welcome to the Ocean View Resort Reservation System! This comprehensive guide will help you navigate and use all features of our system efficiently.</p>
                    
                    <h3>System Overview</h3>
                    <p>This system helps you manage:</p>
                    <ul>
                        <li>Guest reservations and bookings</li>
                        <li>Room availability and assignments</li>
                        <li>Guest information and records</li>
                        <li>Billing and payment calculations</li>
                        <li>Reports and analytics</li>
                    </ul>

                    <h3>System Navigation</h3>
                    <div class="info-box">
                        <strong>Navigation Tips:</strong>
                        <ul>
                            <li>Use the sidebar menu to access different sections</li>
                            <li>Click on buttons and links to perform actions</li>
                            <li>Use the search box to find specific help topics</li>
                            <li>All inputs are validated to ensure data accuracy</li>
                        </ul>
                    </div>

                    <h3>Best Practices</h3>
                    <ol>
                        <li><strong>Verify Information:</strong> Always double-check guest details before saving</li>
                        <li><strong>Check Dates:</strong> Ensure dates are correct to avoid booking conflicts</li>
                        <li><strong>Security:</strong> Log out when finished to maintain system security</li>
                        <li><strong>Record Keeping:</strong> Keep reservation numbers for future reference</li>
                        <li><strong>Regular Backups:</strong> System data is backed up automatically every 24 hours</li>
                    </ol>
                </div>

                <!-- Login -->
                <div id="login" class="help-topic">
                    <h2>Login & Authentication</h2>
                    
                    <h3>How to Log In</h3>
                    <div class="step-box">
                        <strong>Step 1:</strong> Navigate to the login page
                    </div>
                    <div class="step-box">
                        <strong>Step 2:</strong> Enter your assigned username
                    </div>
                    <div class="step-box">
                        <strong>Step 3:</strong> Enter your password (input is hidden for security)
                    </div>
                    <div class="step-box">
                        <strong>Step 4:</strong> Click the "Login" button
                    </div>

                    <h3>Default Credentials</h3>
                    <div class="warning-box">
                        <strong>⚠️ First-time Users:</strong><br>
                        Username: <code>admin</code><br>
                        Password: <code>admin123</code><br><br>
                        <strong>Important:</strong> Change your password immediately after first login!
                    </div>

                    <h3>Troubleshooting Login Issues</h3>
                    <ul>
                        <li><strong>Forgot Password:</strong> Click "Forgot Password?" link and follow email instructions</li>
                        <li><strong>Account Locked:</strong> After 3 failed attempts, account is locked for 15 minutes</li>
                        <li><strong>Username Case Sensitivity:</strong> Usernames are case-sensitive</li>
                        <li><strong>Browser Issues:</strong> Clear cache and cookies, or try a different browser</li>
                    </ul>

                    <h3>Security Tips</h3>
                    <div class="success-box">
                        <strong>✓ Security Best Practices:</strong>
                        <ul>
                            <li>Never share your login credentials with anyone</li>
                            <li>Always log out when leaving your workstation</li>
                            <li>Use strong passwords (minimum 8 characters with letters, numbers, and symbols)</li>
                            <li>Change your password regularly (every 90 days)</li>
                            <li>Don't write down passwords</li>
                        </ul>
                    </div>
                </div>

                <!-- Add Reservation -->
                <div id="add-reservation" class="help-topic">
                    <h2>Adding New Reservations</h2>
                    
                    <h3>Step-by-Step Guide</h3>
                    
                    <div class="step-box">
                        <strong>Step 1: Navigate to Reservations</strong>
                        <p>Click on "Reservations" in the main menu, then select "Add New Reservation"</p>
                    </div>

                    <div class="step-box">
                        <strong>Step 2: Enter Guest Details</strong>
                        <ul>
                            <li><strong>Guest Name:</strong> Full name (e.g., John Doe)</li>
                            <li><strong>Address:</strong> Complete residential address</li>
                            <li><strong>Contact Number:</strong> Valid phone number (e.g., +94771234567)</li>
                            <li><strong>Email:</strong> Valid email address (optional)</li>
                        </ul>
                    </div>

                    <div class="step-box">
                        <strong>Step 3: Select Room Type</strong>
                        <p>Choose from available room categories:</p>
                        <ul>
                            <li>Standard Room</li>
                            <li>Deluxe Room</li>
                            <li>Suite</li>
                            <li>Presidential Suite</li>
                        </ul>
                    </div>

                    <div class="step-box">
                        <strong>Step 4: Enter Booking Dates</strong>
                        <ul>
                            <li><strong>Check-in Date:</strong> Format DD/MM/YYYY (e.g., 15/01/2026)</li>
                            <li><strong>Check-out Date:</strong> Must be after check-in date</li>
                        </ul>
                    </div>

                    <div class="step-box">
                        <strong>Step 5: Review & Confirm</strong>
                        <ul>
                            <li>Verify all details are correct</li>
                            <li>Click "Save Reservation" button</li>
                            <li>System generates unique Reservation Number</li>
                            <li>Note down the reservation number</li>
                        </ul>
                    </div>

                    <h3>Important Notes</h3>
                    <div class="warning-box">
                        <strong>⚠️ Validation Rules:</strong>
                        <ul>
                            <li>Check-out date must be after check-in date</li>
                            <li>Dates cannot be in the past</li>
                            <li>Contact number must be valid (10-15 digits)</li>
                            <li>All mandatory fields must be filled</li>
                        </ul>
                    </div>
                </div>

                <!-- View Reservation -->
                <div id="view-reservation" class="help-topic">
                    <h2>Viewing Reservation Details</h2>
                    
                    <h3>How to View Reservations</h3>
                    <ol>
                        <li>Select "View Reservations" from the main menu</li>
                        <li>Choose your search method:
                            <ul>
                                <li>By Reservation Number (fastest)</li>
                                <li>By Guest Name</li>
                                <li>By Contact Number</li>
                                <li>By Check-in Date</li>
                            </ul>
                        </li>
                        <li>Enter the search criteria</li>
                        <li>Click "Search" button</li>
                    </ol>

                    <h3>Information Displayed</h3>
                    <div class="info-box">
                        <strong>Reservation Details Include:</strong>
                        <ul>
                            <li>✓ Reservation Number</li>
                            <li>✓ Guest Name</li>
                            <li>✓ Contact Information</li>
                            <li>✓ Address</li>
                            <li>✓ Room Type</li>
                            <li>✓ Check-in Date</li>
                            <li>✓ Check-out Date</li>
                            <li>✓ Number of Nights</li>
                            <li>✓ Booking Status (Confirmed/Pending/Cancelled)</li>
                            <li>✓ Total Amount</li>
                        </ul>
                    </div>

                    <h3>Action Options</h3>
                    <p>From the reservation details page, you can:</p>
                    <ul>
                        <li>Edit reservation details</li>
                        <li>Cancel reservation</li>
                        <li>Generate invoice</li>
                        <li>Print confirmation</li>
                        <li>Send confirmation email</li>
                    </ul>

                    <h3>Tips for Quick Search</h3>
                    <div class="success-box">
                        <strong>✓ Search Tips:</strong>
                        <ul>
                            <li>Keep reservation numbers handy for quick access</li>
                            <li>Use exact spelling for name searches</li>
                            <li>Include country code for phone searches (+94)</li>
                            <li>Use date filters to narrow results</li>
                        </ul>
                    </div>
                </div>

                <!-- Billing -->
                <div id="billing" class="help-topic">
                    <h2>Billing & Payments</h2>
                    
                    <h3>How to Generate a Bill</h3>
                    <div class="step-box">
                        <strong>Step 1:</strong> Navigate to "Billing" section
                    </div>
                    <div class="step-box">
                        <strong>Step 2:</strong> Enter Reservation Number
                    </div>
                    <div class="step-box">
                        <strong>Step 3:</strong> System automatically calculates total amount
                    </div>
                    <div class="step-box">
                        <strong>Step 4:</strong> Review bill details
                    </div>
                    <div class="step-box">
                        <strong>Step 5:</strong> Choose output option (Print/Email/PDF)
                    </div>

                    <h3>Bill Calculation</h3>
                    <div class="info-box">
                        <strong>Bill Components:</strong>
                        <ul>
                            <li><strong>Base Rate:</strong> Room rate × Number of nights</li>
                            <li><strong>Tax (15%):</strong> Applied to base rate</li>
                            <li><strong>Service Charge (10%):</strong> Applied to base rate</li>
                            <li><strong>Additional Services:</strong> Extra bed, breakfast, etc.</li>
                        </ul>
                        <p><strong>Total = Base Rate + Tax + Service Charge + Additional Services</strong></p>
                    </div>

                    <h3>Example Calculation</h3>
                    <div class="step-box">
                        <p><strong>Deluxe Room for 3 nights:</strong></p>
                        <p>Room Rate: LKR 12,000 × 3 nights = LKR 36,000<br>
                        Tax (15%): LKR 5,400<br>
                        Service Charge (10%): LKR 3,600<br>
                        <strong>Grand Total: LKR 45,000</strong></p>
                    </div>

                    <h3>Additional Charges</h3>
                    <ul>
                        <li><strong>Early Checkout:</strong> May incur cancellation charges</li>
                        <li><strong>Late Checkout:</strong> Charged at 50% of daily rate</li>
                        <li><strong>Extra Services:</strong> Charged separately</li>
                    </ul>

                    <h3>Payment Methods Accepted</h3>
                    <div class="success-box">
                        <ul>
                            <li>💵 Cash</li>
                            <li>💳 Credit/Debit Cards (Visa, MasterCard, Amex)</li>
                            <li>🏦 Bank Transfer</li>
                            <li>📱 Mobile Payment (ePay, mCash)</li>
                        </ul>
                    </div>
                </div>

                <!-- Room Types -->
                <div id="room-types" class="help-topic">
                    <h2>Room Types & Pricing</h2>
                    
                    <div class="price-card">
                        <h4>🛏️ Standard Room</h4>
                        <div class="price">LKR 8,000 per night</div>
                        <p><strong>Features:</strong></p>
                        <ul>
                            <li>Air Conditioning</li>
                            <li>Free WiFi</li>
                            <li>LED TV with cable</li>
                            <li>Single or Double bed</li>
                            <li>Private bathroom</li>
                        </ul>
                        <p><strong>Occupancy:</strong> Up to 2 guests</p>
                    </div>

                    <div class="price-card">
                        <h4>🏨 Deluxe Room</h4>
                        <div class="price">LKR 12,000 per night</div>
                        <p><strong>Features:</strong></p>
                        <ul>
                            <li>All Standard Room features</li>
                            <li>Mini-bar (stocked)</li>
                            <li>Ocean view balcony</li>
                            <li>Premium toiletries</li>
                            <li>Coffee/tea maker</li>
                        </ul>
                        <p><strong>Occupancy:</strong> Up to 3 guests</p>
                    </div>

                    <div class="price-card">
                        <h4>🌟 Suite</h4>
                        <div class="price">LKR 20,000 per night</div>
                        <p><strong>Features:</strong></p>
                        <ul>
                            <li>Separate living area</li>
                            <li>Private balcony with ocean view</li>
                            <li>Jacuzzi bathtub</li>
                            <li>King-size bed</li>
                            <li>Work desk and seating area</li>
                            <li>Premium minibar</li>
                        </ul>
                        <p><strong>Occupancy:</strong> Up to 4 guests</p>
                    </div>

                    <div class="price-card">
                        <h4>👑 Presidential Suite</h4>
                        <div class="price">LKR 35,000 per night</div>
                        <p><strong>Features:</strong></p>
                        <ul>
                            <li>Luxury furnishings</li>
                            <li>Private terrace</li>
                            <li>Personal butler service</li>
                            <li>Master bedroom + guest room</li>
                            <li>Premium entertainment system</li>
                            <li>Fully stocked premium bar</li>
                            <li>Complimentary spa access</li>
                        </ul>
                        <p><strong>Occupancy:</strong> Up to 6 guests</p>
                    </div>

                    <h3>Additional Services & Charges</h3>
                    <div class="info-box">
                        <ul>
                            <li><strong>Extra Bed:</strong> LKR 2,000 per night</li>
                            <li><strong>Breakfast:</strong> LKR 1,500 per person</li>
                            <li><strong>Airport Transfer:</strong> LKR 5,000 (one way)</li>
                            <li><strong>Laundry Service:</strong> Charges apply per item</li>
                            <li><strong>Room Service:</strong> 24/7 available</li>
                        </ul>
                    </div>
                </div>

                <!-- Guest Management -->
                <div id="guest-management" class="help-topic">
                    <h2>Guest Management</h2>
                    
                    <h3>Guest Data Requirements</h3>
                    
                    <div class="info-box">
                        <strong>Mandatory Fields:</strong>
                        <ul>
                            <li>Guest Name (2-50 characters)</li>
                            <li>Contact Number (10-15 digits)</li>
                            <li>Address (Complete residential address)</li>
                        </ul>
                    </div>

                    <div class="info-box">
                        <strong>Optional Fields:</strong>
                        <ul>
                            <li>Email address</li>
                            <li>Special requests</li>
                            <li>Dietary preferences</li>
                            <li>Emergency contact</li>
                        </ul>
                    </div>

                    <h3>Input Validation Rules</h3>
                    <ul>
                        <li><strong>Name:</strong> Letters and spaces only, no numbers or special characters</li>
                        <li><strong>Phone:</strong> Numbers only, with optional + prefix for country code</li>
                        <li><strong>Email:</strong> Must follow valid email format (user@domain.com)</li>
                        <li><strong>Address:</strong> Minimum 10 characters</li>
                    </ul>

                    <h3>Updating Guest Information</h3>
                    <div class="step-box">
                        <strong>Step 1:</strong> Search for the reservation
                    </div>
                    <div class="step-box">
                        <strong>Step 2:</strong> Click "Edit Guest Details" button
                    </div>
                    <div class="step-box">
                        <strong>Step 3:</strong> Modify required fields
                    </div>
                    <div class="step-box">
                        <strong>Step 4:</strong> Click "Save Changes"
                    </div>
                    <div class="step-box">
                        <strong>Step 5:</strong> Confirmation message appears
                    </div>

                    <h3>Data Privacy & Security</h3>
                    <div class="warning-box">
                        <strong>⚠️ Important:</strong>
                        <ul>
                            <li>All guest data is strictly confidential</li>
                            <li>Access restricted to authorized staff only</li>
                            <li>Comply with data protection regulations</li>
                            <li>Never share guest information with unauthorized parties</li>
                            <li>Report any suspected data breaches immediately</li>
                        </ul>
                    </div>
                </div>

                <!-- Error Messages -->
                <div id="errors" class="help-topic">
                    <h2>Common Error Messages</h2>
                    
                    <h3>Reservation Errors</h3>
                    <div class="warning-box">
                        <strong>⚠️ "Invalid Reservation Number"</strong>
                        <p><strong>Cause:</strong> Reservation number doesn't exist in system</p>
                        <p><strong>Solution:</strong> Verify the number and try again. Reservation numbers are case-sensitive.</p>
                    </div>

                    <div class="warning-box">
                        <strong>⚠️ "Room Not Available"</strong>
                        <p><strong>Cause:</strong> Selected room type is fully booked for chosen dates</p>
                        <p><strong>Solution:</strong> Choose different dates or select another room type</p>
                    </div>

                    <h3>Date Errors</h3>
                    <div class="warning-box">
                        <strong>⚠️ "Invalid Date Format"</strong>
                        <p><strong>Cause:</strong> Date not entered in correct format</p>
                        <p><strong>Solution:</strong> Enter date as DD/MM/YYYY (e.g., 15/01/2026)</p>
                    </div>

                    <div class="warning-box">

                        <!-- Continue from the Date Errors section -->

                        <strong>⚠️ "Check-out date must be after Check-in date"</strong>
                        <p><strong>Cause:</strong> Check-out date is earlier than or same as check-in date</p>
                        <p><strong>Solution:</strong> Select a check-out date that is at least 1 day after check-in</p>
                    </div>

                    <div class="warning-box">
                        <strong>⚠️ "Cannot book dates in the past"</strong>
                        <p><strong>Cause:</strong> Selected dates are before today's date</p>
                        <p><strong>Solution:</strong> Choose future dates for your reservation</p>
                    </div>

                    <h3>Input Validation Errors</h3>
                    <div class="warning-box">
                        <strong>⚠️ "Invalid Contact Number"</strong>
                        <p><strong>Cause:</strong> Phone number format is incorrect</p>
                        <p><strong>Solution:</strong> Enter 10-15 digits only. Example: +94771234567</p>
                    </div>

                    <div class="warning-box">
                        <strong>⚠️ "Guest Name is required"</strong>
                        <p><strong>Cause:</strong> Name field is empty or too short</p>
                        <p><strong>Solution:</strong> Enter full guest name (minimum 2 characters)</p>
                    </div>

                    <div class="warning-box">
                        <strong>⚠️ "Invalid Email Format"</strong>
                        <p><strong>Cause:</strong> Email address doesn't follow standard format</p>
                        <p><strong>Solution:</strong> Use format: username@domain.com</p>
                    </div>

                    <h3>System Errors</h3>
                    <div class="warning-box">
                        <strong>⚠️ "Session Expired"</strong>
                        <p><strong>Cause:</strong> You've been inactive for more than 30 minutes</p>
                        <p><strong>Solution:</strong> Log in again to continue</p>
                    </div>

                    <div class="warning-box">
                        <strong>⚠️ "Database Connection Error"</strong>
                        <p><strong>Cause:</strong> System cannot connect to database</p>
                        <p><strong>Solution:</strong> Contact IT support immediately. Try refreshing the page.</p>
                    </div>

                    <div class="warning-box">
                        <strong>⚠️ "Permission Denied"</strong>
                        <p><strong>Cause:</strong> You don't have access rights for this action</p>
                        <p><strong>Solution:</strong> Contact your supervisor to request appropriate permissions</p>
                    </div>
                </div>

                <!-- FAQ Section -->
                <div id="faq" class="help-topic">
                    <h2>Frequently Asked Questions (FAQ)</h2>
                    
                    <h3>General Questions</h3>
                    
                    <div class="step-box">
                        <strong>Q: What is the check-in and check-out time?</strong>
                        <p>A: Check-in time is 2:00 PM and check-out time is 12:00 PM (noon). Early check-in or late check-out may be available upon request and availability.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: Can I modify or cancel a reservation?</strong>
                        <p>A: Yes, you can modify reservations up to 48 hours before check-in date. Cancellations made 72 hours in advance receive full refund. Late cancellations may incur charges.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: How do I generate a reservation number?</strong>
                        <p>A: The system automatically generates a unique reservation number when you save a new booking. Format: RES + 6 digit number (e.g., RES000001)</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: What payment methods are accepted?</strong>
                        <p>A: We accept cash, credit/debit cards (Visa, MasterCard, Amex), bank transfers, and mobile payments (ePay, mCash).</p>
                    </div>

                    <h3>Reservation Questions</h3>

                    <div class="step-box">
                        <strong>Q: Can I book multiple rooms for the same guest?</strong>
                        <p>A: Yes, create separate reservations for each room using the same guest details. Each reservation will have a unique reservation number.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: What happens if all rooms are booked?</strong>
                        <p>A: The system will show "Room Not Available" message. You can choose alternative dates or a different room type.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: How far in advance can I make a reservation?</strong>
                        <p>A: Reservations can be made up to 365 days in advance.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: Can I add extra guests to an existing reservation?</strong>
                        <p>A: Yes, edit the reservation and add extra bed charges. Each room has a maximum occupancy limit.</p>
                    </div>

                    <h3>Billing Questions</h3>

                    <div class="step-box">
                        <strong>Q: How is the total bill calculated?</strong>
                        <p>A: Total = (Room Rate × Number of Nights) + Tax (15%) + Service Charge (10%) + Additional Services</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: Are taxes included in the room rate?</strong>
                        <p>A: No, 15% tax and 10% service charge are added to the base room rate.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: Can I get a bill breakdown?</strong>
                        <p>A: Yes, the billing section shows detailed breakdown of all charges including room rate, taxes, service charges, and additional services.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: Can I print the bill?</strong>
                        <p>A: Yes, click the "Print Bill" button to generate a printable invoice.</p>
                    </div>

                    <h3>Technical Questions</h3>

                    <div class="step-box">
                        <strong>Q: Which browsers are supported?</strong>
                        <p>A: Chrome, Firefox, Safari, Edge (latest versions). For best experience, use Chrome or Firefox.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: What should I do if the system is slow?</strong>
                        <p>A: Try refreshing the page, clearing browser cache, or checking your internet connection. Contact IT support if problem persists.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: Can I access the system from mobile devices?</strong>
                        <p>A: Yes, the system is responsive and works on tablets and smartphones.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: How often is the system backed up?</strong>
                        <p>A: All data is automatically backed up every 24 hours. Critical data is backed up in real-time.</p>
                    </div>

                    <h3>Security Questions</h3>

                    <div class="step-box">
                        <strong>Q: Is guest data secure?</strong>
                        <p>A: Yes, all guest data is encrypted and stored securely. Access is restricted to authorized personnel only.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: How long do I remain logged in?</strong>
                        <p>A: Sessions expire after 30 minutes of inactivity. You'll receive a warning at 25 minutes.</p>
                    </div>

                    <div class="step-box">
                        <strong>Q: Can I change my password?</strong>
                        <p>A: Yes, go to Profile Settings and click "Change Password". You'll need to enter your current password and a new password.</p>
                    </div>
                </div>

                <!-- Contact Support -->
                <div id="contact" class="help-topic">
                    <h2>Contact Support</h2>
                    <p>Need help? Our support team is here to assist you!</p>

                    <h3>Support Channels</h3>

                    <div class="contact-info">
                        <span class="icon">📞</span>
                        <div>
                            <strong>Phone Support</strong><br>
                            +94 91 2234567<br>
                            Available: Mon-Sun, 24/7
                        </div>
                    </div>

                    <div class="contact-info">
                        <span class="icon">📧</span>
                        <div>
                            <strong>Email Support</strong><br>
                            support@oceanviewresort.lk<br>
                            Response time: Within 24 hours
                        </div>
                    </div>

                    <div class="contact-info">
                        <span class="icon">💬</span>
                        <div>
                            <strong>Live Chat</strong><br>
                            Click the chat icon at bottom right<br>
                            Available: Mon-Fri, 8 AM - 8 PM
                        </div>
                    </div>

                    <div class="contact-info">
                        <span class="icon">📍</span>
                        <div>
                            <strong>Visit Us</strong><br>
                            Ocean View Resort, Galle Road<br>
                            Galle, Sri Lanka
                        </div>
                    </div>

                    <h3>IT Support</h3>
                    <div class="info-box">
                        <strong>For Technical Issues:</strong>
                        <ul>
                            <li><strong>Phone:</strong> +94 91 2234888 (Ext: 101)</li>
                            <li><strong>Email:</strong> itsupport@oceanviewresort.lk</li>
                            <li><strong>Hours:</strong> Mon-Fri, 9 AM - 6 PM</li>
                        </ul>
                    </div>

                    <h3>Emergency Contact</h3>
                    <div class="warning-box">
                        <strong>⚠️ For Urgent Issues:</strong>
                        <ul>
                            <li><strong>Emergency Hotline:</strong> +94 91 2234999</li>
                            <li><strong>Available:</strong> 24/7</li>
                            <li><strong>Use for:</strong> System down, security breaches, critical errors</li>
                        </ul>
                    </div>

                    <h3>Feedback & Suggestions</h3>
                    <div class="success-box">
                        <strong>We value your feedback!</strong>
                        <p>Help us improve the system by sharing your suggestions:</p>
                        <ul>
                            <li><strong>Email:</strong> feedback@oceanviewresort.lk</li>
                            <li><strong>Online Form:</strong> Available in Profile → Send Feedback</li>
                            <li><strong>Response Time:</strong> Within 48 hours</li>
                        </ul>
                    </div>

                    <h3>Training & Workshops</h3>
                    <div class="info-box">
                        <strong>Need Training?</strong>
                        <p>We offer free training sessions for new staff members:</p>
                        <ul>
                            <li>Basic System Navigation (2 hours)</li>
                            <li>Advanced Features Workshop (4 hours)</li>
                            <li>Troubleshooting & Best Practices (2 hours)</li>
                        </ul>
                        <p><strong>Contact:</strong> training@oceanviewresort.lk to schedule a session</p>
                    </div>

                    <h3>System Updates</h3>
                    <div class="info-box">
                        <strong>Stay Informed:</strong>
                        <p>Subscribe to system update notifications:</p>
                        <ul>
                            <li>New feature announcements</li>
                            <li>Scheduled maintenance alerts</li>
                            <li>Security updates</li>
                            <li>Bug fixes and improvements</li>
                        </ul>
                        <p><strong>Subscribe:</strong> Profile → Notification Preferences</p>
                    </div>

                    <h3>Resources</h3>
                    <div class="step-box">
                        <strong>Additional Resources:</strong>
                        <ul>
                            <li><strong>Video Tutorials:</strong> Available on our YouTube channel</li>
                            <li><strong>User Manual:</strong> Download PDF from Dashboard → Resources</li>
                            <li><strong>Quick Reference Guide:</strong> Available for print</li>
                            <li><strong>Knowledge Base:</strong> searchable articles and guides</li>
                        </ul>
                    </div>

                    <button class="back-btn" onclick="window.location.href='Dashboard.jsp'">
                        ← Back to Dashboard
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Show specific help topic
        function showTopic(topicId) {
            // Hide all topics
            const topics = document.querySelectorAll('.help-topic');
            topics.forEach(topic => {
                topic.classList.remove('active');
            });

            // Remove active class from all menu items
            const menuItems = document.querySelectorAll('.menu-item');
            menuItems.forEach(item => {
                item.classList.remove('active');
            });

            // Show selected topic
            const selectedTopic = document.getElementById(topicId);
            if (selectedTopic) {
                selectedTopic.classList.add('active');
            }

            // Add active class to clicked menu item
            event.target.closest('.menu-item').classList.add('active');

            // Scroll to top of content area
            document.querySelector('.content-area').scrollTop = 0;
        }

        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const menuItems = document.querySelectorAll('.menu-item');

            menuItems.forEach(item => {
                const text = item.textContent.toLowerCase();
                if (text.includes(searchTerm)) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });

            // If search is empty, show all items
            if (searchTerm === '') {
                menuItems.forEach(item => {
                    item.style.display = 'flex';
                });
            }
        });

        // Keyboard navigation
        document.addEventListener('keydown', function(e) {
            // Escape key - go back to dashboard
            if (e.key === 'Escape') {
                window.location.href = 'Dashboard.jsp';
            }

            // Ctrl + F - Focus search box
            if (e.ctrlKey && e.key === 'f') {
                e.preventDefault();
                document.getElementById('searchInput').focus();
            }
        });

        // Print functionality for help topics
        function printHelpTopic() {
            window.print();
        }

        // Add keyboard shortcut info to first load
        window.addEventListener('load', function() {
            console.log('Keyboard Shortcuts:');
            console.log('- Escape: Return to Dashboard');
            console.log('- Ctrl+F: Search Help Topics');
        });

        // Track which topics are most viewed (analytics)
        function trackTopicView(topicId) {
            // This would send analytics data to server
            console.log('Topic viewed: ' + topicId);
            // In production: send to analytics endpoint
        }

        // Enhanced search with highlighting
        function highlightSearchResults(searchTerm) {
            const contentArea = document.querySelector('.content-area');
            const content = contentArea.innerHTML;
            
            if (searchTerm.length > 2) {
                const regex = new RegExp(searchTerm, 'gi');
                const highlightedContent = content.replace(regex, 
                    '<mark style="background-color: yellow;">$&</mark>');
                contentArea.innerHTML = highlightedContent;
            }
        }

        // Auto-save scroll position
        const contentArea = document.querySelector('.content-area');
        contentArea.addEventListener('scroll', function() {
            sessionStorage.setItem('helpScrollPosition', contentArea.scrollTop);
        });

        // Restore scroll position
        window.addEventListener('load', function() {
            const scrollPos = sessionStorage.getItem('helpScrollPosition');
            if (scrollPos) {
                contentArea.scrollTop = parseInt(scrollPos);
            }
        });
    </script>
</body>
</html>