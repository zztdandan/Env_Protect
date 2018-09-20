<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListStatus.aspx.cs" Inherits="module_EPLS_ListStatus1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <script src="../../JavaScript/CookieFunc.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap-datetimepicker.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="../../bootstrap3/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="../../JavaScript/autocomplete/jquery.autocomplete.min.js"></script>
    <link href="../../JavaScript/autocomplete/jquery.autocomplete.css" rel="stylesheet" />
    <link href="../../bootstrap3/css/buttons.css" rel="stylesheet" />
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <title>月度挂牌情况1</title>
    <style type="text/css">
        .lstable thead th {
            background: #006699;
            color: #ffffff;
        }
    </style>
    <script type="text/javascript">
        function ListStatus() { }
        ListStatus.CreateStatus = function (date_select) {
            if (date_select == "全年") {
                var swapdate = (new Date).pattern("yyyy");
            }
            else if (date_select == "") {
                var swapdate = (new Date).pattern("yyyy-MM");
            }
            else {
                var reg1 = /(\d+)年(\d+)月/;
                var swapdate = reg1.exec(date_select)[1] + "-" + reg1.exec(date_select)[2];
            }
            formadd = { "action": "CreateListStatus", "time": swapdate };

            $.ajax({
                type: "post", //要用post方式                 
                url: "/ajax/CheckInfoHandler.aspx" + "?r=" + Math.ceil(Math.random() * 10000),//插入一个随机数
                //contentType: "application/json; charset=utf-8",
                //dataType: "json",
                data: formadd,//要做什么，存入数据库的标识名，存入文件的文件地址，要存入的内容
                async: true,
                success: function (d) {
                    $("#Rebuildbtn").removeClass("disabled");
                    var _ret = d;
                    $("#ListStatusContent").html("");
                    alert("本月挂牌情况生成完成，现在将显示重新生成的挂牌情况");
                    var _retarray = JSONfunc.STRtoJSON(_ret);
                    ListStatus.BuildContent(_retarray, $("#ListStatusContent"));
                },
                error: function (err) {
                    ret = err.responseText;
                }
            });
        }
        ListStatus.SwapTime = function (date_select, fac_select) {//参数是"YYYY年MM月"格式
            if (date_select == "") {
                var nowdate = (new Date).pattern("yyyy-MM");
                var nowdate = (new Date).pattern("yyyy年MM月");
                var reg1 = /(\d+)年(\d+)月/;
                var swapdate = reg1.exec(nowdate)[1] + "-" + reg1.exec(nowdate)[2];
            }
            else {
                var reg1 = /(\d+)年(\d+)月/;
                if (reg1.exec(date_select) != null) {
                    var swapdate = reg1.exec(date_select)[1] + "-" + reg1.exec(date_select)[2];
                }
                else {
                    var reg2 = /(\d+)年/;
                    if (reg2.exec(date_select) != null) {
                        var swapdate = reg1.exec(date_select)[1];
                    }
                    else { alert("时间不符合规范"); return 0; }
                }
            }
            if (fac_select == "全部" || fac_select == "") {
                var swapfac = ""
            }
            else {
                var swapfac = fac_select;
            }
            formadd = { "action": "ListStatusCall", "time": swapdate, "fac": swapfac };

            var _ret = JSONfunc.postJsontoHandler(formadd, "/ajax/CheckInfoHandler.aspx");
            var _retarray = JSONfunc.STRtoJSON(_ret);
            $("#ListStatusContent").html("");
            ListStatus.BuildContent(_retarray, $("#ListStatusContent"));
        }
        ListStatus.fmt = function () {
            var less = (new Date).pattern("yyyy") + "-01";
            $('#ListStatus_time').datetimepicker({
                format: 'yyyy年mm月',
                language: 'zh-CN',
                minView: 3,
                weekStart: 1,
                startDate: less,
                endDate: '2100-01-01 00:00:00',
                todayBtn: "linked",
                autoclose: 1,
                startView: 3,
                forceParse: 0,
            })
            //.on('changeDate', function (ev) {
            //        var datefmt = (ev.date).pattern("yyyy年MM月");
            //        $("#ListStatus_time").text(datefmt);
            //});
            var facList = (JSONfunc.LoadJSON("/menu/facList.txt")).CheckInfo;
            $("#ListStatus_fac").autocomplete(facList, {
                minChars: 0,
                scroll: true
            });
            $("#Rebuildbtn").popover({
                trigger: "hover",
                placement: "bottom",
                content: "当你使用手动挂牌时，该项目的挂牌将不再受挂牌规则影响，如果想恢复自动挂牌，请选择重新生成本月挂牌情况，此时所有项目（包括手动挂牌的项目）将重新自动挂牌。在手动挂牌后，车间挂牌的结果无法及时更新时，请刷新整个页面（不要点重新生成挂牌，否则手动挂牌被取消）"
            })
            $("#checkbtn").popover({
                trigger: "hover",
                placement: "bottom",
                content: "时间,车间可手动输入YYYY年/全部来查询年度/全部车间的情况"
            });
        }
        ListStatus.ManualSwitch = function (RuleId, date) {
            var formman = { "action": "ManualList", "time": date, "ruleid": RuleId };
            var _ret = JSONfunc.postJsontoHandler(formman, "/ajax/CheckInfoHandler.aspx");

        }
        ListStatus.BuildContent = function (arrayobj, divobj) {
            function buildtable(dataobj) {
                var newtable = $('<table class="table table-bordered lstable table-condensed "style=" margin: 0px;"><thead><tr><th colspan="2"></th></tr><tr><th width="80%">细节</th><th width="20%">月度挂牌</th></tr></thead><tbody><tr><td style="margin:0px;width:80%;"></td><td style="margin:0px;width:20%;" class="ListCard"></td></tr></tbody></table>');
                newtable.find("thead").find('th:eq(0)').html("<h4>" + dataobj.FactoryName + "|" + dataobj.ListTime + "</h4>");
                var detail_table = $('<table class="table table-responsive" style="padding:0px;width:100%;"></table>');
                //--添加月挂牌细节
                $.each(dataobj.Factory_List_Status,function(i){
                    var newtr = $("<tr></tr>");
                    var lstatus = dataobj.Factory_List_Status[i];
                    newtr.append($("<td></td>").html(lstatus.Type));
                    switch (lstatus.RuleType) {
                        case "PerGreater":
                            if (lstatus.Type == "整改情况") {
                                var benchStr = "整改项目按照预期进度完成的百分比达到" + lstatus._Threshold * 100 + "%";
                            } else {
                                var benchStr = "检查为合格的百分比达到" + lstatus._Threshold * 100 + "%";
                            }
                            var CvalStr = lstatus.CollectionValue * 100 + "%";
                            break;
                        case "PerLess":
                            var benchStr = "检查为合格的百分比不到" + lstatus._Threshold * 100 + "%";
                            var CvalStr = lstatus.CollectionValue * 100 + "%"; 7
                            break;
                        case "TotalNumGreater":
                            var benchStr = "检查的次数达到" + lstatus._Threshold;
                            var CvalStr = lstatus.CollectionValue;
                            break;
                        case "TotalNumLess":
                            var benchStr = "录入的次数不大于" + lstatus._Threshold;
                            var CvalStr = lstatus.CollectionValue;
                            break;
                        default:
                            var benchStr = "";
                            var CvalStr = "";
                            break;
                    }
                    newtr.append($("<td></td>").html(benchStr));
                    if (lstatus.CollectionValue != -1) {
                        newtr.append($("<td></td>").html(CvalStr));
                        if (lstatus.ListValue) {
                            newtr.append($("<td></td>").html(SgreenCard));
                        }
                        else {
                            newtr.append($("<td></td>").html(SredCard));
                        }

                        var switchbtn = $("<a class='btna' author='jidongke'>点此手动切换挂牌<small class='hidden'>" + lstatus.RuleId + "</small></a>");
                        switchbtn.on("click", function () {
                            var card = $(this).closest("tr").find("span");
                            var ruleid = $(this).find("small").text();                           
                            var date = $(this).closest(".lstable").find("thead").find('th:eq(0)').text().split("|")[1]
                            ListStatus.ManualSwitch(ruleid, date);
                            ListStatus.SwapTime($('#ListStatus_time').val(), $('#ListStatus_fac').val());
                        })
                    } else {
                        newtr.append($("<td></td>").html("无数据"));
                        newtr.append($("<td></td>").html(""));
                        var switchbtn = $("<a author='jidongke'>没有检查该项</a>");
                    }
                    newtr.append($("<td></td>").html(switchbtn));
                    detail_table.append(newtr);
                });
                newtable.find("tbody").find('td:eq(0)').append(detail_table);
                //将细节添加到表
                if (dataobj.Factory_List_Result) {//如果月挂牌为正则显示正否则显示负
                    newtable.find("tbody").find('.ListCard').addClass("bg-success");
                }
                else {
                    newtable.find("tbody").find('.ListCard').addClass("bg-danger");
                }
                return newtable;
            }
            var greenCard = '<span class="label label-success pull-right" style="font-size:30px">绿牌</span>';
            var redCard = '<span class="label label-danger pull-right" style="font-size:30px">红牌</span>';
            var SgreenCard = '<span class=" text-success Sgreencard" style="font-size:15px">合格</span>';
            var SredCard = '<span class=" text-danger Sredcard" style="font-size:15px">不合格</span>';
            var datatable = $(' <table class="table table-responsive" border="0"></table>');
            var amount = 0;
            $("#ListStatusContent").html("");
            $.each(arrayobj, function (Fac) {
                var lstable = buildtable(arrayobj[Fac]);
                if (amount % 2 == 0) {//需要多加一行
                    newtr = $("<tr class='realtr'></tr>").html("<td></td>");
                    newtr.find("td").append(lstable);
                    datatable.append(newtr);
                } else {
                    newtd = $("<td></td>");
                    newtd.append(lstable);
                    datatable.find(".realtr:last").append(newtd);
                }
                amount += 1;
            })
            $("#ListStatusContent").append(datatable);
        }
        $(function () {
            $('[data-toggle="popover"]').popover();
            var nowdate = (new Date).pattern("yyyy-MM");
            $("#ListStatus_time").val((new Date).pattern("yyyy年MM月"));
            ListStatus.fmt();
            ListStatus.SwapTime($('#ListStatus_time').val(), $('#ListStatus_fac').val());
        })
    </script>
</head>
<body>
    <div class=" container-fluid">
        <div class="row">
            <h2>月度挂牌情况</h2>
        </div>
        <div class="row">
            <div class="col-md-6">
                <table class="table table-responsive" style="white-space: nowrap;">
                    <tr>
                        <td>
                            <label for="ListStatus_time">时间</label>
                        </td>
                        <td>
                            <input type="text" class="form-control" id="ListStatus_time" />
                        </td>
                        <td>
                            <label for="ListStatus_fac">车间</label>
                        </td>
                        <td>
                            <input type="text" class="form-control" id="ListStatus_fac" />
                        </td>
                        <td>
                            <a href="#" class="btn btn-primary" id="checkbtn" onclick="ListStatus.SwapTime($('#ListStatus_time').val(),$('#ListStatus_fac').val())">查询</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6">
                <a class="button button-raised button-primary button-pill button-block" author="jidongke" id="Rebuildbtn" onclick="ListStatus.CreateStatus($('#ListStatus_time').val());">生成\重新生成本月挂牌情况</a>
            </div>
        </div>
        <div class="row">
            <div id="ListStatusContent" class="col-md-12">
            </div>
        </div>
    </div>
</body>
</html>
