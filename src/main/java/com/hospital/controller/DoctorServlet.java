package com.hospital.controller;

import com.hospital.model.Department;
import com.hospital.model.Doctor;
import com.hospital.service.DepartmentService;
import com.hospital.service.DoctorService;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/doctors")
public class DoctorServlet extends HttpServlet {
    private DoctorService doctorService;
    private DepartmentService departmentService;

    @Override
    public void init() {
        // 初始化服务层
        doctorService = new DoctorService();
        departmentService = new DepartmentService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置请求和响应编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

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
                    deleteDoctor(request, response);
                    break;
                case "list":
                default:
                    listDoctors(request, response);
                    break;
            }
        } catch (Exception ex) {
            // 捕获并处理所有异常
            handleException(request, response, ex, "处理请求时出错: ");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置请求和响应编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        try {
            if ("insert".equals(action)) {
                insertDoctor(request, response);
            } else if ("update".equals(action)) {
                updateDoctor(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/doctors");
            }
        } catch (Exception e) {
            // 捕获并处理所有异常
            handleException(request, response, e, "提交数据时出错: ");
        }
    }

    private void listDoctors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Doctor> doctors = doctorService.getAllDoctors();
            request.setAttribute("doctors", doctors);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/doctorList.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            handleException(request, response, e, "获取医生列表失败: ");
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 使用重载方法，只传入一个参数
            List<Department> departments = departmentService.getAllDepartments();
            request.setAttribute("departments", departments);

            // 创建一个空的医生对象
            Doctor doctor = new Doctor();
            doctor.setDepartment(new Department()); // 初始化空部门对象
            request.setAttribute("doctor", doctor);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/doctorForm.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            handleException(request, response, e, "加载新医生表单失败: ");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Doctor doctor = doctorService.getDoctorById(id);

            // 使用重载方法，只传入一个参数
            List<Department> departments = departmentService.getAllDepartments();

            request.setAttribute("doctor", doctor);
            request.setAttribute("departments", departments);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/doctorForm.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            handleException(request, response, e, "加载编辑表单失败: ");
        }
    }

    private void insertDoctor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 从请求参数中获取数据
            String name = request.getParameter("name");
            String title = request.getParameter("title");
            int departmentId = Integer.parseInt(request.getParameter("departmentId"));
            String bio = request.getParameter("bio");

            // 创建新医生对象
            Doctor doctor = new Doctor();
            doctor.setName(name);
            doctor.setTitle(title);
            doctor.setDepartmentId(departmentId);
            doctor.setBio(bio);

            // 保存医生
            boolean success = doctorService.addDoctor(doctor);

            if (success) {
                // 添加成功，重定向到医生列表
                response.sendRedirect(request.getContextPath() + "/doctors");
            } else {
                // 添加失败，返回表单并显示错误
                request.setAttribute("error", "添加医生失败，请重试");
                List<Department> departments = departmentService.getAllDepartments();
                request.setAttribute("departments", departments);
                request.setAttribute("doctor", doctor);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/doctorForm.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            // 异常处理
            handleException(request, response, e, "添加医生失败: ");
        }
    }

    private void updateDoctor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 从表单参数中获取医生ID
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new IllegalArgumentException("缺少医生ID参数");
            }

            int id = Integer.parseInt(idParam);

            // 获取现有医生记录
            Doctor existingDoctor = doctorService.getDoctorById(id);
            if (existingDoctor == null) {
                throw new Exception("未找到ID为 " + id + " 的医生");
            }

            // 更新医生信息
            existingDoctor.setName(request.getParameter("name"));
            existingDoctor.setTitle(request.getParameter("title"));
            existingDoctor.setDepartmentId(Integer.parseInt(request.getParameter("departmentId")));
            existingDoctor.setBio(request.getParameter("bio"));

            // 保存更新
            boolean success = doctorService.updateDoctor(existingDoctor);

            if (success) {
                // 更新成功，重定向到医生列表
                response.sendRedirect(request.getContextPath() + "/doctors");
            } else {
                // 更新失败，返回表单并显示错误
                request.setAttribute("error", "更新医生信息失败，请重试");
                List<Department> departments = departmentService.getAllDepartments();
                request.setAttribute("departments", departments);
                request.setAttribute("doctor", existingDoctor);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/doctorForm.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            // 异常处理
            handleException(request, response, e, "更新医生失败: ");
        }
    }

    private void deleteDoctor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = doctorService.deleteDoctor(id);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/doctors");
            } else {
                throw new Exception("删除医生失败，请重试");
            }
        } catch (Exception e) {
            handleException(request, response, e, "删除医生失败: ");
        }
    }


    // 统一的异常处理方法
    private void handleException(HttpServletRequest request, HttpServletResponse response,
                                 Exception e, String prefix)
            throws ServletException, IOException {
        // 记录日志（实际项目中应使用日志框架）
        System.err.println(prefix + e.getMessage());
        e.printStackTrace();

        // 设置错误信息并转发到错误页面
        request.setAttribute("error", prefix + e.getMessage());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/error.jsp");
        dispatcher.forward(request, response);
    }
}