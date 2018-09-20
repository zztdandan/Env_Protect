<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NInfo.aspx.cs" Inherits="module_NewInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../bootstrap3/js/bootstrap.min.js"></script>
    <link href="../../bootstrap3/css/bootstrap.min.css" rel="stylesheet" />
        <script src="/bootstrap3/js/html5shiv.min.js"></script>
    <script src="/bootstrap3/js/respond.min.js"></script>
    <script src="../../JavaScript/JSONfunction.js"></script>
    <script src="../../JavaScript/OnLoad.js"></script>
    <script src="../../JavaScript/Support1.js"></script>
    <link href="../../css/mycss.css" rel="stylesheet" />
    <link href="../../bootstrap3/css/buttons.css" rel="stylesheet" />
    <script src="../../JavaScript/CookieFunc.js"></script>
    <title>资讯页面</title>
</head>
<script>
    var Classify;
    var Order;
    var infoList;
    function NInfo() { }
    NInfo.Buildbreadcrumb = function (infoMenu,infoName,classifyN) {
        var breadcrumb = $(".breadcrumb");
        Listurl = "/module/NewInfo/NInfoList.aspx?classifyN=" + classifyN;
        var a1 = $("<a></a>").text(infoMenu.name).attr("href", Listurl);
        breadcrumb.append($("<li></li>").text(infoMenu.type));
        breadcrumb.append($("<li></li>").html(a1));
        breadcrumb.append($("<li class='active'></li>").text(infoName));
    }
    NInfo.BuildPanel=function(classify,order){
        if ((order == -1) || (order == undefined)) {//读最新一个内容            
            var formreadother = { "action": "ReadAccess", "order":-1, "classify": classify };
        }
        else {//读order序号的文章
            var formreadother = { "action": "ReadAccess", "order": order, "classify": classify };           
        }
        var _ret = JSONfunc.postJsontoHandler(formreadother, "/ajax/InfoHandler.aspx");
        if (_ret == "[]") { CookieFunc.Checkuser(); alert("没有本类型的资讯"); return 0; }
        var AccessContent = (JSONfunc.STRtoJSON(_ret))[0];
        var con = $("#InfoContent");
        con.find(".panel-heading").html("最近文章:"+AccessContent.标题 + "<p class='pull-right'>"+AccessContent.时间+"</p><b class='hidden'>"+AccessContent.Id+"</b>");
        con.find(".panel-body").html(AccessContent.内容);
        CookieFunc.Checkuser();
        return AccessContent.标题;

    }    
    NInfo.BuildAccess = function (classify,classifyN, addobj) {
        var formreadother = { "action": "ReadAccessName", "classify":classify, "limit": "4" };
        var _ret = JSONfunc.postJsontoHandler(formreadother, "/ajax/InfoHandler.aspx");
        var Accessarr = JSONfunc.STRtoJSON(_ret);
        for (var i in Accessarr) {
            var _accessName = Accessarr[i];
            var newLi = $('<li class="list-group-item"><a></a><small class="pull-right"></small></li>');
            newLi.find("small").text(_accessName.时间);
            newLi.find("a").text(_accessName.标题);
            newLi.find("a").attr("href", "/module/NewInfo/NInfo.aspx?classifyN=" + classifyN + "&order=" + _accessName.Id);
            addobj.append(newLi);
        }
        addobj.siblings(".panel-footer").find("a").attr("href", "/module/NewInfo/NInfoList.aspx?classifyN=" + classifyN);

    }
    NInfo.BuildOtherClassify = function (jsonobj,panelobj) {
        for (var i in jsonobj) {
            var newli = $('<li class="list-group-item"><a></a></li>');
            newli.find("a").text(jsonobj[i].type+"——"+jsonobj[i].name).attr("href", jsonobj[i].url);
            panelobj.append(newli);
        }
    }
    NInfo.DelAccess = function () {
        var con = $("#InfoContent");
        var id = con.find(".panel-heading").find("b").text();
        var formdel = { "action": "AccesssDel", "Id":id };
        var _ret = JSONfunc.postJsontoHandler(formdel, "/ajax/InfoHandler.aspx");
        alert("文章已经删除");
        var rawurl = window.location.href;
        reg1 = /order=([\S]+)/;
        var nowurl = rawurl.replace(reg1, "order=-1");
        window.location.href = nowurl;

    }
    //根据参数决定读取什么info，根据json生成对应的面包导航
    $(function () {

        
        var Request = new Object();
        Request = GetRequest();
       var ClassifyN = Request["classifyN"];
        Order = parseInt(Request["order"]);
        infoList = JSONfunc.LoadJSON("/menu/EInfoA.txt");
        Classify = infoList[ClassifyN].name;
        var accessname = NInfo.BuildPanel(Classify, Order);
        NInfo.Buildbreadcrumb(infoList[ClassifyN],accessname,ClassifyN);
        NInfo.BuildAccess(Classify,ClassifyN, $("#Other-access"));
        NInfo.BuildOtherClassify(infoList, $("#Other-classify"));
        CookieFunc.Checkuser();
    })

</script>
<body>
    <div class=" container-fluid">
        <div class="row">
            <ol class="breadcrumb" style="font-size: 16px">
            </ol>
        </div>
        <div class="row">
            <div class="col-sm-10">
                <div class="panel panel-primary"id="InfoContent">
                    <div class="panel-heading" ></div>
                    <div class="panel-body"></div>
                </div>
            </div>
            <div class="col-sm-2">
                <div class="panel panel-primary">
                    <div class="panel-heading">同类文章</div>
                    <ul class="list-group" id="Other-access">
                     
                    </ul>
                    <div class="panel-footer"><p><a class="pull-right">更多...</a></p></div>
                </div>
                <div class="panel panel-primary">
                    <div class="panel-heading">其他分类</div>
                    <ul class="list-group" id="Other-classify">
                    </ul>
                </div>
                 <div class="panel panel-primary" author="jidongke">
                    <div class="panel-heading">操作</div>
                    <ul class="list-group" id="Operate">
                        <li class="list-group-item"><a href="InfoEnter.aspx">添加新文章</a></li>
                        <li class="list-group-item-danger list-group-item"><a href="#" onclick="NInfo.DelAccess()">删除该文章</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>



</body>
</html>
