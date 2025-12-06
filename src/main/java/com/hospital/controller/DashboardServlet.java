package com.hospital.controller;

import com.hospital.model.User;
import com.hospital.service.DepartmentService;
import com.hospital.service.DoctorService;
import com.hospital.service.PatientService;
import com.hospital.service.AppointmentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private final DepartmentService departmentService = new DepartmentService();
    private final DoctorService doctorService = new DoctorService();
    private final PatientService patientService = new PatientService();
    private final AppointmentService appointmentService = new AppointmentService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        // 验证用户是否登录
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 关键修复：根据用户角色显示不同仪表盘
        if ("admin".equals(user.getRole())) {
            // 管理员仪表盘
            int departmentCount = departmentService.getAllDepartments(false).size();
            int doctorCount = doctorService.getAllDoctors().size();
            int patientCount = patientService.getAllPatients().size();
            int appointmentCount = appointmentService.getAllAppointments().size();

            request.setAttribute("departmentCount", departmentCount);
            request.setAttribute("doctorCount", doctorCount);
            request.setAttribute("patientCount", patientCount);
            request.setAttribute("appointmentCount", appointmentCount);

            request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
        } else {
            // 普通用户重定向到用户仪表盘
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        }
    }
}