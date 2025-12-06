<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>患者管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;     /* 主色 - 蓝色 */
            --success-color: #27ae60;     /* 成功色 - 绿色 */
            --danger-color: #e74c3c;      /* 危险色 - 红色 */
            --text-dark: #2c3e50;         /* 深色文本 */
            --text-medium: #4f5969;       /* 中深色文本 */
            --text-light: #7f8c8d;        /* 浅色文本 */
            --border-color: #e0e3e7;       /* 边框颜色 */
            --light-bg: #f5f8fa;          /* 浅色背景 */
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
        }

        body {
            background-color: var(--light-bg);
            color: var(--text-dark);
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 25px 20px;
        }

        /* 页面顶部区域 */
        .page-header {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .header-title {
            font-size: 1.8rem;
            font-weight: 600;
            letter-spacing: -0.5px;
            color: var(--text-dark);
        }

        /* 按钮样式 */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.25s ease;
            font-size: 0.95rem;
            border: none;
        }

        .btn-add {
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
        }

        .btn-add:hover {
            background-color: #2980b9;
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.2);
            transform: translateY(-2px);
        }

        .btn-home {
            background-color: #7f8c8d;
            color: white;
        }

        .btn-home:hover {
            background-color: #6c757d;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* 患者表格区域 */
        .patients-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            min-width: 800px;
        }

        thead th {
            background: #e8f4ff;
            color: var(--text-dark);
            font-weight: 600;
            text-align: left;
            padding: 16px 18px;
            border-bottom: 1px solid var(--border-color);
        }

        tbody td {
            padding: 16px 18px;
            color: var(--text-medium);
            border-bottom: 1px solid var(--border-color);
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover td {
            background-color: #f9fcfd;
        }

        /* 操作列样式 */
        .action-links {
            display: flex;
            gap: 15px;
        }

        .action-link {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            transition: background-color 0.2s ease;
            font-weight: 500;
        }

        .edit-link {
            color: var(--success-color);
            border: 1px solid rgba(39, 174, 96, 0.3);
        }

        .edit-link:hover {
            background-color: rgba(39, 174, 96, 0.1);
        }

        .delete-link {
            color: var(--danger-color);
            border: 1px solid rgba(231, 76, 60, 0.3);
        }

        .delete-link:hover {
            background-color: rgba(231, 76, 60, 0.1);
        }

        /* 页脚区域 */
        .page-footer {
            text-align: center;
            margin-top: 20px;
        }

        /* 空状态样式 */
        .empty-state {
            padding: 50px 30px;
            text-align: center;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .empty-icon {
            font-size: 4rem;
            color: #dfe6e9;
            margin-bottom: 20px;
        }

        .empty-title {
            font-size: 1.6rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--text-dark);
        }

        .empty-message {
            color: var(--text-light);
            margin-bottom: 30px;
            font-size: 1.1rem;
        }

        /* 性别指示器 */
        .gender-indicator {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 0.9rem;
            font-weight: 500;
        }

        .gender-male {
            background-color: rgba(52, 152, 219, 0.1);
            color: #2980b9;
        }

        .gender-female {
            background-color: rgba(231, 76, 60, 0.1);
            color: #e74c3c;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                align-items: flex-start;
            }

            .container {
                padding: 20px 15px;
            }

            table {
                min-width: 100%;
                overflow-x: auto;
                display: block;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 页面顶部区域 -->
    <div class="page-header">
        <div class="header-container">
            <h1 class="header-title">患者管理</h1>
            <div>
                <a href="${ctx}/patients?action=new" class="btn btn-add">
                    <i class="fas fa-plus"></i> 添加新患者
                </a>
            </div>
        </div>
    </div>

    <!-- 患者表格区域 -->
    <c:choose>
        <c:when test="${not empty patients}">
            <div class="patients-container">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>年龄</th>
                        <th>电话</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="patient" items="${patients}">
                        <tr>
                            <td>${patient.id}</td>
                            <td>
                                <div style="font-weight: 500;">${patient.name}</div>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${patient.gender == 'MALE'}">
                                        <span class="gender-indicator gender-male">男</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="gender-indicator gender-female">女</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${patient.age}</td>
                            <td>${patient.phone}</td>
                            <td class="action-links">
                                <a href="${ctx}/patients?action=edit&id=${patient.id}" class="action-link edit-link">
                                    <i class="fas fa-edit"></i> 编辑
                                </a>
                                <a href="${ctx}/patients?action=delete&id=${patient.id}"
                                   class="action-link delete-link"
                                   onclick="return confirm('确定删除此患者吗？')">
                                    <i class="fas fa-trash-alt"></i> 删除
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-state">
                <div class="empty-icon">
                    <i class="fas fa-user-injured"></i>
                </div>
                <h3 class="empty-title">暂无患者信息</h3>
                <p class="empty-message">当前系统中尚未添加任何患者信息</p>
                <a href="${ctx}/patients?action=new" class="btn btn-add">
                    <i class="fas fa-plus"></i> 添加患者
                </a>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- 页脚区域 -->
    <div class="page-footer">
        <a href="${ctx}/dashboard" class="btn btn-home">
            <i class="fas fa-home"></i> 返回首页
        </a>
    </div>
</div>
</body>
</html>