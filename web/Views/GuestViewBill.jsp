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

        .bill-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }

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

        .pending { background: #fff3cd; color: #856404; }
        .paid    { background: #d4edda; color: #155724; }

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

        .charges-table { width: 100%; border-collapse: collapse; }

        .charges-table tr td {
            padding: 12px 0;
            border-bottom: 1px dashed #f0f0f0;
        }

        .charges-table tr:last-child td { border-bottom: none; }
        .charges-table .label { color: #555; }
        .charges-table .amount { text-align: right; font-weight: 500; color: #333; }

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

        .payment-section {
            padding: 20px 40px;
            background: #f8f9fa;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .payment-method { display: flex; align-items: center; gap: 10px; color: #555; }

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

        .back-btn-bottom:hover { background: #667eea; color: white; }

        @media print {
            .header, .actions { display: none !important; }
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

<!-- Header -->
<header class="header">
    <h1>Ocean View Resort</h1>
    <div class="header-right">
        <a href="#" class="btn-outline">&larr; My Reservations</a>
        <a href="#" class="btn-outline">Logout</a>
    </div>
</header>

<div class="container">
    <div class="bill-card">

        <!-- Bill Header -->
        <div class="bill-header">
            <div class="resort-name">OCEAN VIEW RESORT</div>
            <div class="resort-address">Beach Road, Galle, Sri Lanka &nbsp;|&nbsp; +94 91 234 5678</div>
            <div class="bill-number">Invoice #BILL-1001</div>
        </div>

        <!-- Status -->
        <div class="status-section">
            <div>
                <span style="color:#888; font-size:0.9em;">Reservation ID: </span>
                <strong>#RES-1001</strong>
            </div>
            <span class="status-badge pending">Pending</span>
        </div>

        <!-- Guest Info -->
        <div class="section">
            <div class="section-title">Guest Information</div>
            <div class="info-grid">
                <div class="info-item">
                    <label>Guest Name</label>
                    <span>Tharsh</span>
                </div>
                <div class="info-item">
                    <label>Contact Number</label>
                    <span>0771234567</span>
                </div>
                <div class="info-item">
                    <label>Email</label>
                    <span>Tharsh@email.com</span>
                </div>
                <div class="info-item">
                    <label>Room Type</label>
                    <span>Deluxe Room</span>
                </div>
            </div>
        </div>

        <!-- Stay Info -->
        <div class="section">
            <div class="section-title">Stay Details</div>
            <div class="info-grid">
                <div class="info-item">
                    <label>Check-in</label>
                    <span>05 Mar 2026</span>
                </div>
                <div class="info-item">
                    <label>Check-out</label>
                    <span>08 Mar 2026</span>
                </div>
                <div class="info-item">
                    <label>Number of Nights</label>
                    <span>3 nights</span>
                </div>
                <div class="info-item">
                    <label>Number of Guests</label>
                    <span>2 guests</span>
                </div>
            </div>
        </div>

        <!-- Charges Breakdown -->
        <div class="section">
            <div class="section-title">Charges Breakdown</div>
            <table class="charges-table">
                <tr>
                    <td class="label">Room Rate (LKR 15,000 x 3 nights)</td>
                    <td class="amount">LKR 45,000.00</td>
                </tr>
                <tr>
                    <td class="label">Tax (10%)</td>
                    <td class="amount">LKR 4,500.00</td>
                </tr>
                <tr>
                    <td class="label">Service Charge (5%)</td>
                    <td class="amount">LKR 2,250.00</td>
                </tr>
            </table>
        </div>

        <!-- Total -->
        <div class="total-section">
            <span class="total-label">Total Amount</span>
            <span class="total-amount">LKR 51,750.00</span>
        </div>

        <!-- Payment Info -->
        <div class="payment-section">
            <div class="payment-method">
                <span>Payment Method: <strong>Pending</strong></span>
            </div>
        </div>

        <!-- Actions -->
        <div class="actions">
            <button class="print-btn" onclick="window.print()">Print Invoice</button>
            <a href="#" class="back-btn-bottom">&larr; Back to Reservations</a>
        </div>

    </div>
</div>

<footer style="background:#2a5298; color:white; text-align:center; padding:18px; font-size:0.9em; margin-top:30px;">
    <p>&copy; 2026 Ocean View Resort. All rights reserved.</p>
</footer>

</body>
</html>