package com.hospital.controller.user;

import com.hospital.model.Patient;
import com.hospital.model.User;
import com.hospital.service.PatientService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/profile")
public class UserProfileServlet extends HttpServlet {
    private final PatientService patientService = new PatientService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // 获取上下文路径
            String contextPath = request.getContextPath();

            // 构建重定向路径
            String redirectPath = contextPath + "/login";

            // 确保路径以统一上下文开头
            if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
                redirectPath = "/Hosp/login";
            }

            response.sendRedirect(redirectPath);
            return;
        }

        Patient patient = patientService.getPatientByUserId(user.getId());
        request.setAttribute("patient", patient);
        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // 获取上下文路径
            String contextPath = request.getContextPath();

            // 构建重定向路径
            String redirectPath = contextPath + "/login";

            // 确保路径以统一上下文开头
            if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
                redirectPath = "/Hosp/login";
            }

            response.sendRedirect(redirectPath);
            return;
        }

        updateProfile(request, response, user.getId());
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        Patient patient = patientService.getPatientByUserId(userId);

        // 更新个人信息
        patient.setPhone(request.getParameter("phone"));
        patient.setAddress(request.getParameter("address"));
        patient.setEmergencyContact(request.getParameter("emergencyContact"));
        patient.setEmergencyPhone(request.getParameter("emergencyPhone"));

        patientService.updatePatient(patient);

        request.setAttribute("success", "个人信息更新成功");
        request.setAttribute("patient", patient);
        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
    }
}