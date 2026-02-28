<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill #1001 - Ocean View Resort</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container { max-width: 900px; margin: 0 auto; }

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

        .btn-print { background: white; color: #667eea; }
        .btn-print:hover { background: #f3f4f6; transform: translateY(-2px); }

        .btn-payment {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
        }
        .btn-payment:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(16,185,129,0.4); }

        .btn-back { background: rgba(255,255,255,0.9); color: #667eea; }
        .btn-back:hover { background: white; }

        .bill-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
        }

        .bill-header {
            background: linear-gradient(135deg, #2a5298 0%, #1e3a6f 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }

        .resort-name { font-size: 32px; font-weight: 700; margin-bottom: 5px; }
        .resort-tagline { font-size: 16px; opacity: 0.9; margin-bottom: 10px; }
        .resort-address { font-size: 14px; opacity: 0.8; }

        .bill-content { padding: 40px; }

        .bill-title { text-align: center; margin-bottom: 30px; }
        .bill-title h1 { color: #2a5298; font-size: 36px; margin-bottom: 10px; }
        .bill-number { color: #6b7280; font-size: 18px; }

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

        .info-item { margin-bottom: 12px; }
        .info-label { color: #6b7280; font-size: 14px; margin-bottom: 4px; }
        .info-value { color: #1f2937; font-size: 16px; font-weight: 600; }

        .bill-table { width: 100%; margin-bottom: 30px; border-collapse: collapse; }
        .bill-table thead { background: #f3f4f6; }
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
        .bill-table tr:last-child td { border-bottom: none; }
        .amount { text-align: right; font-weight: 600; }

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
        .summary-row:last-child { border-bottom: none; }
        .summary-label { color: #6b7280; font-size: 15px; }
        .summary-value { color: #1f2937; font-weight: 600; font-size: 15px; }

        .summary-total {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 3px double #d1d5db;
        }
        .summary-total .summary-label { color: #1f2937; font-size: 20px; font-weight: 700; }
        .summary-total .summary-value { color: #2a5298; font-size: 24px; font-weight: 700; }

        .payment-status {
            text-align: center;
            padding: 20px;
            margin: 30px 0;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 600;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
            border: 2px solid #f59e0b;
        }

        .status-paid {
            background: #d1fae5;
            color: #065f46;
            border: 2px solid #10b981;
        }

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

        .footer-thanks { color: #2a5298; font-size: 18px; font-weight: 600; }

        /* Payment Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-box {
            background: white;
            padding: 40px;
            border-radius: 20px;
            max-width: 500px;
            width: 90%;
        }

        .modal-box h2 { color: #2a5298; margin-bottom: 20px; }

        .form-group { margin-bottom: 20px; }
        .form-label {
            display: block;
            color: #374151;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 15px;
        }

        .form-control-lg { font-size: 18px; font-weight: 700; color: #2a5298; }

        .modal-actions { display: flex; gap: 10px; }

        .btn-confirm {
            flex: 1; padding: 14px;
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white; border: none;
            border-radius: 12px; font-size: 16px;
            font-weight: 600; cursor: pointer;
        }

        .btn-cancel {
            flex: 1; padding: 14px;
            background: #6c757d; color: white;
            border: none; border-radius: 12px;
            font-size: 16px; font-weight: 600; cursor: pointer;
        }

        @media print {
            body { background: white; padding: 0; }
            .action-bar { display: none !important; }
            .container { max-width: 100%; }
            .bill-container { box-shadow: none; border-radius: 0; }
        }

        @media (max-width: 768px) {
            .info-grid { grid-template-columns: 1fr; gap: 20px; }
            .action-bar { flex-direction: column; }
            .btn { width: 100%; justify-content: center; }
            .bill-content { padding: 25px; }
        }
    </style>
</head>
<body>
<div class="container">

    <!-- Action Bar -->
    <div class="action-bar">
        <a href="#" class="btn btn-back">&larr; Back to Dashboard</a>
        <div style="display:flex; gap:10px; flex-wrap:wrap;">
            <button onclick="window.print()" class="btn btn-print">Print Bill</button>
            <button onclick="document.getElementById('paymentModal').style.display='flex'" class="btn btn-payment">Process Payment</button>
        </div>
    </div>

    <!-- Bill Container -->
    <div class="bill-container">

        <!-- Header -->
        <div class="bill-header">
            <div class="resort-name">OCEAN VIEW RESORT</div>
            <div class="resort-tagline">Your Paradise by the Sea</div>
            <div class="resort-address">Beach Road, Galle, Sri Lanka &nbsp;|&nbsp; Tel: +94 91 123 4567 &nbsp;|&nbsp; Email: info@oceanview.lk</div>
        </div>

        <!-- Bill Content -->
        <div class="bill-content">

            <div class="bill-title">
                <h1>INVOICE</h1>
                <div class="bill-number">Bill #01001</div>
            </div>

            <!-- Info Grid -->
            <div class="info-grid">
                <div class="info-section">
                    <h3>Guest Information</h3>
                    <div class="info-item">
                        <div class="info-label">Guest Name</div>
                        <div class="info-value">Tharsh</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Contact Number</div>
                        <div class="info-value">0771234567</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Email</div>
                        <div class="info-value">Tharsh@email.com</div>
                    </div>
                </div>

                <div class="info-section">
                    <h3>Billing Information</h3>
                    <div class="info-item">
                        <div class="info-label">Reservation ID</div>
                        <div class="info-value">RES1001</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Bill Generated</div>
                        <div class="info-value">27 feb 2026, 10:30 AM</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Generated By</div>
                        <div class="info-value">Admin</div>
                    </div>
                </div>
            </div>

            <!-- Stay Details Table -->
            <table class="bill-table">
                <thead>
                    <tr>
                        <th>Description</th>
                        <th>Details</th>
                        <th style="text-align:right;">Amount (LKR)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Room Charges</strong></td>
                        <td>
                            Deluxe Room<br>
                            <small style="color:#6b7280;">
                                Check-in: 05 Mar 2026<br>
                                Check-out: 08 Mar 2026<br>
                                3 night(s) x LKR 15,000.00
                            </small>
                        </td>
                        <td class="amount">45,000.00</td>
                    </tr>
                    <tr>
                        <td><strong>Tax (VAT 12%)</strong></td>
                        <td><small style="color:#6b7280;">Government tax on room charges</small></td>
                        <td class="amount">5,400.00</td>
                    </tr>
                    <tr>
                        <td><strong>Service Charge (10%)</strong></td>
                        <td><small style="color:#6b7280;">Service and amenities</small></td>
                        <td class="amount">4,500.00</td>
                    </tr>
                </tbody>
            </table>

            <!-- Summary -->
            <div class="bill-summary">
                <div class="summary-row">
                    <span class="summary-label">Subtotal</span>
                    <span class="summary-value">LKR 45,000.00</span>
                </div>
                <div class="summary-row">
                    <span class="summary-label">Tax &amp; Service Charge</span>
                    <span class="summary-value">LKR 9,900.00</span>
                </div>
                <div class="summary-row summary-total">
                    <span class="summary-label">Total Amount</span>
                    <span class="summary-value">LKR 54,900.00</span>
                </div>
            </div>

            <!-- Payment Status -->
            <div class="payment-status status-pending">
                PAYMENT PENDING
            </div>

            <!-- Footer -->
            <div class="bill-footer">
                <div class="footer-notes">
                    This is a computer-generated invoice. No signature required.<br>
                    For queries, please contact our reception at +94 91 123 4567
                </div>
                <div class="footer-thanks">Thank you for staying with us! We hope to see you again soon.</div>
            </div>

        </div>
    </div>
</div>

<!-- Payment Modal -->
<div id="paymentModal" class="modal">
    <div class="modal-box">
        <h2>Process Payment</h2>
        <div class="form-group">
            <label class="form-label">Payment Amount</label>
            <input type="text" value="LKR 54,900.00" readonly class="form-control form-control-lg">
        </div>
        <div class="form-group">
            <label class="form-label">Payment Method</label>
            <select class="form-control">
                <option>Cash</option>
                <option>Credit Card</option>
                <option>Debit Card</option>
                <option>Bank Transfer</option>
                <option>Mobile Payment</option>
            </select>
        </div>
        <div class="modal-actions">
            <button class="btn-confirm" onclick="confirmPayment()">Confirm Payment</button>
            <button class="btn-cancel" onclick="document.getElementById('paymentModal').style.display='none'">Cancel</button>
        </div>
    </div>
</div>

<script>
    // Close modal on outside click
    document.getElementById('paymentModal').addEventListener('click', function(e) {
        if (e.target === this) this.style.display = 'none';
    });

    function confirmPayment() {
        document.querySelector('.payment-status').className = 'payment-status status-paid';
        document.querySelector('.payment-status').textContent = 'PAID - Cash';
        document.getElementById('paymentModal').style.display = 'none';
        document.querySelector('.btn-payment').style.display = 'none';
    }
</script>
</body>
</html>