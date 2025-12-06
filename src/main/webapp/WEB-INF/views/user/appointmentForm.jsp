<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <title>新建预约 - 医院管理系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8fafc;
            color: #333;
            line-height: 1.6;
        }

        .header {
            background: linear-gradient(135deg, #6a5acd, #8a7ff0);
            color: white;
            padding: 20px 40px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-title {
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header-title i {
            font-size: 1.5rem;
        }

        .user-controls {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .btn-logout {
            padding: 8px 16px;
            background-color: white;
            color: #6a5acd;
            border: none;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-logout:hover {
            background-color: #f8f9ff;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .appointment-container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .appointment-header {
            background: #6a5acd;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .appointment-form {
            padding: 30px;
        }

        .form-section {
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 1.3rem;
            color: #6a5acd;
            margin-bottom: 20px;
            padding-bottom: 8px;
            border-bottom: 2px solid rgba(106, 90, 205, 0.2);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            font-size: 1.2rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }

        .required::after {
            content: "*";
            color: red;
            margin-left: 4px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            transition: border 0.3s, box-shadow 0.3s;
        }

        .form-control:focus {
            border-color: #6a5acd;
            box-shadow: 0 0 0 3px rgba(106, 90, 205, 0.2);
            outline: none;
        }

        .radio-group {
            display: flex;
            gap: 20px;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
        }

        .radio-option input[type="radio"] {
            accent-color: #6a5acd;
        }

        .form-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .btn {
            padding: 10px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #6a5acd, #8a7ff0);
            color: white;
        }

        .btn-secondary {
            background-color: #f0f0f0;
            color: #555;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>
<!-- 顶部导航栏 -->
<div class="header">
    <div class="header-content">
        <div class="header-title">
            <i class="fas fa-hospital"></i>
            <span>医院管理系统</span>
        </div>
        <div class="user-controls">
            <a href="${ctx}/user/dashboard" class="btn-logout">
                <i class="fas fa-sign-out-alt"></i>
                <span>返回首页</span>
            </a>
        </div>
    </div>
</div>

<!-- 预约表单主体 -->
<div class="appointment-container">
    <div class="appointment-header">
        新建预约
    </div>

    <!-- 病人基本信息 -->
    <form class="appointment-form" method="POST" action="${ctx}/user/appointments/insert">
        <div class="form-section">
            <div class="section-title">
                <i class="fas fa-user-injured"></i>
                病人基本信息
            </div>

            <div class="form-group">
                <label for="patientName" class="required">姓名</label>
                <input type="text" id="patientName" name="patientName" class="form-control"
                       placeholder="请输入姓名" required>
            </div>

            <div class="form-group">
                <label for="patientAge" class="required">年龄</label>
                <input type="number" id="patientAge" name="patientAge" class="form-control"
                       placeholder="请输入年龄" min="1" max="120" required>
            </div>

            <div class="form-group">
                <label class="required">性别</label>
                <div class="radio-group">
                    <label class="radio-option">
                        <input type="radio" name="patientGender" value="男">
                        男
                    </label>
                    <label class="radio-option">
                        <input type="radio" name="patientGender" value="女" checked>
                        女
                    </label>
                </div>
            </div>

            <div class="form-group">
                <label for="patientPhone" class="required">手机号码</label>
                <input type="tel" id="patientPhone" name="patientPhone" class="form-control"
                       placeholder="请输入手机号码" required>
            </div>

            <div class="form-group">
                <label for="emergencyContact">紧急联系人</label>
                <input type="text" id="emergencyContact" name="emergencyContact"
                       class="form-control" placeholder="请输入紧急联系人">
            </div>

            <div class="form-group">
                <label for="emergencyPhone">紧急联系电话</label>
                <input type="tel" id="emergencyPhone" name="emergencyPhone"
                       class="form-control" placeholder="请输入紧急联系电话">
            </div>
        </div>

        <!-- 预约信息 -->
        <div class="form-section">
            <div class="section-title">
                <i class="fas fa-calendar-check"></i>
                预约信息
            </div>

            <div class="form-group">
                <label for="doctorId" class="required">选择医生</label>
                <select id="doctorId" name="doctorId" class="form-control" required>
                    <option value="">-- 请选择医生 --</option>
                    <!-- 动态生成医生选项 -->
                    <c:forEach items="${doctors}" var="doctor">
                        <option value="${doctor.id}">${doctor.name} - ${doctor.department}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="date" class="required">预约日期</label>
                <input type="date" id="date" name="date" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="time" class="required">预约时间</label>
                <select id="time" name="time" class="form-control" required>
                    <option value="">-- 请选择时间 --</option>
                    <option value="08:00">08:00</option>
                    <option value="09:00">09:00</option>
                    <option value="10:00">10:00</option>
                    <option value="11:00">11:00</option>
                    <option value="14:00">14:00</option>
                    <option value="15:00">15:00</option>
                    <option value="16:00">16:00</option>
                </select>
            </div>
        </div>

        <!-- 病情描述 -->
        <div class="form-section">
            <div class="section-title">
                <i class="fas fa-comment-medical"></i>
                病情描述（选填）
            </div>

            <div class="form-group">
                <label for="notes">病情描述</label>
                <textarea id="notes" name="notes" class="form-control"
                          rows="4" placeholder="请详细描述您的症状和情况"></textarea>
            </div>
        </div>

        <!-- 表单按钮 -->
        <div class="form-buttons">
            <button type="button" class="btn btn-secondary"
                    onclick="clearForm()">
                <i class="fas fa-eraser"></i>
                清空表单
            </button>

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-check-circle"></i>
                提交预约
            </button>
        </div>
    </form>
</div>

<!-- 引入 Font Awesome 图标 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<script>
    // 页面加载时初始化表单
    document.addEventListener('DOMContentLoaded', function() {
        // 清空表单值
        const form = document.querySelector('.appointment-form');
        if(form) {
            form.reset();

            // 设置默认日期为明天
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            const formattedDate = tomorrow.toISOString().split('T')[0];
            document.getElementById('date').value = formattedDate;

            // 设置默认时间
            document.getElementById('time').value = "10:00";

            // 自动聚焦到姓名字段
            document.getElementById('patientName').focus();
        }
    });

    // 清空表单函数
    function clearForm() {
        const form = document.querySelector('.appointment-form');
        if(form) {
            form.reset();

            // 设置默认日期为明天
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            const formattedDate = tomorrow.toISOString().split('T')[0];
            document.getElementById('date').value = formattedDate;

            // 设置默认时间
            document.getElementById('time').value = "10:00";

            // 自动聚焦到姓名字段
            document.getElementById('patientName').focus();

            alert('表单已清空！');
        }
    }
</script>
</body>
</html>