package com.hospital.service;

import com.hospital.dao.DepartmentDao;
import com.hospital.model.Department;
import com.hospital.util.DatabaseUtil;
import org.apache.ibatis.session.SqlSession;

import java.util.List;

public class DepartmentService {
    // 添加重载方法，默认不加载关联医生
    public Department getDepartmentById(int id) {
        return getDepartmentById(id, false);
    }

    public Department getDepartmentById(int id, boolean withDoctors) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DepartmentDao departmentDao = sqlSession.getMapper(DepartmentDao.class);
            return withDoctors ?
                    departmentDao.getDepartmentByIdWithDoctors(id) :
                    departmentDao.getDepartmentById(id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("获取科室信息失败", e);
        }
    }

    // 添加重载方法，默认不加载关联医生
    public List<Department> getAllDepartments() {
        return getAllDepartments(false);
    }

    public List<Department> getAllDepartments(boolean withDoctors) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DepartmentDao departmentDao = sqlSession.getMapper(DepartmentDao.class);
            return withDoctors ?
                    departmentDao.getAllDepartmentsWithDoctors() :
                    departmentDao.getAllDepartments();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("获取科室列表失败", e);
        }
    }

    public void addDepartment(Department department) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DepartmentDao departmentDao = sqlSession.getMapper(DepartmentDao.class);
            departmentDao.addDepartment(department);
            sqlSession.commit();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("添加科室失败", e);
        }
    }

    public void updateDepartment(Department department) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DepartmentDao departmentDao = sqlSession.getMapper(DepartmentDao.class);
            departmentDao.updateDepartment(department);
            sqlSession.commit();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("更新科室失败", e);
        }
    }

    public void deleteDepartment(int id) {
        try (SqlSession sqlSession = DatabaseUtil.getSqlSession()) {
            DepartmentDao departmentDao = sqlSession.getMapper(DepartmentDao.class);
            departmentDao.deleteDepartment(id);
            sqlSession.commit();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("删除科室失败", e);
        }
    }
}