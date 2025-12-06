package com.hospital.dao;

import com.hospital.model.Department;
import com.hospital.model.Doctor;
import java.util.List;

public interface DepartmentDao {
    // 基础方法
    List<Department> getAllDepartments();
    Department getDepartmentById(int id);
    void addDepartment(Department department);
    void updateDepartment(Department department);
    void deleteDepartment(int id);

    // 添加带医生列表的方法
    List<Department> getAllDepartmentsWithDoctors();
    Department getDepartmentByIdWithDoctors(int id);

    // 修改方法名，与XML中的id保持一致
    List<Doctor> getDoctorsByDepartment(int departmentId);
}