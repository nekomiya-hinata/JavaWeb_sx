package moe.kuro.servlet;

import com.alibaba.fastjson.JSONObject;
import moe.kuro.entity.User;
import moe.kuro.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = new UserService();

        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        switch (action) {
            case "reg":
                boolean flag = userService.addUser(new User(username, email, password));
                if (flag) {
                    out.print("{\"ret\":1}");
                } else {
                    out.print("{\"ret\":2}");
                }
                break;
            case "login":
                User user = userService.getOneUser(username);
                if (user == null) {
                    out.print("{\"ret\":3}");
                } else {
                    if (password.equals(user.getPassword())) {
                        request.getSession().setAttribute("user", user.getUsername());
                        request.getSession().setAttribute("count", userService.getTotal());
                        out.print("{\"ret\":1}");
                    } else {
                        out.print("{\"ret\":2}");
                    }
                }
                break;
            case "query":
                out.print(JSONObject.toJSONString(userService.getAllUser()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}
