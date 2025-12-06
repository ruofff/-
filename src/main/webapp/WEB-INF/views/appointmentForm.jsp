<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${not empty appointment}">编辑预约</c:when>
            <c:otherwise>新建预约</c:otherwise>
        </c:choose>
    </title>
    <link rel="stylesheet" href="${ctx}/assets/css/styles.css">
    <style>
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        select, input[type="date"], input[type="time"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn-container {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }
        .btn-cancel {
            background-color: #6c757d;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>
        <c:choose>
            <c:when test="${not empty appointment}">编辑预约 #${appointment.id}</c:when>
            <c:otherwise>新建预约</c:otherwise>
        </c:choose>
    </h1>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${ctx}/appointments" method="post">
        <c:if test="${not empty appointment}">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="${appointment.id}">
        </c:if>
        <c:if test="${empty appointment}">
            <input type="hidden" name="action" value="insert">
        </c:if>

        <div class="form-group">
            <label for="patient">患者:</label>
            <select id="patient" name="patient" required>
                <option value="">-- 选择患者 --</option>
                <c:forEach items="${patients}" var="patient">
                    <option value="${patient.id}"
                        ${appointment != null && appointment.patientId == patient.id ? 'selected' : ''}>
                            ${patient.name} (${patient.age}岁)
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="doctor">医生:</label>
            <select id="doctor" name="doctor" required>
                <option value="">-- 选择医生 --</option>
                <c:forEach items="${doctors}" var="doctor">
                    <option value="${doctor.id}"
                        ${appointment != null && appointment.doctorId == doctor.id ? 'selected' : ''}>
                            ${doctor.name} - ${doctor.title}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="date">日期:</label>
            <input type="date" id="date" name="date"
                   value="${appointment != null ? appointment.appointmentDate : ''}" required>
        </div>

        <div class="form-group">
            <label for="time">时间:</label>
            <input type="time" id="time" name="time"
                   value="${appointment != null ? appointment.appointmentTime : ''}" required>
        </div>

        <div class="form-group">
            <label for="notes">备注:</label>
            <textarea id="notes" name="notes" rows="4">${appointment != null ? appointment.notes : ''}</textarea>
        </div>

        <div class="btn-container">
            <button type="submit" class="btn">
                <c:choose>
                    <c:when test="${not empty appointment}">更新预约</c:when>
                    <c:otherwise>创建预约</c:otherwise>
                </c:choose>
            </button>
            <a href="${ctx}/appointments" class="btn btn-cancel">取消</a>
        </div>
    </form>
</div>
</body>
</html>