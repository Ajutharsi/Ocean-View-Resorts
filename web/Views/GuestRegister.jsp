<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Guest Register - Ocean View Resort</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            width: 480px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .logo {
            text-align: center;
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        h2 {
            text-align: center;
            color: #2a5298;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            display: block;
            color: #555;
            margin-bottom: 6px;
            font-weight: 500;
            font-size: 0.95em;
        }
        input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1em;
            transition: border 0.3s;
            outline: none;
        }
        input:focus { border-color: #667eea; }
        .btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: all 0.3s;
        }
        .btn:hover { opacity: 0.9; transform: translateY(-2px); }
        .login-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        .login-link a { color: #667eea; text-decoration: none; font-weight: 600; }
        .error {
            background: #ffe0e0;
            color: #c0392b;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 0.95em;
        }
        .success {
            background: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-size: 0.95em;
        }
    </style>
</head>
<body>
<div class="card">
    <div class="logo">🏖️</div>
    <h2>Create Guest Account</h2>

    <% String error = (String) request.getAttribute("error"); %>
    <% String success = (String) request.getAttribute("success"); %>
    <% if (error != null) { %><div class="error">❌ <%= error %></div><% } %>
    <% if (success != null) { %><div class="success">✅ <%= success %></div><% } %>

    <form action="<%=request.getContextPath()%>/GuestRegister" method="post">
        <div class="form-group">
            <label>Full Name *</label>
            <input type="text" name="full_name" placeholder="Enter your full name" required/>
        </div>
        <div class="form-group">
            <label>Email Address *</label>
            <input type="email" name="email" placeholder="Enter your email" required/>
        </div>
        <div class="form-group">
            <label>Password *</label>
            <input type="password" name="password" placeholder="Min 6 characters" required/>
        </div>
        <div class="form-group">
            <label>Confirm Password *</label>
            <input type="password" name="confirm_password" placeholder="Re-enter password" required/>
        </div>
        <div class="form-group">
            <label>Contact Number</label>
            <input type="text" name="contact_number" placeholder="07X XXXXXXX"/>
        </div>
        <div class="form-group">
            <label>Address</label>
            <input type="text" name="address" placeholder="Your address"/>
        </div>
        <button type="submit" class="btn">🚀 Create Account</button>
    </form>

    <div class="login-link">
        Already have an account? <a href="GuestLogin.jsp">Login here</a>
    </div>
</div>
</body>
</html>