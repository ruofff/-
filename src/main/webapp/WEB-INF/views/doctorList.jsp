<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>医生管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;     /* 主色 - 蓝色 */
            --success-color: #27ae60;     /* 成功色 - 绿色 */
            --danger-color: #e74c3c;      /* 危险色 - 红色 */
            --light-blue: #e8f4ff;        /* 浅蓝色 */
            --text-dark: #2c3e50;         /* 深色文本 */
            --text-medium: #4f5969;       /* 中深色文本 */
            --text-light: #7f8c8d;        /* 浅色文本 */
            --border-color: #e0e3e7;       /* 边框颜色 */
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
        }

        body {
            background-color: #f5f8fa;
            color: var(--text-dark);
            line-height: 1.6;
        }

        .container {
            max-width: 1180px;
            margin: 0 auto;
            padding: 25px 20px;
        }

        /* 页面标题区域 */
        .page-header {
            margin-bottom: 25px;
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

        .header-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .header-title {
            font-size: 1.9rem;
            font-weight: 600;
            letter-spacing: -0.5px;
        }

        /* 按钮样式 */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.25s ease;
            font-size: 0.95rem;
            border: 1px solid transparent;
        }

        .btn-home {
            background-color: #6c757d;
            color: white;
        }

        .btn-home:hover {
            background-color: #5a6268;
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-add {
            background-color: var(--success-color);
            color: white;
            font-weight: 600;
        }

        .btn-add:hover {
            background-color: #219653;
            box-shadow: 0 4px 12px rgba(39, 174, 96, 0.2);
            transform: translateY(-1px);
        }

        /* 医生表格样式 */
        .doctors-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            margin-top: 15px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            min-width: 800px;
        }

        thead {
            background: var(--light-blue);
        }

        th {
            padding: 18px 20px;
            text-align: left;
            font-weight: 600;
            color: var(--text-dark);
            font-size: 1.0rem;
            position: sticky;
            top: 0;
        }

        td {
            padding: 16px 20px;
            border-bottom: 1px solid var(--border-color);
            color: var(--text-medium);
            transition: background-color 0.2s;
        }

        tbody tr:hover td {
            background-color: #f9fcfd;
        }

        /* ID列样式 */
        td.id-cell {
            color: #95a5a6;
            font-weight: 500;
        }

        /* 操作列样式 */
        .action-links {
            display: flex;
            gap: 20px;
        }

        .action-links a {
            color: var(--text-medium);
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 6px 10px;
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .action-links a.edit-link {
            color: var(--success-color);
        }

        .action-links a.edit-link:hover {
            background: rgba(39, 174, 96, 0.1);
        }

        .action-links a.delete-link {
            color: var(--danger-color);
        }

        .action-links a.delete-link:hover {
            background: rgba(231, 76, 60, 0.1);
        }

        /* 空状态样式 */
        .empty-state {
            padding: 50px 30px;
            text-align: center;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            margin-top: 20px;
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

        /* 响应式设计 */
        @media (max-width: 992px) {
            .container {
                padding: 20px 15px;
            }

            th, td {
                padding: 15px;
            }

            .action-links {
                gap: 15px;
            }
        }

        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-title {
                font-size: 1.7rem;
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
    <!-- 页面标题区域 -->
    <div class="page-header">
        <div class="header-container">
            <div class="header-left">
                <a href="${ctx}/dashboard" class="btn btn-home">
                    <i class="fas fa-arrow-left"></i> 返回主页
                </a>
                <h1 class="header-title">医生管理</h1>
            </div>
            <div>
                <a href="${ctx}/doctors?action=new" class="btn btn-add">
                    <i class="fas fa-plus"></i> 添加新医生
                </a>
            </div>
        </div>
    </div>

    <!-- 医生表格区域 -->
    <c:choose>
        <c:when test="${not empty doctors}">
            <div class="doctors-container">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>姓名</th>
                        <th>职称</th>
                        <th>科室</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="doctor" items="${doctors}">
                        <tr>
                            <td class="id-cell">${doctor.id}</td>
                            <td>
                                <div style="font-weight: 500;">${doctor.name}</div>
                            </td>
                            <td>
                                <span style="color: var(--primary-color);">${doctor.title}</span>
                            </td>
                            <td>${doctor.department.name}</td>
                            <td class="action-links">
                                <a href="${ctx}/doctors?action=edit&id=${doctor.id}" class="edit-link">
                                    <i class="fas fa-edit"></i> 编辑
                                </a>
                                <a href="${ctx}/doctors?action=delete&id=${doctor.id}"
                                   class="delete-link"
                                   onclick="return confirm('确定删除该医生吗？')">
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
                    <i class="fas fa-user-md"></i>
                </div>
                <h3 class="empty-title">暂无医生信息</h3>
                <p class="empty-message">当前系统中尚未添加任何医生信息</p>
                <a href="${ctx}/doctors?action=new" class="btn btn-add">
                    <i class="fas fa-plus"></i> 添加医生
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>