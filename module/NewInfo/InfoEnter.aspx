<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InfoEnter.aspx.cs" Inherits="module_NewInfo_InfoEnter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
        <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="../../ueditor/ueditor.config.js"></script>
    <script src="../../ueditor/ueditor.all.js"></script>
    <script src="../../bootstrap3/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../../bootstrap3/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <link href="../../bootstrap3/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="../../JavaScript/autocomplete/jquery.autocomplete.css" rel="stylesheet" />
    <script src="../../JavaScript/autocomplete/jquery.autocomplete.min.js"></script>
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />

    <link href="../../bootstrap3/css/buttons.css" rel="stylesheet" />
    <script src="../../JavaScript/CookieFunc.js"></script>
    <script type="text/javascript">
        var classList = new Array();
        var ue1
        function EInfo() { };
        EInfo.Formatauto = function () {
            var Jsonread = JSONfunc.LoadJSON("/menu/EInfoA.txt");
            j = 0;
            for (var i in Jsonread) {
                classList[j] = Jsonread[i].name;
                j = j + 1;
            }
            $("#EClass").autocomplete(classList, {
                minChars: 0,
                scroll: true
            });
            var username = CookieFunc.getCookie("username");
            var formkk = { "action": "userdetail", "username": username };

            var ret = JSONfunc.postJsontoHandlerAsync(formkk, "/ajax/UserHandler.aspx", function (d) {

                var chnname = (JSONfunc.STRtoJSON(d))[0].中文名;
                var guidearr = JSONfunc.STRtoJSON((JSONfunc.STRtoJSON(d))[0].快捷导航);
                $("#EEditor").val(chnname);
            });
        }
        EInfo.subMit = function (time, classify, editor, title) {
            for (var i in classList)
                if (classify == classList[i]) {
                    var classifyN = i;
                    break;
                }

            if (time == "" || classify == "" || editor == "" || title == "") { alert("时间，分类，作者，标题必须全部填写"); return 0; };
            var _container = ue1.getContent();
            var formkk = { "action": "NewInfoSub", "time": time, "classify": classify, "editor": editor, "title": title, "container": _container, "classifyN": classifyN };
            var _ret = JSONfunc.postJsontoHandler(formkk, "/ajax/InfoHandler.aspx");
            alert(_ret);
        }
        $(function () {
            EInfo.Formatauto();
        })
        $("#container").ready(function () {
            var ue = UE.getEditor('container');
            ue1 = ue;
        })

    </script>
    <title>环保资讯录入页面(EInfo)</title>
    <script>
       
    </script>
</head>
<body>
    <div class="container">
        <!--使用uedit录入资讯-->
        <div class="page-header">
            <h3>文章录入</h3>
        </div>
        <form id="formEInfo" class="form-horizontal">

            <div class="row">
                <div class="form-group-sm col-sm-4">
                    <!-- Appended input-->
                    <label class="control-label">日期</label>
                    <div class="input-append">
                        <div class="input-group date" id="EInfo-date" data-date="" data-link-field="EInfo-date-show" data-link-format="yyyy-mm-dd hh:ii">
                            <input class="form-control " id="EInfo-date-show" size="16" type="text" value="" />
                            <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                        </div>
                        <p class="help-block">用右边选择日期,也可以直接在框内输入"YYYY-MM-DD"</p>
                    </div>
                    <script>
                        $("#EInfo-date").ready(function () {
                            $('#EInfo-date').datetimepicker({
                                format: 'yyyy-mm-dd hh:ii',
                                language: 'zh-CN',
                                minView: 0,
                                weekStart: 1,
                                startDate: '2010-01-01',
                                endDate: '2100-01-01',
                                todayBtn: "linked",
                                autoclose: 1,
                                startView: 2,
                                forceParse: 0,
                            });
                        });//初始化日期选择器,EInfo-date为标志
                    </script>
                </div>
                <div class="form-group-sm col-sm-4">
                    <label class="control-label">分类</label>
                    <input type="text" class="form-control " id="EClass" />
                    <p class="help-block">可用上下方向键打开选择列表，或直接输入部分字</p>
                </div>
                <div class="form-group-sm col-sm-4">
                    <label class="control-label">作者</label>
                    <input type="text" class="form-control" id="EEditor"/>
                </div>
            </div>
            <div class="row">
                <div class=" col-sm-2 col-sm-offset-1 text-center">
                    <label class="control-label" style="font-size: 25px">标题：</label>
                </div>
                <div class=" col-sm-6">
                    <input type="text" class="form-control" id="ETitle" />
                </div>
            </div>
            <hr style="filter: alpha(opacity=100,finishopacity=0,style=2)" width="100%" color="#23512b" size="3" />
            <div class="row">

                <div class="col-sm-12">

                    <!-- 加载编辑器的容器 -->
                    <script id="container" name="content" type="text/plain">
                    </script>
                </div>

            </div>
            <hr style="filter: alpha(opacity=100,finishopacity=0,style=2)" width="100%" color="#23512b" size="1" />
            <div class="row">
                <div class="col-sm-offset-1 col-sm-10">

                    <a class=" button button-3d button-primary button-block" id="btnAdd" onclick="EInfo.subMit($('#EInfo-date-show').val(),$('#EClass').val(),$('#EEditor').val(),$('#ETitle').val())">添加文档</a>
                </div>
            </div>
        </form>

    </div>

</body>
</html>
