package com.hospital.controller;

import com.hospital.dao.UserDao;
import com.hospital.model.User;
import com.hospital.util.DatabaseUtil;
import com.hospital.util.PasswordUtil;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 添加错误消息处理
        String error = request.getParameter("error");
        if (error != null) {
            request.setAttribute("error", getErrorMessage(error));
        }

        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        // 获取表单数据
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 基本验证
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            // 修复：重定向到/login而不是/login.jsp
            response.sendRedirect(request.getContextPath() + "/login?error=validation");
            return;
        }

        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            UserDao userDao = sqlSession.getMapper(UserDao.class);

            // 获取用户信息
            User user = userDao.getUserByUsername(username);

            // 用户不存在或密码不匹配
            if (user == null) {
                // 修复：重定向到/login而不是/login.jsp
                response.sendRedirect(request.getContextPath() + "/login?error=credentials");
                return;
            }

            // 关键修复：对输入的密码进行加密后比较
            String encryptedPassword = PasswordUtil.hashPassword(password);

            if (!user.getPassword().equals(encryptedPassword)) {
                // 修复：重定向到/login而不是/login.jsp
                response.sendRedirect(request.getContextPath() + "/login?error=credentials");
                return;
            }

            // 登录成功：创建会话
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // 重定向到系统首页
            if ("admin".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                // 修复：确保路径与UserDashboardServlet匹配
                response.sendRedirect(request.getContextPath() + "/user/dashboard");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // 修复：重定向到/login而不是/login.jsp
            response.sendRedirect(request.getContextPath() + "/login?error=server");
        }
    }

    // 错误消息映射
    private String getErrorMessage(String errorCode) {
        switch (errorCode) {
            case "validation":
                return "请输入有效的用户名和密码";
            case "credentials":
                return "用户名或密码错误";
            case "server":
                return "服务器错误，请稍后再试";
            default:
                return "登录失败，请重试";
        }
    }
}