package com.hospital.controller;

import com.hospital.model.Appointment;
import com.hospital.service.AppointmentService;
import com.hospital.service.DoctorService;
import com.hospital.service.PatientService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/appointments")
public class AppointmentServlet extends HttpServlet {
    private AppointmentService appointmentService;
    private PatientService patientService;
    private DoctorService doctorService;

    @Override
    public void init() {
        // 使用无参构造函数初始化服务
        appointmentService = new AppointmentService();
        patientService = new PatientService();
        doctorService = new DoctorService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteAppointment(request, response);
                    break;
                case "list":
                default:
                    listAppointments(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if ("insert".equals(action)) {
            insertAppointment(request, response);
        } else if ("update".equals(action)) {
            updateAppointment(request, response);
        } else {
            // 获取上下文路径
            String contextPath = request.getContextPath();

            // 构建重定向路径
            String redirectPath = contextPath + "/appointments";

            // 确保路径以统一上下文开头
            if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
                redirectPath = "/Hosp/appointments";
            }

            response.sendRedirect(redirectPath);
        }
    }

    private void listAppointments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Appointment> appointments = appointmentService.getAllAppointments();
        request.setAttribute("appointments", appointments);
        request.getRequestDispatcher("/WEB-INF/views/appointmentList.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("patients", patientService.getAllPatients());
        request.setAttribute("doctors", doctorService.getAllDoctors());
        request.getRequestDispatcher("/WEB-INF/views/appointmentForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Appointment appointment = appointmentService.getAppointmentById(id);
        request.setAttribute("appointment", appointment);
        request.setAttribute("patients", patientService.getAllPatients());
        request.setAttribute("doctors", doctorService.getAllDoctors());
        request.getRequestDispatcher("/WEB-INF/views/appointmentForm.jsp").forward(request, response);
    }

    private void insertAppointment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Appointment appointment = new Appointment();
        appointment.setPatientId(Integer.parseInt(request.getParameter("patient")));
        appointment.setDoctorId(Integer.parseInt(request.getParameter("doctor")));

        // 合并日期和时间为 LocalDateTime
        LocalDate date = LocalDate.parse(request.getParameter("date"));
        LocalTime time = LocalTime.parse(request.getParameter("time"));

        // 使用正确的方法名设置日期时间
        appointment.setAppointmentDatetime(LocalDateTime.of(date, time));

        appointment.setNotes(request.getParameter("notes"));

        // 设置默认状态
        appointment.setStatus("待处理");

        appointmentService.addAppointment(appointment);

        // 获取上下文路径
        String contextPath = request.getContextPath();

        // 构建重定向路径
        String redirectPath = contextPath + "/appointments";

        // 确保路径以统一上下文开头
        if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
            redirectPath = "/Hosp/appointments";
        }

        response.sendRedirect(redirectPath);
    }

    private void updateAppointment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Appointment appointment = new Appointment();
        appointment.setId(id);
        appointment.setPatientId(Integer.parseInt(request.getParameter("patient")));
        appointment.setDoctorId(Integer.parseInt(request.getParameter("doctor")));

        // 合并日期和时间为 LocalDateTime
        LocalDate date = LocalDate.parse(request.getParameter("date"));
        LocalTime time = LocalTime.parse(request.getParameter("time"));

        // 使用正确的方法名设置日期时间
        appointment.setAppointmentDatetime(LocalDateTime.of(date, time));

        appointment.setNotes(request.getParameter("notes"));

        // 保持原有状态不变（或从请求中获取状态）
        // 如果需要更新状态，可以从请求参数中获取
        // appointment.setStatus(request.getParameter("status"));

        appointmentService.updateAppointment(appointment);

        // 获取上下文路径
        String contextPath = request.getContextPath();

        // 构建重定向路径
        String redirectPath = contextPath + "/appointments";

        // 确保路径以统一上下文开头
        if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
            redirectPath = "/Hosp/appointments";
        }

        response.sendRedirect(redirectPath);
    }

    private void deleteAppointment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        appointmentService.deleteAppointment(id);

        // 获取上下文路径
        String contextPath = request.getContextPath();

        // 构建重定向路径
        String redirectPath = contextPath + "/appointments";

        // 确保路径以统一上下文开头
        if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
            redirectPath = "/Hosp/appointments";
        }

        response.sendRedirect(redirectPath);
    }
}