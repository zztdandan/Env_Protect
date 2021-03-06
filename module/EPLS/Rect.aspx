﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Rect.aspx.cs" Inherits="module_EPLS_Rect" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../JavaScript/CookieFunc.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap-datetimepicker.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="../../bootstrap3/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="../../ueditor/ueditor.config.js"></script>
    <script src="../../ueditor/ueditor.all.js"></script>
    <script src="../../JavaScript/autocomplete/jquery.autocomplete.min.js"></script>
    <link href="../../JavaScript/autocomplete/jquery.autocomplete.css" rel="stylesheet" />
    <script src="../../JavaScript/jQuery.autoIMG.min.js"></script>
    <script src="../../datatables/js/jquery.dataTables.min.js"></script>
    <link href="../../datatables/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="../../bootstrap3/css/buttons.css" rel="stylesheet" />
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <title>整改情况</title>
    <script type="text/javascript">
        var ue1;
        function REctify() { }
        REctify.SwapTime = function (start_date, end_date, fac) {//参数是"YYYY年MM月"格式
            debugger;
            if (start_date == "" || end_date == "") {
                alert("时间为空");
                return 0;
            }
            formadd = { "action": "REctifyCall", "starttime": start_date, "endtime": end_date ,"fac":fac};
            var _ret = JSONfunc.postJsontoHandler(formadd, "/ajax/CheckInfoHandler.aspx");
            var _retarray = JSONfunc.STRtoJSON(_ret);
            $("#REctifyContent").html("");
            REctify.BuildContent(_retarray, $("#REctifyContent"));
            CookieFunc.Checkuser();
        }
        REctify.fmt = function () {
            $("#start-date").ready(function () {
                $('#start-date').datetimepicker({
                    format: 'yyyy-mm-dd',
                    language: 'zh-CN',
                    minView: 2,
                    weekStart: 1,
                    startDate: '2010-01-01 00:00:00',
                    endDate: '2100-01-01 00:00:00',
                    todayBtn: "linked",
                    autoclose: 1,
                    startView: 2,
                    forceParse: 0
                });
            });//初始化日期选择器,
            $("#end-date").ready(function () {
                $('#end-date').datetimepicker({
                    format: 'yyyy-mm-dd',
                    language: 'zh-CN',
                    minView: 2,
                    weekStart: 1,
                    startDate: '2010-01-01 00:00:00',
                    endDate: '2100-01-01 00:00:00',
                    todayBtn: "linked",
                    autoclose: 1,
                    startView: 2,
                    forceParse: 0
                });
            });//初始化日期选择器,
            $("#Add_date").ready(function () {
                $('#Add_date').datetimepicker({
                    format: 'yyyy-mm-dd hh:ii',
                    language: 'zh-CN',
                    minView: 0,
                    weekStart: 1,
                    startDate: '2010-01-01 00:00:00',
                    endDate: '2100-01-01 00:00:00',
                    todayBtn: "linked",
                    autoclose: 1,
                    startView: 2,
                    forceParse: 0
                });
            });//初始化日期选择器,
            var facList = (JSONfunc.LoadJSON("/menu/facList.txt")).CheckInfo;
            $("#Add_fac").autocomplete(facList, {
                minChars: 0,
                scroll: true
            });
            $("#interfac").autocomplete(facList, {
                minChars: 0,
                scroll: true
            });
        }
        REctify.AddInfo = function (inputgroup) {
            for (i = 0; i < inputgroup.length; i++) {
                if (inputgroup[i].value == "") {
                    alert("有项目为空");
                    return 0;
                }
            }
            var detailstr = ue1.getContent();
            formadd = { "action": "SaveInfo", "time": inputgroup[0].value, "type": "整改情况", "pass": inputgroup[2].value, "fac": inputgroup[1].value, "detail": detailstr };
            var _ret = JSONfunc.postJsontoHandler(formadd, "/ajax/CheckInfoHandler.aspx");
            alert(_ret);
        }
        REctify.BuildContent = function (arrayobj, divobj) {
            function BuildPanel(jsonobj) {
                var divobj = $('<div class="col-md-6 ffall"><div class="panel panel-primary"><div class="panel-heading"><h4></h4></div><ul class="list-group"></ul><div class="panel-footer text-center"></div></div></div>');
                divobj.find("h4").text(jsonobj.Name);
                $.each(jsonobj.InfoList, function () {
                    var scedetail = this;
                    var newli = $('<li class="list-group-item"><label></label></li>');
                    if (scedetail.Pass) {
                        var passStr = "<strong class='text-success' role='test'>合格</strong>";
                    }
                    else {
                        var passStr = "<strong class='text-danger'>不合格</strong>";
                    }
                    $(newli).find("label").html("时间：" + scedetail.Time + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;是否合格：" + passStr + "&nbsp;&nbsp;&nbsp;");
                    var delbtn = $("<a class='btna pull-right  button button-small button-pill' author='jidongke'>删除<b class='hidden'>" + scedetail.Id + "</b></a>");
                    delbtn.on("click", function () {
                        var id = $(this).find("b").text();
                        var formkk = { "action": "DelCheckInfo", "id": id };
                        var ret = JSONfunc.postJsontoHandler(formkk, "/ajax/CheckInfoHandler.aspx");
                        if (ret == "1") {
                            $(this).closest("li").remove();
                        }
                        else { alert(ret) }
                    });
                    var detailbtn = $("<a class='btna pull-right button button-small button-primary button-pill'>细节<b class='hidden'></b></a>");
                    detailbtn.find("b").text(scedetail.Detail);
                    detailbtn.on("click", function () {
                        var detailhtml = $(this).find("b").text();
                        $("#DetailModel").find(".modal-body").html(detailhtml);
                        $("#DetailModel").modal('show');
                    });                   
                    $(newli).append(delbtn);
                    $(newli).append(detailbtn);
                    $(divobj).find("ul").append(newli);
                })
                divobj.find(".panel-footer").text("合格点:" + jsonobj.PassNum + " 不合格点:" + (jsonobj.TotalNum - jsonobj.PassNum) + "合格率:" + parseInt((jsonobj.PassNum / jsonobj.TotalNum) * 100) + "%");
                return divobj;
            }
            $.each(arrayobj, function () {
                var newdiv = BuildPanel(this);
                $("#REctifyContent").append(newdiv);
            })

            CookieFunc.Checkuser();
            if (window.top != window.self) {//存在父页面
                window.parent.ChildrenCallback();
            }
        }
        $(function () {           
            var monthenddate = monthend((new Date).getFullYear(), (new Date).getMonth());
            var starttime = (new Date).pattern("yyyy-MM") + "-01";
            var endtime = (new Date).pattern("yyyy-MM") + "-" + monthenddate;

            REctify.fmt();
            formadd = { "action": "REctifyCall", "starttime": starttime, "endtime": endtime,"fac":""};
            var _ret = JSONfunc.postJsontoHandler(formadd, "/ajax/CheckInfoHandler.aspx");
            var _retarray = JSONfunc.STRtoJSON(_ret);
            REctify.BuildContent(_retarray, $("#REctifyContent"));
            CookieFunc.Checkuser();
        })
        $("#container").ready(function () {
            var ue = UE.getEditor('container');
            ue1 = ue;
        })

    </script>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <h2>整改情况
                </h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-7">
                <div class="input-group">
                    <span class="input-group-addon">选择起止日期：</span>
                    <input class="form-control" id="start-date" />
                    <span class="input-group-addon">到</span>
                    <input class="form-control" id="end-date" />
                      <span class="input-group-addon">车间</span>
                    <input class="form-control" id="interfac" />
                    <span class="input-group-btn">
                        <a class="btna btn btn-default" onclick="REctify.SwapTime($('#start-date').val(),$('#end-date').val(),$('#interfac').val())">查询</a>
                    </span>
                </div>
            </div>
            <div class="col-md-5">
                <a href="#" author="jidongke" class="button button-raised button-primary button-pill button-block" data-toggle="collapse" data-target="#Addcollapse" aria-expanded="false" aria-controls="Addcollapse">录入整改情况</a>
            </div>
            <div class="col-xs-12">
                <div class="collapse" id="Addcollapse">
                    <div class="well">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group-sm ">
                                    <label class="control-label">日期</label>
                                    <input class="form-control" id="Add_date" size="16" type="text" value="" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group-sm ">
                                    <label class="control-label">车间</label>
                                    <input type="text" class="form-control" id="Add_fac" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group-sm ">
                                    <label class="control-label">是否合格</label>
                                    <select class="form-control">
                                        <option value="1">是</option>
                                        <option value="0">否</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group-sm ">
                                <label class="control-label">详情</label>
                                <script id="container" name="content" type="text/plain">
                                </script>
                            </div>
                        </div>
                        <hr width="100%" size="2" />
                        <div class="row text-center">
                            <button type="button" class="button button-raised button-primary" onclick='REctify.AddInfo($("#Addcollapse").find(".form-control"))'>录入整改情况</button>
                            <button type="button" class="button button-raised" onclick='$("#Addcollapse").collapse("hide");'>退出录入</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <hr style="filter: alpha(opacity=100,finishopacity=0,style=2)" width="100%" color="#23512b" size="1" />
        <div class="row">
            <div class="col-sm-12" id="REctifyContent"></div>
            <div class="modal fade" id="DetailModel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">细节</h4>
                        </div>
                        <div class="modal-body">
                           
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
