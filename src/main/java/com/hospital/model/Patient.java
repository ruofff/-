package com.hospital.model;

import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;

@Data
public class Patient {
    private int id;
    private String name;
    private Gender gender; // 修改为枚举类型
    private int age;
    private LocalDate dateOfBirth;
    private String phone;
    private String address;
    private String medicalHistory;
    private int userId;
    private LocalDateTime createdAt;
    private String emergencyContact;
    private String emergencyPhone;

    // 添加计算年龄的方法
    public int getAge() {
        if (dateOfBirth == null) {
            return 0;
        }
        return Period.between(dateOfBirth, LocalDate.now()).getYears();
    }

    // 添加日期设置方法
    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    // 添加字符串日期设置方法
    public void setDateOfBirth(String dateString) {
        this.dateOfBirth = LocalDate.parse(dateString);
    }

    // 添加缺失的方法
    public int getUserId() {
        return this.userId;
    }

    // 添加便捷方法
    public String getGenderDisplayName() {
        return gender != null ? gender.getDisplayName() : "";
    }

    public enum Gender {
        MALE("男"),
        FEMALE("女");

        private final String displayName;

        Gender(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }

        public static Gender fromDisplayName(String displayName) {
            for (Gender gender : values()) {
                if (gender.displayName.equals(displayName)) {
                    return gender;
                }
            }
            throw new IllegalArgumentException("无效的性别值: " + displayName);
        }
    }
}