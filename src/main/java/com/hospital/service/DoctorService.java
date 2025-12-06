package com.hospital.service;

import com.hospital.dao.DoctorDao;
import com.hospital.model.Department;
import com.hospital.model.Doctor;
import com.hospital.util.DatabaseUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.Collections;
import java.util.List;

public class DoctorService {
    private final DepartmentService departmentService;

    public DoctorService() {
        this.departmentService = new DepartmentService();
    }

    public List<Doctor> getAllDoctors() {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DoctorDao doctorDao = sqlSession.getMapper(DoctorDao.class);
            List<Doctor> doctors = doctorDao.getAllDoctors();

            // 为每个医生设置科室名称
            for (Doctor doctor : doctors) {
                // 使用重载方法，只传入一个参数
                Department department = departmentService.getDepartmentById(doctor.getDepartmentId());
                if (department != null) {
                    doctor.setDepartmentName(department.getName());
                }
            }

            return doctors;
        } catch (Exception e) {
            System.err.println("获取医生列表失败: " + e.getMessage());
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    public Doctor getDoctorById(int id) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DoctorDao doctorDao = sqlSession.getMapper(DoctorDao.class);
            Doctor doctor = doctorDao.getDoctorById(id);

            if (doctor != null) {
                // 使用重载方法，只传入一个参数
                Department department = departmentService.getDepartmentById(doctor.getDepartmentId());
                if (department != null) {
                    doctor.setDepartment(department);
                    doctor.setDepartmentName(department.getName());
                }
            }

            return doctor;
        } catch (Exception e) {
            System.err.println("获取医生信息失败: " + e.getMessage());
            return null;
        }
    }

    public boolean addDoctor(Doctor doctor) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DoctorDao doctorDao = sqlSession.getMapper(DoctorDao.class);
            int rowsAffected = doctorDao.addDoctor(doctor);
            sqlSession.commit();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("添加医生失败: " + e.getMessage());
            return false;
        }
    }

    public boolean updateDoctor(Doctor doctor) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DoctorDao doctorDao = sqlSession.getMapper(DoctorDao.class);
            int rowsAffected = doctorDao.updateDoctor(doctor);
            sqlSession.commit();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("更新医生失败: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteDoctor(int id) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DoctorDao doctorDao = sqlSession.getMapper(DoctorDao.class);
            int rowsAffected = doctorDao.deleteDoctor(id);
            sqlSession.commit();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("删除医生失败: " + e.getMessage());
            return false;
        }
    }
}