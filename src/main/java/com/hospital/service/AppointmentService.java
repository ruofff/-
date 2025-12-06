package com.hospital.service;

import com.hospital.dao.AppointmentDao;
import com.hospital.model.Appointment;
import com.hospital.model.Doctor;
import com.hospital.model.Patient;
import com.hospital.util.DatabaseUtil;
import org.apache.ibatis.session.SqlSession;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class AppointmentService {
    // 日期时间格式化器
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");

    public void addAppointment(Appointment appointment) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            appointmentDao.addAppointment(appointment);
            sqlSession.commit();
        }
    }

    public List<Appointment> getAllAppointments() {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            return appointmentDao.getAllAppointments();
        }
    }

    public Appointment getAppointmentById(int id) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            return appointmentDao.getAppointmentById(id);
        }
    }

    public void updateAppointment(Appointment appointment) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            appointmentDao.updateAppointment(appointment);
            sqlSession.commit();
        }
    }

    public void deleteAppointment(int id) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            appointmentDao.deleteAppointment(id);
            sqlSession.commit();
        }
    }

    /**
     * 获取医生的可用日期（未来日期）
     */
    public List<LocalDate> getAvailableDates(int doctorId) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            return appointmentDao.getAvailableDates(doctorId);
        }
    }

    /**
     * 获取特定日期的可用时间段（当前时间之后）
     */
    public List<LocalTime> getAvailableTimes(int doctorId, LocalDate date) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            return appointmentDao.getAvailableTimes(doctorId, date);
        }
    }

    /**
     * 按用户ID获取预约（带关联患者信息）
     */
    public List<Appointment> getAppointmentsByUserId(int userId) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            return appointmentDao.getAppointmentsByUserId(userId);
        }
    }

    /**
     * 取消预约并更新状态
     */
    public void cancelAppointment(int appointmentId) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            appointmentDao.cancelAppointment(appointmentId);
            sqlSession.commit();
        }
    }

    /**
     * 创建预约（符合您图片中的界面设计）
     */
    public boolean createAppointment(int patientId, int doctorId,
                                     LocalDate date, LocalTime time,
                                     String notes) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            Appointment appointment = new Appointment();
            appointment.setPatientId(patientId);
            appointment.setDoctorId(doctorId);

            // 组合日期和时间
            LocalDateTime dateTime = LocalDateTime.of(date, time);
            appointment.setAppointmentDatetime(dateTime);

            appointment.setStatus("待处理");
            appointment.setNotes(notes);

            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            appointmentDao.addAppointment(appointment);
            sqlSession.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 获取按日期分组的预约
     */
    public List<Appointment> getAppointmentsByDate(LocalDate date) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            return appointmentDao.getAppointmentsByDate(date);
        }
    }

    /**
     * 获取按医生和日期分组的预约
     */
    public List<Appointment> getAppointmentsByDoctorAndDate(int doctorId, LocalDate date) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            return appointmentDao.getAppointmentsByDoctorAndDate(doctorId, date);
        }
    }

    /**
     * 获取预约详细信息（带关联数据）
     */
    public Appointment getAppointmentDetail(int appointmentId) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            AppointmentDao appointmentDao = sqlSession.getMapper(AppointmentDao.class);
            Appointment appointment = appointmentDao.getAppointmentById(appointmentId);

            // 如果有关联对象
            if (appointment != null) {
                int patientId = appointment.getPatientId();
                int doctorId = appointment.getDoctorId();

                PatientService patientService = new PatientService();
                DoctorService doctorService = new DoctorService();

                Patient patient = patientService.getPatientById(patientId);
                Doctor doctor = doctorService.getDoctorById(doctorId);

                appointment.setPatient(patient);
                appointment.setDoctor(doctor);
            }

            return appointment;
        }
    }
}