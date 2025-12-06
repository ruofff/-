package com.hospital.model;

import lombok.Data;
import java.util.List;

@Data
public class Department {
    private int id;
    private String name;
    private String description;
    // 关联医生列表
    private List<Doctor> doctors;
}