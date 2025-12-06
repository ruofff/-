<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>医院管理系统仪表盘</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db; /* 蓝色 */
            --department-color: #3498db; /* 科室信息 */
            --doctor-color: #2ecc71; /* 医生信息 */
            --patient-color: #e67e22; /* 患者信息 */
            --appointment-color: #9b59b6; /* 预约管理 */
            --system-color: #95a5a6; /* 系统管理 */
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8f9fa;
            color: #34495e;
            line-height: 1.6;
            padding: 0;
            margin: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 欢迎区域 */
        .welcome-section {
            margin-bottom: 30px;
            padding: 25px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .welcome-title {
            font-size: 2.2rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        .welcome-subtitle {
            font-size: 1.1rem;
            color: #7f8c8d;
            margin-bottom: 15px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.1rem;
            color: #34495e;
            font-weight: 500;
            padding: 10px 0;
        }

        .user-badge {
            background-color: #eaf6ff;
            border-radius: 20px;
            padding: 4px 15px;
            color: var(--primary-color);
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        /* 卡片网格布局 */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        /* 卡片通用样式 */
        .dashboard-card {
            background-color: white;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        /* 卡片头部样式 */
        .card-header {
            padding: 20px 25px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            background-color: rgba(255, 255, 255, 0.25);
        }

        .card-title {
            font-size: 1.4rem;
            font-weight: 600;
        }

        /* 卡片内容样式 */
        .card-content {
            padding: 20px 25px;
            flex-grow: 1;
        }

        .card-stats {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .stat-value {
            font-size: 2.8rem;
            font-weight: 700;
            line-height: 1;
            color: #2c3e50;
            margin-right: 15px;
        }

        .stat-label {
            font-size: 1.1rem;
            color: #7f8c8d;
            line-height: 1.4;
        }

        .card-footer {
            padding: 15px 25px;
            border-top: 1px solid #eee;
            text-align: right;
        }

        /* 操作按钮样式 */
        .card-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 1rem;
            text-decoration: none;
            transition: all 0.3s;
            background-color: white;
            color: #444;
            border: 1px solid #ddd;
        }

        .card-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* 科室信息卡片样式 */
        .department-card .card-header {
            background: linear-gradient(135deg, var(--department-color), #2980b9);
        }

        .department-card .card-btn {
            background-color: var(--department-color);
            color: white;
            border-color: var(--department-color);
        }

        /* 医生信息卡片样式 */
        .doctor-card .card-header {
            background: linear-gradient(135deg, var(--doctor-color), #27ae60);
        }

        .doctor-card .card-btn {
            background-color: var(--doctor-color);
            color: white;
            border-color: var(--doctor-color);
        }

        /* 患者信息卡片样式 */
        .patient-card .card-header {
            background: linear-gradient(135deg, var(--patient-color), #d35400);
        }

        .patient-card .card-btn {
            background-color: var(--patient-color);
            color: white;
            border-color: var(--patient-color);
        }

        /* 预约管理卡片样式 */
        .appointment-card .card-header {
            background: linear-gradient(135deg, var(--appointment-color), #8e44ad);
        }

        .appointment-card .card-btn {
            background-color: var(--appointment-color);
            color: white;
            border-color: var(--appointment-color);
        }

        /* 系统管理卡片样式 */
        .system-card .card-header {
            background: linear-gradient(135deg, var(--system-color), #7f8c8d);
        }

        .system-card .card-btn {
            background-color: var(--system-color);
            color: white;
            border-color: var(--system-color);
        }

        /* 系统管理卡片中的账户信息样式 */
        .account-info {
            padding: 15px 0;
        }

        .account-row {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            font-size: 1rem;
        }

        .account-label {
            width: 70px;
            font-weight: 500;
            color: #7f8c8d;
        }

        .account-value {
            font-weight: 500;
            color: #2c3e50;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .dashboard-grid {
                gap: 20px;
            }

            .welcome-title {
                font-size: 1.8rem;
            }

            .stat-value {
                font-size: 2.3rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 欢迎区域 -->
    <div class="welcome-section">
        <h1 class="welcome-title">欢迎使用医院管理系统</h1>
        <p class="welcome-subtitle">一站式管理医院运营的智能化平台</p>
        <div class="user-info">
            <i class="fas fa-user-circle"></i>
            欢迎回来，<span>${user.username}</span>
            <span class="user-badge">
                <i class="fas fa-user-shield"></i> ${user.role}
            </span>
        </div>
    </div>

    <!-- 仪表盘卡片 -->
    <div class="dashboard-grid">
        <!-- 科室信息卡片 -->
        <div class="dashboard-card department-card">
            <div class="card-header">
                <div class="card-title">
                    <i class="fas fa-hospital"></i> 科室信息
                </div>
                <div class="card-icon">
                    <i class="fas fa-building"></i>
                </div>
            </div>
            <div class="card-content">
                <div class="card-stats">
                    <div class="stat-value">${departmentCount}</div>
                    <div class="stat-label">科室总数</div>
                </div>
            </div>
            <div class="card-footer">
                <a href="${ctx}/departments" class="card-btn">
                    <i class="fas fa-cog"></i> 管理科室
                </a>
            </div>
        </div>

        <!-- 医生信息卡片 -->
        <div class="dashboard-card doctor-card">
            <div class="card-header">
                <div class="card-title">
                    <i class="fas fa-user-md"></i> 医生信息
                </div>
                <div class="card-icon">
                    <i class="fas fa-stethoscope"></i>
                </div>
            </div>
            <div class="card-content">
                <div class="card-stats">
                    <div class="stat-value">${doctorCount}</div>
                    <div class="stat-label">注册医生总数</div>
                </div>
            </div>
            <div class="card-footer">
                <a href="${ctx}/doctors" class="card-btn">
                    <i class="fas fa-users"></i> 管理医生
                </a>
            </div>
        </div>

        <!-- 患者信息卡片 -->
        <div class="dashboard-card patient-card">
            <div class="card-header">
                <div class="card-title">
                    <i class="fas fa-procedures"></i> 患者信息
                </div>
                <div class="card-icon">
                    <i class="fas fa-user-injured"></i>
                </div>
            </div>
            <div class="card-content">
                <div class="card-stats">
                    <div class="stat-value">${patientCount}</div>
                    <div class="stat-label">患者总数</div>
                </div>
            </div>
            <div class="card-footer">
                <a href="${ctx}/patients" class="card-btn">
                    <i class="fas fa-clipboard-list"></i> 管理患者
                </a>
            </div>
        </div>

        <!-- 预约管理卡片 -->
        <div class="dashboard-card appointment-card">
            <div class="card-header">
                <div class="card-title">
                    <i class="fas fa-calendar-check"></i> 预约管理
                </div>
                <div class="card-icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
            </div>
            <div class="card-content">
                <div class="card-stats">
                    <div class="stat-value">${appointmentCount}</div>
                    <div class="stat-label">今日预约数</div>
                </div>
            </div>
            <div class="card-footer">
                <a href="${ctx}/appointments" class="card-btn">
                    <i class="fas fa-search"></i> 查看预约
                </a>
            </div>
        </div>

        <!-- 系统管理卡片 -->
        <div class="dashboard-card system-card">
            <div class="card-header">
                <div class="card-title">
                    <i class="fas fa-cogs"></i> 系统管理
                </div>
                <div class="card-icon">
                    <i class="fas fa-server"></i>
                </div>
            </div>
            <div class="card-content">
                <div class="account-info">
                    <div class="account-row">
                        <span class="account-label">账户：</span>
                        <span class="account-value">${user.username}</span>
                    </div>
                    <div class="account-row">
                        <span class="account-label">角色：</span>
                        <span class="account-value">${user.role}</span>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <a href="${ctx}/login" class="card-btn">
                    <i class="fas fa-sign-out-alt"></i> 退出系统
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>