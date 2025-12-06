package com.hospital.dao;

import com.hospital.model.User;

public interface UserDao {
    User getUserByUsername(String username);
    void addUser(User user);
}