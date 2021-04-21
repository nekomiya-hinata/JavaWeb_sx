package moe.kuro.dao;

import moe.kuro.entity.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    public void getConnection() {
        String url = "jdbc:mysql://localhost:3306/javaweb?serverTimezone=Asia/Shanghai";
        String name = "root";
        String password = "YYH-mysql1";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            long l = System.currentTimeMillis();
            conn = DriverManager.getConnection(url, name, password);
            System.out.println("获取连接耗时：" + (System.currentTimeMillis() - l) + "mm");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isExist(String username) {
        return getOneUser(username) != null;
    }

    public List<User> getAllUser() {
        List<User> users = new ArrayList<>();
        getConnection();
        try {
            pstmt = conn.prepareStatement("select id,username,email from user");
            rs = pstmt.executeQuery();
            while (rs.next()) {
                users.add(new User(rs.getInt(1), rs.getString(2), rs.getString(3)));
            }
            return users;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public User getOneUser(String username) {
        User user = null;
        getConnection();
        try {
            pstmt = conn.prepareStatement("select * from user where username=?");
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User(rs.getString(2), rs.getString(3), rs.getString(4));
            }
            return user;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public int getTotalCount() {
        getConnection();
        int total = -1;
        try {
            pstmt = conn.prepareStatement("select count(id) from user");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
            return total;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            return -1;
        }
    }

    public int getLastID() {
        getConnection();
        int last_id = 0;
        try {
            pstmt = conn.prepareStatement("select id from user order by id DESC limit 1");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                last_id = rs.getInt(1);
            }
            return last_id;
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            return -1;
        }
    }

    public boolean addUser(User user, int id) {
        getConnection();
        try {
            pstmt = conn.prepareStatement("insert into user values(?,?,?,?)");
            pstmt.setInt(1, id);
            pstmt.setString(2, user.getUsername());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPassword());
            int rs = pstmt.executeUpdate();
            return rs > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void close() {
        try {
            if (!rs.isClosed()) {
                rs.close();
            }
            if (!pstmt.isClosed()) {
                pstmt.close();
            }
            if (!conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
