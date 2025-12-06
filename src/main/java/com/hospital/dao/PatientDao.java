package com.hospital.dao;

import com.hospital.model.Patient;
import java.util.List;

public interface PatientDao {
    List<Patient> getAllPatients();
    Patient getPatientById(int id);
    void addPatient(Patient patient);
    void updatePatient(Patient patient);
    void deletePatient(int id);

    // 添加缺失的方法
    Patient getPatientByUserId(int userId);
}