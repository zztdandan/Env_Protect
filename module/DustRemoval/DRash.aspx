<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DRash.aspx.cs" Inherits="module_DustRemoval_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>除尘器放灰量</title>
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../JavaScript/CookieFunc.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap-datetimepicker.js"></script>
    <script src="../../bootstrap3/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <link href="../../bootstrap3/css/bootstrap-datetimepicker.css" rel="stylesheet" />
    <script src="../../JavaScript/JSONfunction.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <%--<link href="../../css/mycss.css" rel="stylesheet" />--%>
    <script src="../../JavaScript/OnLoad.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <style>
        td.details-control {
            cursor: pointer;
        }

        tr.shown td.details-control {
            background: no-repeat center center;
        }
    </style>
    <script type="text/javascript">
        DRashArray = function (length) {
            this.Date = 0;
            this.Account = 0;
            this.Account_Number = 0;
            this.Content = new Object();
            this.Account_Can = 0;
            this.Account_Can_Number = 0;
            this.Account_Car = 0;
            this.Account_Car_Number = 0;
            this.setAccount = function (date) {

                function convert(jsonobj) {
                    var newjson = new Object();
                    $.each(jsonobj, function (i) {
                        if ((i == "number" || i == "substance") && (typeof jsonobj[i] == "string")) {
                            newjson[i] = parseInt(jsonobj[i]);
                        }
                        else {
                            newjson[i] = jsonobj[i];
                        }
                    });
                    return newjson;
                }
                var kk = this;
                $.each(kk.Content.value, function (i) {
                    var _value = convert(kk.Content.value[i]);
                    if (_value.type == "车") { kk.Account_Car += _value.number; kk.Account_Car_Number += (_value.number / _value.substance); }
                    else { kk.Account_Can += _value.number; kk.Account_Can_Number += (_value.number / _value.substance); };
                });
                this.Date = date;
                this.Account = this.Account_Can + this.Account_Car;
                this.Account_Number = this.Account_Can_Number + this.Account_Car_Number;
                return this.Account;
            }
        };//传入的表格数据的存储类
        $("#dtpclass1").ready(function () {
            $('#dtpclass1').datetimepicker({
                format: 'yyyy-mm',
                language: 'zh-CN',
                minView: 'year',
                weekStart: 1,
                startDate: '2010-1',
                endDate: '2100-1',
                todayBtn: "linked",
                autoclose: 1,
                startView: 'year',
                forceParse: 0,
            });
        });//初始化日期选择器,dtpclass是日期选择器标识
    </script>
    <script type="text/javascript">
        var drashArray;
        $(function () {
            var NowMonth = (new Date()).pattern("yyyy-MM");
            BuildPanel(NowMonth);
            CookieFunc.Checkuser();
        })//初始化函数
        function BuildPanel(nowmonth) {
            function BuildTable(drashArray) {
                function buildth(thArray) {
                    var newtr = $("<tr></tr>");
                    $.each(thArray, function (i) {
                        var newth = $("<th></th>").text(this);
                        newtr.append(newth);
                    });
                    return newtr;
                }
                var thArray = ["日期", "总车数", "总罐数", "车装重量", "罐装重量", "总除尘灰重量", "细节"];
                $('#DRashTable').append($("<thead></thead>").html(buildth(thArray)));
                $('#DRashTable').append($("<tbody></tbody>"));
                $.each(drashArray, function () {
                    var newtr = $("<tr></tr>");
                    newtr.append($("<td></td>").text(this.Date));
                    newtr.append($("<td></td>").text(this.Account_Car_Number));
                    newtr.append($("<td></td>").text(this.Account_Can_Number));
                    newtr.append($("<td></td>").text(this.Account_Car));
                    newtr.append($("<td></td>").text(this.Account_Can));
                    newtr.append($("<td></td>").text(this.Account));
                    var detailcontent =JSONfunc.JSONtoSTR(this.Content);
                    newmodala = $('<a target="newpage" class="btn btn-primary"></a>').text("详细");
                    newmodala.on("click", function () {
                        function buildtb(jsonobj, targetdom) {
                            targetdom.html("");
                            var newthead = $("<tr></tr>").html("<th>序号</th><th>设备名称</th><th>类型</th><th>总重量</th><th>单重</th>")
                            targetdom.append($("<thead></thead>").html(newthead));
                            targetdom.append($("<tbody></tbody>"));
                            var tbody = targetdom.find("tbody");
                            $.each(jsonobj, function () {
                                var newtr = $("<tr></tr>");
                                newtr.append($("<td></td>").text(this.order));
                                newtr.append($("<td></td>").text(this.name));
                                newtr.append($("<td></td>").text(this.type));
                                newtr.append($("<td></td>").text(this.number));
                                newtr.append($("<td></td>").text(this.substance));
                                tbody.append(newtr);
                            });

                        }
                        var date = $(this).closest("tr").find("td:eq(0)").text();
                        var formRead = { "action": "DRashRead", "time": date };
                        var _ret = JSONfunc.postJsontoHandler(formRead, "/ajax/DRashHandler.aspx");
                        var _retarray = (JSONfunc.STRtoJSON((JSONfunc.STRtoJSON(_ret))[0].数据)).value;
                        buildtb(_retarray, $("#DetailModel").find("table"));
                        $("#DetailModel").modal('show');
                    })
                    newtr.append($("<td></td>").html(newmodala));
                    $('#DRashTable').find("tbody").append(newtr)
                });
            }//datatable建立初始化函数
            var reg1 = /(\d+)-(\d+)/;

            $("#TableHeader").html(reg1.exec(nowmonth)[1] + "年" + reg1.exec(nowmonth)[2] + "月放灰量");

            //从数据库读取数据

            var formRead = { "action": "DRashRead", "time": nowmonth };
            var _ret = JSONfunc.postJsontoHandler(formRead, "/ajax/DRashHandler.aspx");

            if (_ret == "[]") { alert("没有数据，请重新选择日期"); return 0; }
            var _retarray = JSONfunc.STRtoJSON(_ret);
            drashArray = new Array(_retarray.length);
            for (i = 0; i < drashArray.length; i++) {
                drashArray[i] = new DRashArray();
                drashArray[i].Content = JSONfunc.STRtoJSON(_retarray[i].数据);
                drashArray[i].setAccount(_retarray[i].日期);
            }
            //-----------------读取结束，存入drashArray---------------

            //$('#DRashTable').html("");
            BuildTable(drashArray);

        }//初始化表格函数，制作新表函数
        function SwapMonDRash(date) {
            if (date == "") {
                date = (new Date()).pattern("yyyy-MM");
            }
            $('#DRashTable').html("");
            BuildPanel(date);
            CookieFunc.Checkuser();
        }
    </script>
</head>
<body>
    <div class="container-fluid">
        <div class="page-header">
            <h3>除尘器放灰量数据</h3>        
        </div>
        <div class="panel panel-default">
            <div class="panel-body bg-info">

                <h2 id="TableHeader"></h2>

                <div class="control-group col-md-6">
                    <!-- Appended input-->
                    <label class="control-label">查询时间选择</label>
                    <div class="controls">
                        <div class="input-append">
                            <div class="input-group date" id="dtpclass1" data-date="" data-link-field="mon-select" data-link-format="yyyy-mm">
                                <input class="form-control" size="16" type="text" value="" />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                                <a href="#" type="button" class="input-group-addon" onclick="SwapMonDRash($('#mon-select').val())">查询</a>
                                <!-- Button trigger modal -->
                                <a  class="input-group-addon btn btna btn-primary" data-toggle="modal" data-target="#myModal" author="huanshuifac">修改/添加放灰量数据</a>
                                <!-- Modal -->
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                    <div class="modal-dialog modal-lg" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                <h4 class="modal-title" id="myModalLabel">修改/添加放灰量数据</h4>
                                            </div>
                                            <div class="modal-body">
                                                <%--这里只能用iframe，问题太多--%>
                                                <iframe src="DRashA.aspx" frameborder="0" width="100%" height="450"></iframe>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="SwapMonDRash($('#mon-select').val())">关闭窗口</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" id="mon-select" value="" /><br />
                        </div>
                        <p class="help-block">请点右边图标选择日期</p>
                    </div>
                </div>

            </div>
            <ul class="list-group">
                <li class=" list-group-item">
                    <table id="DRashTable" class="table table-hover  table-responsive" cellspacing="0" width="100%" align="center">
                    </table>

                </li>
            </ul>
        </div>
    </div>
    <div class="modal fade" id="DetailModel" >
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">细节</h4>
                </div>
                <div class="modal-body">
                   <table class="table table-hover  table-responsive" cellspacing="0" width="100%" align="center">
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
