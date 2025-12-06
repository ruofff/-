package com.hospital.model;

import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Data
public class Appointment {
    private int id;
    private int patientId;
    private int doctorId;
    private LocalDateTime appointmentDatetime;
    private String status;
    private String notes;
    private LocalDateTime createdAt; // 添加此字段

    // 关联对象
    private Patient patient;
    private Doctor doctor;

    // 便捷方法
    public LocalDate getAppointmentDate() {
        return appointmentDatetime != null ? appointmentDatetime.toLocalDate() : null;
    }

    public LocalTime getAppointmentTime() {
        return appointmentDatetime != null ? appointmentDatetime.toLocalTime() : null;
    }
}