<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DRMcondition.aspx.cs" Inherits="module_DustRemoval_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>除尘机运行情况</title>

    <script src="../../JavaScript/CookieFunc.js"></script>
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
        <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <link href="../../bootstrap3/css/buttons.css" rel="stylesheet" />
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <script src="../../JavaScript/OnLoad.js"></script>
    <script type="text/javascript">
        function DRM() { }
        var thArray = ["车间", "时间", "运行状态", "电流", "转速", "流量", "压差"];
        DRM.BuildTable = function (jsonarray, target) {
            function getThNumber(targetstr, objarray) {
                var num = 0;
                $(objarray).each(function (i) {
                    if (objarray[i] == targetstr) {
                        num = i;
                        return false;
                    }
                });
                return num;
            }
            $(target).html("");
            $.each(jsonarray, function (i) {
                var newStatus = this;
                var newtr = $("<tr></tr>");
                $(thArray).each(function () {
                    var newtd = $("<td></td>");
                    newtr.append(newtd);
                });
                $.each(newStatus, function (i) {
                    var name=i;
                    var number = getThNumber(name, thArray);
                    var value = newStatus[i];
                   
                  
                    if (name == "运行状态") {
                        if (value == 1) {
                            var isRun = true;
                        }
                        else {
                            var isRun = false;
                        }
                        var StatuBtn = $("<a class='button button-small btna' author='huanshuifac'></a>");
                        StatuBtn.addClass(isRun ? "button-action" : "button-caution");
                        StatuBtn.text(isRun ? "运行" : "停止");
                        StatuBtn.on("click", function (d) {
                            if (CookieFunc.getCookie("username") != "huanshuifac") {
                                alert("您无权修改工作情况");
                                return 0;
                            }
                                $(this).toggleClass("button-caution button-action");
                                if ($(this).text() == "运行") {
                                    $(this).text("停止");
                                }
                                else {
                                    $(this).text("运行");
                                }
                                var thisname = $(this).closest("tr").find("td:eq("+getThNumber("车间",thArray)+")").text();
                                var thistime = $(this).closest("tr").find("td:eq(" + getThNumber("时间", thArray) + ")").text();
                                formchange = { "action": "DRMChange", "name": thisname, "time": thistime };
                                var _ret = JSONfunc.postJsontoHandler(formchange, "/ajax/DRMHandler.aspx");
                                if (_ret!="1") alert (_ret);
                            });
                            $(newtr.find("td:eq(" + number + ")")[0]).append(StatuBtn);
                    } else if (value != null) {
                        newtr.find("td:eq(" + number + ")").text(value);
                    }
                    var kk = 1;
                });
                $(target).append(newtr);
            });
        }
        DRM.BuildNewPage = function () {
            function buildth(jsonobj,target) {
                var newtr = $("<tr></tr>");
                $.each(jsonobj, function (i) {
                    var newth = $("<th></th>").text(this);
                    newtr.append(newth);
                })
                $(target).append(newtr);
            }
            var formRead = { "action": "DRMRead" };
            var _ret = JSONfunc.postJsontoHandler(formRead, "/ajax/DRMHandler.aspx");
            var _retArray = JSONfunc.STRtoJSON(_ret);
            buildth(thArray, $("#DRMContent").find("thead")[0]);
            DRM.BuildTable(_retArray,$("#DRMContent").find("tbody"));

            //for (var i in _retArray) {
                
            //    var newThum = $($("#sample")[0].outerHTML);
            //    newThum.removeClass("hidden");
            //    var newStatus = _retArray[i];
            //    newThum.attr("id", newStatus.位置);
            //    newThum.find(".machine").text(newStatus.位置);
            //    newThum.find("small").text(newStatus.时间);
            //    var StatuBtn = newThum.find(".button-3d");
            //    if (newStatus.状态 == 1) {//运行
            //        StatuBtn.addClass("button-action");
            //        StatuBtn.removeClass("button-caution");
            //        StatuBtn.text("运行");
            //    }
            //    else {
            //        StatuBtn.addClass("button-caution");
            //        StatuBtn.removeClass("button-action");
            //        StatuBtn.text("停止");
            //    }
            //    StatuBtn.on("click", function (d) {
            //        $(this).toggleClass("button-caution button-action");
            //        if ($(this).text() == "运行") {
            //            $(this).text("停止");
            //        }
            //        else {
            //            $(this).text("运行");
            //        }
            //        var thisname = $(this).closest(".panel").parent("div").attr("id");
            //        var thistime = $(this).closest(".panel").find("small").text();
            //        formchange = { "action": "DRMChange", "name": thisname, "time": thistime };
            //        var _ret = JSONfunc.postJsontoHandler(formchange, "/ajax/DRMHandler.aspx");
            //    });
            //    var user = CookieFunc.getCookie("username");
            //    if (user != "huanshuifac") {
            //        StatuBtn.off("click");
            //    }
               
            //    var ThumCol = newThum.find(".col-xs-12");
            //    ThumColid = ("collapse" + newStatus.位置).toLocaleString();
            //    ThumCol.find("a").attr("data-target", "#collapse" + newStatus.位置);
            //    ThumCol.find("a").attr("aria-controls", "collapse" + newStatus.位置);
            //    ThumCol.find(".collapse").attr("id", "collapse" + newStatus.位置);
            //    ThumCol.find("p")[0].innerHTML = "<strong>电流：</strong>" + newStatus.电流;
            //    ThumCol.find("p")[1].innerHTML = "<strong>转速：</strong>" + newStatus.转速;
            //    ThumCol.find("p")[2].innerHTML = "<strong>流量：</strong>" + newStatus.流量;
            //    ThumCol.find("p")[3].innerHTML = "<strong>压差：</strong>" + newStatus.压差;
            //    $("#DRMContent").prepend(newThum);
            //}
        }
        $(function () {
            DRM.BuildNewPage(); //建立20个元素 

            setInterval(function () {
                var formRead = { "action": "DRMRead" };
                var _ret = JSONfunc.postJsontoHandler(formRead, "/ajax/DRMHandler.aspx");
                var _retArray = JSONfunc.STRtoJSON(_ret);
                DRM.BuildTable(_retArray, $("#DRMContent").find("tbody"));
            }, 10000);
        })
        
    </script>
    <script type="text/javascript">
      
    </script>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="page-header">
                <h3>除尘机运行情况</h3>
            </div>
        </div>

        <div class="col-md-12" id="DRMContent" style="background:#ffffff">
            <table class="table table-hover table-responsive text-center">
                <thead></thead>
                <tbody></tbody>
                
            </table>
        </div>
    </div>
</body>
</html>
