<%@ Page Language="C#" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <meta name="auther" content="fq" />
    <title>����ҳ</title>
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
            if (window.top != window.self) {//���ڸ�ҳ��
                window.parent.ChildrenCallback();
            }
            if (window.ActiveXObject) {
                var ua = navigator.userAgent.toLowerCase();
                var ie = ua.match(/msie ([\d.]+)/)[1]
                if (ie == 6.0) {
                    alert("����������汾���ͣ��ڱ�ϵͳ�в��ܴﵽ���õ��Ӿ�Ч����������������ie8���ϣ�");
                    window.location.reload("forie6.html");
                }
            }
        }
    </script>
    <script type="text/javascript">
        function EPguide() { }
        EPguide.Login = function (name, pass) {
            var base64pw = BASE64.encoder(pass); //���ر������ַ�
            var formkk = { "action": "checkpw", "username": name, "password": base64pw };
            var ret = JSONfunc.postJsontoHandlerAsync(formkk, "ajax/UserHandler.aspx", function (d) {
                if (d == "True") {//��ȷ���û������룬��cookie,ˢҳ��
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
                else {//������û����룬תΪ�ο�
                    if (CookieFunc.getCookie("username") != null) {
                        CookieFunc.delCookie("username");
                    }
                    alert("û������û����������������Ϊ�ο͵�¼")
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
                    var chnname = (JSONfunc.STRtoJSON(d))[0].������;
                    var guidearr = JSONfunc.STRtoJSON((JSONfunc.STRtoJSON(d))[0].��ݵ���);
                    Logdiv.find(".lead").text(chnname);
                    var guidediv = $("#QuickGuide");
                    if (guidearr.length == 0) {
                        guidediv.append($("<p></p>").html("û�п��Բ�������........."));
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
                <h3>��ӭ����������������Ϣϵͳ</h3>
                <p>�����ڵ�����ǣ�</p>
                <p class="lead"></p>
                <a href="#" class="pull-right" data-toggle="modal" data-target="#LoginModal" id="loginbtn">��˵�¼</a>
                <a href="#" class="pull-right hidden" id="logoutbtn" onclick="EPguide.Logout()">��˵ǳ�</a>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="LoginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="myModalLabel1">��¼</h4>
                        </div>
                        <div class="modal-body">

                            <p>�����������˺ţ�</p>
                            <input type="text" id="yourname" /><br />
                            <p>�������������룺</p>
                            <input type="password" id="yourpw" /><br />

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="EPguide.Login($('#yourname').val(),$('#yourpw').val())">��¼</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">�˳���¼</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h4>��ݵ���</h4>
                </div>
                <ul class="list-group" id="QuickGuide">
                </ul>
            </div>
        </div>

        <div class="col-md-4">
            <div class=" panel panel-primary">
                <div class="panel-heading">
                    <h4>��ʹ��360�����������Ч��</h4>
                </div>
                <div class="panel-body">
                    <a href="ftp://172.16.132.235/%C8%ED%BC%FE/360se6_6.2.1.180.exe">360�����</a>
                    <p>ʹ�ü���ģʽ���Ч��</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h4>������־</h4>
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
