package com.hospital.dao;

import com.hospital.model.Appointment;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

public interface AppointmentDao {
    void addAppointment(Appointment appointment);
    List<Appointment> getAllAppointments();
    Appointment getAppointmentById(int id);
    void updateAppointment(Appointment appointment);
    void deleteAppointment(int id);

    // 添加新方法
    List<Appointment> getAppointmentsByDate(LocalDate date);
    List<Appointment> getAppointmentsByDoctorAndDate(int doctorId, LocalDate date);
    List<LocalDate> getAvailableDates(int doctorId);
    List<LocalTime> getAvailableTimes(int doctorId, LocalDate date);
    List<Appointment> getAppointmentsByUserId(int userId);
    void cancelAppointment(int appointmentId);
}