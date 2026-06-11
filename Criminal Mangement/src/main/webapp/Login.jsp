<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Criminal Management System | Government of India</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', 'Helvetica', sans-serif;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.gov-header {
    background: linear-gradient(90deg, #FF9933 0%, #FF9933 33.33%, #FFFFFF 33.33%, #FFFFFF 66.66%, #138808 66.66%, #138808 100%);
    height: 8px;
}

.header-main {
    background: #fff;
    padding: 15px 30px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.header-content {
    max-width: 1200px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    gap: 20px;
}

.emblem {
    width: 60px;
    height: 60px;
    background: #000080;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
    font-weight: bold;
    font-size: 24px;
}

.header-text h1 {
    color: #000080;
    font-size: 24px;
    font-weight: 600;
}

.header-text p {
    color: #666;
    font-size: 14px;
}

.main-content {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px 20px;
}

.login-container {
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    width: 100%;
    max-width: 450px;
    overflow: hidden;
}

.login-header {
    background: linear-gradient(135deg, #000080 0%, #0000CD 100%);
    color: #fff;
    padding: 30px;
    text-align: center;
}

.login-header h2 {
    font-size: 28px;
    margin-bottom: 8px;
}

.login-header p {
    opacity: 0.9;
    font-size: 14px;
}

.login-form {
    padding: 40px;
}

.form-group {
    margin-bottom: 25px;
}

.form-group label {
    display: block;
    color: #333;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 14px;
}

.form-group input {
    width: 100%;
    padding: 12px 15px;
    border: 2px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    transition: border-color 0.3s;
}

.form-group input:focus {
    outline: none;
    border-color: #000080;
}

.btn-login {
    width: 100%;
    padding: 14px;
    background: linear-gradient(135deg, #000080 0%, #0000CD 100%);
    color: #fff;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    transition: transform 0.2s;
}

.btn-login:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,128,0.3);
}

.signup-link {
    text-align: center;
    margin-top: 20px;
    color: #666;
    font-size: 14px;
}

.signup-link a {
    color: #000080;
    text-decoration: none;
    font-weight: 600;
}

.signup-link a:hover {
    text-decoration: underline;
}

.alert-success {
    background-color: #d4edda;
    border: 1px solid #c3e6cb;
    color: #155724;
    padding: 12px 20px;
    border-radius: 6px;
    margin-bottom: 20px;
    text-align: center;
    font-size: 14px;
}

.footer {
    background: #f8f9fa;
    padding: 20px;
    text-align: center;
    color: #666;
    font-size: 13px;
    border-top: 1px solid #ddd;
}
</style>
</head>
<body>
    <div class="gov-header"></div>
    
    <div class="header-main">
        <div class="header-content">
            <div class="emblem">🇮🇳</div>
            <div class="header-text">
                <h1>Government of India</h1>
                <p>Ministry of Home Affairs | National Crime Records Bureau</p>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="login-container">
            <div class="login-header">
                <h2>CMS Portal</h2>
                <p>Criminal Management System</p>
            </div>
            
            <form method="post" action="${pageContext.request.contextPath}/Login" class="login-form">
                <% 
                    String success = request.getParameter("success");
                    if (success != null && success.equals("true")) {
                %>
                <div class="alert-success">
                    ✓ Registration successful! Please login with your credentials.
                </div>
                <% } %>
                
                <div class="form-group">
                    <label for="username">Username / ID</label>
                    <input type="text" id="username" name="username" required autofocus placeholder="Enter your username">
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required placeholder="Enter your password">
                </div>
                
                <button type="submit" class="btn-login">Login to Portal</button>
                
                <div class="signup-link">
                    Not Registered? <a href="${pageContext.request.contextPath}/SignUp.jsp">Register Here</a>
                </div>
            </form>
        </div>
    </div>

    <div class="footer">
        © 2026 Government of India. All Rights Reserved. | Developed by National Informatics Centre
    </div>
</body>
</html>