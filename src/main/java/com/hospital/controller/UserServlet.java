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
import java.io.IOException;

@WebServlet("/register")
public class UserServlet extends HttpServlet {

    static {
        System.out.println("UserServlet已加载");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("处理GET请求到/register");
        response.sendRedirect(request.getContextPath() + "/login?showRegister=true");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("===== 进入UserServlet doPost方法 =====");
        System.out.println("请求URI: " + request.getRequestURI());
        System.out.println("上下文路径: " + request.getContextPath());
        System.out.println("Servlet路径: " + request.getServletPath());

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = "user";

        System.out.println("注册参数: username=" + username + ", password=" + password);

        // 基本验证
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                !password.equals(confirmPassword)) {
            System.out.println("验证失败，重定向到登录页");
            response.sendRedirect(request.getContextPath() + "/login?error=validation&showRegister=true");
            return;
        }

        // 密码强度验证
        if (password.length() < 6) {
            System.out.println("密码长度不足，重定向到登录页");
            response.sendRedirect(request.getContextPath() + "/login?error=password_length&showRegister=true");
            return;
        }

        SqlSession sqlSession = null;
        try {
            System.out.println("获取数据库会话");
            sqlSession = DatabaseUtil.getSqlSession();
            UserDao userDao = sqlSession.getMapper(UserDao.class);

            // 检查用户名是否已存在
            System.out.println("检查用户名是否存在: " + username);
            User existingUser = userDao.getUserByUsername(username);
            if (existingUser != null) {
                System.out.println("用户名已存在: " + username);
                response.sendRedirect(request.getContextPath() + "/login?error=username_exists&showRegister=true");
                return;
            }

            // 创建用户
            User user = new User();
            user.setUsername(username);
            user.setPassword(PasswordUtil.hashPassword(password));
            user.setRole(role);

            System.out.println("准备插入用户: " + username);
            userDao.addUser(user);
            System.out.println("用户插入成功，ID: " + user.getId());

            // 提交事务
            sqlSession.commit();
            System.out.println("事务提交成功");

            // 重定向到登录页面
            System.out.println("重定向到登录页");
            response.sendRedirect(request.getContextPath() + "/login?success=true");

        } catch (Exception e) {
            System.err.println("注册过程中发生异常: ");
            e.printStackTrace();

            if (sqlSession != null) {
                sqlSession.rollback();
                System.err.println("事务已回滚");
            }

            response.sendRedirect(request.getContextPath() + "/login?error=server&showRegister=true");
        } finally {
            if (sqlSession != null) {
                sqlSession.close();
            }
        }
    }
}