package moe.kuro.web;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class SendDataHttpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
//        if (request.getParameter("method").equals("qqzf")) {
//            request.getRequestDispatcher("qqzf.jsp").forward(request, response);
//        } else {
//            response.sendRedirect("/cdx.jsp");
//        }
        int number = 0;
        try {
            number = (int) request.getSession().getAttribute("number");
            number++;
        } catch (Exception e) {
            number++;
        }
        request.getSession().setAttribute("number", number);
        response.getWriter().print("当前第" + request.getSession().getAttribute("number") + "次访问！");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}
