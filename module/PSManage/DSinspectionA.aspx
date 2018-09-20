<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DSinspectionA.aspx.cs" Inherits="module_PSManage_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
        <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="../../bootstrap3/switch/bootstrapSwitch.js"></script>
    <link href="../../bootstrap3/switch/bootstrapSwitch.css" rel="stylesheet" />
    <script src="../../JavaScript/masonry.pkgd.min.js"></script>
    <script src="../../JavaScript/autocomplete/jquery.autocomplete.min.js"></script>
    <link href="../../JavaScript/autocomplete/jquery.autocomplete.css" rel="stylesheet" />
    <script src="../../datatables/js/jquery.dataTables.min.js"></script>
    <link href="../../datatables/css/jquery.dataTables.min.css" rel="stylesheet" />

    <script src="../../bootstrap3/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../../bootstrap3/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
    <link href="../../bootstrap3/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <script src="../../JavaScript/CookieFunc.js"></script>
    <title>粉尘源填写</title>
    <script>
        var showAct;
        var DSzoneList;
        var contentArray;
        function formatdtp(begindate, enddate) {//通过调节$()的起始截止日期调整选择范围
            $("#DSinspection-date").ready(function () {
                $('#DSinspection-date').datetimepicker({
                    format: 'yyyy-mm-dd',
                    language: 'zh-CN',
                    minView: 2,
                    weekStart: 1,
                    startDate: begindate,
                    endDate: enddate,
                    todayBtn: "linked",
                    autoclose: 1,
                    startView: 2,
                    forceParse: 0,
                }).on('changeDate', function (ev) {
                    var select_date = (ev.date).pattern("yyyy-MM-dd");
                    DSinspectionA.Confirmdata(select_date, $("#DSWorkshop").val(), $("#Password").val());
                });
                ;
            });
        }//初始化时间选择
        function DSinspectionA() { }
        DSinspectionA.Delete = function (DSdate, DSworkshop) {
            if (showAct == "edit") {
                if (DSdate == "" || DSworkshop == "") { CookieFunc.Checkuser(); return 0; }
            } else {
                if (DSdate == "" || DSworkshop == "") { CookieFunc.Checkuser(); return 0; }
            }
            var formRead = { "action": "DSinsDel", "time": DSdate, "workshop": DSworkshop };
            var _ret = JSONfunc.postJsontoHandler(formRead, "/ajax/DSinspectHandler.aspx");
            alert(_ret);
        }
        DSinspectionA.Formatauto_Workshop = function () {
            DSzoneList = JSONfunc.LoadJSON("jsondata/DSworkshopList.txt");
            var DSworkshopList = new Array();
            var j = 0;
            var username = CookieFunc.getCookie("username");
            for (var i in DSzoneList) {
                if (DSzoneList[i].author == username) {
                    DSworkshopList[j] = i;
                    j++;
                }
                else if (username=='jidongke') {
                    DSworkshopList[j] = i;
                    j++;
                }
            };
            $("#DSWorkshop").autocomplete(DSworkshopList, {
                minChars: 0,
                scroll: true
            }).result(function (event, data, formatted) {
                DSinspectionA.Confirmdata($("#DSinspection-date-show").val(), formatted, $("#Password").val());
            });
            $("#DSWorkshop").val(DSworkshopList[0]);
            
        }//初始化自动填表
        DSinspectionA.Confirmdata = function (DSdate, DSworkshop, DSpassword) {
            if (showAct == "edit") {
                if (DSdate == "" || DSworkshop == "") { CookieFunc.Checkuser(); return 0; }
            } else {
                if (DSdate == "" || DSworkshop == "") { CookieFunc.Checkuser(); return 0; }
            }
            var formRead = { "action": "DSinsReadbyDay", "time": DSdate, "workshop": DSworkshop };
            var _ret = JSONfunc.postJsontoHandler(formRead, "/ajax/DSinspectHandler.aspx");
            var returnArray = JSONfunc.STRtoJSON(_ret);
            contentArray = DSinspectionA.Construction(returnArray);
            $("#Answer-to-query").html("该日期粉尘源异常数量为:<strong>" + DSinspectionA.ConfirmTotal($("#DSinsContent")) + "</strong>");
            CookieFunc.Checkuser();
        }//自动填表完成后进行确认数据，然后读取数据库中的数据
        DSinspectionA.Construction = function (objArray) {
            function BuildNewPoint(DSpoint, DSbool, order) {
                var newPoint = $('<div class="input-group"><span class="hidden"></span><span class="input-group-addon labelpoint" style="width:100%"></span><span class="input-group-addon"><input type="checkbox"/></span></div>');
                $(newPoint).find(".hidden").text(order);//给该点添加与数组对应的序号
                if (DSbool == undefined) {//这个数组没有给bool赋值，代表这是个新的数组，没有数据                    
                    $(newPoint).find("input").attr("checked", true);
                    objArray[i].合格 = true;
                }
                else {//已经有赋值，应该读取值
                    $(newPoint).find("input").attr("checked", DSbool);
                }
                $(newPoint).find("input").wrap('<div class="switch switch-small" data-on-label="正常" data-animated="false" data-off-label="异常" data-on="success" data-off="danger" />').parent().bootstrapSwitch();
                newPoint.find(".labelpoint").html("<small>" + DSpoint + "</small>");//粉尘源名字
                //if ((DSbool != undefined) && (DSbool = false)) {
                //    newPoint.find("button").toggleClass("btn-success btn-danger");
                //}//button点击方法，已不用,改用switch控件
                return newPoint;
            }
            var newdivArray = new Object();
            for (var i in objArray) {
                var zone = objArray[i].区域;
                var DSpoint = objArray[i].粉尘源;
                var DSbool = objArray[i].合格;
                if (newdivArray[zone] == undefined) {//这个区域还没建立div
                    newdivArray[zone] = $("<div class='ffall col-md-6' style='width:49%'></div>");
                    newdivArray[zone].append($("<h4></h4>").text(zone));//加一个区域标题
                    var newPoint = BuildNewPoint(DSpoint, DSbool, i)
                    newdivArray[zone].append(newPoint);
                }
                else {//这个区域已有div
                    var newPoint = BuildNewPoint(DSpoint, DSbool, i)
                    newdivArray[zone].append(newPoint);
                }

            }
            $("#DSinsContent").html("");
            for (var i in newdivArray) {
                $("#DSinsContent").append(newdivArray[i]);
            }
            $('#DSinsContent').find(".switch").on('switch-change', function (e, data) {

                var total = $("#Answer-to-query").find("strong");
                var totalnum = 0;
                var Location = parseInt($(data.el).closest("div.input-group").find(".hidden").text());//对应数组位置的值
                contentArray[Location].合格 = !contentArray[Location].合格;
                if (typeof total.text() == "string") {
                    totalnum = parseInt(total.text());
                }
                else {
                    totalnum = total.text();
                }
                if (data.value == false) {
                    totalnum += 1;
                }
                else {
                    totalnum = totalnum - 1;
                }
                total.text(totalnum);
            });//设定switch控件使用后的执行函数
            DSinspectionA.FormatfreeFall();
            return objArray;
        }//将数据展示
        DSinspectionA.FormatfreeFall = function () {
            var elem = document.querySelector('.free-wall');
            var msnry = new Masonry(elem, {
                // options
                itemSelector: '.ffall',
                //percentPosition: true,
                //isFitWidth: true
            });
            //$("#DSinsContent").masonry({
            //    // options
            //    itemSelector: '.ffall',
            //    percentPosition: true,
            //    isOriginLeft: false
            //})
        }//瀑布流效果
        DSinspectionA.ConfirmTotal = function (contentobj) {
            var totalnum = $(contentobj).find(".switch-off").length;
            return totalnum;
        }//总数确认
        DSinspectionA.Contentsub = function (date, workshop, password) {

            if (showAct == "edit") { if (date == "" || workshop == "" || password == "") { alert("有数据没填写"); return 0; } }
            else {
                if (date == "" || workshop == "") {  alert("有数据没填写");return 0; }
            }
            totalNum = DSinspectionA.ConfirmTotal($("#DSinsContent"));
            formSub = { "action": "DSSave", "time": date, "workshop": workshop, "JSONDATA": JSONfunc.JSONtoSTR(contentArray), "total": totalNum };
            var _ret = JSONfunc.postJsontoHandler(formSub, "/ajax/DSinspectHandler.aspx");
            alert(_ret);
            CookieFunc.Checkuser();
        }//修改提交
        DSinspectionA.parentCall = function (date, workshop) {
            $("#DSinspection-date-show").val(date);
            $("#DSinspection-date-select").val(date);
            $("#DSWorkshop").val(workshop);
            DSinspectionA.Confirmdata(date, workshop);
        }//父页面调用函数
        $(function () {
            var Request = new Object();
            Request = GetRequest();
            showAct = Request["act"];
            if (showAct == "edit") {
                var nowdate = new Date();
                var three_days_ago_ms = nowdate - 1000 * 60 * 60 * 24 * 7;
                var fda = new Date();
                fda.setTime(three_days_ago_ms);
                var nowdatestr = (nowdate).pattern("yyyy-MM-dd");
                var fdastr = (fda).pattern("yyyy-MM-dd");
                formatdtp(fdastr, nowdatestr);
                $("#btnChange").removeClass("hidden");
                $("#btnReset").removeClass("hidden");
            }
            else {
                if (showAct == 'show') $("#btnChange").addClass("hidden");
                if (showAct == 'show') $("#btnReset").addClass("hidden");
                formatdtp('2010-01-01', '2100-01-01');
            }
            DSinspectionA.Formatauto_Workshop();
            CookieFunc.Checkuser();
        })


    </script>
</head>
<body>
    <form id="formCMGas" class="form-horizontal">
        <div class="form-group-sm col-sm-6">
            <!-- Appended input-->
            <label class="control-label">日期</label>
            <div class="input-append">
                <div class="input-group date" id="DSinspection-date" data-date="" data-link-field="date-select" data-link-format="yyyy-mm-dd">
                    <input class="form-control " id="DSinspection-date-show" size="16" type="text" value="" />
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>

                </div>
                <input type="hidden" id="DSinspection-date-select" value="" /><br />
            </div>
        </div>
        <div class="form-group-sm col-sm-6">
            <label class="control-label">车间</label>
            <input type="text" class="form-control " id="DSWorkshop" />
            <p class="help-block">可用上下方向键打开选择列表，或直接输入部分字</p>
        </div>
        <hr style="filter: alpha(opacity=100,finishopacity=0,style=2)" width="100%" size="1" />
        <p id="Answer-to-query" class="bg-info lead"></p>
        <div id="DSinsContent" class="free-wall"></div>
        <hr style="filter: alpha(opacity=100,finishopacity=0,style=2)" width="100%" size="1" />
        <div class="btn-group" role="group" aria-label="...">
            <a href="#" type="button" class="btn btn-primary" author="chejian" id="btnChange" onclick='DSinspectionA.Contentsub($("#DSinspection-date-show").val(),$("#DSWorkshop").val(),$("#Password").val())'>添加\修改</a>
            <a href="#" type="reset" class="btn btn-default" author="chejian" id="btnReset" onclick='DSinspectionA.Confirmdata($("#DSinspection-date-show").val(),$("#DSWorkshop").val())'>还原修改</a>
              <a href="#" type="reset" class="btn btn-default" author="jidongke" id="btnDel" onclick='DSinspectionA.Delete($("#DSinspection-date-show").val(),$("#DSWorkshop").val())'>删除</a>
        </div>
    </form>
</body>
</html>
