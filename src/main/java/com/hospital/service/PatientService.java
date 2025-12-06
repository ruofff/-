package com.hospital.service;

import com.hospital.dao.PatientDao;
import com.hospital.model.Patient;
import com.hospital.util.DatabaseUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class PatientService {
    public PatientService() {
    }
    public List<Patient> getAllPatients() {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao patientDao = sqlSession.getMapper(PatientDao.class);
            return patientDao.getAllPatients();
        }
    }

    public Patient getPatientById(int id) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao patientDao = sqlSession.getMapper(PatientDao.class);
            return patientDao.getPatientById(id);
        }
    }

    public void addPatient(Patient patient) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao patientDao = sqlSession.getMapper(PatientDao.class);
            patientDao.addPatient(patient);
            sqlSession.commit();
        }
    }
    public void createPatient(Patient patient) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao patientDao = sqlSession.getMapper(PatientDao.class);
            patientDao.addPatient(patient);
            sqlSession.commit();
        }
    }

    public void updatePatient(Patient patient) {
        // 验证性别
        if (patient.getGender() == null) {
            throw new IllegalArgumentException("性别不能为空");
        }

        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao patientDao = sqlSession.getMapper(PatientDao.class);
            patientDao.updatePatient(patient);
            sqlSession.commit();
        }
    }

    public void deletePatient(int id) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao patientDao = sqlSession.getMapper(PatientDao.class);
            patientDao.deletePatient(id);
            sqlSession.commit();
        }
    }

    public Patient getPatientByUserId(int userId) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao patientDao = sqlSession.getMapper(PatientDao.class);
            return patientDao.getPatientByUserId(userId);
        }
    }
    /**
     * 创建与用户关联的患者记录
     * @param userId 用户ID
     * @return 创建的Patient对象
     */
    public Patient createPatientForUser(int userId) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao patientDao = sqlSession.getMapper(PatientDao.class);

            // 创建患者记录
            Patient patient = new Patient();
            patient.setUserId(userId);
            patient.setName("新患者");
            patient.setGender(Patient.Gender.MALE); // 使用枚举值
            patient.setAge(30);
            patient.setPhone("");
            patient.setEmergencyContact("");
            patient.setEmergencyPhone("");

            // 执行插入
            patientDao.addPatient(patient);
            sqlSession.commit();

            // 返回新创建的患者
            return patient;
        } catch (Exception e) {
            throw new RuntimeException("创建患者失败: " + e.getMessage(), e);
        }
    }
}