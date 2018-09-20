<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DSinspection.aspx.cs" Inherits="module_PSManage_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="../../datatables/js/jquery.dataTables.min.js"></script>
    <link href="../../datatables/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="../../bootstrap3/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../../bootstrap3/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <link href="../../bootstrap3/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <script src="../../JavaScript/CookieFunc.js"></script>
    <title>粉尘源自检结果</title>
    <script type="text/javascript">
        var thArray;
        var thnumArray;
        var DSinspectionTable;
        function DSinspection() { }
        DSinspection.BuildPanel = function (nowmonth) {
            function BuildTable(_retarray) {
                function Buildth(thobj) {
                    var _newtr = $("<tr></tr>");
                    var tharray = new Array();
                    var j = 0;
                    for (var i in thobj[0]) {
                        _newtr.append($("<th></th>").html(i));
                        tharray[j] = i;
                        j = j + 1;
                    }
                    $(DSinspectionTable).find("thead").append(_newtr);
                    return tharray;
                }
                function Buildtd(jsonobj, thArray) {
                    for (var i in thArray) //i为数字
                        for (var j in jsonobj) //j为项目，即列名
                            if (j == thArray[i]) {
                                if (jsonobj[j] == null) { var newtd = $("<td></td>").html("未填"); }
                                else {

                                    if (j != "time") {//不是时间，输出字串

                                        if (typeof jsonobj[j] == "string") { jsonobj[j] = parseInt(jsonobj[j]); }
                                        percentNum = parseInt((thnumArray[j].number - jsonobj[j]) / thnumArray[j].number * 100) + "%";
                                        str = "异常数:" + jsonobj[j] + "<br/>正常比:" + percentNum + "<br/>";
                                        var btn = $('<a href="#" type="button" class="bg-info" data-toggle="modal" data-target="#ShowModal">(查询)</a>')
                                        var newtd = $("<td></td>").html($("<strong></strong>").html(str));
                                        $(newtd).append(btn);

                                    }
                                    else {//等于时间，直接输出
                                        var newtd = $("<td></td>").html(jsonobj[j]);
                                    }
                                }
                                $(Newtr).append(newtd);
                                break;
                            }
                }
                function Buildtf(jsondata, jsonsum) {
                    var footArray = new Array();
                    for (var i in thArray) {
                        footArray[i] = new Object();
                        footArray[i].err = 0;
                        footArray[i].tot = 0;
                    }
                    for (var i in jsondata) {
                        for (var j in jsonsum) {
                            if (typeof jsondata[i][j] == "string") {
                                var dataNum = parseInt(jsondata[i][j]);
                            }
                            else {
                                var dataNum = jsondata[i][j];
                            }
                            if (dataNum != null) {//该值有数据
                                var ord;
                                for (var k in thArray) {
                                    if (thArray[k] == j) { ord = parseInt(k); break; }
                                }
                                footArray[ord].err += dataNum;
                                footArray[ord].tot += thnumArray[j].number;
                            }
                        }
                    }
                    var foottr = $("<tr></tr>").html("");
                    var totalErr = 0;
                    for (var i in footArray) {
                        if (thArray[i] == "time") {
                            foottr.append($("<td></td>").html("<strong></strong>"));
                        } else {
                            if (footArray[i].tot != 0) {
                                totalErr += footArray[i].err;
                                var percentNum = parseInt((footArray[i].tot - footArray[i].err) / footArray[i].tot * 100) + "%";
                                var newtd = $("<td></td>").html("总异常数:" + footArray[i].err + "<br/>正常比率:" + percentNum + "<br/>");
                                foottr.append(newtd);
                            }
                            else {
                                foottr.append($("<td></td>").html(""));
                            }
                        }
                    }
                    foottr.find("strong").text("本月总异常数:" + totalErr);
                    $(DSinspectionTable).find("tfoot").append(foottr);
                }
                DSinspectionTable = $("#DSinspectionTable");
                thArray = new Array();

                thArray = Buildth(_retarray);
                for (var i in _retarray)//建立表格
                {
                    var Newtr = $("<tr></tr>");
                    Buildtd(_retarray[i], thArray);
                    $(DSinspectionTable).find("tbody").append(Newtr);
                }
                Buildtf(_retarray, thnumArray);
                //$('#DSinspectionTable').dataTable(//表格初始化
                //{
                //    "dom": '<fl<t>ip>',
                //    "lengthMenu": [[-1, 10, 100], ["ALL", 10, 100, ]],
                //    "language": {
                //        "lengthMenu": "每页 _MENU_ 条记录",
                //        "zeroRecords": "没有找到记录",
                //        "info": "第 _PAGE_ 页 ( 总共 _PAGES_ 页 )",
                //        "infoEmpty": "无记录",
                //        "infoFiltered": "(从 _MAX_ 条记录过滤)"
                //    },
                //    "scrollX": true
                //});
                DSinspectionTable.find('tbody').on('click', 'a.bg-info', function () {
                    var tr = $(this).closest('tr');
                    var columns = thArray[$(this).closest('td').index()];
                    var time = tr.find("td:eq(0)").html();
                    //$("#DSinspectionAframe").attr("src", "DSinspectionA.aspx?act=show");
                    DSinspectionAframe1.window.DSinspectionA.parentCall(time, columns);
                })//初始化表格函数，制作新表函数
            }
            var reg1 = /(\d+)-(\d+)/;
            //从数据库读取数据
            var formRead = { "action": "DSReadTotalCol", "time": nowmonth };
            var _ret = JSONfunc.postJsontoHandler(formRead, "/ajax/DSinspectHandler.aspx");
            if (_ret == "[]") { CookieFunc.Checkuser(); alert("没有数据，请重新选择日期"); return 0; }
            $("#TableHeader").html(reg1.exec(nowmonth)[1] + "年" + reg1.exec(nowmonth)[2] + "月粉尘源自检");
            var _retarray = JSONfunc.STRtoJSON(_ret);
            //-----------------读取结束，存入_retArray---------------
            BuildTable(_retarray);
            CookieFunc.Checkuser();
        }//datatable建立初始化函数
        DSinspection.SwapPanel = function (date) {
            if (date == "") {
                date = (new Date()).pattern("yyyy-MM");
            }
            if ($(DSinspectionTable).find('td').length != 0)//判断是否有datatable,如果没有，则做这个函数会出错
            {
                $(DSinspectionTable).dataTable().fnDestroy();
            }
            $(DSinspectionTable).html("<thead></thead><tbody></tbody><tfoot></tfoot>");
            DSinspection.BuildPanel(date);
        }
        $(function () {
            CookieFunc.Checkuser();
            var NowMonth = (new Date()).pattern("yyyy-MM");
            thnumArray = JSONfunc.LoadJSON("jsondata/DSworkshopList.txt");
            DSinspection.BuildPanel(NowMonth);
        });
    </script>
</head>
<body>
    <div class="container-fluid">
        <div class="page-header">
            <h3>粉尘源自检结果</h3>
        </div>
        <div class="panel panel-default">
            <div class="panel-body bg-info">
                <h2 id="TableHeader"></h2>
                <div class="control-group col-lg-5">
                    <!-- Appended input-->
                    <label class="control-label">查询时间选择</label>
                    <div class="controls">
                        <div class="input-append">
                            <div class="input-group date" id="dtpclass1" data-date="" data-link-field="month-select" data-link-format="yyyy-mm">
                                <input class="form-control" id="selector-control" size="16" type="text" value="" />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                <a href="#" type="button" class="input-group-addon btn btn-default" onclick="DSinspection.SwapPanel($('#month-select').val())">查询</a>
                                <a href="#" type="button" class="input-group-addon btn btn-default" onclick="location.reload()">刷新</a>
                                <a href="#" type="button" class="input-group-addon btn btn-default" data-toggle="modal" author="chejian" data-target="#AddModal">添加\修改</a>
                                <!-- Modal -->
                                <div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
                                    <div class="modal-dialog modal-lg" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title" id="myModalLabel1">添加\修改</h4>
                                            </div>
                                            <div class="modal-body">
                                                <%--这里只能用iframe，问题太多.A=assist--%>
                                                <iframe src="DSinspectionA.aspx?act=edit" id="DSinspectionAframe" name="DSinspectionAframe" frameborder="0" height="500px" width="100%"></iframe>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="DSinspection.SwapPanel($('#month-select').val())">关闭窗口</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <input type="hidden" id="month-select" value="" /><br />
                            <p class="help-block">用右边选择日期,也可以直接在框内输入"YYYY-MM"</p>
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
                    <table id="DSinspectionTable" class="table table-hover table-responsive text-center" cellspacing="0" width="100%">
                        <thead>
                        </thead>
                        <tfoot>
                        </tfoot>
                        <tbody>
                        </tbody>
                    </table>
                    <!-- Modal -->
                    <div class="modal fade" id="ShowModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title" id="myModalLabel2">查询</h4>
                                </div>
                                <div class="modal-body">
                                    <%--这里只能用iframe，问题太多.A=assist--%>
                                    <iframe src="DSinspectionA.aspx?act=show" id="DSinspectionAframe1" name="DSinspectionAframe1" frameborder="0" height="500px" width="100%"></iframe>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal" onclick="DSinspection.SwapPanel($('#month-select').val())">关闭窗口</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</body>
</html>
