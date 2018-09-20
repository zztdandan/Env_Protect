<%@ Page Language="C#" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <meta name="auther" content="fq" />
    <title>导航页</title>
    <script src="JavaScript/jquery1.10.2.min.js"></script>
    <script src="bootstrap3/js/bootstrap.min.js"></script>
    <link href="bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="JavaScript/jbase64/jbase64.js"></script>
    <script src="JavaScript/CookieFunc.js"></script>
    <script src="JavaScript/JSONfunction.js"></script>
    <%--<script src="JavaScript/OnLoad.js"></script>--%>
    <link href="css/mycss.css" rel="stylesheet" />
    <script type="text/javascript">
        window.onload = function () {
            if (window.top != window.self) {//存在父页面
                window.parent.ChildrenCallback();
            }
            if (window.ActiveXObject) {
                var ua = navigator.userAgent.toLowerCase();
                var ie = ua.match(/msie ([\d.]+)/)[1]
                if (ie == 6.0) {
                    alert("您的浏览器版本过低，在本系统中不能达到良好的视觉效果，建议你升级到ie8以上！");
                    window.location.reload("forie6.html");
                }
            }
        }
    </script>
    <script type="text/javascript">
        function EPguide() { }
        EPguide.Login = function (name, pass) {
            var base64pw = BASE64.encoder(pass); //返回编码后的字符
            var formkk = { "action": "checkpw", "username": name, "password": base64pw };
            var ret = JSONfunc.postJsontoHandlerAsync(formkk, "ajax/UserHandler.aspx", function (d) {
                if (d == "True") {//正确的用户名密码，改cookie,刷页面
                    if (CookieFunc.getCookie("username") != null) {
                        CookieFunc.delCookie("username");
                    }
                    CookieFunc.setCookiewithTime("username", name, "d1");
                    if (window.top != window.self) {
                        top.location.reload();
                    }
                    else {
                        self.location.reload();
                    }
                }
                else {//错误的用户密码，转为游客
                    if (CookieFunc.getCookie("username") != null) {
                        CookieFunc.delCookie("username");
                    }
                    alert("没有这个用户或密码错误！您将作为游客登录")
                    CookieFunc.setCookiewithTime("username", "guest", "d1");
                    if (window.top != window.self) {
                        top.location.reload();
                    }
                    else {
                        self.location.reload();
                    }                  
                }
            });

        }
        EPguide.Logout = function () {
            var username = CookieFunc.getCookie("username");
            if (username != null) {
                CookieFunc.delCookie("username");
            }
            CookieFunc.setCookiewithTime("username", "guest", "d1");
            self.location.reload();
        }
        EPguide.Identity = function () {

            var Logdiv = $(".jumbotron");
            var username = CookieFunc.getCookie("username");

            if (username != null) {
                var formkk = { "action": "userdetail", "username": username };
                if (username != "guest") {
                    $("#loginbtn").addClass("hidden");
                    $("#logoutbtn").removeClass("hidden");
                }
                else {
                    $("#logoutbtn").addClass("hidden");
                    $("#loginbtn").removeClass("hidden");
                }
                var ret = JSONfunc.postJsontoHandlerAsync(formkk, "ajax/UserHandler.aspx", function (d) {
                    var chnname = (JSONfunc.STRtoJSON(d))[0].中文名;
                    var guidearr = JSONfunc.STRtoJSON((JSONfunc.STRtoJSON(d))[0].快捷导航);
                    Logdiv.find(".lead").text(chnname);
                    var guidediv = $("#QuickGuide");
                    if (guidearr.length == 0) {
                        guidediv.append($("<p></p>").html("没有可以操作的项........."));
                    } else {
                        for (var i = 0; i < guidearr.length; i++) {
                            var ahref = $("<a></a>").attr("href", guidearr[i].url).text(guidearr[i].name);
                            guidediv.append($("<li class='list-group-item'></li>").html(ahref));
                        }
                    }
                });
            }
            else {
                CookieFunc.setCookiewithTime("username", "guest", "d1");
                EPguide.Identity();
            }
        }

        $(function () {
            EPguide.Identity();
        })
    </script>
</head>
<body>
    <div class="container-fluid">
        <div class="col-md-4">
            <div class="jumbotron">
                <h3>欢迎进入炼铁厂环保信息系统</h3>
                <p>您现在的身份是：</p>
                <p class="lead"></p>
                <a href="#" class="pull-right" data-toggle="modal" data-target="#LoginModal" id="loginbtn">点此登录</a>
                <a href="#" class="pull-right hidden" id="logoutbtn" onclick="EPguide.Logout()">点此登出</a>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="LoginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalLabel1">登录</h4>
                        </div>
                        <div class="modal-body">

                            <p>请输入您的账号：</p>
                            <input type="text" id="yourname" /><br />
                            <p>请输入您的密码：</p>
                            <input type="password" id="yourpw" /><br />

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="EPguide.Login($('#yourname').val(),$('#yourpw').val())">登录</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">退出登录</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h4>快捷导航</h4>
                </div>
                <ul class="list-group" id="QuickGuide">
                </ul>
            </div>
        </div>

        <div class="col-md-4">
            <div class=" panel panel-primary">
                <div class="panel-heading">
                    <h4>请使用360浏览器获得最好效果</h4>
                </div>
                <div class="panel-body">
                    <a href="ftp://172.16.132.235/%C8%ED%BC%FE/360se6_6.2.1.180.exe">360浏览器</a>
                    <p>使用极速模式获得效果</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h4>更新日志</h4>
                </div>
                <div class="panel-body">
                    <label id="changelogdiv">
                        <script>
                            $("#changelogdiv").ready(
                                function () {
                                    var changetext = JSONfunc.LoadJSON("/menu/changelog.txt");
                                    $("#changelogdiv").html(changetext.responseText);
                                })
                        </script>
                    </label>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
