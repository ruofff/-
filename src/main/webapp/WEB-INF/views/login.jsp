<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>医院管理系统 - 登录</title>
    <link rel="stylesheet" href="${ctx}/assets/css/styles.css">
    <style>
        body {
            background-color: #f5f5f5;
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            width: 350px;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        .logo {
            margin-bottom: 20px;
        }

        .logo h1 {
            color: #2c3e50;
            font-size: 24px;
            margin: 0;
        }

        .logo p {
            color: #7f8c8d;
            margin-top: 5px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #2980b9;
        }

        .error-message {
            color: #e74c3c;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #fdeded;
            border-radius: 4px;
            font-size: 14px;
        }

        .success-message {
            color: #2ecc71;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #e8f5e9;
            border-radius: 4px;
            font-size: 14px;
        }

        .footer {
            margin-top: 20px;
            color: #95a5a6;
            font-size: 14px;
        }

        /* 注册相关样式 */
        .register-container {
            margin-top: 15px;
            text-align: center;
            padding: 12px 0;
            border-top: 1px solid #eee;
        }

        .register-container p {
            margin: 0;
            color: #7f8c8d;
            font-size: 14px;
        }

        .register-link {
            color: #3498db;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s;
        }

        .register-link:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        .register-form {
            display: none;
            margin-top: 20px;
        }

        .form-switch {
            margin-top: 15px;
            font-size: 14px;
            color: #3498db;
            text-decoration: none;
            cursor: pointer;
            display: inline-block;
        }

        .form-switch:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="logo">
        <h1>医院管理系统</h1>
        <p>您的健康管理专家</p>
    </div>

    <!-- 错误消息区域 -->
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <!-- 注册成功消息 -->
    <c:if test="${not empty param.success}">
        <div class="success-message">
            注册成功！请使用新账户登录
        </div>
    </c:if>

    <!-- 错误参数处理 -->
    <c:if test="${not empty param.error}">
        <div class="error-message">
            <c:choose>
                <c:when test="${param.error == 'validation'}">
                    请输入有效的用户名和密码
                </c:when>
                <c:when test="${param.error == 'password_length'}">
                    密码长度至少为6个字符
                </c:when>
                <c:when test="${param.error == 'username_exists'}">
                    用户名已存在
                </c:when>
                <c:when test="${param.error == 'credentials'}">
                    用户名或密码错误
                </c:when>
                <c:when test="${param.error == 'server'}">
                    服务器错误，请稍后再试
                </c:when>
                <c:otherwise>
                    登录失败，请重试
                </c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <!-- 登录表单 -->
    <form id="loginForm" method="post" action="${ctx}/login">
        <div class="form-group">
            <label for="username">用户名:</label>
            <input type="text" id="username" name="username" required placeholder="请输入用户名">
        </div>

        <div class="form-group">
            <label for="password">密码:</label>
            <input type="password" id="password" name="password" required placeholder="请输入密码">
        </div>

        <button type="submit">登录</button>
    </form>

    <!-- 注册功能区域 -->
    <div class="register-container">
        <p>没有账户? <a href="#" id="showRegister" class="register-link">注册新账户</a></p>
    </div>

    <!-- 注册表单 -->
    <form id="registerForm" class="register-form" action="register" method="post">
        <div class="form-group">
            <label for="registerUsername">用户名:</label>
            <input type="text" id="registerUsername" name="username" required placeholder="设置您的用户名">
        </div>

        <div class="form-group">
            <label for="registerPassword">密码:</label>
            <input type="password" id="registerPassword" name="password" required placeholder="设置您的密码">
        </div>

        <div class="form-group">
            <label for="confirmPassword">确认密码:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="再次输入密码">
        </div>

        <button type="submit">注册账户</button>

        <a href="#" id="showLogin" class="form-switch">返回登录</a>
    </form>

    <div class="footer">
        &copy; 2025 医院管理系统 | 版本 1.0
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const loginForm = document.getElementById('loginForm');
        const registerForm = document.getElementById('registerForm');
        const showRegister = document.getElementById('showRegister');
        const showLogin = document.getElementById('showLogin');

        // 检查URL参数
        const urlParams = new URLSearchParams(window.location.search);
        const errorParam = urlParams.get('error');
        const successParam = urlParams.get('success');
        const showRegisterParam = urlParams.get('showRegister');

        // 显示注册表单的错误类型
        const registerErrors = [
            'validation',
            'password_length',
            'username_exists',
            'server'
        ];

        // 初始显示设置
        function setFormVisibility() {
            // 如果需要显示注册表单
            if (successParam || showRegisterParam ||
                (errorParam && registerErrors.includes(errorParam))) {
                loginForm.style.display = 'none';
                registerForm.style.display = 'block';

                // 清除表单数据
                document.getElementById('registerUsername').value = '';
                document.getElementById('registerPassword').value = '';
                document.getElementById('confirmPassword').value = '';
            } else {
                loginForm.style.display = 'block';
                registerForm.style.display = 'none';
            }
        }

        // 初始化表单显示
        setFormVisibility();

        // 显示注册表单
        if (showRegister) {
            showRegister.addEventListener('click', function(e) {
                e.preventDefault();
                if (loginForm && registerForm) {
                    loginForm.style.display = 'none';
                    registerForm.style.display = 'block';

                    // 清除任何可能的错误状态
                    window.history.replaceState({}, document.title, window.location.pathname);
                }
            });
        }

        // 显示登录表单
        if (showLogin) {
            showLogin.addEventListener('click', function(e) {
                e.preventDefault();
                if (registerForm && loginForm) {
                    registerForm.style.display = 'none';
                    loginForm.style.display = 'block';

                    // 清除任何可能的错误状态
                    window.history.replaceState({}, document.title, window.location.pathname);
                }
            });
        }

        // 注册表单验证
        if (registerForm) {
            registerForm.addEventListener('submit', function(e) {
                const username = document.getElementById('registerUsername').value;
                const password = document.getElementById('registerPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;

                // 用户名验证
                if (username.length < 3) {
                    e.preventDefault();
                    alert('用户名至少需要3个字符');
                    return false;
                }

                // 密码验证
                if (password.length < 6) {
                    e.preventDefault();
                    alert('密码长度至少为6个字符');
                    return false;
                }

                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('两次输入的密码不一致');
                    return false;
                }

                // 显示加载状态
                const submitBtn = registerForm.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '注册中...';

                return true;
            });
        }

        // 登录表单提交处理
        if (loginForm) {
            loginForm.addEventListener('submit', function(e) {
                const username = document.getElementById('username').value;
                const password = document.getElementById('password').value;

                if (username.length < 3 || password.length < 6) {
                    return; // 让服务器验证处理
                }

                // 显示加载状态
                const submitBtn = loginForm.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '登录中...';
            });
        }
    });
</script>
</body>
</html>