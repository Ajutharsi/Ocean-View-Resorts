<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Guest Login - Ocean View Resort</title>
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
            width: 420px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }
        .logo { text-align:center; font-size:3em; margin-bottom:10px; }
        h2 { text-align:center; color:#2a5298; margin-bottom:5px; }
        .subtitle { text-align:center; color:#888; margin-bottom:25px; font-size:0.95em; }
        .form-group { margin-bottom:18px; }
        label { display:block; color:#555; margin-bottom:6px; font-weight:500; }
        input {
            width:100%; padding:12px 15px;
            border:2px solid #e0e0e0; border-radius:10px;
            font-size:1em; outline:none; transition:border 0.3s;
        }
        input:focus { border-color:#667eea; }
        .btn {
            width:100%; padding:14px;
            background:linear-gradient(135deg, #667eea, #764ba2);
            color:white; border:none; border-radius:10px;
            font-size:1.1em; font-weight:600; cursor:pointer;
            transition:all 0.3s;
        }
        .btn:hover { opacity:0.9; transform:translateY(-2px); }
        .register-link { text-align:center; margin-top:20px; color:#666; }
        .register-link a { color:#667eea; text-decoration:none; font-weight:600; }
        .error {
            background:#ffe0e0; color:#c0392b;
            padding:12px; border-radius:8px; margin-bottom:15px;
        }
        .divider {
            text-align:center; margin:15px 0; color:#aaa; font-size:0.9em;
        }
        .admin-link {
            text-align:center; margin-top:10px;
        }
        .admin-link a {
            color:#aaa; font-size:0.85em; text-decoration:none;
        }
        .admin-link a:hover { color:#667eea; }
    </style>
</head>
<body>
<div class="card">
    <div class="logo">🏖️</div>
    <h2>Ocean View Resort</h2>
    <p class="subtitle">Guest Portal - Sign In</p>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
    <div class="error">❌ <%= error %></div>
    <% } %>

    <form action="<%=request.getContextPath()%>/GuestLogin" method="post">
        <div class="form-group">
            <label>📧 Email Address</label>
            <input type="email" name="email" placeholder="Enter your email" required/>
        </div>
        <div class="form-group">
            <label>🔒 Password</label>
            <input type="password" name="password" placeholder="Enter your password" required/>
        </div>
        <button type="submit" class="btn">🔑 Login</button>
    </form>

    <div class="register-link">
        New guest? <a href="GuestRegister.jsp">Create account</a>
    </div>

    <div class="divider">─────────────────</div>
    <div class="admin-link">
        <a href="<%=request.getContextPath()%>/login.jsp">🔧 Staff Login</a>
    </div>
</div>
</body>
</html>