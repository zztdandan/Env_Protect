<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CMresultA.aspx.cs" Inherits="module_PSManage_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>公司监测结果（气\水）录入</title>
    <script src="../../JavaScript/jquery1.10.2.min.js"></script>
    <script src="../../JavaScript/jquery-ui-1.8.24.min.js"></script>
    <link href="../../JavaScript/jquery-ui.css" rel="stylesheet" />
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
    <link href="../../css/mycss.css" rel="stylesheet" />
    <script src="../../JavaScript/CookieFunc.js"></script>
    <script type="text/javascript">




        var CMresult;
        function CMresultA() { }
        CMresultA.Formatauto = function (val) {
            var CMlist = JSONfunc.LoadJSON("jsondata/CMList.txt");
            $("#TpointGas").autocomplete({
                source: CMlist.Gas,
                minLength: 0,
                delay: 100
            });
            $("#TpointLiq").autocomplete({
                source: CMlist.Liquid,
                minLength: 0,
                delay: 100
            });
        }//定义两个自动完成窗口的初始化
        CMresultA.Changeauto = function (val) {
            if (val == "Gas") { $("#TpointLiq").val("").hide(); $("#TpointGas").val("").show(); }
            else { $("#TpointGas").val("").hide(); $("#TpointLiq").val("").show(); }
        }//根据选择气液交换来改变到底显示哪个窗口
        CMresultA.ReadTpoint = function (date, type, tpoint) {
            function ReconstructTpoint(arrayobj) {
                $("#TpointContent").html("");
                var aa = $("<div></div>");
                example = $('<div class="form-group well col-sm-4"><label class="control-label"></label><input type="text" class="form-control "/></div>');
                var newobj = new Array();
                $.each(arrayobj,function(i){
                    iname = arrayobj[i].name;
                    inumber = arrayobj[i].number;
                    newobj[i] = $('<div class=" col-sm-3 panel panel-default"><div class="form-group-sm " role="hero"><label class="control-label"></label><br/><input type="text" class="form-control "/></div></div>');
                    newobj[i].find("label").text(iname).attr("id", "name" + iname);
                    newobj[i].find("input").val(inumber).attr("id", "number" + iname);
                    $("#TpointContent").append(newobj[i]);
                });
            }
            if ((date == "") || (tpoint == "")) { return 0; }
            var formRead = { "action": "CMReadDetail", "time": date, "name": tpoint };
            var _ret = JSONfunc.postJsontoHandler(formRead, "/ajax/CMHandler.aspx");
            $("#btnDel").hide();
            if (_ret == "[]") {
                if (type == "Liq") {
                    CMresult = JSONfunc.LoadJSON("jsondata/CMLiq.txt");
                }
                else {
                    CMresult = JSONfunc.LoadJSON("jsondata/CMGas.txt");
                }
                $("#Answer-to-query").text("没有找到数据库内的记录，该数据将被添加入数据库");
                $("#querybool").text("2");
            }
            else {
                CMresult = JSONfunc.STRtoJSON(JSONfunc.STRtoJSON(_ret)[0].数据);
                $("#Answer-to-query").text("该时刻的该监测点已在数据库内，该数据将覆盖原有数据");
                $("#querybool").text("1");
                $("#btnDel").show();
            }
            ReconstructTpoint(CMresult);
        }//在写完3个input内容后，编写下面的表单
        CMresultA.submit = function (date, type, tpoint, tcontent) {
            function RebuildCMresult() {
                for (var i in CMresult) {
                    objid = tcontent[i].id;
                    reg = /number([\S]+)/;
                    CMresult[i].number = tcontent[i].value;
                }
            }
            if ((date == "") || (type == "") || (tpoint == "")) { alert("前面定位数据为空，重新填写"); return 0; }
            RebuildCMresult();
            var upjson = JSONfunc.JSONtoSTR(CMresult);
            if ($("#querybool").text() == "1") {
                var formSave = { "action": "CMUpdate", "time": date, "name": tpoint, "type": type, "JSONDATA": upjson };
            }
            else {
                formSave = { "action": "CMInsert", "time": date, "name": tpoint, "type": type, "JSONDATA": upjson };
            }
            var _ret = JSONfunc.postJsontoHandler(formSave, "/ajax/CMHandler.aspx");
            alert(_ret);
            location.reload();
        }
        CMresultA.del = function (date, type, tpoint) {
            if ((date == "") || (type == "") || (tpoint == "")) { alert("前面定位数据为空，重新填写"); return 0; }
            var upjson = JSONfunc.JSONtoSTR(CMresult);
            var formdel = { "action": "CMDel", "time": date, "name": tpoint, "type": type };
            var _ret = JSONfunc.postJsontoHandler(formdel, "/ajax/CMHandler.aspx");
            alert(_ret);
            location.reload();
        }
        CMresultA.parentCall = function (date, tpoint) {


            $('#date-select').val(date);
            $('#TpointGas').val(tpoint);
            $('#date-show').val(date);
            CMresultA.ReadTpoint($('#date-select').val(), "", $('#TpointGas').val() + $('#TpointLiq').val());
        }
        $(function () {
            CMresultA.Formatauto();
            $("#CMType").val("Gas");
            //SetBuild($("#date-select").val(),$("#CMType").val());
            //SetBuild("2015-09", $("#CMType").val());
            CMresultA.Changeauto("Gas");

        });


    </script>
    <script type="text/javascript">
        $("#dtpclass1").ready(function () {
            $('#dtpclass1').datetimepicker({
                format: 'yyyy-mm-dd',
                language: 'zh-CN',
                minView: 2,
                weekStart: 1,
                startDate: '2010-01-01',
                endDate: '2100-01-01',
                todayBtn: "linked",
                autoclose: 1,
                startView: 2,
                forceParse: 0,
            });
        });//初始化日期选择器,dtpclass是日期选择器标识

    </script>
</head>
<body>
    <div class=" container">
        <div class="row">
            <form id="formCMGas" class="form-horizontal">
                <fieldset>
                    <div class="form-group-sm col-sm-4">
                        <!-- Appended input-->
                        <label class="control-label">日期</label>
                        <div class="input-append">
                            <div class="input-group date" id="dtpclass1" data-date="" data-link-field="date-select" data-link-format="yyyy-mm-dd">
                                <input class="form-control" id="date-show" size="16" type="text" value="" />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                            </div>
                            <input type="hidden" id="date-select" value="" /><br />
                        </div>
                    </div>
                    <div class="form-group-sm col-sm-2">
                        <!-- Select Basic -->
                        <label class="control-label">类型</label>
                        <select id="CMType" class="form-control" onchange="CMresultA.Changeauto($(this).val())">
                            <option value="Gas">气体</option>
                            <option value="Liq">水体</option>
                        </select>
                    </div>
                    <div class="form-group-sm col-sm-6">
                        <label class="control-label">监测点</label>
                        <input type="text" class="form-control Tpoint" id="TpointGas" />
                        <input type="text" class="form-control Tpoint" id="TpointLiq" />
                        <p class="help-block">可用上下方向键打开选择列表，或直接输入部分字</p>
                    </div>


                    <div class="text-center col-sm-12">
                        <a href="#" type="button" class="btn btn-primary" onclick="CMresultA.ReadTpoint($('#date-select').val(),$('#CMType').val(),$('#TpointGas').val()+$('#TpointLiq').val())">添加\修改该监测点</a>
                    </div>
                    <%--分割线--%>
                    <hr size="1" />
                    <p id="Answer-to-query" class="bg-info"></p>
                    <p class="hidden" id="querybool"></p>
                    <div id="TpointContent" class="form-inline"></div>
                    <%--分割线--%>
                    <hr size="1" />
                    <%--按钮--%>

                    <div class="text-center col-sm-12">
                        <hr size="1" />
                        <div class="btn-group " role="group" aria-label="...">
                            <a href="#" type="button" class="btn btn-primary" id="btnChange" onclick="CMresultA.submit($('#date-select').val(),$('#CMType').val(),$('#TpointGas').val()+$('#TpointLiq').val(),$('#TpointContent').find('input'))">添加\修改</a>
                            <a href="#" type="button" class="btn btn-danger" id="btnDel" onclick="CMresultA.del($('#date-select').val(),$('#CMType').val(),$('#TpointGas').val()+$('#TpointLiq').val())">删除</a>
                            <a href="#" type="reset" class="btn btn-default" id="btnReset" onclick="CMresultA.ReadTpoint($('#date-select').val(),$('#CMType').val(),$('#TpointGas').val()+$('#TpointLiq').val())">还原修改</a>
                        </div>
                    </div>
                </fieldset>
            </form>
        </div>
    </div>
</body>
</html>
