<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${not empty doctor}">编辑医生</c:when>
            <c:otherwise>添加新医生</c:otherwise>
        </c:choose>
    </title>
    <link rel="stylesheet" href="${ctx}/assets/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6a5acd;
            --secondary-color: #95a5a6;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --text-dark: #2c3e50;
            --text-medium: #555;
            --border-color: #ddd;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8f9fa;
            color: var(--text-dark);
            line-height: 1.6;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 25px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .page-header {
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .page-title i {
            color: var(--primary-color);
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-dark);
        }

        .required::after {
            content: "*";
            color: var(--danger-color);
            margin-left: 4px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            font-size: 1rem;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(106, 90, 205, 0.2);
            outline: none;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .form-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 24px;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 1rem;
            border: none;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background: #5a4ac0;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(106, 90, 205, 0.3);
        }

        .btn-secondary {
            background-color: var(--secondary-color);
            color: white;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
            transform: translateY(-2px);
        }

        .photo-section {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
        }

        .doctor-photo {
            width: 120px;
            height: 150px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid var(--border-color);
            background-color: #f0f3ff;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 2.5rem;
        }

        .photo-actions {
            flex-grow: 1;
        }

        .photo-actions .btn {
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .error-message {
            color: var(--danger-color);
            margin-top: 5px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 10px;
            background-color: #fff0f0;
            border-radius: 6px;
            border: 1px solid #ffd6d6;
        }

        .error-message i {
            font-size: 1rem;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1 class="page-title">
            <i class="fas fa-user-md"></i>
            <c:choose>
                <c:when test="${not empty doctor}">编辑医生 #${doctor.id}</c:when>
                <c:otherwise>添加新医生</c:otherwise>
            </c:choose>
        </h1>
    </div>

    <c:if test="${not empty error}">
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>

    <form action="${ctx}/doctors" method="post">
        <!-- 隐藏字段：操作类型 -->
        <input type="hidden" name="action"
               value="${not empty doctor ? 'update' : 'insert'}">

        <!-- 只在编辑模式下传递ID -->
        <c:if test="${not empty doctor}">
            <input type="hidden" name="id" value="${doctor.id}">
        </c:if>

        <!-- 医生照片区域 -->
        <div class="photo-section">
            <div class="doctor-photo">
                <i class="fas fa-user-md"></i>
            </div>
            <div class="photo-actions">
                <button type="button" class="btn btn-primary">
                    <i class="fas fa-upload"></i> 上传照片
                </button>
                <button type="button" class="btn btn-secondary">
                    <i class="fas fa-trash-alt"></i> 移除照片
                </button>
                <p style="margin-top: 10px; color: var(--text-medium); font-size: 0.9rem;">
                    建议尺寸：300×375像素，JPG/PNG格式
                </p>
            </div>
        </div>

        <!-- 基本信息 -->
        <div class="form-group">
            <label for="name" class="form-label required">姓名</label>
            <input type="text" id="name" name="name" class="form-control"
                   value="${doctor.name}" required placeholder="请输入医生姓名">
        </div>

        <div class="form-group">
            <label for="title" class="form-label required">职称</label>
            <input type="text" id="title" name="title" class="form-control"
                   value="${doctor.title}" required placeholder="请输入医生职称（如：主任医师、副主任医师）">
        </div>

        <div class="form-group">
            <label for="departmentId" class="form-label required">所属科室</label>
            <select id="departmentId" name="departmentId" class="form-control" required>
                <c:choose>
                    <c:when test="${empty departments}">
                        <option value="" disabled>-- 科室数据加载失败，请联系管理员 --</option>
                    </c:when>
                    <c:otherwise>
                        <option value="">-- 请选择科室 --</option>
                        <c:forEach items="${departments}" var="dept">
                            <option value="${dept.id}"
                                    <c:if test="${doctor.departmentId == dept.id}">selected</c:if>>
                                    ${dept.name}
                            </option>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </select>
        </div>

        <div class="form-group">
            <label for="bio" class="form-label">简介</label>
            <textarea id="bio" name="bio" class="form-control"
                      placeholder="请填写医生专业领域、教育背景、临床经验等详细信息">${doctor.bio}</textarea>
        </div>

        <!-- 表单操作按钮 -->
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">
                <c:choose>
                    <c:when test="${not empty doctor}">
                        <i class="fas fa-save"></i> 更新医生信息
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-plus"></i> 添加医生
                    </c:otherwise>
                </c:choose>
            </button>

            <a href="${ctx}/doctors" class="btn btn-secondary">
                <i class="fas fa-times"></i> 取消
            </a>
        </div>
    </form>
</div>

<script>
    // 表单提交验证
    document.querySelector('form').addEventListener('submit', function(e) {
        const nameInput = document.getElementById('name');
        const titleInput = document.getElementById('title');
        const departmentSelect = document.getElementById('departmentId');
        let isValid = true;

        // 清除之前的错误样式
        document.querySelectorAll('.form-control').forEach(input => {
            input.style.borderColor = '';
        });

        // 验证姓名
        if (!nameInput.value.trim()) {
            nameInput.style.borderColor = 'var(--danger-color)';
            isValid = false;
        }

        // 验证职称
        if (!titleInput.value.trim()) {
            titleInput.style.borderColor = 'var(--danger-color)';
            isValid = false;
        }

        // 验证科室
        if (!departmentSelect.value) {
            departmentSelect.style.borderColor = 'var(--danger-color)';
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault();
            alert('请填写所有必填字段（标记为*的字段）');
        }
    });
</script>
</body>
</html>