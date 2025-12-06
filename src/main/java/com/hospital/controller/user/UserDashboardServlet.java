package com.hospital.controller.user;

import com.hospital.model.Department;
import com.hospital.model.User;
import com.hospital.service.AppointmentService;
import com.hospital.service.DepartmentService;
import com.hospital.service.DoctorService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {
    private final DepartmentService departmentService = new DepartmentService();
    private final DoctorService doctorService = new DoctorService();
    private final AppointmentService appointmentService = new AppointmentService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 获取数据
        int departmentCount = departmentService.getAllDepartments(false).size();
        int doctorCount = doctorService.getAllDoctors().size();
        List<Department> featuredDepartments = departmentService.getAllDepartments(false).subList(0, Math.min(4, departmentCount));

        request.setAttribute("departmentCount", departmentCount);
        request.setAttribute("doctorCount", doctorCount);
        request.setAttribute("featuredDepartments", featuredDepartments);

        request.getRequestDispatcher("/WEB-INF/views/user/dashboard.jsp").forward(request, response);
    }
}