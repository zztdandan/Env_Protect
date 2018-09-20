<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PDDRfactory.aspx.cs" Inherits="module_PSManage_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="../../JavaScript/autocomplete/jquery.autocomplete.min.js"></script>
    <link href="../../JavaScript/autocomplete/jquery.autocomplete.css" rel="stylesheet" />
    <script src="../../datatables/js/jquery.dataTables.min.js"></script>
    <link href="../../datatables/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="../../bootstrap3/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../../bootstrap3/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <link href="../../bootstrap3/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
        <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <script src="../../JavaScript/CookieFunc.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>岗位粉尘检测结果（厂部）</title>
    <style type="text/css">
        table.tableizer-table {
            border: 1px solid #ccc;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 12px;
            white-space: nowrap;
            width: 100%;
        }

        .tableizer-table td {
            padding: 4px;
            margin: 3px;
            border: 1px solid #ccc;
        }

        .tableizer-table th {
            background-color: #104e8b;
            color: #fff;
            font-weight: bold;
            border: 1px solid #ffffff;
        }
    </style>
    <script type="text/javascript">
        var PDDRTable;
        var thArray = ["时间",
                                "单位",
                                "是否合格",
                                "检查点名称",
                                "检查位置",
                                "检测点电话",
                                "检测数据（单位：mg/m3）",
                                "检测人员",
                                "岗位人员",
                                "备注（下雨或者开停机）"];
        function PDDR() { }
        PDDR.FillInput = function (datatofill, inputForm) {
            for (var i in datatofill) {
                $(inputForm[i]).val(datatofill[i]);
            }

        }
        PDDR.BuildPanel = function (nowmonth) {

            function BuildTable(_retarray, _idarray) {
                function Buildtd(jsonobj, thArray) {
                    for (var i in thArray) //i为数字
                        for (var j in jsonobj) //j为项目，即列名
                            if (j == thArray[i]) {
                               
                                var newtd = $("<td></td>").html(jsonobj[j]);
                                if (j == "检测数据（单位：mg/m3）") {
                                    if (typeof jsonobj[j] == "string") { jsonobj[j] = parseFloat(jsonobj[j]) };
                                    if (jsonobj[j] > 8) {
                                        $(newtd).removeClass("text-warning");
                                        $(newtd).addClass("text-danger");
                                    }
                                    else if (jsonobj[j] > 5) {
                                        $(newtd).removeClass("text-danger");
                                        $(newtd).addClass("text-warning");
                                    }
                                    else {
                                        $(newtd).removeClass("text-danger");
                                        $(newtd).removeClass("text-warning");
                                    }
                                } else if (j == "是否合格") {
                                    if (jsonobj[j] == "1") {
                                        newtd = $("<td></td>").html("是");
                                    }
                                    else {
                                        newtd = $("<td></td>").html("否");
                                    }
                                }
                                $(Newtr).append(newtd);
                                break;
                            }
                    $(Newtr).append($("<td></td>").html(""));
                }
                PDDRTable = $("#PDDRTable");

                for (var i in _retarray)//建立表格
                {
                    var Newtr = $("<tr idarray='"+idarray[i]+"'></tr>");
                    Buildtd(_retarray[i], thArray);
                    $(PDDRTable).find("tbody").append(Newtr);
                }

                $(PDDRTable).dataTable(//表格初始化
                {
                    "dom": '<fl<t>ip>',
                    "lengthMenu": [[-1, 10, 100], ["ALL", 10, 100, ]],
                    "language": {
                        "lengthMenu": "每页 _MENU_ 条记录",
                        "zeroRecords": "没有找到记录",
                        "info": "第 _PAGE_ 页 ( 总共 _PAGES_ 页 )",
                        "infoEmpty": "无记录",
                        "infoFiltered": "(从 _MAX_ 条记录过滤)"
                    },
                    "scrollX": true,
                    "columnDefs": [{
                        "targets": -1,
                        "orderable": false,
                        "data": null,
                        "defaultContent": '<a class="btn editorbtn btn-primary btn-sm" author="jidongke">删除</a>'
                    }]
                });
                $(PDDRTable).find('tbody').on('click', 'a.editorbtn', function () {
                    var tr = $(this).closest('tr');
                    var id = tr.attr("idarray");
                    var formkk = { "action": "DelCheckInfo", "id": id };
                    var ret = JSONfunc.postJsontoHandler(formkk, "/ajax/CheckInfoHandler.aspx");
                    if (ret == "1") {
                        tr.remove();
                    }
                    else { alert(ret) }
                });
            }
            var reg1 = /(\d+)-(\d+)/;

            //从数据库读取数据
            var formRead = { "action": "LoadPDDRbyMon", "time": nowmonth };
            var _ret = JSONfunc.postJsontoHandler(formRead, "/ajax/CheckInfoHandler.aspx");
            if (_ret == "[]") { CookieFunc.Checkuser(); alert("没有数据，请重新选择日期"); return 0; }
            $("#TableHeader").html(reg1.exec(nowmonth)[1] + "年" + reg1.exec(nowmonth)[2] + "月生产车间粉尘现场检测点记录表");
            var _retarray = JSONfunc.STRtoJSON(_ret);
            var newretarray = new Array();
            var idarray = new Array();
            for (i in _retarray) {
                newretarray[i] = JSONfunc.STRtoJSON(_retarray[i].详情);
                idarray[i] = _retarray[i].Id;
            }
            //-----------------读取结束，存入cmLiqArray---------------
            BuildTable(newretarray, idarray);
            CookieFunc.Checkuser();
        }//datatable建立初始化函数
        PDDR.SwapPanel = function (date) {            
            if (date == "") {
                date = (new Date()).pattern("yyyy-MM");
            }
            if ($(PDDRTable).find('td').length != 0)//判断是否有datatable,如果没有，则做这个函数会出错
            {
                $(PDDRTable).dataTable().fnDestroy();
            }
            $(PDDRTable).find("tbody").html("");
            PDDR.BuildPanel(date);
        }
        PDDR.Formatauto = function () {
            var PDDRList = JSONfunc.LoadJSON("jsondata/PDDRAssist.txt");
            var Unit = PDDRList.单位;
            var Cpoint = PDDRList.检查点;
            $("#cpoint-control").autocomplete(Cpoint, {
                minChars: 0,
                scroll: true
            });
            $("#unit-control").autocomplete(Unit, {
                minChars: 0,
                scroll: true
            });
        }//初始化自动填表
        PDDR.SubMit = function (inputArray) {
            var newSubArray = new Object();
            for (i = 0; i < inputArray.length; i++) {
                if (inputArray[i].value == "") { alert("有数据项:\"" + thArray[i] + "\"  没填完"); return 0; }
                newSubArray[thArray[i]] = inputArray[i].value;
            }
            var date = newSubArray.时间;
            var formSave = { "action": "SavePDDR", "time": date, "fac": newSubArray.单位, "type": "粉尘采样", "pass": newSubArray.是否合格, "JSONDATA": JSONfunc.JSONtoSTR(newSubArray) };
            var _ret = JSONfunc.postJsontoHandler(formSave, "/ajax/CheckInfoHandler.aspx");
            alert(_ret);
            PDDR.SwapPanel($("#month-select").val());
        }
        $(function () {
            var NowMonth = (new Date()).pattern("yyyy-MM");
            PDDR.BuildPanel(NowMonth);
            PDDR.Formatauto();
        });
    </script>
</head>
<body>
    <div class="container-fluid">
        <div class="page-header">
            <h3>岗位粉尘检测结果（厂部）</h3>
        </div>
        <div class="panel panel-default">
            <div class="panel-body bg-info">
                <h2 id="TableHeader"></h2>
                <div class="control-group col-lg-5">
                    <!-- Appended input-->
                    <label class="control-label">时间</label>
                    <div class="controls">
                        <div class="input-append">
                            <div class="input-group date" id="dtpclass1" data-date="" data-link-field="month-select" data-link-format="yyyy-mm">
                                <input class="form-control" id="selector-control" size="16" type="text" value="" />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                <a href="#" type="button" class="input-group-addon btn btn-default" onclick="PDDR.SwapPanel($('#month-select').val())">查询</a>
                            </div>
                            <input type="hidden" id="month-select" value="" /><br />
                            <p class="help-block">用右边选择日期,也可以直接在框内输入""YYYY-MM"</p>
                            <script>
                                $("#dtpclass1").ready(function () {
                                    $('#dtpclass1').datetimepicker({
                                        format: 'yyyy-mm',
                                        language: 'zh-CN',
                                        minView: 3,
                                        weekStart: 1,
                                        startDate: '2010-01',
                                        endDate: '2100-01',
                                        todayBtn: "linked",
                                        autoclose: 1,
                                        startView: 3,
                                        forceParse: 0,
                                    });
                                });//初始化日期选择器,dtpclass是日期选择器标识
                                document.getElementById("selector-control").onchange = function () {
                                    reg1 = /(\d+)-(\d+)/;
                                    if ($(this).val() == "") {
                                        $("#dtpclass1").nextAll(".help-block").html("用右边选择日期,也可以直接在框内输入\"YYYY-MM\"");
                                    }
                                    else {
                                        if (reg1.test($(this).val())) {
                                            $("#year-select").val($(this).val());
                                            $("#dtpclass1").nextAll(".help-block").html("日期格式正确，点右边查询按钮可查询");
                                            $("#dtpclass1").find("a").removeClass("disabled");
                                        }
                                        else {
                                            $("#dtpclass1").nextAll(".help-block").html("你输入的日期格式不正确，请输入\"YYYY-MM\"格式");
                                            $("#dtpclass1").find("a").addClass("disabled");
                                        }
                                    }
                                }//一个简单的认证函数
                            </script>
                        </div>
                    </div>
                </div>
            </div>
            <ul class="list-group">
                <li class=" list-group-item">
                    <div class="collapse" id="addCollapse">
                        <div class="well">
                            <form id="addForm">
                                <div class="form-group">
                                    <label class="control-label">时间</label>
                                    <div class="input-append">
                                        <div class="input-group date" id="dtpclass2" data-date="" data-link-field="add-select" data-link-format="yyyy-mm-dd hh:ii">
                                            <input class="form-control" id="add-select" size="16" type="text" value="" />
                                            <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                        </div>
                                        <%--<input type="hidden" id="add-select" value="" /><br />--%>
                                        <script>
                                            $("#dtpclass2").ready(function () {

                                                Monthstart = (new Date).pattern("yyyy-MM") + "-01";
                                                var lastday = (new Date(((new Date).getFullYear()), (new Date).getMonth() + 1, 0)).pattern("yyyy-MM-dd");
                                                $('#dtpclass2').datetimepicker({
                                                    format: 'yyyy-mm-dd hh:ii',
                                                    language: 'zh-CN',
                                                    minView: 0,
                                                    weekStart: 1,
                                                    startDate:'2010-01-01',
                                                    endDate: lastday,
                                                    todayBtn: "linked",
                                                    autoclose: 1,
                                                    startView: 2,
                                                    forceParse: 0,
                                                });
                                            });//初始化日期选择器,dtpclass是日期选择器标识

                                        </script>
                                    </div>
                                    <p class="help-block">通过控件选择,如果修改时间，将不会覆盖原来的数据</p>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">单位</label>
                                    <input type="text" class="form-control" id="unit-control" />
                                    <p class="help-block">按上下方向键或输入部分内容可查看列表</p>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">是否合格</label>
                                    <select class="form-control">
                                        <option value='1' selected="selected">是</option>
                                        <option value='0'>否</option>
                                    </select>
                                    <p class="help-block">"是"或"否"</p>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">检查点名称</label>
                                    <input type="text" class="form-control" id="cpoint-control" />
                                    <p class="help-block">按上下方向键或输入部分内容可查看列表</p>
                                </div>
                                <div class="form-group">
                                    <label class="control-label">检查位置</label>
                                    <input type="text" class="form-control" />
                                </div>
                                <div class="form-group">
                                    <label class="control-label">检测点电话</label>
                                    <input type="text" class="form-control" />
                                </div>
                                <div class="form-group">
                                    <label class="control-label">检测数据（单位：mg/m3）</label>
                                    <input type="text" class="form-control" />
                                </div>
                                <div class="form-group">
                                    <label class="control-label">检测人员</label>
                                    <input type="text" class="form-control" />
                                </div>
                                <div class="form-group">
                                    <label class="control-label">岗位人员</label>
                                    <input type="text" class="form-control" />
                                </div>
                                <div class="form-group">
                                    <label class="control-label">备注（下雨或者开停机）</label>
                                    <input type="text" class="form-control" />
                                </div>
                            </form>
                            <a class="btn btn-primary" onclick='PDDR.SubMit($("#addForm").find(".form-control"))'>保存数据</a>
                            <a class="btn btn-default" data-dismiss="modal" onclick='$("#addCollapse").collapse("hide");'>收起</a>

                        </div>
                    </div>
                    <table id="PDDRTable" class="table  table-hover  table-responsive text-center" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th>时间</th>
                                <th>单位</th>
                                <th>是否合格</th>
                                <th>检查点名称</th>
                                <th>检查位置</th>
                                <th>检测点电话</th>
                                <th>检测数据（单位：mg/m3）</th>
                                <th>检测人员</th>
                                <th>岗位人员</th>
                                <th>备注（下雨或者开停机）</th>
                                <th></th>
                            </tr>
                        </thead>

                        <tbody>
                        </tbody>
                    </table>
                </li>
                <li class=" list-group-item">
                    <div class="btn-group" role="group" aria-label="...">
                        <a class="btn btn-primary" data-toggle="collapse" data-target="#addCollapse" aria-expanded="false" aria-controls="addCollapse" onclick='var aarray=["","","1","","","","","","",""]; PDDR.FillInput(aarray,$("#addForm").find(".form-control"));' author="jidongke">添加新项
                        </a>
                    </div>

                </li>
            </ul>
        </div>
    </div>
</body>
</html>
