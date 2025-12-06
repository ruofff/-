package com.hospital.controller;

import com.hospital.dao.PatientDao;
import com.hospital.model.Patient;
import com.hospital.util.DatabaseUtil;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/patients")
public class PatientServlet extends HttpServlet {
    private PatientDao patientDao;

    @Override
    public void init() {
        SqlSession sqlSession = DatabaseUtil.getSqlSession();
        patientDao = sqlSession.getMapper(PatientDao.class);
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
                    deletePatient(request, response);
                    break;
                case "list":
                default:
                    listPatients(request, response);
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
            insertPatient(request, response);
        } else if ("update".equals(action)) {
            updatePatient(request, response);
        } else {
            redirectToPatients(request, response);
        }
    }

    private void listPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Patient> patients = patientDao.getAllPatients();
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("/WEB-INF/views/patientList.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/patientForm.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Patient patient = patientDao.getPatientById(id);
        request.setAttribute("patient", patient);
        request.getRequestDispatcher("/WEB-INF/views/patientForm.jsp").forward(request, response);
    }

    private void insertPatient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Patient patient = new Patient();
        patient.setName(request.getParameter("name"));

        // 修复点：将字符串转换为 Gender 枚举
        String genderStr = request.getParameter("gender");
        if (genderStr != null && !genderStr.isEmpty()) {
            try {
                patient.setGender(Patient.Gender.fromDisplayName(genderStr));
            } catch (IllegalArgumentException e) {
                throw new RuntimeException("无效的性别值: " + genderStr);
            }
        } else {
            throw new RuntimeException("性别不能为空");
        }

        // 修改点1：使用年龄字段而不是出生日期
        patient.setAge(Integer.parseInt(request.getParameter("age")));

        patient.setPhone(request.getParameter("phone"));

        // 修改点2：添加紧急联系人信息
        patient.setEmergencyContact(request.getParameter("emergencyContact"));
        patient.setEmergencyPhone(request.getParameter("emergencyPhone"));

        // 修改点3：设置用户ID
        patient.setUserId(Integer.parseInt(request.getParameter("userId")));

        // 修改点4：设置创建时间为当前时间
        patient.setCreatedAt(LocalDateTime.now());

        patientDao.addPatient(patient);

        redirectToPatients(request, response);
    }

    private void updatePatient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Patient patient = patientDao.getPatientById(id);

        if (patient == null) {
            redirectToPatients(request, response);
            return;
        }

        patient.setName(request.getParameter("name"));

        // 修复点：将字符串转换为 Gender 枚举
        String genderStr = request.getParameter("gender");
        if (genderStr != null && !genderStr.isEmpty()) {
            try {
                patient.setGender(Patient.Gender.fromDisplayName(genderStr));
            } catch (IllegalArgumentException e) {
                throw new RuntimeException("无效的性别值: " + genderStr);
            }
        } else {
            throw new RuntimeException("性别不能为空");
        }

        // 修改点1：使用年龄字段而不是出生日期
        patient.setAge(Integer.parseInt(request.getParameter("age")));

        patient.setPhone(request.getParameter("phone"));

        // 修改点2：添加紧急联系人信息
        patient.setEmergencyContact(request.getParameter("emergencyContact"));
        patient.setEmergencyPhone(request.getParameter("emergencyPhone"));

        // 修改点3：更新用户ID
        patient.setUserId(Integer.parseInt(request.getParameter("userId")));

        patientDao.updatePatient(patient);

        redirectToPatients(request, response);
    }

    private void deletePatient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        patientDao.deletePatient(id);
        redirectToPatients(request, response);
    }

    private void redirectToPatients(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String contextPath = request.getContextPath();
        String redirectPath = contextPath + "/patients";

        if (contextPath == null || contextPath.isEmpty() || "/".equals(contextPath)) {
            redirectPath = "/Hosp/patients";
        }

        response.sendRedirect(redirectPath);
    }
}