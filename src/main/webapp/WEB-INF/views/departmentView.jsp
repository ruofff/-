<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
    <title>${department.name} - 科室详情</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
            padding: 0;
            margin: 0;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 顶部标题区域 */
        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        .header-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: #2c3e50;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 0.95rem;
            border: 1px solid #ddd;
            background-color: white;
            color: #444;
        }

        .btn:hover {
            background-color: #f5f7fa;
            border-color: #ccc;
        }

        .btn-primary {
            background-color: #6a5acd;
            color: white;
            border-color: #6a5acd;
        }

        .btn-primary:hover {
            background-color: #5a4ac0;
        }

        .btn i {
            font-size: 0.95rem;
        }

        /* 科室信息卡片 */
        .department-card {
            background-color: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }

        .department-info {
            margin-bottom: 25px;
        }

        .department-name {
            font-size: 1.8rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 15px;
        }

        .department-description {
            font-size: 1.1rem;
            color: #555;
            line-height: 1.7;
            max-width: 800px;
        }

        .section-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: #2c3e50;
            margin: 30px 0 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title i {
            color: #6a5acd;
        }

        .doctor-count {
            font-size: 1rem;
            font-weight: normal;
            color: #666;
            margin-left: 8px;
        }

        /* 医生列表 */
        .doctor-list {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .doctor-item {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border: 1px solid #eee;
        }

        .doctor-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .doctor-icon {
            width: 50px;
            height: 50px;
            background-color: #f0f3ff;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6a5acd;
            font-size: 1.5rem;
        }

        .doctor-info {
            flex-grow: 1;
        }

        .doctor-name {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 4px;
            color: #2c3e50;
        }

        .doctor-title {
            color: #6a5acd;
            font-size: 0.95rem;
            font-weight: 500;
        }

        .doctor-bio {
            color: #555;
            font-size: 1rem;
            line-height: 1.6;
        }

        /* 空状态 */
        .empty-state {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 40px 20px;
            text-align: center;
            border: 1px dashed #ddd;
            color: #777;
        }

        .empty-state i {
            font-size: 2.5rem;
            color: #ccc;
            margin-bottom: 15px;
        }

        .empty-state h3 {
            font-size: 1.3rem;
            margin-bottom: 10px;
            color: #555;
        }

        .empty-state p {
            font-size: 1rem;
        }

        /* 返回区域 */
        .back-section {
            margin-top: 30px;
            padding-top: 25px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: center;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 30px;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 1rem;
            border: 1px solid #6a5acd;
            background-color: white;
            color: #6a5acd;
        }

        .back-btn:hover {
            background-color: #f5f7ff;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .header-actions {
                width: 100%;
                justify-content: flex-start;
            }

            .doctor-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- 顶部导航 -->
    <div class="header-container">
        <h1 class="header-title">
            <i class="fas fa-stethoscope"></i> ${department.name} - 科室详情
        </h1>

        <div class="header-actions">
            <c:choose>
                <c:when test="${sessionScope.user.role == 'admin'}">
                    <a href="${ctx}/dashboard" class="btn">
                        <i class="fas fa-home"></i> 返回主页
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${ctx}/user/dashboard" class="btn">
                        <i class="fas fa-home"></i> 返回主页
                    </a>
                </c:otherwise>
            </c:choose>

            <c:if test="${sessionScope.user.role == 'admin'}">
                <a href="${ctx}/doctors?action=new&departmentId=${department.id}" class="btn btn-primary">
                    <i class="fas fa-user-plus"></i> 添加医生
                </a>
            </c:if>
        </div>
    </div>

    <!-- 科室信息 -->
    <div class="department-card">
        <div class="department-info">
            <h2 class="department-name">${department.name}</h2>
            <div class="department-description">
                ${department.description}
            </div>
        </div>

        <!-- 医生列表 -->
        <div>
            <h3 class="section-title">
                <i class="fas fa-user-md"></i> 医生列表
                <span class="doctor-count">(${department.doctors.size()}位)</span>
            </h3>

            <c:choose>
                <c:when test="${not empty department.doctors}">
                    <div class="doctor-list">
                        <c:forEach var="doctor" items="${department.doctors}">
                            <div class="doctor-item">
                                <div class="doctor-header">
                                    <div class="doctor-icon">
                                        <i class="fas fa-user-md"></i>
                                    </div>
                                    <div class="doctor-info">
                                        <div class="doctor-name">${doctor.name}</div>
                                        <div class="doctor-title">${doctor.title}</div>
                                    </div>
                                </div>

                                <div class="doctor-bio">
                                        ${doctor.bio}
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-user-md"></i>
                        <h3>暂无医生信息</h3>
                        <p>当前科室尚未添加医生信息</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 返回按钮 -->
    <div class="back-section">
        <c:if test="${sessionScope.user.role eq 'admin'}">
            <a href="${ctx}/departments" class="back-btn">
                <i class="fas fa-arrow-left"></i> 返回科室列表
            </a>
        </c:if>
    </div>
</div>
</body>
</html>