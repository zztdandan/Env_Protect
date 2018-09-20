<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EnvironmentSysA.aspx.cs" Inherits="module_Manage_EnvironmentSysA" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <title>环境管理体系管理目标修改页面</title>
    <style type="text/css">
       
    </style>
    <script type="text/javascript">
        var partjson = new Array();
        var jsonmenu = new Object();
        var strJson = "";
        $(function ()
        {
            BuildForm();

        });
        function Restore()
        {
            $("#ChangeForm").html("");
            BuildForm();
        }
        function SaveChange()
        {
            if ($(checknum).val() == "")
            {
                RebuildJson();//采集填好的表格到json
                var _name="EnvironmentSys";
                var _url = "module\\Manage\\jsonData\\EnvironmentSys.txt";//文件流右斜，网页左斜
                var _jsonobj=strJson;
                var _form = { "action": "SaveJsonToDB", "name": _name, "JSONDATA": _jsonobj }; 
                JSONfunc.postJsontoHandler(_form,"/ajax/JsonHandler.aspx");
                var _form1 = { "action": "SaveJsonToFile", "name": _name, "url": _url, "JSONDATA": _jsonobj };
                var ad = JSONfunc.postJsontoHandler(_form1, "/ajax/JsonHandler.aspx");
            }
            else alert("口令错误，不能修改");
        }
        
        function BuildForm()
        {
            //正则表达式
            reg = /"title":".+?","text":".+?"/g;
            jsonmenu = JSONfunc.LoadJSON("jsonData/EnvironmentSys.txt?r=" + Math.ceil(Math.random() * 100));
            strJson = JSONfunc.JSONtoSTR(jsonmenu);
            //分割后要修改的各个字串组：
            JsonSplited = strJson.match(reg);

            a = DateString();
            for (var i in JsonSplited)
            {
                partjson[i] = JSONfunc.STRtoJSON("{" + JsonSplited[i] + "}");
                var formgroup = $("<div></div>").html("<label for='" + partjson[i].title + "'>" + partjson[i].title + "</label> <input class='form-control' id='" + partjson[i].title + "' value='" + partjson[i].text + "' /><br/>");
                formgroup.addClass("form-group");
                $("#ChangeForm").append(formgroup);
            }
            $("#修改时间").val(DateString());
            $("#修改时间").attr("disabled", "disabled");
        }
        function DateString()
        {
            var d = new Date();
            var vYear = d.getFullYear();
            var vMonth = d.getMonth() + 1;
            var vDate = d.getDate();
            var vHour = (d.getHours() < 10) ? ("0" + d.getHours()) : (d.getHours());
            var vMinutes = ((d.getMinutes() < 10) ? ("0" + d.getMinutes()) : ("" + d.getMinutes()));
            var str = vYear + "-" + vMonth + "-" + vDate + " " + vHour + ":" + vMinutes;
            return str;
        }
        function RebuildJson()
        {
            for (var i in partjson)
            {
                regpart = eval('/("' + partjson[i].title + '","text":").+?(")/');
                valueToRep = $("#" + partjson[i].title)[0].value;
                strJson=strJson.replace(regpart, "$1" + valueToRep + "$2");
            }
        }
        function backPage()
        {
            window.location.href = "EnvironmentSys.aspx";
        }
    </script>
</head>
<body>
    <div class=" container-fluid">
        <div class="row">
            <div class=" col-sm-offset-1 col-sm-10">
                <div class="well">
                    <form role="form" id="ChangeForm">
                    </form>
                </div>
            </div>
        </div>
        <div class="row ">
            <div class="col-sm-6 col-sm-offset-3 center">
                <input class="form-control " id="checknum" placeholder="只有输入正确的代码才能修改管理目标的内容！" />
                <br />
                <div class="btn-group" role="group" aria-label="...">
                    <a class="btn btn-primary" onclick="SaveChange()">保存修改</a>
                    <a class="btn btn-default" onclick="Restore()">还原未保存的修改</a>
                    <a class="btn btn-default" onclick="backPage()">返回</a>
                </div>
                         
            </div>
        </div>
    </div>
       
</body>
</html>
