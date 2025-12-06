<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>医生列表 - 医院管理系统</title>
    <link rel="stylesheet" href="${ctx}/assets/css/styles.css">
    <style>
        .user-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .page-header {
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #6a5acd;
            position: relative;
        }

        .page-header h1 {
            color: #6a5acd;
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #666;
            font-size: 1.1rem;
        }

        /* 添加返回按钮样式 */
        .back-to-dashboard {
            position: absolute;
            top: 10px;
            right: 0;
            padding: 8px 15px;
            background-color: #6a5acd;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.3s;
            font-size: 14px;
        }

        .back-to-dashboard:hover {
            background-color: #5a4acd;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #495057;
        }

        tr:hover {
            background-color: #f5f7ff;
        }

        .action-links {
            display: flex;
            gap: 10px;
        }

        .view-link, .appointment-link {
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s;
        }

        .view-link {
            background-color: #6a5acd;
            color: white;
        }

        .appointment-link {
            background-color: #28a745;
            color: white;
        }

        .view-link:hover, .appointment-link:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .doctor-bio {
            color: #6c757d;
            font-size: 14px;
            max-width: 400px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</head>
<body>
<div class="user-container">
    <div class="page-header">
        <h1>医生列表</h1>
        <p>查看医生信息并预约就诊</p>

        <!-- 添加返回主页按钮 -->
        <a href="${ctx}/user/dashboard" class="back-to-dashboard">
            返回主页
        </a>
    </div>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>姓名</th>
            <th>职称</th>
            <th>科室</th>
            <th>简介</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="doctor" items="${doctors}">
            <tr>
                <td>${doctor.id}</td>
                <td>${doctor.name}</td>
                <td>${doctor.title}</td>
                <td>${doctor.department.name}</td>
                <td class="doctor-bio">${doctor.bio}</td>
                <td class="action-links">
                    <a href="${ctx}/user/doctor?id=${doctor.id}" class="view-link">查看</a>
                    <a href="${ctx}/user/appointments/new?doctorId=${doctor.id}" class="appointment-link">预约</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>