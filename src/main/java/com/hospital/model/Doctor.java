package com.hospital.model;

import lombok.Data;

@Data
public class Doctor {
    private int id;
    private String name;
    private String title;
    private int departmentId; // 部门ID
    private String bio;
    private Department department; // 关联部门对象
    private String departmentName; // 部门名称（非数据库字段）

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    // 手动添加getDepartmentName方法
    public String getDepartmentName() {
        return departmentName;
    }
}