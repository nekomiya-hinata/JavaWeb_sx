<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: nekomiya
  Date: 2021/4/20
  Time: 18:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>首页</title>
    <meta name="viewport" content="width=device-width initial-scale=1 shrink-to-fit=no">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.8.2/css/all.min.css">
    <link rel="stylesheet" href="css/components.css">
    <link rel="stylesheet" href="css/style-purple.css">
    <link rel="stylesheet" href="css/sweetalert2.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <style>
        .pagination .page-item .page-link {
            margin: 0 0 0 -1px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body class>
<c:set value="${pageContext.request}" var="request"/><c:set value="${request.contextPath}" var="Path"/>
<div id="app">
    <div class="main-wrapper">
        <div class="navbar-bg"></div>
        <nav class="navbar navbar-expand-lg main-navbar">
            <form class="form-inline mr-auto">
                <ul class="navbar-nav mr-3">
                    <li>
                        <a href="#" data-toggle="sidebar" id="change_bar" class="nav-link nav-link-lg"><i
                                class="fas fa-bars"></i></a>
                    </li>
                </ul>
            </form>
            <ul class="navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" data-toggle="dropdown" class="nav-link dropdown-toggle nav-link-lg nav-link-user"
                       aria-expanded="false">
                        <img alt="image"
                             src="https://secure.gravatar.com/avatar/4b0b4f6e64d828eecf2a3e1da496639c?d=retro"
                             class="rounded-circle mr-1">
                        <div id="user_status" class="d-sm-none d-lg-inline-block"></div>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a href="${Path}/logout" class="dropdown-item has-icon text-danger">
                            <i class="fas fa-sign-out-alt"></i> 退出登錄
                        </a>
                    </div>
                </li>
            </ul>
        </nav>
        <div class="main-sidebar sidebar-style-2" tabindex="1" style="overflow: hidden; outline: none;">
            <aside id="sidebar-wrapper">
                <div class="sidebar-brand"><a>后台管理系统</a></div>
                <div class="sidebar-brand sidebar-brand-sm"><i class="fas fa-blog"></i></div>
                <ul class="sidebar-menu">
                    <li class="active">
                        <a class="nav-link" href="${Path}"><i class="fab fa-fort-awesome"></i><span>首页</span></a>
                    </li>
                </ul>
            </aside>
        </div>
        <div class="main-content">
            <section class="section">
                <div class="section-header">
                    <h1>首页</h1>
                </div>
                <div class="row">
                    <div class="col-lg-3 col-md-3 col-sm-12">
                        <div class="card card-statistic-2">
                            <div class="card-icon shadow-primary bg-primary">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="card-wrap">
                                <div class="card-header">
                                    <h4>用户总数</h4>
                                </div>
                                <div class="card-body">
                                    <span class="counter"></span> 人
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4><i class="fas fa-bullhorn"></i> 信息总览</h4>
                            </div>
                            <div id="userInfo" class="card-body">
                                <table class="table table-hover table-responsive-md">
                                    <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">用户名</th>
                                        <th scope="col">邮箱</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <template>
                                        <tr v-for="todo in info" :key="todo.id">
                                            <th scope='row'>{{todo.id}}</th>
                                            <td>{{todo.username}}</td>
                                            <td>{{todo.email}}</td>
                                        </tr>
                                    </template>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <footer class="main-footer">
                <div class="footer-left">
                    2020 © xx网络运营
                    <div class="bullet"></div>
                    <span id="copyright">
                        Powered by <a href="https://www.jetbrains.com/idea/" target="_blank">IntelliJ IDEA</a>
                        <div class="bullet"></div>
                        Theme by <a href="https://github.com/nekomiya-hinata" target="_blank">nekomiya</a>
                    </span>
                </div>
            </footer>
        </div>
    </div>
</div>
<!--核心Jquery-->
<script src="js/jquery-3.4.1.js"></script>
<!--核心Vue-->
<script src="js/vue.js"></script>
<!--兼容IE-->
<script src="js/promise.min.js"></script>
<!--定位（bootstrap依赖）-->
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.js"></script>
<!--弹出提示框-->
<script src="js/sweetalert2.all.min.js"></script>
<!--进度条-->
<script src="js/progressbar.js"></script>
<script>
    $("#change_bar").click(function () {
        let body = $("body");
        if ($(window).width() > 1024) {
            if (body.hasClass("sidebar-mini")) {
                body.removeClass("sidebar-mini");
            } else {
                body.addClass("sidebar-mini");
            }
        } else {
            body.attr("class", "sidebar-show");
        }
    })

    function hasScrollbar() {
        return document.body.scrollHeight > (window.innerHeight || document.documentElement.clientHeight);
    }

    $(window).resize(function () {
        let body = $("body");
        let min_width;
        if (hasScrollbar()) {
            min_width = 1007;
        } else {
            min_width = 1024;
        }
        if ($(window).width() <= min_width) {
            if (body.hasClass("sidebar-show")) {
                body.removeClass("sidebar-show");
            }
            if (body.hasClass("sidebar-mini")) {
                body.removeClass("sidebar-mini");
            }
            body.addClass("sidebar-gone");
        } else {
            body.removeClass("sidebar-gone");
        }
    })
</script>
<script>
    const text = "Hi，" + "${request.getSession(false).getAttribute('user')}";

    $(document).ready(function () {
        $("#user_status").append(text);
        $(".counter").append("${request.getSession(false).getAttribute('count')}");

        if ($(window).width() <= 1024) {
            $("body").addClass("sidebar-gone");
        }
        $(document).bind("click", function (e) {
            if ($("body").hasClass("sidebar-show")) {
                if ($(e.target).closest(".main-sidebar").length === 0 && $(e.target).closest("#change_bar").length !== 1) {
                    $("body").attr("class", "sidebar-gone");
                }
            }
        })

        $.ajax({
            method: 'get',
            url: "/user",
            dataType: "json",
            data: {action: "query"},
            success: function (data) {
                let index = new Vue({
                    el: '#userInfo',
                    data: {
                        info: data
                    }
                });
            }
        })
    })


</script>
</body>
