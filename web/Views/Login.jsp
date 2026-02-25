<%-- 
    Document   : Login
    Created on : 14 Jan 2026, 11:40:23
    Author     : tharsi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort - Login</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }

        .login-container {
            display: flex;
            max-width: 900px;
            width: 100%;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        }

        /* Left side branding */
        .login-left {
            flex: 1;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-left h1 { font-size: 2.5em; margin-bottom: 20px; text-shadow: 2px 2px 4px rgba(0,0,0,0.3); }
        .login-left .subtitle { font-size: 1.2em; margin-bottom: 30px; opacity: 0.9; }

        .feature-list { list-style: none; margin-top: 20px; }
        .feature-list li {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.05em;
            padding: 10px 0;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }
        .feature-list li:last-child { border-bottom: none; }
        .feature-list .icon { font-size: 1.3em; }

        /* Right side form */
        .login-right {
            flex: 1;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header { text-align: center; margin-bottom: 30px; }
        .login-header h2 { color: #2a5298; font-size: 2em; margin-bottom: 10px; }
        .login-header p { color: #6c757d; font-size: 0.95em; }

        .form-group { margin-bottom: 20px; position: relative; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: 500; color: #495057; }
        .input-wrapper { position: relative; }
        .input-icon { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); font-size: 1.2em; color: #667eea; }
        .form-control { width: 100%; padding: 12px 12px 12px 40px; border-radius: 10px; border: 2px solid #dee2e6; outline: none; transition: 0.3s; }
        .form-control:focus { border-color: #667eea; box-shadow: 0 0 0 3px rgba(102,126,234,0.1); }

        .password-toggle { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #6c757d; }

        .error-message { color: #dc3545; font-size: 0.85em; margin-top: 5px; }

        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-login:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(102,126,234,0.4); }

        .form-options { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; font-size: 0.9em; }
        .remember-me { display: flex; align-items: center; gap: 8px; cursor: pointer; }
       

        /* Responsive */
        @media(max-width: 768px) {
            .login-container { flex-direction: column; }
            .login-left, .login-right { padding: 30px 20px; }
        }
    </style>
    
    
    
    
    <script>
        
        function togglePassword() {
            const pwd = document.getElementById('password');
            pwd.type = pwd.type === 'password' ? 'text' : 'password';
        }
        
       
    window.addEventListener('DOMContentLoaded', (event) => {
        const errorMsg = document.querySelector('.error-message');
        if(errorMsg) {
            errorMsg.style.display = 'block';
            setTimeout(() => {
                errorMsg.style.transition = 'opacity 0.8s ease';
                errorMsg.style.opacity = '0';
                
                setTimeout(() => { errorMsg.style.display = 'none'; }, 800);
            }, 5000); 
        }
    });


    </script>
    
</head>





<body>
    
    <div class="login-container">
        <!-- Left side branding -->
        <div class="login-left">
            <h1>🏖️ Ocean View Resort</h1>
            <p class="subtitle">Advanced Reservation Management System</p>
            <ul class="feature-list">
                <li><span class="icon">✓</span> <span>Secure User Authentication</span></li>
                <li><span class="icon">✓</span> <span>Real-time Room Availability</span></li>
                <li><span class="icon">✓</span> <span>Automated Billing System</span></li>
                <li><span class="icon">✓</span> <span>Guest Management</span></li>
                <li><span class="icon">✓</span> <span>Comprehensive Reporting</span></li>
            </ul>
        </div>

        <!-- login form -->
        <div class="login-right">
            <div class="login-header">
                <h2>Welcome Back!</h2>
                <p>Please login to access your dashboard</p>
            </div>

            <form id="loginForm" method="post" action="LoginServlet">
                <div class="form-group">
                    <label for="username">Username</label>
                    <div class="input-wrapper">
                        <span class="input-icon">👤</span>
                        <input type="text" id="username" name="username" class="form-control" placeholder="Enter username">
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-wrapper">
                        <span class="input-icon">🔒</span>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Enter password">
                        <span class="password-toggle" onclick="togglePassword()">👁️</span>
                    </div>
                </div>

                <!-- Error message -->
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>



                <button type="submit" class="btn-login">Login</button>
            </form>
        </div>
    </div>
                
</body>

</html>
