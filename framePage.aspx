<%@ Page Language="C#" AutoEventWireup="true" CodeFile="framePage.aspx.cs" Inherits="Main" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>环保信息系统</title>
    <link href="css/mycss.css" rel="stylesheet" />
    <script src="JavaScript/jquery1.10.2.min.js"></script>

    <script src="bootstrap3/js/bootstrap.min.js"></script>

    <link href="bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
        <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="/bootstrap3/js/html5shiv.min.js"></script>

    <script src="JavaScript/JSONfunction.js"></script>
    <script src="JavaScript/BuildMenuFunc.js"></script>
    <script src="JavaScript/CookieFunc.js"></script>
    <link href="css/ddsub.css" rel="stylesheet" />
    <!-- Bootstrap -->
    <style type="text/css">
       .kk img{
           max-width:98%;
           max-height:75px;
       }
       
        body {
            background: url(/img/bg2.png);
        }
    </style>
    <script type="text/javascript">
        function BuildMenuFunc(jsonmenu) {
            this.BuildTop = function (jsonmenu) {
                $.ajax
                function Addli(jsonobj, navbarobj, val) {
                    if (val == 1) {
                        var newA = $("<a href='#'></a>").text(jsonobj.text);
                    }
                    else {
                        var newA = $("<a href='#'></a>").text("-" + jsonobj.text);
                    }

                    newA.append($('<small class="hidden"></small>').text(jsonobj.url));
                    if (jsonobj.text == "在线监控视频") {
                        newA = $("<a href='" + jsonobj.url + "' target='new'>在线监控视频</a>");
                    }
                    else {
                        $(newA).on("click", function () {
                            $(this).closest("#nav1").find("li").removeClass("active");
                            $(this).closest("#nav1").find("ul").removeClass("active");
                            $(this).closest("li").addClass("active");
                            var _url = $(this).find("small").text();
                            $("#MainPage").attr("src", _url);
                        });
                    }
                    newA.attr("style", "font-size:15px");
                    var newLi = $('<li></li>').html(newA);
                    navbarobj.append(newLi);
                    return navbarobj;
                }
                function Addul(jsonobj, navbarobj, val) {

                    if (val == 2) {
                        var newLi = $('<li class="dropdown-submenu"></li>');
                        var DDbutton = $('<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"></a>').html(jsonobj.text);
                    }
                    else {
                        var newLi = $('<li class="dropdown"></li>');
                        var DDbutton = $('<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"></a>').html(jsonobj.text + '<b class="caret"></b>');
                    }
                    DDbutton.attr("style", "font-size:15px");
                    var newUl = $('<ul class="dropdown-menu"></ul>');
                    for (var i in jsonobj.value) {
                        var _Model = jsonobj.value[i];
                        switch (_Model.type) {
                            case "menu": {

                                newUl = Addul(_Model, newUl, 2);
                                break;
                            }
                            default: {
                                if (val == 2) {
                                    newUl = Addli(_Model, newUl, 2);
                                }
                                else {
                                    newUl = Addli(_Model, newUl, 1);
                                }
                                break;
                            }
                        }
                    }
                    newLi.append(DDbutton);
                    newLi.append(newUl);
                    navbarobj.append(newLi);
                    return navbarobj;
                }
                _jsonmenu = jsonmenu;
                if (_jsonmenu.menu0 != null) {
                    var newNav1 = $("<ul class='nav navbar-nav navbar-left'></ul>");
                    var newNav2 = $('<ul class="dropdown-menu" id="nav2"></ul>');

                    for (var i in _jsonmenu.menu0) {
                        var _Model = _jsonmenu.menu0[i];
                        switch (_Model.type) {
                            case "menu": {
                                newNav1 = Addul(_Model, newNav1, 1);
                                break;
                            }
                            case "page": {
                                newNav1 = Addli(_Model, newNav1, 1);
                                break;
                            }
                            case "menu-addon": {
                                newNav2 = Addul(_Model, newNav2, 2);
                                break;
                            }
                            default: {
                                newNav2 = Addli(_Model, newNav2, 1);
                                break;
                            }
                        }
                    }

                    if (newNav2.html() != "") {
                        var dropdown = $('<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">更多 <b class="caret"></b></a></li>');
                        dropdown.append(newNav2);

                        $(newNav1).append(dropdown);
                    }
                    $("#nav1").prepend(newNav1);
                }

                else alert("出现错误，网站目录文件损坏");
            }//做顶端栏             
        }
        window.onload = function () {

            var isIE = !!window.ActiveXObject;
            if (window.ActiveXObject) {
                var ua = navigator.userAgent.toLowerCase();
                var ie = ua.match(/msie ([\d.]+)/)[1]
                if (ie == 6.0) {
                    alert("您的浏览器版本过低，在本系统中不能达到良好的视觉效果，建议你升级到ie8以上！");
                    window.location.reload("forie6.html");
                }
            }
        }
        // 初始化整个页面，ajax写入目录和起始页
        var jsonmenu;//直接读json 

        $(function () {
            jsonmenu = JSONfunc.LoadJSON("../menu/mainmenu.txt");//直接读json 
            var buildMenuFunc = new BuildMenuFunc(jsonmenu);//主页的建目录类
            buildMenuFunc.BuildTop(jsonmenu);//做导航栏,包括左侧栏
            $("#MainPage").attr("src", jsonmenu.guide.url);
        });
        $("#userinfo").ready(function () {
            if (CookieFunc.getCookie("username")==null)//游客
            {
                $("#userinfo").text("身份:游客");
            }
            else {
                var username = CookieFunc.getCookie("username");
                var formkk = { "action": "userdetail", "username": username };
                var ret = JSONfunc.postJsontoHandlerAsync(formkk, "ajax/UserHandler.aspx", function (d) {
                    var chnname = (JSONfunc.STRtoJSON(d))[0].中文名;
                    $("#userinfo").text("身份:" + chnname);
                });
            }
        })
    </script>
    <style type="text/css">
    </style>
    <script type="text/javascript">
        //宽度方面
        window.onresize = function () {
            ChildrenCallback();
        }

        function ChildrenCallback() {
            var innerpage = $(window).height() - $("#topnav").height() - 10;
            var pageheight = Math.max( $("#MainPage").contents().find("body").height(),550);
            $("#MainPage").height(pageheight);
        }
    </script>

</head>
<body>
    <div class="container-fluid" id="topnav">
        <div class="row">
            <div class="col-lg-4 col-sm-6">
                <a href="guide.aspx" class=" img-responsive kk" target="MainPage">
                    <img src="/img/Logo1.png" /></a>
            </div>
            <div class="col-lg-4 col-sm-6 pull-right hidden-xs">
                <a href="#" class=" img-responsive kk">
                    <img src="/img/Logo22.png" /></a>
            </div>
           <%--  <div class="pull-right">
                   <a><img class=" img-responsive kk" src="/img/Logo2.png" /></a> 
            </div>--%>
            </div>
        <div class="row">
            <div class="col-md-12">
                <div class="navbar navbar-default" role="navigation" style="margin-bottom: 10px">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#nav1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand pull-right" href="guide.aspx" target="MainPage" id="userinfo"></a>
                        <%--   <a href="guide.aspx" target="MainPage" class="navbar-brand" style="font-size:20px">环保信息系统</a>--%>
                    </div>
                    <div id="nav1" class="collapse navbar-collapse">
                    </div>

                    <%--<div class="collapse navbar-collapse" id="nav1">--%>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid" id="midcon">
        <div class="row">

            <div class="col-md-12">
                <iframe id="MainPage" name="MainPage" frameborder="0" height="550px" width="100%" allowtransparency="true"></iframe>
            </div>
        </div>
    </div>

</body>
</html>
