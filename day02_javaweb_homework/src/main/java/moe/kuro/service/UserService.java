package moe.kuro.service;

import moe.kuro.dao.UserDao;
import moe.kuro.entity.User;

import java.sql.Connection;
import java.util.List;

public class UserService {
    private UserDao userDao = new UserDao();

    public List<User> getAllUser() {
        return userDao.getAllUser();
    }

    public User getOneUser(String name) {
        return userDao.getOneUser(name);
    }

    public boolean addUser(User user) {
        if (!userDao.isExist(user.getUsername())) {
            boolean flag = userDao.addUser(user,userDao.getLastID()+1);
            userDao.close();
            return flag;
        } else {
            System.out.println("此人已存在！");
            userDao.close();
            return false;
        }
    }

    public int getTotal() {
        return userDao.getTotalCount();
    }
}
