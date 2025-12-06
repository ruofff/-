package com.hospital.controller;

import com.hospital.model.Department;
import com.hospital.service.DepartmentService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/departments")
public class DepartmentServlet extends HttpServlet {
    private DepartmentService departmentService = new DepartmentService();

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
                case "view":
                    viewDepartment(request, response);
                    break;
                case "delete":
                    deleteDepartment(request, response);
                    break;
                case "list":
                default:
                    listDepartments(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException("处理科室请求失败", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if ("insert".equals(action)) {
            insertDepartment(request, response);
        } else if ("update".equals(action)) {
            updateDepartment(request, response);
        } else {
            // 获取上下文路径
            String contextPath = request.getContextPath();

            // 构建重定向路径
            String redirectPath = contextPath + "/departments";

            // 确保路径以统一上下文开头
            if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
                redirectPath = "/Hosp/departments";
            }

            response.sendRedirect(redirectPath);
        }
    }

    private void listDepartments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        boolean withDoctors = "true".equals(request.getParameter("withDoctors"));
        List<Department> departments = departmentService.getAllDepartments(withDoctors);
        request.setAttribute("departments", departments);
        request.getRequestDispatcher("/WEB-INF/views/departmentList.jsp").forward(request, response);
    }

    private void viewDepartment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Department department = departmentService.getDepartmentById(id, true);
        request.setAttribute("department", department);
        request.getRequestDispatcher("/WEB-INF/views/departmentView.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/departmentForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Department department = departmentService.getDepartmentById(id, false);
        request.setAttribute("department", department);
        request.getRequestDispatcher("/WEB-INF/views/departmentForm.jsp").forward(request, response);
    }

    private void insertDepartment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Department department = new Department();
        department.setName(request.getParameter("name"));
        department.setDescription(request.getParameter("description"));

        departmentService.addDepartment(department);

        // 获取上下文路径
        String contextPath = request.getContextPath();

        // 构建重定向路径
        String redirectPath = contextPath + "/departments";

        // 确保路径以统一上下文开头
        if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
            redirectPath = "/Hosp/departments";
        }

        response.sendRedirect(redirectPath);
    }

    private void updateDepartment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Department department = new Department();
        department.setId(Integer.parseInt(request.getParameter("id")));
        department.setName(request.getParameter("name"));
        department.setDescription(request.getParameter("description"));

        departmentService.updateDepartment(department);

        // 获取上下文路径
        String contextPath = request.getContextPath();

        // 构建重定向路径
        String redirectPath = contextPath + "/departments";

        // 确保路径以统一上下文开头
        if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
            redirectPath = "/Hosp/departments";
        }

        response.sendRedirect(redirectPath);
    }

    private void deleteDepartment(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        departmentService.deleteDepartment(id);

        // 获取上下文路径
        String contextPath = request.getContextPath();

        // 构建重定向路径
        String redirectPath = contextPath + "/departments";

        // 确保路径以统一上下文开头
        if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
            redirectPath = "/Hosp/departments";
        }

        response.sendRedirect(redirectPath);
    }
}