<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EnvironmentSys.aspx.cs" Inherits="model_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
        <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <title>环境管理体系管理目标</title>
    <style type="text/css">
        /*td {
            white-space: nowrap;
        }*/
    </style>
    <script type="text/javascript">
        var JSONdata = new Object();
        $(function () {
            //读json文件
            //将文件写入网页元素
            ReadContext();
            BuildChangeMain();
        });
        $('#myModal').modal({
            keyboard: false
        });
        function ReadContext() {
            JSONdata = JSONfunc.LoadJSON("jsonData/EnvironmentSys.txt?r=" + Math.ceil(Math.random() * 10000));
            /*
            先从txt里面读目录。
            如果对内容进行了修改，在handler里面会将新的目录同时写入txt和数据库
            */
            var Mantarget = $("#Managetarget");
            for (var It in JSONdata.管理目标)//将管理目标中的东西做成元素加在这里面
            {
                var jsonobj = JSONdata.管理目标[It];
                var newTarget = $("<div></div>").html("<div class='thumbnail'><div class='caption'><h3>" + jsonobj.title + "</h3><p>" + jsonobj.text + "</p></div></div>");
                newTarget.addClass("col-sm-4");
                Mantarget.append(newTarget);
            }
            //制表
            var tbodyContext = $("#detailTable").find("tbody");
            for (var It in JSONdata.各车间科室目标) {
                var jsonobj = JSONdata.各车间科室目标[It];
                var newTarget = $("<tr></tr>").html("<td>" + jsonobj.title + "</td><td>" + jsonobj.text + "</td>");
                tbodyContext.append(newTarget);
            }
            //做表注脚，一些其他信息
            var tfootcontext = $("#detailTable").find("tfoot");
            var otherinfo = "";
            for (var it in JSONdata.其他信息) {
                var jsonobj = JSONdata.其他信息[it];
                otherinfo += "<td>" + jsonobj.title + "</td> :before <td>" + jsonobj.text + "</td>";
            }
            var newTfoor = $("<tr></tr>").html(otherinfo);
            tfootcontext.append(newTfoor);
        }
        function BuildChangeMain() {
            var strJson = JSON.stringify(JSONdata);
        }


    </script>
</head>
<body>
    <form runat="server">
        <div class="container-fluid">
            <%--标题--%>
            <div class="row">
                <div class="page-header">
                    <h1>环境管理体系 <small>管理目标</small></h1>
                </div>
            </div>
        </div>
        <%--主要内容--%>
        <div class="container-fluid ">
            <%--管理目标--%>
            <div class="row" id="Managetarget">
            </div>
            <div class="row">
                <%--表格--%>
                <table class="table  table-hover  table-responsive" id="detailTable">
                    <caption>
                        <h3>车间、科室目标</h3>
                    </caption>
                    <thead>
                        <tr>
                            <th>单位</th>
                            <th>目标</th>
                        </tr>
                    </thead>
                    <%--表尾--%>
                    <tfoot>
                    </tfoot>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="pull-right">
                    <a class="btn btn-primary btn-lg" href="EnvironmentSysA.aspx">修改管理目标              
                    </a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
