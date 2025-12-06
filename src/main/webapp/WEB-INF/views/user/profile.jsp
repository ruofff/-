<%--
  Created by IntelliJ IDEA.
  User: Raniy
  Date: 2025/7/16
  Time: 11:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>个人中心 - 医院管理系统</title>
    <style>
        body {
            font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 20px;
        }

        .profile-container {
            max-width: 800px;
            margin: 30px auto;
            padding: 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eaeaea;
        }

        .welcome-section {
            margin-bottom: 30px;
        }

        .welcome-title {
            font-size: 28px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
        }

        .welcome-subtitle {
            font-size: 18px;
            color: #6a5acd;
        }

        .btn-back {
            padding: 10px 18px;
            background-color: #6a5acd;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            transition: all 0.3s;
        }

        .btn-back:hover {
            background-color: #5a4acd;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(106, 90, 205, 0.2);
        }

        .profile-card {
            background-color: #f8f9fe;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 25px;
            border-left: 4px solid #6a5acd;
        }

        .card-title {
            font-size: 22px;
            font-weight: 600;
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .card-title svg {
            margin-right: 12px;
            color: #6a5acd;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .info-item {
            margin-bottom: 18px;
        }

        .info-label {
            font-weight: 600;
            color: #6a5acd;
            margin-bottom: 6px;
            font-size: 16px;
        }

        .info-value {
            font-size: 17px;
            color: #2c3e50;
            padding: 8px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .empty-value {
            color: #868e96;
            font-style: italic;
        }

        .statistics {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 35px;
        }

        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: all 0.3s;
            border: 1px solid #e9ecef;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .stat-value {
            font-size: 36px;
            font-weight: 700;
            color: #6a5acd;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 16px;
            color: #495057;
        }
    </style>
</head>
<body>
<div class="profile-container">
    <div class="header">
        <div class="welcome-section">
            <h1 class="welcome-title">欢迎回来，${patient.name}！</h1>
            <p class="welcome-subtitle">您的专属健康管理中心</p>
        </div>

        <a href="${ctx}/user/dashboard" class="btn-back">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <polyline points="15 18 9 12 15 6"></polyline>
            </svg>
            返回主页
        </a>
    </div>

    <div class="statistics">
        <div class="stat-card">
            <div class="stat-value">4</div>
            <div class="stat-label">医疗科室</div>
        </div>

        <div class="stat-card">
            <div class="stat-value">4</div>
            <div class="stat-label">专业医生</div>
        </div>

        <div class="stat-card">
            <div class="stat-value">今日可约</div>
            <div class="stat-label">4人</div>
        </div>
    </div>

    <div class="profile-card">
        <h2 class="card-title">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
            </svg>
            个人信息
        </h2>

        <div class="info-grid">
            <div class="info-item">
                <div class="info-label">姓名</div>
                <div class="info-value">${patient.name}</div>
            </div>

            <div class="info-item">
                <div class="info-label">性别</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${not empty patient.gender}">
                            ${patient.gender}
                        </c:when>
                        <c:otherwise>
                            <span class="empty-value">未填写</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="info-item">
                <div class="info-label">年龄</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${patient.age > 0}">
                            ${patient.age} 岁
                        </c:when>
                        <c:otherwise>
                            <span class="empty-value">18</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="info-item">
                <div class="info-label">联系电话</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${not empty patient.phone}">
                            ${patient.phone}
                        </c:when>
                        <c:otherwise>
                            <span class="empty-value">未填写</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="info-item">
                <div class="info-label">紧急联系人</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${not empty patient.emergencyContact}">
                            ${patient.emergencyContact}
                        </c:when>
                        <c:otherwise>
                            <span class="empty-value">未设置</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="info-item">
                <div class="info-label">紧急联系电话</div>
                <div class="info-value">
                    <c:choose>
                        <c:when test="${not empty patient.emergencyPhone}">
                            ${patient.emergencyPhone}
                        </c:when>
                        <c:otherwise>
                            <span class="empty-value">未设置</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>