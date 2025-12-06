<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>医生详情 - 医院管理系统</title>
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

        .doctor-detail {
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
            width: 120px;
            font-weight: bold;
            color: #495057;
        }

        .detail-value {
            flex: 1;
            color: #6c757d;
        }

        .bio-content {
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 4px;
            line-height: 1.6;
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

        .btn-appoint {
            background-color: #28a745;
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
    <a href="${ctx}/user/doctors" class="back-link">← 返回医生列表</a>

    <div class="page-header">
        <h1>医生详情</h1>
    </div>

    <div class="doctor-detail">
        <c:if test="${not empty doctor}">
            <div class="detail-row">
                <div class="detail-label">ID:</div>
                <div class="detail-value">${doctor.id}</div>
            </div>

            <div class="detail-row">
                <div class="detail-label">姓名:</div>
                <div class="detail-value">${doctor.name}</div>
            </div>

            <div class="detail-row">
                <div class="detail-label">职称:</div>
                <div class="detail-value">${doctor.title}</div>
            </div>

            <div class="detail-row">
                <div class="detail-label">科室:</div>
                <div class="detail-value">${doctor.department.name}</div>
            </div>

            <div class="detail-row">
                <div class="detail-label">简介:</div>
                <div class="detail-value">
                    <div class="bio-content">${doctor.bio}</div>
                </div>
            </div>

            <div class="action-buttons">
                <a href="${ctx}/user/doctors" class="btn btn-back">返回列表</a>
                <a href="${pageContext.request.contextPath}/user/appointments/new?doctorId=${doctor.id}"
                   class="btn btn-primary">
                    预约该医生
                </a>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>