<%--
  Created by IntelliJ IDEA.
  User: nekomiya
  Date: 2021/4/20
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>项目首页</title>
</head>

<body>
使用超链接向后台发送数据
<br/>
<a href="/user?name=1233444">发送参数1</a>
<a href="/user?name=1233444&pwd=admin">发送参数1</a>

<form action="/user" method="post">
    <table>
        <tr>
            <td>用户名</td>
            <td><input type="text" name="username"/></td>
        </tr>
        <tr>
            <td>密码</td>
            <td><input type="password" name="password"/></td>
        </tr>
        <tr>
            <td>年龄</td>
            <td><input type="text" name="age"/></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="提交"/></td>
        </tr>
    </table>
</form>

<a href="<c:url value="/send?method=qqzf"/>">请求转发</a>
<a href="<c:url value="/send?method=cdx"/>">重定向</a><br/>
<a href="<c:url value="/send"/>">计数页面</a>
</body>
</html>
