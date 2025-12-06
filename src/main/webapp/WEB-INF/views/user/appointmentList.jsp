<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>我的预约</title>
    <link rel="stylesheet" href="${ctx}/assets/css/styles.css">
    <style>
        body {
            font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        }

        .header-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #6a5acd;
        }

        .page-title {
            font-size: 28px;
            font-weight: 600;
            color: #333;
            margin: 0;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 10px 18px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            transition: all 0.2s ease;
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-primary {
            background-color: #6a5acd;
            color: white;
        }

        .btn-primary:hover {
            background-color: #5a4acd;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(106, 90, 205, 0.2);
        }

        .btn-secondary {
            background-color: #f0f2f5;
            color: #333;
        }

        .btn-secondary:hover {
            background-color: #e5e7eb;
            transform: translateY(-2px);
        }

        .alert {
            padding: 12px 18px;
            margin-bottom: 20px;
            border-radius: 6px;
            background-color: #fff4f4;
            color: #dc3545;
            border: 1px solid #ffd4d4;
        }

        .table-container {
            overflow-x: auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
            background: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            overflow: hidden;
        }

        .table th {
            background-color: #f8f9fa;
            padding: 15px 20px;
            text-align: left;
            font-weight: 600;
            color: #495057;
            border-bottom: 2px solid #e9ecef;
        }

        .table td {
            padding: 15px 20px;
            text-align: left;
            color: #495057;
            border-bottom: 1px solid #e9ecef;
        }

        .table tr {
            transition: background-color 0.2s;
        }

        .table tr:hover {
            background-color: #f5f7ff;
        }

        .text-center {
            text-align: center;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        .status-cancelled {
            background-color: #ffeded;
            color: #dc3545;
        }

        .status-pending {
            background-color: #e6f7e6;
            color: #28a745;
        }

        .action-buttons .btn-sm {
            padding: 7px 15px;
            font-size: 13px;
            border-radius: 5px;
        }

        .btn-info {
            background-color: #6a5acd;
            color: white;
        }

        .btn-info:hover {
            background-color: #5a4acd;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background-color: #bd2130;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }

        .empty-state img {
            max-width: 300px;
            margin-bottom: 20px;
            opacity: 0.7;
        }

        .empty-state p {
            font-size: 16px;
            margin: 0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header-container">
        <h1 class="page-title">我的预约</h1>
        <div class="action-buttons">
            <!-- 返回主页按钮 -->
            <a href="${ctx}/user/dashboard" class="btn btn-secondary">
                返回主页
            </a>
            <!-- 新建预约按钮 -->
            <a href="${ctx}/user/appointments/new" class="btn btn-primary">新建预约</a>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert">${error}</div>
    </c:if>

    <div class="table-container">
        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>医生</th>
                <th>预约时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${not empty appointments}">
                    <c:forEach var="appointment" items="${appointments}">
                        <tr>
                            <td>${appointment.id}</td>
                            <td>${appointment.doctor.name}</td>
                            <td>${appointment.appointmentDate} ${appointment.appointmentTime}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${appointment.status == '已取消'}">
                                        <span class="status-badge status-cancelled">${appointment.status}</span>
                                    </c:when>
                                    <c:when test="${appointment.status == '待处理'}">
                                        <span class="status-badge status-pending">${appointment.status}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge">${appointment.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${appointment.status == '已取消'}">
                                        <a href="${ctx}/user/appointments/edit?id=${appointment.id}" class="btn btn-info btn-sm">编辑</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${ctx}/user/appointments/edit?id=${appointment.id}" class="btn btn-info btn-sm">编辑</a>
                                        <a href="${ctx}/user/appointments/cancel?id=${appointment.id}"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('确定取消此预约吗？')">取消</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5">
                            <div class="empty-state">
                                <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M10 9V5l-7 7m0 0h14M4 16v4h16v-4m-1-3.09A5 5 0 1 1 11 7"></path>
                                </svg>
                                <p>暂无预约记录</p>
                                <p>点击上方"新建预约"按钮开始创建预约</p>
                            </div>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>