package com.hospital.dao.impl;

import com.hospital.dao.PatientDao;
import com.hospital.model.Patient;
import com.hospital.util.DatabaseUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class PatientDaoImpl implements PatientDao {

    @Override
    public List<Patient> getAllPatients() {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao mapper = sqlSession.getMapper(PatientDao.class);
            return mapper.getAllPatients();
        }
    }

    @Override
    public Patient getPatientById(int id) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao mapper = sqlSession.getMapper(PatientDao.class);
            return mapper.getPatientById(id);
        }
    }

    @Override
    public void addPatient(Patient patient) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao mapper = sqlSession.getMapper(PatientDao.class);
            mapper.addPatient(patient);
            sqlSession.commit();
        }
    }

    @Override
    public void updatePatient(Patient patient) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao mapper = sqlSession.getMapper(PatientDao.class);
            mapper.updatePatient(patient);
            sqlSession.commit();
        }
    }

    @Override
    public void deletePatient(int id) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao mapper = sqlSession.getMapper(PatientDao.class);
            mapper.deletePatient(id);
            sqlSession.commit();
        }
    }

    @Override
    public Patient getPatientByUserId(int userId) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            PatientDao mapper = sqlSession.getMapper(PatientDao.class);
            return mapper.getPatientByUserId(userId);
        }
    }
}