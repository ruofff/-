<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>${department.id == null ? '添加' : '编辑'}科室</title>
    <link rel="stylesheet" href="${ctx}/assets/css/styles.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            height: 150px;
        }
        .actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
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
    <h1>${department.id == null ? '添加新科室' : '编辑科室信息'}</h1>

    <div class="form-container">
        <form action="${ctx}/departments" method="post">
            <input type="hidden" name="action" value="${department.id == null ? 'insert' : 'update'}">
            <input type="hidden" name="id" value="${department.id}">

            <div class="form-group">
                <label for="name">科室名称:</label>
                <input type="text" id="name" name="name" value="${department.name}" required>
            </div>

            <div class="form-group">
                <label for="description">科室描述:</label>
                <textarea id="description" name="description" required>${department.description}</textarea>
            </div>

            <div class="actions">
                <button type="submit" class="btn">保存</button>
                <a href="${ctx}/departments" class="btn btn-cancel">取消</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>