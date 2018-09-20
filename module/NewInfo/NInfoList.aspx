<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NInfoList.aspx.cs" Inherits="module_NewInfo_NInfoList" %>

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
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <link href="../../bootstrap3/css/buttons.css" rel="stylesheet" />
    <script src="../../JavaScript/CookieFunc.js"></script>
    <title>资讯目录</title>
    <script type="text/javascript">
        var Classify;
        var infoList;
        function NInfoList() { }

        NInfoList.BuildPanel = function (classifyN, divobj) {
            function BuildTable(_retarray, objtable) {
                function Buildth(thobj) {
                    var _newtr = $("<tr></tr>");
                    var tharray = new Array();
                    var j = 0;
                    for (var i in thobj[0]) {
                        var newth = $("<th></th>").html(i);
                        if (i != "标题") { newth.addClass("hidden"); }
                        _newtr.append(newth);                       
                        tharray[j] = i;
                        j = j + 1;
                    }
                    $(objtable).find("thead").append(_newtr);
                    return tharray;
                }
                function Buildtd(jsonobj, thArray) {
                    for (var i in thArray) //i为数字
                        for (var j in jsonobj) //j为项目，即列名
                            if (j == thArray[i]) {
                                var newtd = $("<td></td>").html(jsonobj[j]);
                                if (j != "标题") { newtd.addClass("hidden"); }
                                else if(j=="标题"){
                                    var newA = $("<a></a>").text(jsonobj[j]).attr("href", "/module/NewInfo/NInfo.aspx?classifyN=" + classifyN + "&order=" + jsonobj.Id);
                                    newA.append($("<small class='pull-right'></small>").text(jsonobj.时间));
                                    newtd.html(newA);
                                } 
                                    
                                
                                $(Newtr).append(newtd);
                                break;
                            }
                }
                thArray = new Array();               
                thArray = Buildth(_retarray);
                for (var i in _retarray)//建立表格
                {
                    var Newtr = $("<tr></tr>");
                    Buildtd(_retarray[i], thArray);
                    $(objtable).find("tbody").append(Newtr);
                }             
            }
            var reg1 = /(\d+)-(\d+)/;
            //从数据库读取数据
            var classify = infoList[classifyN].name;
            var formreadother = { "action": "ReadAccessName", "classify": classify, "limit": "-1" };
            var _ret = JSONfunc.postJsontoHandler(formreadother, "/ajax/InfoHandler.aspx");
            if (_ret == "[]") { alert("没有本类型的文章"); return 0; }
            
            var Accessarr = JSONfunc.STRtoJSON(_ret);
            var newTable = $('<table class="table table-hover table-responsive" cellspacing="0" width="100%"></table>').html("<thead></thead><tbody></tbody><tfoot></tfoot>");
            BuildTable(Accessarr, newTable);
            divobj.append(newTable);
            $(divobj).find("table").dataTable(//表格初始化
              {
                  "dom": '<tp>',
                  "lengthMenu": [[20, -1], [20, "ALL"]],
                  "language": {
                      "lengthMenu": "每页 _MENU_ 条记录",
                      "zeroRecords": "没有找到记录",
                      "info": "第 _PAGE_ 页 ( 总共 _PAGES_ 页 )",
                      "infoEmpty": "无记录",
                      "infoFiltered": "(从 _MAX_ 条记录过滤)"
                  }
              });
        }//制作一个表格panel
        NInfoList.Buildbreadcrumb = function (infoMenu,classifyN) {
            var breadcrumb = $(".breadcrumb");
            breadcrumb.append($("<li></li>").text(infoMenu.type));
            breadcrumb.append($("<li></li>").html(infoMenu.name));
        }
        $(function () {
            var Request = new Object();
            Request = GetRequest();
            var ClassifyN = Request["classifyN"];
            infoList = JSONfunc.LoadJSON("/menu/EInfoA.txt");
            Classify = infoList[ClassifyN].name;
            $("#Infoclass").find(".panel-heading").text(Classify);
            NInfoList.Buildbreadcrumb(infoList[ClassifyN],ClassifyN);
            NInfoList.BuildPanel(ClassifyN, $("#Infoclass").find(".panel-body"));
        })
    </script>
</head>
<body>
    <div class="container">
        <div class="row">
              <ol class="breadcrumb" style="font-size: 16px">
            </ol>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-primary" id="Infoclass">
                    <div class="panel-heading"></div>
                    <div class=" panel-body">
                    </div>
                </div>
            </div>

        </div>
    </div>
</body>
</html>
