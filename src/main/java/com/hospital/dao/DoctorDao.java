package com.hospital.dao;

import com.hospital.model.Doctor;
import java.util.List;

public interface DoctorDao {
    List<Doctor> getAllDoctors();
    Doctor getDoctorById(int id);
    List<Doctor> getDoctorsByDepartment(int departmentId); // 修复方法名
    int addDoctor(Doctor doctor);
    int updateDoctor(Doctor doctor);
    int deleteDoctor(int id);
    List<Doctor> searchDoctorsByName(String name);
    int getDoctorCount();
}