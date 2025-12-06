<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>${patient.id == null ? '添加' : '编辑'}患者信息</title>
    <link rel="stylesheet" href="${ctx}/assets/css/styles.css">
    <style>
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"],
        input[type="number"],
        input[type="tel"],
        input[type="date"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box;
        }

        input:focus, select:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }

        .btn-container {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            text-align: center;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
        }

        .btn-submit {
            background-color: #2ecc71;
            color: white;
            border: none;
        }

        .btn-submit:hover {
            background-color: #27ae60;
        }

        .btn-cancel {
            background-color: #95a5a6;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-cancel:hover {
            background-color: #7f8c8d;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>${patient.id == null ? '添加新患者' : '编辑患者信息'}</h1>

    <form action="${ctx}/patients" method="post">
        <input type="hidden" name="action" value="${patient.id == null ? 'insert' : 'update'}">
        <c:if test="${not empty patient.id}">
            <input type="hidden" name="id" value="${patient.id}">
        </c:if>

        <div class="form-group">
            <label for="name">姓名:</label>
            <input type="text" id="name" name="name" value="${patient.name}" required placeholder="请输入患者姓名">
        </div>

        <div class="form-group">
            <label for="gender">性别:</label>
            <select id="gender" name="gender" required>
                <option value="男" ${patient.gender == '男' ? 'selected' : ''}>男</option>
                <option value="女" ${patient.gender == '女' ? 'selected' : ''}>女</option>
            </select>
        </div>

        <div class="form-group">
            <label for="dateOfBirth">出生日期:</label>
            <input type="date" id="dateOfBirth" name="dateOfBirth" value="${patient.dateOfBirth}" required>
        </div>

        <div class="form-group">
            <label for="phone">电话:</label>
            <input type="tel" id="phone" name="phone" value="${patient.phone}" required placeholder="请输入联系电话">
        </div>

        <div class="form-group">
            <label for="address">地址:</label>
            <input type="text" id="address" name="address" value="${patient.address}" placeholder="请输入联系地址">
        </div>

        <div class="form-group">
            <label for="emergencyContact">紧急联系人:</label>
            <input type="text" id="emergencyContact" name="emergencyContact" value="${patient.emergencyContact}" placeholder="请输入紧急联系人姓名">
        </div>

        <div class="form-group">
            <label for="emergencyPhone">紧急联系电话:</label>
            <input type="tel" id="emergencyPhone" name="emergencyPhone" value="${patient.emergencyPhone}" placeholder="请输入紧急联系电话">
        </div>

        <div class="btn-container">
            <button type="submit" class="btn btn-submit">保存</button>
            <a href="${ctx}/patients" class="btn btn-cancel">取消</a>
        </div>
    </form>
</div>
</body>
</html>