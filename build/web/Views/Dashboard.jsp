<%-- 
    Document   : Dashboard
    Created on : 14 Jan 2026, 11:44:07
    Author     : Oyslans
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort - Dashboard</title>
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
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header-left h1 {
            font-size: 1.8em;
            font-weight: 600;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 15px;
            background: rgba(255,255,255,0.1);
            border-radius: 25px;
        }

        .user-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: #667eea;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2em;
        }

        .logout-btn {
            padding: 10px 25px;
            background: rgba(255,255,255,0.2);
            border: 2px solid white;
            color: white;
            border-radius: 25px;
            cursor: pointer;
            font-size: 0.95em;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .logout-btn:hover {
            background: white;
            color: #2a5298;
        }

        /* Main Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px 40px;
        }

        /* Welcome Section */
        .welcome-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .welcome-section h2 {
            font-size: 2.2em;
            margin-bottom: 10px;
        }

        .welcome-section p {
            font-size: 1.1em;
            opacity: 0.9;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .stat-info h3 {
            color: #6c757d;
            font-size: 0.9em;
            margin-bottom: 8px;
            text-transform: uppercase;
            font-weight: 500;
        }

        .stat-info .stat-number {
            font-size: 2em;
            font-weight: 700;
            color: #2a5298;
        }

        .stat-icon {
            font-size: 3em;
            opacity: 0.3;
        }

        /* Quick Actions Section */
        .section-title {
            font-size: 1.8em;
            color: #2a5298;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .action-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .action-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            border-color: #667eea;
        }

        .action-icon {
            font-size: 3em;
            margin-bottom: 15px;
            display: block;
        }

        .action-card h3 {
            font-size: 1.4em;
            color: #2a5298;
            margin-bottom: 10px;
        }

        .action-card p {
            color: #6c757d;
            line-height: 1.6;
            font-size: 0.95em;
        }

        /* Recent Activity */
        .activity-section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .activity-item {
            padding: 15px;
            border-left: 4px solid #667eea;
            background: #f8f9fa;
            margin-bottom: 15px;
            border-radius: 5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .activity-item:last-child {
            margin-bottom: 0;
        }

        .activity-info h4 {
            color: #2a5298;
            margin-bottom: 5px;
            font-size: 1.05em;
        }

        .activity-info p {
            color: #6c757d;
            font-size: 0.9em;
        }

        .activity-time {
            color: #6c757d;
            font-size: 0.85em;
            white-space: nowrap;
        }

        /* Footer */
        .footer {
            background: white;
            padding: 20px;
            text-align: center;
            color: #6c757d;
            border-top: 1px solid #dee2e6;
            margin-top: 40px;
        }

        /* Notification Badge */
        .notification-badge {
            position: relative;
            cursor: pointer;
        }

        .notification-badge .badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #dc3545;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75em;
            font-weight: bold;
        }

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal.show {
            display: flex;
        }

        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 15px;
            max-width: 500px;
            width: 90%;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: slideUp 0.3s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-header h3 {
            color: #2a5298;
            font-size: 1.5em;
        }

        .close-btn {
            font-size: 1.5em;
            cursor: pointer;
            color: #6c757d;
            background: none;
            border: none;
            padding: 5px 10px;
        }

        .close-btn:hover {
            color: #dc3545;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                padding: 20px;
            }

            .header-right {
                width: 100%;
                justify-content: space-between;
            }

            .container {
                padding: 20px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .action-grid {
                grid-template-columns: 1fr;
            }

            .welcome-section h2 {
                font-size: 1.6em;
            }
        }

        /* Loading Animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(102, 126, 234, 0.3);
            border-top-color: #667eea;
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Color Classes */
        .color-blue { color: #667eea; }
        .color-green { color: #28a745; }
        .color-orange { color: #fd7e14; }
        .color-red { color: #dc3545; }
        .color-purple { color: #764ba2; }
        .color-teal { color: #20c997; }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-left">
            <h1>🏖️ Ocean View Resort</h1>
        </div>
        <div class="header-right">
            <div class="notification-badge" onclick="showNotifications()">
                <span style="font-size: 1.5em; cursor: pointer;">🔔</span>
                <span class="badge" id="notificationCount">3</span>
            </div>
            <div class="user-info">
                <div class="user-avatar">👤</div>
                <div>
                    <div style="font-weight: 600;" id="displayUsername">Admin</div>
                    <div style="font-size: 0.85em; opacity: 0.8;" id="displayRole">Administrator</div>
                </div>
            </div>
            
            
       
    
    
            <!-- Logout button (use this in your header) -->
<button type="button" class="logout-btn" onclick="showLogoutModal()">
    🚪 Logout
</button>

<!-- Logout Confirmation Modal -->
<div id="logoutModal" class="modal">
    <div class="modal-content" style="max-width:450px; text-align:center;">
        <div style="font-size:4em; margin-bottom:15px;">👋</div>
        <h2 style="color:#2a5298; margin-bottom:10px; font-size:1.8em;">Confirm Logout</h2>
        <p style="color:#6c757d; margin-bottom:20px; font-size:1.05em;">
            Are you sure you want to exit the Ocean View Resort system?
        </p>
        
        <div style="background:#fff3cd; border-left:4px solid #ffc107; padding:15px; border-radius:8px; margin-bottom:20px; text-align:left;">
            <div style="display:flex; align-items:center; gap:10px; margin:8px 0; color:#856404;">
                <span>⚠️</span> All unsaved changes will be lost
            </div>
            <div style="display:flex; align-items:center; gap:10px; margin:8px 0; color:#856404;">
                <span>🔒</span> Your session will be terminated
            </div>
        </div>
        
        <div style="margin-top:25px; display:flex; justify-content:center; gap:12px;">
            <button class="action-btn btn-edit" onclick="confirmLogout()">
                ✓ Yes, Logout
            </button>
            <button class="action-btn btn-delete" onclick="closeLogoutModal()">
                ✕ Cancel
            </button>
        </div>
    </div>
</div>

<form id="logoutForm" action="<%=request.getContextPath()%>/Logout" method="post" style="display:none;">
</form>

<style>
/* Modal Overlay */
.modal {
    display: none;
    position: fixed;
    z-index: 10000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6);
    backdrop-filter: blur(5px);
    align-items: center;
    justify-content: center;
    animation: fadeIn 0.3s ease;
}

.modal.show {
    display: flex;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

/* Modal Content */
.modal-content {
    background: white;
    padding: 35px;
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
    animation: slideUp 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(50px) scale(0.9);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

/* Action Buttons */
.action-btn {
    padding: 13px 30px;
    border-radius: 25px;
    cursor: pointer;
    border: none;
    font-weight: 600;
    font-size: 1em;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.action-btn:active {
    transform: scale(0.95);
}

/* Yes, Logout Button */
.btn-edit {
    background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
    color: white;
}

.btn-edit:hover {
    background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(220, 53, 69, 0.4);
}

/* Cancel Button */
.btn-delete {
    background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
    color: white;
}

.btn-delete:hover {
    background: linear-gradient(135deg, #5a6268 0%, #495057 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(108, 117, 125, 0.4);
}

/* Main Logout Button */
.logout-btn {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    padding: 12px 28px;
    border-radius: 25px;
    cursor: pointer;
    font-weight: 600;
    font-size: 1em;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.logout-btn:hover {
    background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
}

/* Responsive */
@media (max-width: 768px) {
    .modal-content {
        padding: 25px;
        max-width: 95% !important;
    }
    
    .modal-content > div:last-child {
        flex-direction: column !important;
    }
    
    .action-btn {
        width: 100%;
    }
}
</style>

<script>
function showLogoutModal() {
    document.getElementById('logoutModal').classList.add('show');
    document.body.style.overflow = 'hidden';
}

function closeLogoutModal() {
    document.getElementById('logoutModal').classList.remove('show');
    document.body.style.overflow = '';
}

function confirmLogout() {
    document.getElementById('logoutForm').submit();
}

// Close modal if user clicks outside
window.onclick = function(event) {
    const modal = document.getElementById('logoutModal');
    if (event.target === modal) {
        closeLogoutModal();
    }
}

// ESC key to close
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        const modal = document.getElementById('logoutModal');
        if (modal.classList.contains('show')) {
            closeLogoutModal();
        }
    }
});
</script>
           
        </div>
    </header>

    
    <%
    String msg = request.getParameter("msg");
%>

    <!-- Main Container -->
    <div class="container">
        
        <% if ("success".equals(msg)) { %>
    <div id="successMsg" style="
        background:#d4edda;
        color:#155724;
        padding:15px;
        border-radius:8px;
        margin-bottom:20px;
        border:1px solid #c3e6cb;
    ">
        ✅ Reservation added successfully!
    </div>
<% } %>

        
        <!-- Welcome Section -->
        <div class="welcome-section">
            <h2>Welcome back, <span id="welcomeUsername">Admin</span>! 👋</h2>
            <p>Here's what's happening with your resort today - <span id="currentDate"></span></p>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Total Reservations</h3>
                    <div class="stat-number">156</div>
                </div>
                <div class="stat-icon color-blue">📋</div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>Check-ins Today</h3>
                    <div class="stat-number">12</div>
                </div>
                <div class="stat-icon color-green">✅</div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>Occupied Rooms</h3>
                    <div class="stat-number">45/60</div>
                </div>
                <div class="stat-icon color-orange">🏨</div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>Revenue Today</h3>
                    <div class="stat-number">LKR 2.4M</div>
                </div>
                <div class="stat-icon color-purple">💰</div>
            </div>
        </div>

        <!-- Quick Actions -->
        <h2 class="section-title">⚡ Quick Actions</h2>
        <div class="action-grid">
            <a href="AddReservation.jsp" class="action-card">
                <span class="action-icon color-blue">➕</span>
                <h3>Add New Reservation</h3>
                <p>Create a new booking for guests. Enter guest details, select room type, and confirm dates.</p>
            </a>

            
            
           <a href="<%=request.getContextPath()%>/ViewReservation" class="action-card">

                <span class="action-icon color-green">👁️</span>
                <h3>View Reservations</h3>
                <p>Search and view all reservations. Check booking details, guest information, and status.</p>
            </a>

            <a href="<%=request.getContextPath()%>/GenerateBill" class="action-card">
    <span class="action-icon color-orange">💳</span>
    <h3>Billing & Payments</h3>
    <p>Generate bills, process payments, and print invoices for guest check-outs.</p>
</a>

            <a href="room-management.html" class="action-card">
                <span class="action-icon color-purple">🛏️</span>
                <h3>Room Management</h3>
                <p>Manage room availability, status, and maintenance schedules.</p>
            </a>

            <a href="reports.html" class="action-card">
                <span class="action-icon color-teal">📊</span>
                <h3>Reports & Analytics</h3>
                <p>View occupancy reports, revenue analytics, and guest statistics.</p>
            </a>

            <a href="Help.jsp" class="action-card">
                <span class="action-icon color-red">❓</span>
                <h3>Help Center</h3>
                <p>Access user guides, FAQs, and contact support for assistance.</p>
            </a>
        </div>

        <!-- Recent Activity -->
        <div class="activity-section">
            <h2 class="section-title">📌 Recent Activity</h2>
            
            <div class="activity-item">
                <div class="activity-info">
                    <h4>New Reservation Created - #RES156</h4>
                    <p>Guest: John Doe | Room: Deluxe Suite | Check-in: 20/01/2026</p>
                </div>
                <div class="activity-time">5 minutes ago</div>
            </div>

            <div class="activity-item">
                <div class="activity-info">
                    <h4>Payment Received - #RES145</h4>
                    <p>Amount: LKR 45,000 | Payment Method: Credit Card</p>
                </div>
                <div class="activity-time">15 minutes ago</div>
            </div>

            <div class="activity-item">
                <div class="activity-info">
                    <h4>Guest Check-out - #RES132</h4>
                    <p>Guest: Sarah Williams | Room: Standard Room | Status: Completed</p>
                </div>
                <div class="activity-time">1 hour ago</div>
            </div>

            <div class="activity-item">
                <div class="activity-info">
                    <h4>Room Maintenance - Room 305</h4>
                    <p>Status: Completed | Type: Routine Cleaning | Next: 25/01/2026</p>
                </div>
                <div class="activity-time">2 hours ago</div>
            </div>

            <div class="activity-item">
                <div class="activity-info">
                    <h4>Reservation Modified - #RES150</h4>
                    <p>Guest extended stay by 2 nights | New checkout: 22/01/2026</p>
                </div>
                <div class="activity-time">3 hours ago</div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2026 Ocean View Resort. All rights reserved. | Reservation Management System v1.0</p>
    </footer>

    <!-- Notification Modal -->
    <div id="notificationModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>🔔 Notifications</h3>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <div class="modal-body">
                <div class="activity-item">
                    <div class="activity-info">
                        <h4>🎉 New Booking Confirmed</h4>
                        <p>Reservation #RES156 has been confirmed</p>
                    </div>
                    <div class="activity-time">New</div>
                </div>
                <div class="activity-item">
                    <div class="activity-info">
                        <h4>⚠️ Upcoming Check-in</h4>
                        <p>12 guests checking in today</p>
                    </div>
                    <div class="activity-time">New</div>
                </div>
                <div class="activity-item">
                    <div class="activity-info">
                        <h4>💰 Payment Pending</h4>
                        <p>5 reservations with pending payments</p>
                    </div>
                    <div class="activity-time">1h ago</div>
                </div>
            </div>
        </div>
    </div>

    
    
    <script>
        // Check if user is logged in
        window.addEventListener('load', function() {
            const isLoggedIn = sessionStorage.getItem('isLoggedIn');
            const username = sessionStorage.getItem('username');
            const userRole = sessionStorage.getItem('userRole');

         

            // Update user info
            if (username) {
                document.getElementById('displayUsername').textContent = username;
                document.getElementById('welcomeUsername').textContent = username;
            }

            if (userRole) {
                document.getElementById('displayRole').textContent = userRole;
            }

            // Display current date
            displayCurrentDate();

            // Load dashboard data
            loadDashboardData();
        });

        // Display current date
        function displayCurrentDate() {
            const options = { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
            };
            const today = new Date();
            document.getElementById('currentDate').textContent = today.toLocaleDateString('en-US', options);
        }

        // Load dashboard data
        function loadDashboardData() {
            // In real application, fetch data from backend API
            // fetch('/api/dashboard/stats')
            //     .then(response => response.json())
            //     .then(data => updateStats(data));

            // For now, using static data
            console.log('Dashboard data loaded successfully');
        }

  
       
        // Show notifications
        function showNotifications() {
            document.getElementById('notificationModal').classList.add('show');
            // Reset notification count
            document.getElementById('notificationCount').textContent = '0';
        }

        // Close modal
        function closeModal() {
            document.getElementById('notificationModal').classList.remove('show');
        }

        // Close modal when clicking outside
        window.addEventListener('click', function(e) {
            const modal = document.getElementById('notificationModal');
            if (e.target === modal) {
                closeModal();
            }
        });

        // Session timeout warning
        let sessionTimeout;
        let warningTimeout;

        function resetSessionTimeout() {
            clearTimeout(sessionTimeout);
            clearTimeout(warningTimeout);

            // Warning after 25 minutes
            warningTimeout = setTimeout(() => {
                alert('Your session will expire in 5 minutes due to inactivity.');
            }, 25 * 60 * 1000);

            // Logout after 30 minutes
            sessionTimeout = setTimeout(() => {
                alert('Your session has expired. Please login again.');
                sessionStorage.clear();
                window.location.href = 'login.html';
            }, 30 * 60 * 1000);
        }

        // Reset timeout on user activity
        ['mousedown', 'keydown', 'scroll', 'touchstart'].forEach(event => {
            document.addEventListener(event, resetSessionTimeout);
        });

        // Initialize session timeout
        resetSessionTimeout();

        // Update stats in real-time (demo)
        function updateStats() {
            // This function can be called periodically to update stats
            // setInterval(updateStats, 30000); // Update every 30 seconds
        }

       
        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Alt + H for Help
            if (e.altKey && e.key === 'h') {
                window.location.href = 'help.html';
            }
            // Alt + L for Logout
            if (e.altKey && e.key === 'l') {
                logout();
            }
            // Alt + N for Notifications
            if (e.altKey && e.key === 'n') {
                showNotifications();
            }
        });

        // Display welcome message on first login
        const isFirstLogin = sessionStorage.getItem('isFirstLogin');
        if (isFirstLogin === 'true') {
            setTimeout(() => {
                alert('Welcome to Ocean View Resort Dashboard!\n\nYou can now manage reservations, billing, and more.\n\nNeed help? Click on Help Center or press Alt+H');
                sessionStorage.removeItem('isFirstLogin');
            }, 1000);
        }

        // Auto-refresh dashboard data every 5 minutes
        setInterval(() => {
            loadDashboardData();
            console.log('Dashboard data refreshed at:', new Date().toLocaleTimeString());
        }, 5 * 60 * 1000);
    </script>
    
    <script>
    setTimeout(() => {
        const alert = document.getElementById("successMsg");
        if (alert) alert.style.display = "none";
    }, 4000);
</script>

</body>
</html>