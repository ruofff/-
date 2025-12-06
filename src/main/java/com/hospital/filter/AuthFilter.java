package com.hospital.filter;

import com.hospital.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@WebFilter("/*")
public class AuthFilter implements Filter {

    private FilterConfig filterConfig;

    // 普通用户允许访问的路径
    private static final Set<String> USER_ALLOWED_PATHS = new HashSet<>(Arrays.asList(
            "/user/doctors", //医生列表
            "/user/doctor",  //医生详情
            "/user/dashboard",
            "/user/appointments",
            "/user/appointment",
            "/user/appointments/new",   // 新建预约
            "/user/appointments/create",// 兼容旧路径
            "/user/appointments/my",    // 我的预约
            "/user/appointments/cancel",// 取消预约
            "/user/profile",
            "/user/my-profile",
            "/departments",
            "/patient/profile",
            "/logout"
//            "/regster"
    ));

    // 管理员允许访问的路径
    private static final Set<String> ADMIN_ALLOWED_PATHS = new HashSet<>(Arrays.asList(
            "/dashboard",
            "/doctors",
            "/departments",
            "/patients",
            "/appointments",
            "/admin/doctors",
            "/admin/departments",
            "/admin/patients",
            "/admin/appointments"
//            "/regster"
    ));

    // 公共访问路径（无需登录）
    private static final Set<String> PUBLIC_PATHS = new HashSet<>(Arrays.asList(
            "/login",
            "/index.jsp",
            "/static/",
            "/register"
    ));

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        String appName = filterConfig.getInitParameter("appName");
        if (appName != null) {
            System.out.println("AuthFilter initialized for application: " + appName);
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        // 将 ServletRequest 转换为 HttpServletRequest
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String contextPath = httpRequest.getContextPath();
        String requestURI = httpRequest.getRequestURI();
        String normalizedURI = requestURI.substring(contextPath.length());

        // 检查是否公共路径
        if (isPublicPath(normalizedURI)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // 检查用户是否已登录
        if (user == null) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        // 验证角色访问权限
        if (!hasAccessPermission(user, normalizedURI)) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "您没有权限访问此页面");
            return;
        }

        // 修复参数类型：使用 httpRequest 而不是 request
        if (isRedirectToUnsafePath(httpRequest, normalizedURI)) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "禁止的访问路径");
            return;
        }

        chain.doFilter(request, response);
    }

    /**
     * 检查是否为公共路径（无需登录）
     */
    private boolean isPublicPath(String path) {
        for (String publicPath : PUBLIC_PATHS) {
            if (path.startsWith(publicPath)) {
                return true;
            }
        }
        return false;
    }

    /**
     * 检查用户是否有访问权限
     */
    private boolean hasAccessPermission(User user, String path) {
        if ("admin".equals(user.getRole())) {
            return isAdminAllowedPath(path);
        } else {
            return isUserAllowedPath(path);
        }
    }

    /**
     * 检查是否为普通用户允许的路径
     */
    private boolean isUserAllowedPath(String path) {
        // 普通用户可以查看医生详情
        if (path.startsWith("/doctors") && path.contains("action=view")) {
            return true;
        }
        // 普通用户可以查看科室详情
        if (path.startsWith("/departments") && path.contains("action=view")) {
            return true;
        }
        // 普通用户可以管理自己的预约
        if (path.startsWith("/appointments") && (path.contains("action=new") || path.contains("action=my"))) {
            return true;
        }

        return USER_ALLOWED_PATHS.contains(path) ||
                USER_ALLOWED_PATHS.stream().anyMatch(path::startsWith);
    }

    /**
     * 检查是否为管理员允许的路径
     */
    private boolean isAdminAllowedPath(String path) {
        // 管理员可以访问所有基础路径
        if (path.startsWith("/doctors") || path.startsWith("/departments") ||
                path.startsWith("/patients") || path.startsWith("/appointments")) {
            return true;
        }

        return ADMIN_ALLOWED_PATHS.contains(path) ||
                ADMIN_ALLOWED_PATHS.stream().anyMatch(path::startsWith);
    }

    /**
     * 检查是否尝试重定向到不安全路径
     */
    private boolean isRedirectToUnsafePath(HttpServletRequest request, String normalizedURI) {
        if (request.getParameter("redirect") != null) {
            String redirectPath = request.getParameter("redirect");
            if (redirectPath.startsWith("/admin") && !"admin".equals(getUserRole(request))) {
                return true;
            }
        }

        // 防止普通用户尝试访问管理员路径
        if (normalizedURI.startsWith("/admin") && !"admin".equals(getUserRole(request))) {
            return true;
        }

        return false;
    }

    /**
     * 从会话中获取用户角色
     */
    private String getUserRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            return (user != null) ? user.getRole() : "";
        }
        return "";
    }

    @Override
    public void destroy() {
        System.out.println("AuthFilter is being destroyed");
        if (this.filterConfig != null) {
            this.filterConfig = null;
        }
    }
}