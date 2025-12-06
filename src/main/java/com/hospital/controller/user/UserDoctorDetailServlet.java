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

@WebServlet("/user/doctor")
public class UserDoctorDetailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "缺少医生ID参数");
            return;
        }

        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DoctorDao doctorDao = sqlSession.getMapper(DoctorDao.class);
            int doctorId = Integer.parseInt(idParam);

            // 获取医生详情
            Doctor doctor = doctorDao.getDoctorById(doctorId);

            if (doctor == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "未找到该医生");
                return;
            }

            request.setAttribute("doctor", doctor);
            request.getRequestDispatcher("/WEB-INF/views/user/doctorDetail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "无效的医生ID格式");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "获取医生信息失败");
        }
    }
}