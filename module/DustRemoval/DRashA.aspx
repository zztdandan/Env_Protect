<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DRashA.aspx.cs" Inherits="module_DustRemoval_DRashA" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../JavaScript/CookieFunc.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
        <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="../../datatables/js/jquery.dataTables.min.js"></script>
    <link href="../../datatables/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="../../bootstrap3/js/bootstrap-datetimepicker.js"></script>
    <script src="../../bootstrap3/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <link href="../../bootstrap3/css/bootstrap-datetimepicker.css" rel="stylesheet" />
    <script src="../../JavaScript/JSONfunction.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <script src="../../JavaScript/Support1.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <title></title>
    <script type="text/javascript">
        $(function () {
            ReadDate((new Date()).pattern("yyyy-MM-dd"));
        })


    </script>
    <script type="text/javascript">
        var submitJson = new Object();
        $("#dtpclass2").ready(function () {
            $('#dtpclass2').datetimepicker({
                format: 'yyyy-mm-dd',
                language: 'zh-CN',
                minView: 2,
                weekStart: 1,
                startDate: '2010-01-01',
                endDate: '2100-01-01',
                todayBtn: "linked",
                autoclose: 1,
                startView: 'year',
                forceParse: 0,
            }).on('changeDate', function (ev) {
                debugger;
                ReadDate($('#date-select').val());
            })
            $("#dtpclass2").find("input").val((new Date()).pattern("yyyy-MM-dd"));
            $("#date-select").val((new Date()).pattern("yyyy-MM-dd"));
        });//初始化日期选择器,dtpclass2是日期选择器标识,位于表单内
        function ReadDate(str) {

            function BuildupsetTable(jsonobj) {
                var _newTable = $("<table></table>");
                $.each(jsonobj,function(i) {
                    var _cell = jsonobj[i];
                    var _newRow = $("<tr></tr>");
                    $.each(_cell, function (j) {
                        var _atom = this;
                        var class1 = "row" + i;
                        var class2 = j;
                        if (j != "number" && j != "substance") {
                            var _newatom = $("<td></td>").html("<textbox class='" + class1 + " " + class2 + "'>" + _atom + "</textbox>");
                        }
                        else {
                            var _newatom = $("<td></td>").html("<input class='" + class1 + " " + class2 + "' value=" + _atom + " />");
                        }
                        _newRow.append(_newatom);
                    });
                    _newTable.append(_newRow);
                });
                $("#upsetTable tbody").append(_newTable.find("tbody").html());
            }//从json建立表格
            if (str == "") return 0;
            $("#upsetTable tbody").html("");
            var formkk = { "action": "DRashRead", "time": str };
            var _ret = JSONfunc.postJsontoHandler(formkk, "/ajax/DRashHandler.aspx");
            if (_ret == "[]") {//没有数据
                submitJson.Json = JSONfunc.LoadJSON("jsonData/DRash.txt");
                var formatJson = submitJson.Json.value;//读取文件夹内的标准数据
                submitJson.Has = false;
                $("#btnChange").hide();
                $("#btnDel").hide();
                $("#btnAdd").show();
            }
            else {//有数据
                var _retarray = JSONfunc.STRtoJSON(_ret);
                submitJson.Json = JSONfunc.STRtoJSON(_retarray[0].数据)
                var formatJson = submitJson.Json.value;
                submitJson.Has = true;
                $("#btnChange").show();
                $("#btnDel").show();
                $("#btnAdd").hide();
            }

            BuildupsetTable(formatJson);
        }//读日期，从日期读出json
        function aa(){
        submit1($('#date-select').val());
        }
        function submit1(date) {
            function RebuildJson(jsonobj) {
                for (var i in jsonobj.value) {
                    var _inputnumber = $(".number.row" + i).val();
                    jsonobj.value[i].number = parseFloat(_inputnumber);
                    var _inpusubstance = $(".substance.row" + i).val();
                    jsonobj.value[i].substance = parseFloat(_inpusubstance
                        );
                }
                return jsonobj;
                //如果要改变数据结构，需要改DRash.txt，改完后就能达到目的，不能网页内修改                         
            }
            
            submitjson=submitJson;
            submitjson.Json = RebuildJson(submitjson.Json);

            if (!submitjson.Has) {
                var formkk = { "action": "DRashSave", "time": date, "JSONDATA": JSONfunc.JSONtoSTR(submitjson.Json) };
            } else {
                var formkk = { "action": "DRashUpdate", "time": date, "JSONDATA": JSONfunc.JSONtoSTR(submitjson.Json) };
            }
            var resp = JSONfunc.postJsontoHandler(formkk, "/ajax/DRashHandler.aspx");//根据不同情况，选择改变或添加新项
            alert(resp);
            ReadDate($('#date-select').val());
        }//以日期和json情况，将数据写入数据库
        function del(date) {
            var formkk = { "action": "DRashDel", "time": date };
            alert
            var resp = JSONfunc.postJsontoHandler(formkk, "/ajax/DRashHandler.aspx");//根据不同情况，选择改变或添加新项
            alert(resp);
            ReadDate($('#date-select').val());
        }//删除当前日期的数据
    </script>
</head>
<body>
    <%--  ReadDate($('#date-select').val())--%>
    <form>

        <%--表单内容--%>
        <div class="control-group">

            <!-- Appended input-->
            <label class="control-label">录入/修改时间</label>
            <div class="controls">
                <div class="input-append">
                    <div class="input-group date " id="dtpclass2" data-date="" data-link-field="date-select" data-link-format="yyyy-mm-dd">
                        <input class="form-control" id="date-select" size="16" type="text" value=""/>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                    </div>
                </div>
                <p class="help-block">点击按钮打开修改表单。如果已有该日期的数据，则新数据会覆盖旧数据。默认显示的表单是今日的表单</p>
            </div>
        </div>
        <table id="upsetTable" class="table  table-hover  table-responsive table-condensed table-bordered" cellspacing="0" width="768px">
            <thead>
                <tr>
                    <th>名称</th>
                    <th>序号</th>
                    <th>类型</th>
                    <th>重量</th>
                    <th>单重</th>
                </tr>
            </thead>
            <tfoot>
            </tfoot>
            <tbody class="text-center">
            </tbody>
        </table>
        <div class="btn-group text-center" role="group" aria-label="...">
            <a href="#" type="button" class="btn btn-primary" id="btnAdd" onclick="aa()">添加</a>
            <a href="#" type="button" class="btn btn-primary" id="btnChange" onclick="aa()">修改</a>
<%--              <a href="#" type="button" class="btn btn-primary" id="btnAdd" onclick="alert('123')">添加</a>
            <a href="#" type="button" class="btn btn-primary" id="btnChange" onclick="alert('233')">修改</a>--%>
            <a href="#" type="button" class="btn btn-danger" id="btnDel" onclick="del($('#date-select').val())">删除</a>
            <a href="#" type="reset" class="btn btn-default" id="btnReset" onclick="ReadDate($('#date-select').val())">还原修改</a>
        </div>
    </form>
</body>
</html>
