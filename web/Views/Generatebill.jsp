<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Reservation"%>
<%@page import="Service.ReservationService"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Bill - Ocean View Resort</title>

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container { max-width: 900px; margin: 0 auto; }

        .page-header {
            background: linear-gradient(135deg, #7c8ff6 0%, #9370db 100%);
            padding: 30px 40px;
            border-radius: 20px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
            color: white;
        }

        .page-header h1 { font-size: 32px; margin-bottom: 10px; }
        .page-header p { opacity: 0.9; font-size: 16px; }

        .card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            margin-bottom: 20px;
        }

        .card-title {
            color: #2a5298;
            font-size: 24px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group { margin-bottom: 25px; }

        .form-group label {
            display: block;
            color: #374151;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            font-size: 15px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .btn {
            padding: 14px 30px;
            border-radius: 12px;
            border: none;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-secondary { background: #6c757d; color: white; }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }

        .alert-error {
            background: #fee2e2;
            color: #991b1b;
        }

        .info-box {
            background: #f0f9ff;
            border-left: 4px solid #3b82f6;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .reservation-preview {
            display: none;
            background: #f9fafb;
            padding: 20px;
            border-radius: 12px;
            margin-top: 20px;
            border: 2px dashed #d1d5db;
        }

        .reservation-preview.show { display: block; }

        .preview-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .preview-label { color: #6b7280; }
        .preview-value { font-weight: 600; }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 10px;
            background: rgba(255,255,255,0.2);
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .form-row { grid-template-columns: 1fr; }
            .button-group { flex-direction: column; }
        }
    </style>
</head>

<body>
<div class="container">

    <a href="Dashboard.jsp" class="back-btn">← Back to Dashboard</a>

    <div class="page-header">
        <h1>💳 Generate Bill</h1>
        <p>Create a billing invoice for guest checkout</p>
    </div>

    <% String error = (String) request.getAttribute("error");
       if (error != null) { %>
        <div class="alert alert-error">
            ❌ <%= error %>
        </div>
    <% } %>

    <div class="card">
        <h2 class="card-title">📋 Bill Information</h2>

        <div class="info-box">
            <ul>
                <li>Tax (VAT): 12%</li>
                <li>Service Charge: 10%</li>
                <li>Extras allowed</li>
            </ul>
        </div>

        <form method="post" action="<%=request.getContextPath()%>/GenerateBill" id="billForm">
            <input type="hidden" name="action" value="generate">

            <div class="form-group">
                <label>Reservation ID *</label>
                <input type="number"
                       class="form-control"
                       id="reservationId"
                       name="reservationId"
                       required
                       onchange="previewReservation()">
            </div>

            <div id="reservationPreview" class="reservation-preview">
                <h4>Reservation Details Preview</h4>
                <div id="previewContent"></div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Discount (LKR)</label>
                    <input type="number" class="form-control" name="discount" value="0">
                </div>

                <div class="form-group">
                    <label>Additional Charges (LKR)</label>
                    <input type="number" class="form-control" name="additionalCharges" value="0">
                </div>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-primary">Generate Bill</button>
                <button type="reset" class="btn btn-secondary">Reset</button>
            </div>
        </form>
    </div>
</div>

<script>
    function previewReservation() {
        const resId = document.getElementById('reservationId').value;

        if (resId && resId > 0) {
            document.getElementById('reservationPreview').classList.add('show');

            document.getElementById('previewContent').innerHTML = `
                <div class="preview-item">
                    <span class="preview-label">Reservation ID:</span>
                    <span class="preview-value">RES\${String(resId).padStart(3, '0')}</span>
                </div>
                <div class="preview-item">
                    <span class="preview-label">Status:</span>
                    <span class="preview-value" style="color:green;">Ready for billing</span>
                </div>
            `;
        } else {
            document.getElementById('reservationPreview').classList.remove('show');
        }
    }
</script>

</body>
</html>
