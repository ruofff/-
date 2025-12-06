<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户中心 - 医院管理系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6a5acd;
            --primary-hover: #5a4abb;
            --secondary-color: #f8f9ff;
            --text-dark: #333;
            --text-medium: #555;
            --text-light: #777;
            --white: #ffffff;
            --light-border: #e0e0e0;
            --box-shadow: 0 5px 15px rgba(104, 85, 205, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8fafc;
            color: var(--text-dark);
            line-height: 1.6;
        }

        /* 顶部导航 */
        .top-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 40px;
            background: linear-gradient(135deg, var(--primary-color), #8a7ff0);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            color: var(--white);
        }

        .system-title {
            font-size: 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .system-title i {
            margin-right: 10px;
            font-size: 1.8rem;
        }

        .user-controls {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .welcome-user {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome-user .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--secondary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-weight: bold;
            font-size: 1.1rem;
        }

        .btn-logout {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            background-color: var(--white);
            color: var(--primary-color);
            border: none;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--box-shadow);
        }

        .btn-logout:hover {
            background-color: #ffeff5;
            color: #ff4772;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 71, 114, 0.2);
        }

        /* 主内容区 */
        .user-dashboard {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 40px;
        }

        .dashboard-header {
            margin-bottom: 30px;
            padding: 20px;
            background-color: var(--white);
            border-radius: 15px;
            box-shadow: var(--box-shadow);
        }

        .welcome-message {
            font-size: 1.8rem;
            color: var(--text-dark);
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome-message i {
            color: var(--primary-color);
        }

        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: linear-gradient(135deg, #f7f9ff, #ffffff);
            border-radius: 15px;
            box-shadow: var(--box-shadow);
            padding: 25px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(106, 90, 205, 0.1);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #6a5acd, #8a7ff0);
        }

        .stat-card:nth-child(2)::before {
            background: linear-gradient(90deg, #36b9cc, #4ed4e6);
        }

        .stat-card:nth-child(3)::before {
            background: linear-gradient(90deg, #1cc88a, #34e3a6);
        }

        .stat-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 12px 25px rgba(104, 85, 205, 0.25);
        }

        .stat-icon {
            font-size: 2.2rem;
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        .stat-value {
            font-size: 2.5rem;
            color: var(--primary-color);
            font-weight: bold;
            margin-bottom: 5px;
        }

        .stat-label {
            color: var(--text-medium);
            font-size: 1rem;
            font-weight: 500;
        }

        .section-title {
            margin: 25px 0 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid rgba(106, 90, 205, 0.1);
            font-size: 1.4rem;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .action-card {
            background: linear-gradient(135deg, #f7f9ff, #ffffff);
            border-radius: 15px;
            box-shadow: var(--box-shadow);
            padding: 25px;
            text-align: center;
            cursor: pointer;
            transition: all 0.4s ease;
            border: 1px solid rgba(106, 90, 205, 0.1);
            position: relative;
        }

        .action-card:hover {
            box-shadow: 0 10px 30px rgba(104, 85, 205, 0.3);
            transform: translateY(-5px);
            background: linear-gradient(135deg, var(--white), #f3f6ff);
        }

        .action-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 20px;
            transition: transform 0.3s;
        }

        .action-card:hover .action-icon {
            transform: scale(1.1);
        }

        .action-card h3 {
            font-size: 1.3rem;
            margin-bottom: 12px;
            color: var(--text-dark);
        }

        .action-card p {
            color: var(--text-light);
            font-size: 0.95rem;
            margin-bottom: 10px;
        }

        .featured-departments {
            margin-top: 40px;
        }

        .dept-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
        }

        .dept-card {
            background: var(--white);
            border-radius: 15px;
            box-shadow: var(--box-shadow);
            overflow: hidden;
            transition: transform 0.3s;
            border: 1px solid var(--light-border);
        }

        .dept-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px rgba(104, 85, 205, 0.2);
        }

        .dept-header {
            background: linear-gradient(135deg, var(--primary-color), #8a7ff0);
            color: var(--white);
            padding: 20px;
            text-align: center;
            position: relative;
        }

        .dept-header::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 20px;
            width: 20px;
            height: 20px;
            background-color: var(--primary-color);
            transform: rotate(45deg);
            z-index: 1;
        }

        .dept-header h3 {
            font-size: 1.3rem;
            position: relative;
            z-index: 2;
        }

        .dept-body {
            padding: 25px 20px;
        }

        .dept-desc {
            color: var(--text-medium);
            font-size: 0.95rem;
            margin-bottom: 20px;
            line-height: 1.7;
        }

        .dept-action {
            text-align: center;
        }

        .btn-dept {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 20px;
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 30px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-dept:hover {
            background-color: var(--primary-hover);
            box-shadow: 0 5px 15px rgba(106, 90, 205, 0.4);
        }
    </style>
</head>
<body>
<!-- 顶部导航栏 -->
<div class="top-nav">
    <div class="system-title">
        <i class="fas fa-hospital"></i>
        <span>医院管理系统</span>
    </div>
    <div class="user-controls">
        <div class="welcome-user">
            <div class="avatar">${user.username.substring(0,1).toUpperCase()}</div>
            <span>${user.username}</span>
        </div>
        <a href="${ctx}/login" class="btn-logout">
            <i class="fas fa-sign-out-alt"></i>
            <span>退出系统</span>
        </a>
    </div>
</div>

<div class="user-dashboard">
    <div class="dashboard-header">
        <h1 class="welcome-message">
            <i class="fas fa-hand-wave"></i>
            欢迎回来，${user.username}！
        </h1>
        <p>您的专属健康管理中心</p>
    </div>

    <!-- 统计卡片 -->
    <div class="dashboard-stats">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-clinic-medical"></i>
            </div>
            <div class="stat-value">${departmentCount}</div>
            <div class="stat-label">医疗科室</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-user-md"></i>
            </div>
            <div class="stat-value">${doctorCount}</div>
            <div class="stat-label">专业医生</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-calendar-check"></i>
            </div>
            <div class="stat-value">4</div>
            <div class="stat-label">今日可约</div>
        </div>
    </div>

    <!-- 快速操作 -->
    <h2 class="section-title">
        <i class="fas fa-bolt"></i>
        快捷功能
    </h2>
    <div class="quick-actions">
        <div class="action-card" onclick="location.href='${ctx}/user/doctors'">
            <div class="action-icon">
                <i class="fas fa-search"></i>
            </div>
            <h3>查找医生</h3>
            <p>按科室选择医生预约</p>
            <div class="dept-action">
                <button class="btn-dept">立即使用</button>
            </div>
        </div>
        <div class="action-card" onclick="location.href='${ctx}/user/appointments/my'">
            <div class="action-icon">
                <i class="fas fa-calendar-alt"></i>
            </div>
            <h3>我的预约</h3>
            <p>查看和管理预约记录</p>
            <div class="dept-action">
                <button class="btn-dept">查看详情</button>
            </div>
        </div>
        <div class="action-card" onclick="location.href='${ctx}/user/my-profile'">
            <div class="action-icon">
                <i class="fas fa-user-circle"></i>
            </div>
            <h3>个人中心</h3>
            <p>管理我的健康信息</p>
            <div class="dept-action">
                <button class="btn-dept">进入中心</button>
            </div>
        </div>
    </div>

    <!-- 特色科室 -->
    <div class="featured-departments">
        <h2 class="section-title">
            <i class="fas fa-star"></i>
            特色医疗科室
        </h2>
        <div class="dept-grid">
            <c:forEach items="${featuredDepartments}" var="dept">
                <div class="dept-card">
                    <div class="dept-header">
                        <h3>${dept.name}</h3>
                    </div>
                    <div class="dept-body">
                        <div class="dept-desc">
                                ${dept.description.length() > 120 ? dept.description.substring(0,120).concat('...') : dept.description}
                        </div>
                        <div class="dept-action">
                            <a href="${ctx}/departments?action=view&id=${dept.id}" class="btn-dept">
                                <i class="fas fa-arrow-right"></i>
                                查看详情
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<!-- 平滑滚动效果 -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 为所有交互元素添加悬停效果
        const cards = document.querySelectorAll('.stat-card, .action-card, .dept-card');
        cards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transition = 'all 0.3s ease';
            });

            card.addEventListener('click', function(e) {
                if (e.target.closest('.btn-dept')) return;
                this.style.transform = 'scale(0.98)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 200);
            });
        });

        // 为退出按钮添加动画
        const logoutBtn = document.querySelector('.btn-logout');
        logoutBtn.addEventListener('mouseenter', function() {
            this.querySelector('span').textContent = '退出登录';
        });

        logoutBtn.addEventListener('mouseleave', function() {
            this.querySelector('span').textContent = '退出系统';
        });
    });
</script>
</body>
</html>