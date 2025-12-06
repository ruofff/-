<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>科室管理</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db; /* 蓝色 */
            --success-color: #27ae60; /* 绿色 */
            --danger-color: #e74c3c; /* 红色 */
            --light-bg: #f5f7fa; /* 浅灰背景 */
            --text-color: #2c3e50; /* 深蓝灰文本 */
            --border-color: #e0e3e7; /* 边框颜色 */
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
        }

        body {
            background-color: #f9fbfd;
            color: #34495e;
            line-height: 1.6;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 25px 20px;
        }

        /* 顶部标题区域 */
        .header-section {
            margin-bottom: 30px;
            padding: 15px 0;
            position: relative;
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .header-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--text-color);
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
            transition: all 0.2s ease;
            font-size: 0.95rem;
            border: 1px solid transparent;
        }

        .btn-home {
            background-color: #6c757d;
            color: white;
        }

        .btn-home:hover {
            background-color: #5a6268;
        }

        .btn-add {
            background-color: var(--success-color);
            color: white;
            font-weight: 600;
        }

        .btn-add:hover {
            background-color: #219653;
            box-shadow: 0 4px 12px rgba(39, 174, 96, 0.2);
        }

        .btn-edit {
            background-color: var(--success-color);
            color: white;
        }

        .btn-edit:hover {
            background-color: #219653;
        }

        .btn-delete {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        /* 科室卡片列表 */
        .department-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(330px, 1fr));
            gap: 28px;
            margin-top: 20px;
        }

        /* 科室卡片样式 */
        .department-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            position: relative;
            border: 1px solid var(--border-color);
        }

        .department-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }

        .card-header {
            padding: 22px 22px 18px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .department-name {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-color);
            line-height: 1.3;
        }

        .doctor-count {
            background-color: var(--primary-color);
            color: white;
            padding: 4px 12px;
            border-radius: 30px;
            font-size: 0.9rem;
            font-weight: 500;
            height: 28px;
            display: flex;
            align-items: center;
        }

        .card-content {
            padding: 20px 22px;
            min-height: 110px;
        }

        .department-description {
            color: #4f5969;
            line-height: 1.7;
            font-size: 1.0rem;
        }

        /* 操作按钮区域 */
        .card-actions {
            display: flex;
            gap: 12px;
            padding: 18px 22px;
            background-color: var(--light-bg);
            border-top: 1px solid var(--border-color);
        }

        .action-btn {
            flex: 1;
            text-align: center;
            border-radius: 6px;
            font-weight: 500;
            font-size: 0.95rem;
            padding: 8px;
            transition: all 0.2s ease;
        }

        /* 空状态 */
        .empty-state {
            text-align: center;
            padding: 60px 30px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            margin-top: 30px;
            border: 1px solid var(--border-color);
        }

        .empty-icon {
            font-size: 56px;
            color: #aab5c3;
            margin-bottom: 20px;
        }

        .empty-title {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: #4f5969;
            font-weight: 600;
        }

        .empty-message {
            color: #6c757d;
            margin-bottom: 30px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                align-items: flex-start;
            }

            .header-title {
                font-size: 1.6rem;
            }

            .department-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 顶部标题区域 -->
    <div class="header-section">
        <div class="header-container">
            <div class="header-left">
                <c:choose>
                    <c:when test="${sessionScope.user.role == 'admin'}">
                        <a href="${ctx}/dashboard" class="btn btn-home">
                            <i class="fas fa-arrow-left"></i> 返回主页
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${ctx}/user/dashboard" class="btn btn-home">
                            <i class="fas fa-arrow-left"></i> 返回主页
                        </a>
                    </c:otherwise>
                </c:choose>
                <h1 class="header-title">科室管理</h1>
            </div>
            <div>
                <c:if test="${sessionScope.user.role == 'admin'}">
                    <a href="${ctx}/departments?action=new" class="btn btn-add">
                        <i class="fas fa-plus"></i> 添加新科室
                    </a>
                </c:if>
            </div>
        </div>
    </div>

    <!-- 科室列表 -->
    <div class="department-grid">
        <c:choose>
            <c:when test="${not empty departments}">
                <c:forEach var="department" items="${departments}">
                    <div class="department-card">
                        <!-- 科室标题和医生数量 -->
                        <div class="card-header">
                            <div class="department-name">${department.name}</div>
                        </div>

                        <!-- 科室描述 -->
                        <div class="card-content">
                            <p class="department-description">
                                    ${department.description}
                            </p>
                        </div>

                        <!-- 操作按钮 -->
                        <div class="card-actions">
                            <a href="${ctx}/departments?action=edit&id=${department.id}"
                               class="action-btn btn btn-edit">
                                <i class="fas fa-edit"></i> 编辑
                            </a>
                            <a href="${ctx}/departments?action=delete&id=${department.id}"
                               onclick="return confirm('确定删除此科室? 这将同时删除所有关联的医生信息')"
                               class="action-btn btn btn-delete">
                                <i class="fas fa-trash-alt"></i> 删除
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="fas fa-hospital"></i>
                    </div>
                    <h3 class="empty-title">暂无科室信息</h3>
                    <p class="empty-message">当前系统中尚未添加任何科室信息</p>

                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <div>
                            <a href="${ctx}/departments?action=new" class="btn btn-add">
                                <i class="fas fa-plus"></i> 添加科室
                            </a>
                        </div>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>