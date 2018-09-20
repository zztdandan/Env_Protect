<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CMresultGas.aspx.cs" Inherits="module_PSManage_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
        <script src="/bootstrap3/js/respond.min.js"></script>
        <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="../../datatables/js/jquery.dataTables.min.js"></script>
    <link href="../../datatables/css/jquery.dataTables.min.css" rel="stylesheet" />
        <script src="../../bootstrap3/js/bootstrap-datetimepicker.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="../../bootstrap3/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="../../JavaScript/laydate/laydate.js"></script>
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <script src="../../JavaScript/CookieFunc.js"></script>
    <title>公司监测结果（气）</title>
    <script type="text/javascript">
        var cmGasArray;
        function CMresultGas() { }
       
        CMresultGas.BuildPanel = function (nowyear) {
            function BuildTable(cmGasArray) {
                function Buildth(thobj) {
                    var _newtr = $("<tr></tr>");
                    _newtr.append($("<th></th>").html("监测点"));
                    _newtr.append($("<th></th>").html("日期"));
                    for (var i in thobj) {
                        _newtr.append($("<th></th>").html(thobj[i].name));
                    }
                    _newtr.append($("<th></th>").html("修改"));
                    $(CMGasTable).find("thead").append(_newtr);
                }
                function Buildtd(jsonobj, thArray) {
                    function buildcontent(jsonobj, exampleobj) {
                        var _ret = "";

                        for (var i in jsonobj)
                            for (var j in exampleobj) {
                                if (jsonobj[i].name == exampleobj[j].name) {
                                    exampleobj[j].number = jsonobj[i].number;
                                }
                            }
                        for (var i in exampleobj) {
                            var t = exampleobj[i].number;
                            _ret += "<td>" + t + "</td>";
                        }
                        return _ret;
                    }
                    Newtr.append($("<td></td>").html(jsonobj.Name));
                    Newtr.append($("<td></td>").html(jsonobj.Date));
                    //Newtr.append($("<td></td>").html(jsonobj.Type));

                    Newtr.append(buildcontent(jsonobj.Content, thArray));
             
                    Newtr.append($("<td></td>").html(""));
                }

                var CMGasTable = $("#CMGasTable");
                thArray = JSONfunc.LoadJSON("jsondata/CMGas.txt");
                Buildth(thArray);
                for (var i in cmGasArray)//建立表格
                {
                    var Newtr = $("<tr></tr>");
                    Buildtd(cmGasArray[i], thArray);
                    $(CMGasTable).find("tbody").append(Newtr);
                }
                $('#CMGasTable').dataTable(//表格初始化
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
                        "defaultContent": '<a href="#"class="btn editorbtn btn-primary btn-sm" author="jidongke" data-toggle="modal" data-target="#AddModal">修改</a>'
                    }]
                });
                $('#CMGasTable tbody').on('click', 'a.editorbtn', function () {     
                    var tr = $(this).closest('tr');
                    var table = $('#CMGasTable').dataTable().api();
                    var rowdata = table.row(tr).data();
                    CMresAframe.window.CMresultA.parentCall(rowdata[1],rowdata[0]);                  
                });
            }//datatable建立初始化函数
            var reg1 = /(\d+)年/;
            $("#TableHeader").html("公司检测结果（" + reg1.exec(nowyear)[1] + "年）");
            nowyear = reg1.exec(nowyear)[1];
            //从数据库读取数据
            var formRead = { "action": "CMRead", "time": nowyear, "type": "Gas" };
            var _ret = JSONfunc.postJsontoHandler(formRead, "/ajax/CMHandler.aspx");
            if (_ret == "[]") { CookieFunc.Checkuser(); alert("没有数据，请重新选择日期"); return 0; }
            var _retarray = JSONfunc.STRtoJSON(_ret);
            cmGasArray = new Array(_retarray.length);
            for (i = 0; i < cmGasArray.length; i++) {
                cmGasArray[i] = new Object();
                cmGasArray[i].Date = _retarray[i].日期;
                cmGasArray[i].Type = _retarray[i].类型;
                cmGasArray[i].Name = _retarray[i].监测点;
                cmGasArray[i].Content = JSONfunc.STRtoJSON(_retarray[i].数据);
            }
            //-----------------读取结束，存入cmGasArray---------------
            BuildTable(cmGasArray);
            CookieFunc.Checkuser();
        }//初始化表格函数，制作新表函数
        CMresultGas.SwapCMGas = function (date) {
            if (date == "") {
                date = (new Date()).pattern("yyyy年");
            }
            if ($('#CMGasTable td').length != 0)//判断是否有datatable,如果没有，则做这个函数会出错
            {
                $('#CMGasTable').dataTable().fnDestroy();
            }
            $('#CMGasTable').html("<thead></thead><tbody></tbody><tfoot></tfoot>");
            CMresultGas.BuildPanel(date);
        }

        $(function () {
            var NowYear = (new Date()).pattern("yyyy年");
            CMresultGas.BuildPanel(NowYear);

        });
    </script>
</head>
<body>
    <div class="container-fluid">
        <div class="page-header">
            <h3>公司检测结果（气）</h3>
        </div>
        <div class="panel panel-default">
            <div class="panel-body bg-info">
                <h2 id="TableHeader"></h2>
                <div class="control-group col-lg-5">
                    <!-- Appended input-->
                    <label class="control-label">查询时间选择</label>
                    <div class="controls">
                        <div class="input-append">
                            <div class="input-group date" id="dtpclass1" data-date="" data-link-field="year-select" data-link-format="yyyy年">
                                <input class="form-control" id="form-control" size="16" type="text" value="" />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                <a href="#" type="button" class="input-group-addon btn btn-default" onclick="CMresultGas.SwapCMGas($('#year-select').val())">查询</a>
                            </div>
                            <input type="hidden" id="year-select" value="" /><br />
                            <p class="help-block">用右边选择日期,也可以直接在框内输入"XXXX年"</p>
                            <script>
                                $("#dtpclass1").ready(function () {
                                    $('#dtpclass1').datetimepicker({
                                        format: 'yyyy年',
                                        language: 'zh-CN',
                                        minView: 4,
                                        weekStart: 1,
                                        startDate: '2010',
                                        endDate: '2100',
                                        todayBtn: "linked",
                                        autoclose: 1,
                                        startView: 4,
                                        forceParse: 0,
                                    });
                                });//初始化日期选择器,dtpclass是日期选择器标识
                                document.getElementById("form-control").onchange = function () {
                                    reg1 = /(\d+)年/;
                                    if ($(this).val() == "") {
                                        $("#dtpclass1").nextAll(".help-block").html("用右边选择日期,也可以直接在框内输入\"XXXX年\"");
                                    }
                                    else {
                                        if (reg1.test($(this).val())) {
                                            $("#year-select").val($(this).val());
                                            $("#dtpclass1").nextAll(".help-block").html("日期格式正确，点右边查询按钮可查询");
                                            $("#dtpclass1 a").removeClass("disabled");
                                        }
                                        else {
                                            $("#dtpclass1").nextAll(".help-block").html("你输入的日期格式不正确，请输入\"XXXX年\"格式");
                                            $("#dtpclass1 a").addClass("disabled");
                                        }
                                    }
                                }
                            </script>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
            <ul class="list-group">
                <li class=" list-group-item">
                    <table id="CMGasTable" class="table table-hover table-responsive text-center" cellspacing="0" width="100%">
                        <thead>
                        </thead>
                        <tfoot>
                        </tfoot>
                        <tbody>
                        </tbody>
                    </table>
                </li>
                <li class=" list-group-item">

                    <div class="btn-group" role="group" aria-label="...">
                        <a href="#" type="button" class="btn btn-primary" data-toggle="modal" author="jidongke" data-target="#AddModal">添加\修改</a>
                        <!-- Modal -->
                        <div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel1">添加\修改</h4>
                                    </div>
                                    <div class="modal-body">
                                        <%--这里只能用iframe，问题太多--%>
                                        <iframe src="CMresultA.aspx" id="CMresAframe" name="CMresAframe" frameborder="0" width="100%" height="600px"></iframe>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="CMresultGas.SwapCMGas($('#year-select').val())">关闭窗口</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a href="#" type="button" class="btn btn-info" data-toggle="modal" data-target="#ListModal">设备表</a>
                        <!-- Modal -->
                        <div class="modal fade" id="ListModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                            <div class="modal-dialog modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">设备表</h4>
                                    </div>
                                    <div class="modal-body">
                                        <%--这里只能用iframe，问题太多--%>
                                        <iframe src="CMGaslist.aspx" frameborder="0" width="100%" height="600px"></iframe>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal" onclick="CMresultGas.SwapCMGas($('#year-select').val())">关闭窗口</button>
                                    </div>
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
