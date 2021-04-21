<%--
  Created by IntelliJ IDEA.
  User: nekomiya
  Date: 2021/4/20
  Time: 18:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width initial-scale=1 shrink-to-fit=no">
    <title>后台管理登录</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/components.css">
    <link rel="stylesheet" href="css/sweetalert2.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <style>
        form {
            margin-bottom: 13rem;
        }

        svg {
            border-radius: 0.25rem;
        }

        #container {
            margin: 20px;
            height: 10px;
        }
    </style>
</head>
<body>
<div>
    <div class="d-flex flex-wrap align-items-stretch">
        <div class="col-lg-4 col-md-6 col-12 order-2 bg-white">
            <div class="p-4 m-3">
                <h4 class="text-dark font-weight-normal">欢迎使用
                    <span style="font-weight: 700!important;">后台管理系统</span>
                </h4>
                <p class="text-muted">享受下一代云管理的便捷</p>
                <form action="javascript:void(0);" method="post" class="needs-validation user-login" novalidate>
                    <div class="login-form-item">
                        <div class="form-group">
                            <label for="username">用户名</label>
                            <input id="username" type="text" class="form-control" name="username" tabindex="1" required
                                   autofocus/>
                            <div class="invalid-feedback">请输入用户名</div>
                        </div>
                        <div class="form-group">
                            <label for="password">密码</label>
                            <input id="password" type="password" class="form-control" name="password" tabindex="2"
                                   required>
                            <div class="invalid-feedback">请输入密码</div>
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <button type="submit" class="btn btn-primary btn-lg btn-icon icon-right login" tabindex="5">
                            登录
                        </button>
                        <button type="submit" class="btn btn-primary btn-lg btn-icon icon-right reg" tabindex="4"
                                data-toggle='modal' data-target='#registerUser'>
                            注册
                        </button>
                    </div>
                </form>
                <div class="text-center mt-5 text-small">Copyright © 2020 xx网络运营
                    <div class="mt-2" id="copyright">
                        powered by <a href="https://www.jetbrains.com/idea/" target="_blank">IntelliJ IDEA</a>
                        <div class="bullet"></div>
                        Theme by <a href="https://github.com/nekomiya-hinata" target="_blank">nekomiya</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-8 col-12 order-lg-2 order-1 position-relative overlay-gradient-bottom"
             data-background="pic/75222705_p0.jpg"
             style="background-image: url(pic/right_pic.jpg);background-repeat: no-repeat">
            <div class="absolute-bottom-left index-2">
                <div class="text-light p-5 pb-2">
                    <div class="mb-5 pb-3">
                        <h1 class="mb-2 display-4 font-weight-bold">Good Day</h1>
                        <h5 class="font-weight-normal text-muted-transparent">Bali, Indonesia</h5>
                    </div>
                    Photo by <a class="text-light" target="_blank" href="https://unsplash.com/photos/a8lTjWJJgLA">Justin
                    Kauffman</a> on <a class="text-light" target="_blank" href="https://unsplash.com">Unsplash</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!--核心Jquery-->
<script src="js/jquery-3.4.1.js"></script>
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
    let button = $(".login");

    function registerUser() {
        let username = $("#reg_username").val();
        let email = $("#reg_email").val();
        let password = $("#reg_password").val();
        let re_pwd = $("#repwd").val();
        let form_reg = $(".user-reg");

        if (!form_reg.hasClass("was-validated")) {
            form_reg.addClass("was-validated");
        }
        if (email === "" | username === "" || password === "") {
            return false;
        }
        if (!(/^([A-Za-z0-9_\-.\u4e00-\u9fa5])+@([A-Za-z0-9_\-.])+\.([A-Za-z]{2,8})$/.test(email))) {
            swal.fire({
                title: "出错了", html: "邮箱格式不正确", icon: "error"
            });
            return false;
        }
        if (/[ ]/.test(password)) {
            swal.fire({
                title: "出错了", html: "不允许的密码<br/>不允许出现空格", icon: "error"
            });
            return false;
        }
        if (password !== re_pwd) {
            swal.fire({
                title: "出错了", text: "两次密码输入不一致！", icon: "error"
            })
            return false;
        }

        $.ajax({
            method: "post",
            url: "/user",
            dataType: "json",
            data: {username: username, email: email, password: password, action: "reg"},
            success: function (data) {
                let errorMsg;
                if (data.ret === 1) {
                    $('#registerUser').modal(false);
                    swal.fire({
                        title: '注册结果',
                        text: '你已成功注册，点击确定返回登陆页面',
                        icon: 'success'
                    }).then(function () {
                        window.location = '/login.jsp';
                    });
                    return;
                } else if (data.ret === 2) {
                    swal.fire({
                        title: '出错了',
                        text: '此用户已存在',
                        icon: 'error'
                    })
                    return false
                } else {
                    errorMsg = "系统内部出错！";
                }
                swal.fire({
                    title: '出错了',
                    text: errorMsg,
                    icon: 'error'
                })
                return false
            }
        })
    }

    function login() {
        let username = $("#username").val();
        let password = $("#password").val();
        let form_login = $(".user-login");
        if (!form_login.hasClass("was-validated")) {
            form_login.addClass("was-validated");
        }
        if (username === "" || password === "") {
            button.removeAttr("disabled");
            return false;
        }
        showLogin();
        $.ajax({
            method: "post",
            url: "/user",
            dataType: "json",
            data: {
                username: username,
                password: password,
                action: "login"
            },
            success: function (data) {
                let errorMsg;
                if (data.ret === 1) {
                    $('#loginSuccess').modal(true);
                    progressbar();
                    setTimeout("jump();", 3000);
                    return;
                } else if (data.ret === 2) {
                    //form_login.removeClass("was-validated");
                    errorMsg = "密码错误！";
                } else if (data.ret === 3) {
                    errorMsg = "此用户不存在！";
                } else {
                    errorMsg = "系统内部出错！";
                }
                swal.fire({
                    title: '出错了',
                    text: errorMsg,
                    icon: 'error'
                }).then(function () {
                    button.removeAttr("disabled");
                    endLogin();
                });
            }
        })
    }

    function showLogin() {
        button.empty();
        button.append("<span class=\"spinner-grow spinner-grow-sm\" role=\"status\" aria-hidden=\"true\"></span> Loading...");
    }

    function endLogin() {
        button.empty();
        button.append("登录")
    }

    function jump() {
        window.location = '/';
    }

    $("body").keydown(function (event) {
        if (event.keyCode === 13) {
            button.prop("disabled", "disabled");
            login();
            return false;
        }
    });
    button.click(function () {
        button.prop("disabled", "disabled")
        login();
    });
</script>
<div class="modal fade" id="loginSuccess" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">登录成功</h5>
            </div>
            <div class="modal-body">
                将在<span id="time-left">3</span>s后进入管理平台...
                <div id="container"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="jump();">
                    确定
                </button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="registerUser" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">用户注册</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body" style="height:480px">
                <form action="javascript:void(0);" method="post" class="needs-validation user-reg" novalidate>
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label for="reg_username">用户名</label>
                            <input type="text" id="reg_username" class="form-control" required>
                            <div class="invalid-feedback">请输入用户名</div>
                        </div>
                        <div class="form-group col-12">
                            <label for="reg_email">邮箱</label>
                            <input type="email" id="reg_email" class="form-control" required>
                            <div class="invalid-feedback">请输入邮箱</div>
                        </div>
                        <div class="form-group col-12">
                            <label for="reg_password">密码</label>
                            <input type="password" id="reg_password" class="form-control" required>
                            <div class="invalid-feedback">请输入密码</div>
                        </div>
                        <div class="form-group col-12">
                            <label for="repwd">确认新密码</label>
                            <input id="repwd" type="password" class="form-control" required>
                            <div class="invalid-feedback">请重复输入</div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary confirm" onclick="registerUser()">确定注册</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>

<script>
    function progressbar() {
        let countAttr = document.getElementById("time-left");
        let count = 2;
        setInterval(function () {
            if (count >= 1) {
                countAttr.innerHTML = String(count--);
            }
        }, 1000);
        const bar = new ProgressBar.Line(container, {
            strokeWidth: 4,
            easing: 'easeInOut',
            duration: 3000,
            color: '#007bff',
            trailColor: '#eee',
            trailWidth: 1,
            svgStyle: {width: '100%', height: '100%'}
        });
        bar.animate(1.0);
    }
</script>
</body>
</html>
