package com.hospital.controller;

import com.hospital.model.User;
import com.hospital.model.Patient;
import com.hospital.dao.PatientDao;
import com.hospital.dao.impl.PatientDaoImpl; // 导入实现类

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/my-profile")
public class ProfileServlet extends HttpServlet {

    private PatientDao patientDao;

    @Override
    public void init() throws ServletException {
        // 使用实现类创建实例
        this.patientDao = new PatientDaoImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Patient patient = patientDao.getPatientByUserId(user.getId());

            if (patient == null) {
                patient = new Patient();
                patient.setName(user.getUsername());
            }

            request.setAttribute("patient", patient);
            request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "加载个人信息失败: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
        }
    }
}