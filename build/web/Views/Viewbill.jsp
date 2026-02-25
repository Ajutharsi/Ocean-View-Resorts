<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Bill"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>

<%
    Bill bill = (Bill) request.getAttribute("bill");
    if (bill == null) {
        response.sendRedirect("GenerateBill.jsp");
        return;
    }
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMM yyyy");
    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
    DecimalFormat currencyFormat = new DecimalFormat("#,##0.00");
    
    boolean isPaid = "true".equals(request.getParameter("paid"));
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill #<%= bill.getBillId() %> - Ocean View Resort</title>
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
            max-width: 900px;
            margin: 0 auto;
        }

        /* Action Buttons (No Print) */
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 24px;
            border-radius: 10px;
            border: none;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-print {
            background: white;
            color: #667eea;
        }

        .btn-print:hover {
            background: #f3f4f6;
            transform: translateY(-2px);
        }

        .btn-payment {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
        }

        .btn-payment:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.4);
        }

        .btn-back {
            background: rgba(255,255,255,0.9);
            color: #667eea;
        }

        .btn-back:hover {
            background: white;
        }

        /* Bill Container */
        .bill-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        /* Bill Header */
        .bill-header {
            background: linear-gradient(135deg, #2a5298 0%, #1e3a6f 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }

        .resort-logo {
            font-size: 48px;
            margin-bottom: 10px;
        }

        .resort-name {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .resort-tagline {
            font-size: 16px;
            opacity: 0.9;
            margin-bottom: 10px;
        }

        .resort-address {
            font-size: 14px;
            opacity: 0.8;
        }

        /* Bill Content */
        .bill-content {
            padding: 40px;
        }

        .bill-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .bill-title h1 {
            color: #2a5298;
            font-size: 36px;
            margin-bottom: 10px;
        }

        .bill-number {
            color: #6b7280;
            font-size: 18px;
        }

        /* Info Grid */
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
            padding: 25px;
            background: #f9fafb;
            border-radius: 12px;
        }

        .info-section h3 {
            color: #374151;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .info-item {
            margin-bottom: 12px;
        }

        .info-label {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 4px;
        }

        .info-value {
            color: #1f2937;
            font-size: 16px;
            font-weight: 600;
        }

        /* Bill Table */
        .bill-table {
            width: 100%;
            margin-bottom: 30px;
            border-collapse: collapse;
        }

        .bill-table thead {
            background: #f3f4f6;
        }

        .bill-table th {
            padding: 15px;
            text-align: left;
            color: #374151;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .bill-table td {
            padding: 15px;
            border-bottom: 1px solid #e5e7eb;
            color: #4b5563;
        }

        .bill-table tr:last-child td {
            border-bottom: none;
        }

        .amount {
            text-align: right;
            font-weight: 600;
        }

        /* Summary Section */
        .bill-summary {
            margin-top: 30px;
            padding: 25px;
            background: #f9fafb;
            border-radius: 12px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .summary-row:last-child {
            border-bottom: none;
        }

        .summary-label {
            color: #6b7280;
            font-size: 15px;
        }

        .summary-value {
            color: #1f2937;
            font-weight: 600;
            font-size: 15px;
        }

        .summary-total {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 3px double #d1d5db;
        }

        .summary-total .summary-label {
            color: #1f2937;
            font-size: 20px;
            font-weight: 700;
        }

        .summary-total .summary-value {
            color: #2a5298;
            font-size: 24px;
            font-weight: 700;
        }

        /* Payment Status */
        .payment-status {
            text-align: center;
            padding: 20px;
            margin: 30px 0;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 600;
        }

        .status-paid {
            background: #d1fae5;
            color: #065f46;
            border: 2px solid #10b981;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
            border: 2px solid #f59e0b;
        }

        /* Footer */
        .bill-footer {
            margin-top: 40px;
            padding-top: 30px;
            border-top: 2px solid #e5e7eb;
            text-align: center;
        }

        .footer-notes {
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 15px;
            line-height: 1.6;
        }

        .footer-thanks {
            color: #2a5298;
            font-size: 18px;
            font-weight: 600;
        }

        /* Success Alert */
        .success-alert {
            background: #d1fae5;
            color: #065f46;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Print Styles */
        @media print {
            body {
                background: white;
                padding: 0;
            }

            .action-bar,
            .btn,
            .success-alert {
                display: none !important;
            }

            .container {
                max-width: 100%;
            }

            .bill-container {
                box-shadow: none;
                border-radius: 0;
            }

            .info-grid {
                break-inside: avoid;
            }

            .bill-summary {
                break-inside: avoid;
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .action-bar {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .bill-content {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Action Bar -->
        <div class="action-bar">
            <a href="Dashboard.jsp" class="btn btn-back">← Back to Dashboard</a>
            <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                <button onclick="window.print()" class="btn btn-print">🖨️ Print Bill</button>
                <% if (!"Paid".equals(bill.getPaymentStatus())) { %>
                    <button onclick="showPaymentModal()" class="btn btn-payment">💳 Process Payment</button>
                <% } %>
            </div>
        </div>

        <% if (isPaid) { %>
            <div class="success-alert">
                <span style="font-size: 24px;">✅</span>
                <span>Payment processed successfully!</span>
            </div>
        <% } %>

        <!-- Bill Container -->
        <div class="bill-container">
            <!-- Bill Header -->
            <div class="bill-header">
                <div class="resort-logo">🏖️</div>
                <div class="resort-name">OCEAN VIEW RESORT</div>
                <div class="resort-tagline">Your Paradise by the Sea</div>
                <div class="resort-address">Beach Road, Galle, Sri Lanka | Tel: +94 91 123 4567 | Email: info@oceanview.lk</div>
            </div>

            <!-- Bill Content -->
            <div class="bill-content">
                <div class="bill-title">
                    <h1>INVOICE</h1>
                    <div class="bill-number">Bill #<%= String.format("%05d", bill.getBillId()) %></div>
                </div>

                <!-- Info Grid -->
                <div class="info-grid">
                    <div class="info-section">
                        <h3>Guest Information</h3>
                        <div class="info-item">
                            <div class="info-label">Guest Name</div>
                            <div class="info-value"><%= bill.getGuestName() %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Contact Number</div>
                            <div class="info-value"><%= bill.getContactNumber() %></div>
                        </div>
                        <% if (bill.getEmail() != null && !bill.getEmail().isEmpty()) { %>
                        <div class="info-item">
                            <div class="info-label">Email</div>
                            <div class="info-value"><%= bill.getEmail() %></div>
                        </div>
                        <% } %>
                    </div>

                    <div class="info-section">
                        <h3>Billing Information</h3>
                        <div class="info-item">
                            <div class="info-label">Reservation ID</div>
                            <div class="info-value">RES<%= String.format("%03d", bill.getReservationId()) %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Bill Generated</div>
                            <div class="info-value"><%= dateTimeFormat.format(bill.getGeneratedDate()) %></div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Generated By</div>
                            <div class="info-value"><%= bill.getGeneratedBy() != null ? bill.getGeneratedBy() : "Admin" %></div>
                        </div>
                    </div>
                </div>

                <!-- Stay Details -->
                <table class="bill-table">
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th>Details</th>
                            <th style="text-align: right;">Amount (LKR)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Room Charges</strong></td>
                            <td>
                                <%= bill.getRoomType() %><br>
                                <small style="color: #6b7280;">
                                    Check-in: <%= dateFormat.format(bill.getCheckIn()) %><br>
                                    Check-out: <%= dateFormat.format(bill.getCheckOut()) %><br>
                                    <%= bill.getNights() %> night(s) × LKR <%= currencyFormat.format(bill.getRatePerNight()) %>
                                </small>
                            </td>
                            <td class="amount"><%= currencyFormat.format(bill.getRoomCharges()) %></td>
                        </tr>
                        
                        <% if (bill.getAdditionalCharges() > 0) { %>
                        <tr>
                            <td><strong>Additional Charges</strong></td>
                            <td>
                                <small style="color: #6b7280;">
                                    <%= bill.getAdditionalChargesDescription() != null && !bill.getAdditionalChargesDescription().isEmpty() 
                                        ? bill.getAdditionalChargesDescription() 
                                        : "Miscellaneous charges" %>
                                </small>
                            </td>
                            <td class="amount"><%= currencyFormat.format(bill.getAdditionalCharges()) %></td>
                        </tr>
                        <% } %>
                        
                        <tr>
                            <td><strong>Tax (VAT 12%)</strong></td>
                            <td><small style="color: #6b7280;">Government tax on room charges</small></td>
                            <td class="amount"><%= currencyFormat.format(bill.getTaxAmount()) %></td>
                        </tr>
                        
                        <tr>
                            <td><strong>Service Charge (10%)</strong></td>
                            <td><small style="color: #6b7280;">Service and amenities</small></td>
                            <td class="amount"><%= currencyFormat.format(bill.getServiceCharge()) %></td>
                        </tr>
                        
                        <% if (bill.getDiscount() > 0) { %>
                        <tr style="color: #10b981;">
                            <td><strong>Discount</strong></td>
                            <td><small>Special offer / Loyalty discount</small></td>
                            <td class="amount">- <%= currencyFormat.format(bill.getDiscount()) %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <!-- Summary -->
                <div class="bill-summary">
                    <div class="summary-row">
                        <span class="summary-label">Subtotal</span>
                        <span class="summary-value">LKR <%= currencyFormat.format(bill.getSubTotal()) %></span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Tax & Service Charge</span>
                        <span class="summary-value">LKR <%= currencyFormat.format(bill.getTaxAndServiceCharge()) %></span>
                    </div>
                    <% if (bill.getDiscount() > 0) { %>
                    <div class="summary-row">
                        <span class="summary-label">Discount</span>
                        <span class="summary-value" style="color: #10b981;">- LKR <%= currencyFormat.format(bill.getDiscount()) %></span>
                    </div>
                    <% } %>
                    <div class="summary-row summary-total">
                        <span class="summary-label">Total Amount</span>
                        <span class="summary-value">LKR <%= currencyFormat.format(bill.getTotalAmount()) %></span>
                    </div>
                </div>

                <!-- Payment Status -->
                <div class="payment-status <%= "Paid".equals(bill.getPaymentStatus()) ? "status-paid" : "status-pending" %>">
                    <% if ("Paid".equals(bill.getPaymentStatus())) { %>
                        ✅ PAID - <%= bill.getPaymentMethod() != null ? bill.getPaymentMethod() : "N/A" %>
                    <% } else { %>
                        ⏳ PAYMENT PENDING
                    <% } %>
                </div>

                <!-- Footer -->
                <div class="bill-footer">
                    <div class="footer-notes">
                        This is a computer-generated invoice. No signature required.<br>
                        For queries, please contact our reception at +94 91 123 4567
                    </div>
                    <div class="footer-thanks">
                        Thank you for staying with us! We hope to see you again soon! 🌊
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Payment Modal -->
    <div id="paymentModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000; align-items: center; justify-content: center;">
        <div style="background: white; padding: 40px; border-radius: 20px; max-width: 500px; width: 90%;">
            <h2 style="color: #2a5298; margin-bottom: 20px;">Process Payment</h2>
            <form method="post" action="<%=request.getContextPath()%>/GenerateBill">
                <input type="hidden" name="action" value="payment">
                <input type="hidden" name="billId" value="<%= bill.getBillId() %>">
                
                <div style="margin-bottom: 20px;">
                    <label style="display: block; color: #374151; font-weight: 600; margin-bottom: 8px;">Payment Amount</label>
                    <input type="text" 
                           value="LKR <%= currencyFormat.format(bill.getTotalAmount()) %>" 
                           readonly 
                           style="width: 100%; padding: 12px; border: 2px solid #e5e7eb; border-radius: 10px; font-size: 18px; font-weight: 700; color: #2a5298;">
                </div>
                
                <div style="margin-bottom: 25px;">
                    <label style="display: block; color: #374151; font-weight: 600; margin-bottom: 8px;">Payment Method</label>
                    <select name="paymentMethod" 
                            required
                            style="width: 100%; padding: 12px; border: 2px solid #e5e7eb; border-radius: 10px; font-size: 15px;">
                        <option value="Cash">💵 Cash</option>
                        <option value="Credit Card">💳 Credit Card</option>
                        <option value="Debit Card">💳 Debit Card</option>
                        <option value="Bank Transfer">🏦 Bank Transfer</option>
                        <option value="Mobile Payment">📱 Mobile Payment</option>
                    </select>
                </div>
                
                <div style="display: flex; gap: 10px;">
                    <button type="submit" 
                            style="flex: 1; padding: 14px; background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white; border: none; border-radius: 12px; font-size: 16px; font-weight: 600; cursor: pointer;">
                        ✓ Confirm Payment
                    </button>
                    <button type="button" 
                            onclick="hidePaymentModal()"
                            style="flex: 1; padding: 14px; background: #6c757d; color: white; border: none; border-radius: 12px; font-size: 16px; font-weight: 600; cursor: pointer;">
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function showPaymentModal() {
            document.getElementById('paymentModal').style.display = 'flex';
        }

        function hidePaymentModal() {
            document.getElementById('paymentModal').style.display = 'none';
        }

        // Close modal on outside click
        document.getElementById('paymentModal').addEventListener('click', function(e) {
            if (e.target === this) {
                hidePaymentModal();
            }
        });

        // Auto-hide success message
        setTimeout(function() {
            const alert = document.querySelector('.success-alert');
            if (alert) {
                alert.style.transition = 'opacity 0.3s ease';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 300);
            }
        }, 5000);
    </script>
</body>
</html>
