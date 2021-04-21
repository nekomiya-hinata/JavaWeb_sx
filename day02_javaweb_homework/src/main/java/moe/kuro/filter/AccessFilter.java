package moe.kuro.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AccessFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession();
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");

        String login_page = "/login.jsp";
        String index_page = "/";
        String visit_page = request.getRequestURI();

        if (session.getAttribute("user") != null) {
            System.out.println("当前访问用户ip："+request.getRemoteAddr()+" 用户名："+session.getAttribute("user")+"成功登录");
            if (login_page.equals(visit_page)) {
                response.sendRedirect(index_page);
            } else {
                chain.doFilter(req, resp);
            }
        } else if (login_page.equals(visit_page)) {
            System.out.println("当前访问用户ip："+request.getRemoteAddr()+"还未登录");
            chain.doFilter(req, resp);
        } else {
            System.out.println("当前访问用户ip："+request.getRemoteAddr()+"还未登录");
            String errorPage = "<!DOCTYPE html>" +
                    "<html>" +
                    "<head>" +
                    "<title>出错页</title>" +
                    "<meta name=\"viewport\" content=\"width=device-width initial-scale=1 shrink-to-fit=no\">" +
                    "<link rel=\"stylesheet\" href=\"css/sweetalert2.min.css\">" +
                    "</head>" +
                    "<body>" +
                    "<script src=\"js/jquery-3.4.1.js\"></script>" +
                    "<script src=\"js/promise.min.js\"></script>" +
                    "<script src=\"js/sweetalert2.all.min.js\"></script>\n" +
                    "<script>swal.fire({title:'出错了',html:'请在登录后访问本页！<form id=\"msg\" action=\"/logout\"><input type=\"hidden\" name=\"msg\" value=\"cookie_err\" /><form>',icon:'error'}).then(function(){$('#msg').submit();})</script>" +
                    "</body>" +
                    "</html>";
            response.getWriter().write(errorPage);
        }
    }
}
