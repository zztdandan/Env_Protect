<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListStatusYear.aspx.cs" Inherits="module_EPLS_ListStatusYear" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        .innertable table {
            white-space:nowrap;

        }
    </style>
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
    <script src="../../datatables/js/jquery.dataTables.min.js"></script>
    <link href="../../datatables/css/jquery.dataTables.min.css" rel="stylesheet" />
    <script src="../../JavaScript/masonry.pkgd.min.js"></script>
    <link href="../../bootstrap3/css/buttons.css" rel="stylesheet" />
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <link href="../../css/TopLeftHeadStatic.css" rel="stylesheet" />
    <title>年度挂牌情况</title>
    <script type="text/javascript">
        var facList=new Array();
        var facListbyName=new Object();
        ListStatusYear = function () { }
        ListStatusYear.BuildTbody=function(){
            var tbody = $("#ListContent");
            facList = (JSONfunc.LoadJSON("/menu/facList.txt")).CheckInfo;
            for (var i in facList) {
                var facName = facList[i];
                facListbyName[facName] = i;
                var newtr = $("<tr></tr>").addClass("facList facList"+i);
                var facNametd = $("<td style='width:7.68%'></td>").text(facName);
                newtr.append(facNametd);
                for (var j = 0; j < 12; j++) {
                    var newtd = $("<td style='padding:0px;width:7.68%;'></td>").addClass("innertable innertable" + j);
                    newtr.append(newtd);
                }
                tbody.append(newtr);
            }           
        }
        ListStatusYear.FillCell = function (year) {

            function fillincell(obj) {
                
                var objfacOrd =parseInt( facListbyName[ obj.FactoryName]);
                var objtime = parseInt(obj.ListTime.split("-")[1],10) - 1;

                var cellobj = tbody.find(".facList:eq(" + objfacOrd + ")").find(".innertable:eq(" + objtime + ")");
                var cellobj1 = tbody.find(".facList" + objfacOrd).find(".innertable" + objtime);
                var innertable = $('<table class="table table-bordered btna table-condensed " style=" margin: 0px;"><tr><td style="width:75%">项目及合格情况</td><td class="ListVal"style="width:25%"></td></tr></table>');
                innertable.find(".ListVal").attr("rowspan", obj.Factory_List_Status.length + 1);
                if (obj.Factory_List_Result) {
                    innertable.find(".ListVal").addClass("bg-success");
                }
                else {
                    innertable.find(".ListVal").addClass("bg-danger");
                }
                for (var i = 0; i < obj.Factory_List_Status.length;i++)
                {
                    var v = obj.Factory_List_Status[0];
                    
                }
                $(obj.Factory_List_Status).each( function (j) {
                    var ls = this;
                    var reg1 = /Per/;
                    if (reg1.exec(ls.RuleType) != null) {//是百分类型
                        var lsname = ls.Type + "合格率:";
                        var lsval = (ls.CollectionValue == -1) ? "无数据" : (parseInt(ls.CollectionValue * 100) + "%");
                    }
                    else {
                        var lsname = ls.Type + "次数:";
                        var lsval = ls.CollectionValue;
                    }
                    if (ls.ListValue) {
                        var newtd = $("<td></td>").html(lsname + "<strong class='text-success'>" + lsval + "</strong>");
                    }
                    else {
                        var newtd = $("<td></td>").html(lsname + "<strong class='text-danger'>" + lsval + "</strong>");
                    }
                    innertable.append($("<tr></tr>").html(newtd));
                })
                
                cellobj1.append(innertable);
            }
            if (year == "") {
                swapdate=(new Date).pattern("yyyy");
            }
            else {
                var reg2 = /(\d+)年/;
                if (reg2.exec(year) != null) {
                    var swapdate = reg2.exec(year)[1];
                }
                else { alert("时间不符合规范"); return 0; }
            }
            $("#TableTitle").text("炼铁厂" + swapdate + "年环保挂牌公示栏");
            formadd = { "action": "ListStatusCall", "time": swapdate, "fac": "" };

            var _ret = JSONfunc.postJsontoHandler(formadd, "/ajax/CheckInfoHandler.aspx");
            var _retarray = JSONfunc.STRtoJSON(_ret);
            var tbody = $("#ListContent");
            $.each(_retarray, function (name, value) {
                fillincell(value);
            })
            //for (var i in _retarray) {
            //    fillincell(_retarray[i]);
            //}                     
        }
        ListStatusYear.Checkrulesurl = function () {
            var infolist = JSONfunc.LoadJSON("/menu/EInfoA.txt");
            for (var i in infolist) {
                if (infolist[i].name == "挂牌制度") {
                    var infourl = infolist[i].url;
                }
            }
            $("#checkrules").attr("href", infourl);
        }
        ListStatusYear.SwapTime=function(time){
            $("#ListContent").find(".innertable").html("");
            ListStatusYear.FillCell(time);

        }
        $(function () {
            ListStatusYear.BuildTbody();
            ListStatusYear.FillCell($('#ListStatusYear_time').val());
            ListStatusYear.Checkrulesurl();
            //if (tbody.closest("table").hasClass("dataTable")) {//有这个表格
            //    tbody.closest("table").dataTable().fnDestroy();
            //}
            //var tableheight = $(window).height() - $("#topkk").height() - 30;
            //if (document.documentMode>8) {
            //    $("#ListContent").closest("table").dataTable({
            //        "dom": '<t>',
            //        "lengthMenu": [[-1], ["ALL"]],
            //        "scrollX": true,
            //        "scrollY": tableheight
            //    });
            //}
        })

    </script>
</head>
<body>
    <div class="container-fluid">
        <div class="row" id="topkk">
            <div class="col-md-12">                
                    <h2 class="text-center text-success" style="font-family:KaiTi" id="TableTitle">炼铁厂年环保挂牌公示栏</h2>               
            </div>           
             <div class="col-sm-4 pull-right">
                <h1 class="input-group">
                        <label class="input-group-addon" for="ListStatusYear_time">选择年份</label>
                        <input type="text" class="form-control" id="ListStatusYear_time"/>                     
                    <a href="#" class="input-group-addon btn btn-primary" id="checkbtn" onclick="ListStatusYear.SwapTime($('#ListStatusYear_time').val())">查询</a>
                    
                    <a class="input-group-addon btn btn-primary" id="checkrules">查看挂牌标准</a>
                </h1>
                 <script>
                     $('#ListStatusYear_time').datetimepicker({
                         format: 'yyyy年',
                         language: 'zh-CN',
                         minView: 4,
                         weekStart: 1,
                         startDate: '2010-01-01 00:00:00',
                         endDate: '2100-01-01 00:00:00',
                         todayBtn: "linked",
                         autoclose: 1,
                         startView: 4,
                         forceParse: 0,
                     })
                 </script>
            </div>           
        </div>
        <div class="row">             
            <table style="width:2600px" border="1">
                <thead>
                    <tr>
                        <th>车间\时间</th>
                        <th>1月</th>
                        <th>2月</th>
                        <th>3月</th>
                        <th>4月</th>
                        <th>5月</th>
                        <th>6月</th>
                        <th>7月</th>
                        <th>8月</th>
                        <th>9月</th>
                        <th>10月</th>
                        <th>11月</th>
                        <th>12月</th>
                    </tr>
                </thead>
                <tfoot></tfoot>
                <tbody id="ListContent">                    
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
