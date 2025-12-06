package com.hospital.util;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.InputStream;

public class DatabaseUtil {
    private static final Logger logger = LogManager.getLogger(DatabaseUtil.class);
    private static SqlSessionFactory sqlSessionFactory;

    static {
        try {
            // 使用类加载器加载资源
            InputStream inputStream = DatabaseUtil.class.getClassLoader()
                    .getResourceAsStream("mybatis-config.xml");

            if (inputStream == null) {
                throw new RuntimeException("找不到 mybatis-config.xml 配置文件");
            }

            // 添加详细日志
            logger.info("开始初始化 SqlSessionFactory");
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
            logger.info("SqlSessionFactory 初始化成功");
        } catch (Exception e) {
            // 添加详细错误日志
            logger.error("初始化 SqlSessionFactory 失败", e);
            throw new ExceptionInInitializerError("初始化 SqlSessionFactory 失败: " + e.getMessage());
        }
    }

    public static SqlSession getSqlSession() {
        return sqlSessionFactory.openSession(false); // 关闭自动提交
    }
}