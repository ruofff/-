<%--
  Created by IntelliJ IDEA.
  User: Raniy
  Date: 2025/7/16
  Time: 4:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>预约详情 - 医院管理系统</title>
    <link rel="stylesheet" href="${ctx}/assets/css/styles.css">
    <style>
        .user-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }

        .page-header {
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #6a5acd;
        }

        .page-header h1 {
            color: #6a5acd;
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #6a5acd;
            text-decoration: none;
            font-weight: 500;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .appointment-detail {
            background-color: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .detail-row {
            display: flex;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .detail-label {
            width: 150px;
            font-weight: bold;
            color: #495057;
        }

        .detail-value {
            flex: 1;
            color: #6c757d;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 4px;
            font-weight: 500;
        }

        .status-confirmed {
            background-color: #d4edda;
            color: #155724;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-back {
            background-color: #6c757d;
            color: white;
        }

        .btn-cancel {
            background-color: #dc3545;
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="user-container">
    <a href="${ctx}/user/appointments" class="back-link">← 返回我的预约</a>

    <div class="page-header">
        <h1>预约详情</h1>
    </div>

    <div class="appointment-detail">
        <c:if test="${not empty appointment}">
            <div class="detail-row">
                <div class="detail-label">预约ID:</div>
                <div class="detail-value">${appointment.id}</div>
            </div>

            <div class="detail-row">
                <div class="detail-label">医生姓名:</div>
                <div class="detail-value">
                        ${appointment.doctor.name} (${appointment.doctor.title})
                </div>
            </div>

            <div class="detail-row">
                <div class="detail-label">所属科室:</div>
                <div class="detail-value">${appointment.doctor.department.name}</div>
            </div>

            <div class="detail-row">
                <div class="detail-label">预约日期:</div>
                <div class="detail-value">${appointment.appointmentDate}</div>
            </div>

            <div class="detail-row">
                <div class="detail-label">预约时间:</div>
                <div class="detail-value">${appointment.appointmentTime}</div>
            </div>

            <div class="detail-row">
                <div class="detail-label">当前状态:</div>
                <div class="detail-value">
                    <c:choose>
                        <c:when test="${appointment.status == '已预约'}">
                            <span class="status-badge status-confirmed">${appointment.status}</span>
                        </c:when>
                        <c:when test="${appointment.status == '已取消'}">
                            <span class="status-badge status-cancelled">${appointment.status}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge status-pending">${appointment.status}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="detail-row">
                <div class="detail-label">创建时间:</div>
                <div class="detail-value">${appointment.createdAt}</div>
            </div>

            <c:if test="${not empty appointment.notes}">
                <div class="detail-row">
                    <div class="detail-label">备注信息:</div>
                </div>
            </c:if>

            <div class="action-buttons">
                <a href="${ctx}/user/appointments" class="btn btn-back">返回列表</a>
                <c:if test="${appointment.status == '已预约'}">
                    <a href="${ctx}/user/appointments?action=cancel&id=${appointment.id}"
                       class="btn btn-cancel"
                       onclick="return confirm('确定要取消此预约吗？')">取消预约</a>
                </c:if>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>
