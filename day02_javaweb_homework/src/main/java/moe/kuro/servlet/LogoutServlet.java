package moe.kuro.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        Cookie[] cookies = request.getCookies();
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        for (Cookie ck : cookies) {
            ck.setMaxAge(0);
            response.addCookie(ck);
        }
        if ("cookie_err".equals(request.getParameter("msg"))) {
            response.getWriter().print("<script>window.location='/login.jsp'</script>");
        } else {
            response.getWriter().print("<script>alert('注销成功！');window.location='/login.jsp'</script>"); //
        }
    }
}
