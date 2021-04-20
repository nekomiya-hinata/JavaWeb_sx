package moe.kuro.web;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 获取用户登陆信息
 */
public class UserHttpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String pwd = request.getParameter("pwd");
        System.out.println("用户名："+name+" 密码："+pwd);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
