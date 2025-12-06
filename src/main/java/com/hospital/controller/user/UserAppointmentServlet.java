package com.hospital.controller.user;

import com.hospital.model.*;
import com.hospital.service.AppointmentService;
import com.hospital.service.DoctorService;
import com.hospital.service.PatientService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.io.UnsupportedEncodingException;

@WebServlet("/user/appointments/*")
public class UserAppointmentServlet extends HttpServlet {
    private final AppointmentService appointmentService = new AppointmentService();
    private final DoctorService doctorService = new DoctorService();
    private final PatientService patientService = new PatientService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            redirectToLogin(request, response);
            return;
        }

        String action = request.getPathInfo();
        if (action == null) action = "/list";

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response, user.getId());
                    break;
                case "/edit":
                    showEditForm(request, response, user.getId());
                    break;
                case "/cancel":
                    cancelAppointment(request, response, user.getId());
                    break;
                case "/my":
                default:
                    listMyAppointments(request, response, user.getId());
                    break;
            }
        } catch (Exception e) {
            handleError(request, response, "操作失败: " + e.getMessage(), "/WEB-INF/views/user/appointmentList.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            redirectToLogin(request, response);
            return;
        }

        String action = request.getPathInfo();
        if (action == null) action = "/insert";

        try {
            switch (action) {
                case "/insert":
                    createAppointment(request, response, user.getId());
                    break;
                case "/update":
                    updateAppointment(request, response, user.getId());
                    break;
                default:
                    redirectToAppointments(request, response);
                    break;
            }
        } catch (Exception e) {
            handleError(request, response, "操作失败: " + e.getMessage(), "/WEB-INF/views/user/appointmentForm.jsp");
        }
    }

    private void redirectToLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String contextPath = request.getContextPath();
        String redirectPath = contextPath + "/login";

        if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
            redirectPath = "/Hosp/login";
        }

        response.sendRedirect(redirectPath);
    }

    private void redirectToAppointments(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String contextPath = request.getContextPath();
        String redirectPath = contextPath + "/user/appointments/my";

        if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
            redirectPath = "/Hosp/user/appointments/my";
        }

        response.sendRedirect(redirectPath);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
                             String errorMessage, String viewPath)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher(viewPath).forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            // 获取所有医生列表
            DoctorService doctorService = new DoctorService();
            List<Doctor> doctors = doctorService.getAllDoctors();

            // 添加日志
            System.out.println("准备显示预约表单，医生数量: " + doctors.size());

            // 将医生列表存入请求属性
            request.setAttribute("doctors", doctors);

            // 获取当前用户关联的患者信息（如果有）
            PatientService patientService = new PatientService();
            Patient patient = patientService.getPatientByUserId(userId);
            request.setAttribute("patient", patient);

            // 设置当前时间选项的默认值
            request.setAttribute("defaultDate", LocalDate.now().plusDays(1).toString());
            request.setAttribute("defaultTime", "10:00");

            // 分发到预约表单视图
            request.getRequestDispatcher("/WEB-INF/views/user/appointmentForm.jsp").forward(request, response);

        } catch (Exception e) {
            // 错误处理
            System.err.println("显示新建预约表单失败: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("error", "加载预约表单失败: " + e.getMessage());
            listMyAppointments(request, response, userId);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            int appointmentId = Integer.parseInt(request.getParameter("id"));
            Appointment appointment = appointmentService.getAppointmentById(appointmentId);

            // 验证用户是否有权编辑这个预约
            if (appointment == null || appointment.getPatient().getUserId() != userId) {
                request.setAttribute("error", "无权编辑此预约");
                listMyAppointments(request, response, userId);
                return;
            }

            // 获取所有医生列表
            List<Doctor> doctors = doctorService.getAllDoctors();

            // 获取当前预约关联的患者信息
            Patient patient = appointment.getPatient();
            request.setAttribute("patient", patient);

            request.setAttribute("appointment", appointment);
            request.setAttribute("doctors", doctors);
            request.getRequestDispatcher("/WEB-INF/views/user/appointmentForm.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "获取预约信息失败: " + e.getMessage());
            listMyAppointments(request, response, userId);
        }
    }

    private void listMyAppointments(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            List<Appointment> appointments = appointmentService.getAppointmentsByUserId(userId);
            request.setAttribute("appointments", appointments);
            request.getRequestDispatcher("/WEB-INF/views/user/appointmentList.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "获取预约列表失败: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/user/appointmentList.jsp").forward(request, response);
        }
    }

    private void updateAppointment(HttpServletRequest request, HttpServletResponse response, int userId)
            throws Exception {
        int appointmentId = Integer.parseInt(request.getParameter("id"));
        Appointment existingAppointment = appointmentService.getAppointmentById(appointmentId);

        // 验证用户是否有权编辑这个预约
        if (existingAppointment == null || existingAppointment.getPatient().getUserId() != userId) {
            request.setAttribute("error", "无权更新此预约");
            listMyAppointments(request, response, userId);
            return;
        }

        // 更新患者信息（姓名、年龄等）
        Patient patient = existingAppointment.getPatient();
        updatePatientFromRequest(request, patient);
        patientService.updatePatient(patient);

        // 更新预约信息
        Appointment appointment = new Appointment();
        appointment.setId(appointmentId);
        appointment.setPatientId(patient.getId());
        appointment.setDoctorId(Integer.parseInt(request.getParameter("doctorId")));

        // 解析日期和时间
        LocalDate date = LocalDate.parse(request.getParameter("date"));
        LocalTime time = LocalTime.parse(request.getParameter("time"));
        appointment.setAppointmentDatetime(LocalDateTime.of(date, time));

        appointment.setStatus(existingAppointment.getStatus());
        appointment.setNotes(request.getParameter("notes"));

        // 更新预约
        appointmentService.updateAppointment(appointment);

        // 重定向到我的预约页面
        redirectToAppointments(request, response);
    }

    private void cancelAppointment(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        int appointmentId = Integer.parseInt(request.getParameter("id"));
        Appointment appointment = appointmentService.getAppointmentById(appointmentId);

        // 验证用户是否有权取消这个预约
        if (appointment == null || appointment.getPatient().getUserId() != userId) {
            request.setAttribute("error", "无权取消此预约");
            listMyAppointments(request, response, userId);
            return;
        }

        // 取消预约（更新状态）
        appointment.setStatus("已取消");
        appointmentService.updateAppointment(appointment);

        // 重定向到我的预约页面
        redirectToAppointments(request, response);
    }

    // 创建预约的核心方法
    private void createAppointment(HttpServletRequest request, HttpServletResponse response, int userId)
            throws Exception {
        try {
            // 1. 获取或创建患者
            Patient patient = patientService.getPatientByUserId(userId);
            boolean isNewPatient = (patient == null);

            if (isNewPatient) {
                patient = new Patient();
                patient.setUserId(userId);
            }

            // 2. 更新患者信息
            updatePatientFromRequest(request, patient);

            // 3. 保存或更新患者记录
            if (isNewPatient) {
                patientService.createPatient(patient);
            } else {
                patientService.updatePatient(patient);
            }

            // 4. 验证患者记录
            if (patient.getId() <= 0) {
                throw new ServletException("无法获取有效的患者记录");
            }

            // 5. 创建预约
            Appointment appointment = new Appointment();
            appointment.setPatientId(patient.getId());
            appointment.setDoctorId(Integer.parseInt(request.getParameter("doctorId")));

            // 解析日期和时间
            LocalDate date = LocalDate.parse(request.getParameter("date"));
            LocalTime time = LocalTime.parse(request.getParameter("time"));
            appointment.setAppointmentDatetime(LocalDateTime.of(date, time));

            appointment.setStatus("待处理");
            appointment.setNotes(request.getParameter("notes"));

            // 6. 保存预约
            appointmentService.addAppointment(appointment);

            // 7. 重定向
            redirectToAppointments(request, response);

        } catch (Exception e) {
            // 错误处理
            System.err.println("创建预约失败: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("error", "创建预约失败: " + e.getMessage());
            showNewForm(request, response, userId);
        }
    }

    // 从请求中更新患者信息
    private void updatePatientFromRequest(HttpServletRequest request, Patient patient) {
        // 获取表单参数
        String name = request.getParameter("patientName");
        String ageStr = request.getParameter("patientAge");
        String genderStr = request.getParameter("patientGender");
        String phone = request.getParameter("patientPhone");
        String emergencyContact = request.getParameter("emergencyContact");
        String emergencyPhone = request.getParameter("emergencyPhone");

        // 设置患者姓名
        patient.setName(name);

        // 设置年龄
        try {
            int age = Integer.parseInt(ageStr);
            if (age < 0 || age > 120) {
                throw new IllegalArgumentException("年龄必须在0-120之间");
            }
            patient.setAge(age);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("无效的年龄格式");
        }

        // 关键修复：使用新的枚举转换方法
        if (genderStr != null && !genderStr.isEmpty()) {
            try {
                // 使用枚举的fromDisplayName方法
                Patient.Gender gender = Patient.Gender.fromDisplayName(genderStr);
                patient.setGender(gender);
            } catch (IllegalArgumentException e) {
                // 添加详细日志
                System.err.println("性别转换失败: " + genderStr);
                e.printStackTrace();
                throw e;
            }
        } else {
            throw new IllegalArgumentException("性别不能为空");
        }

        // 设置电话号码
        patient.setPhone(phone);

        // 设置紧急联系人信息
        patient.setEmergencyContact(emergencyContact);
        patient.setEmergencyPhone(emergencyPhone);
    }

    // 添加编码转换方法
    private String convertEncoding(String input) {
        if (input == null) return null;

        try {
            // 尝试将 ISO-8859-1 编码的字符串转换为 UTF-8
            byte[] bytes = input.getBytes("ISO-8859-1");
            return new String(bytes, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // 如果转换失败，返回原始值
            return input;
        }
    }
}