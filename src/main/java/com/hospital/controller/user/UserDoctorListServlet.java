package com.hospital.controller.user;

import com.hospital.dao.DoctorDao;
import com.hospital.model.Doctor;
import com.hospital.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.ibatis.session.SqlSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/doctors")
public class UserDoctorListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DoctorDao doctorDao = sqlSession.getMapper(DoctorDao.class);

            // 获取所有医生列表
            List<Doctor> doctors = doctorDao.getAllDoctors();

            request.setAttribute("doctors", doctors);
            request.getRequestDispatcher("/WEB-INF/views/user/doctorList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "获取医生列表失败");
        }
    }
}