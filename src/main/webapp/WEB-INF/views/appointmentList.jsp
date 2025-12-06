<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>预约管理</title>
    <link rel="stylesheet" href="${ctx}/assets/css/styles.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .header-right {
            display: flex;
            gap: 10px;
        }

        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            margin-bottom: 0;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .btn-home {
            background-color: #6c757d;
        }

        .btn-home:hover {
            background-color: #5a6268;
        }

        .btn-new {
            background-color: #28a745;
        }

        .btn-new:hover {
            background-color: #218838;
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
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f8f9fa;
            font-weight: bold;
            color: #495057;
        }

        tr:hover {
            background-color: #f5f7ff;
        }

        .action-links a {
            margin-right: 10px;
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s;
        }

        .action-links a:hover {
            color: #0056b3;
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .header-right {
                width: 100%;
                justify-content: flex-end;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header-container">
        <div class="header-left">
            <a href="${ctx}/dashboard" class="btn btn-home">返回主页</a>
            <h1>预约管理</h1>
        </div>
        <div class="header-right">
            <a href="${ctx}/appointments?action=new" class="btn btn-new">新建预约</a>
        </div>
    </div>

    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>患者</th>
            <th>医生</th>
            <th>日期</th>
            <th>时间</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="appointment" items="${appointments}">
            <tr>
                <td>${appointment.id}</td>
                <td>${appointment.patient.name}</td>
                <td>${appointment.doctor.name}</td>
                <td>${appointment.appointmentDate}</td>
                <td>${appointment.appointmentTime}</td>
                <td>${appointment.status}</td>
                <td class="action-links">
                    <a href="${ctx}/appointments?action=edit&id=${appointment.id}">编辑</a>
                    <a href="${ctx}/appointments?action=delete&id=${appointment.id}"
                       onclick="return confirm('确定删除该预约吗？')">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>