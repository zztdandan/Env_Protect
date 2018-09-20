/// <reference path="../ajax/JsonHandler.aspx" />
JSONfunc = function ()
{ }

JSONfunc.LoadJSON = function (_url)
{
    var ret;
    $.ajax({
        type: "get",
        url: _url + "?r=" + Math.ceil(Math.random() * 10000),//插入随机数
        dataType: "json",
        async: false,
        success: function (jsonobj)
        {

            ret = jsonobj;
        },
        error: function (err)
        {

            ret = err;
        }
    });
    return ret;
}

JSONfunc.JSONLength = function (obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};
JSONfunc.loadJSONbyHandler = function ()
{

}
JSONfunc.JSONtoSTR = function (jsonobj)
{
    return JSON.stringify(jsonobj);
}
JSONfunc.STRtoJSON = function (strobj)
{
    return JSON.parse(strobj);
}
JSONfunc.postJsontoHandler = function (formkk,_url)
{
    var ret = "";
    
    $.ajax({
        type: "post", //要用post方式                 
        url: _url + "?r="+ Math.ceil(Math.random() * 10000),//插入一个随机数
        //contentType: "application/json; charset=utf-8",
        //dataType: "json",
        data: formkk,//要做什么，存入数据库的标识名，存入文件的文件地址，要存入的内容
        async: false,
        success: function (d)
        {
            ret = d;
        },
        error: function (err)
        {
            ret = err.responseText;
        }
    });
    return ret;
}
JSONfunc.postJsontoHandlerAsync = function (formkk, _url,func) {
    var ret = "";
    $.ajax({
        type: "post", //要用post方式                 
        url: _url + "?r=" + Math.ceil(Math.random() * 10000),//插入一个随机数
        //contentType: "application/json; charset=utf-8",
        //dataType: "json",
        data: formkk,//要做什么，存入数据库的标识名，存入文件的文件地址，要存入的内容
        async:true,
        success: function (d) {
            func(d);
        },
        error: function (err) {
            ret = err.responseText;
            alert(ret);
        }
    });
}
JSONfunc.DateString = function ()
{
    var d = new Date();
    var vYear = d.getFullYear();
    var vMonth = d.getMonth() + 1;
    var vDate = d.getDate();
    var vHour = (d.getHours() < 10) ? ("0" + d.getHours()) : (d.getHours());
    var vMinutes = ((d.getMinutes() < 10) ? ("0" + d.getMinutes()) : ("" + d.getMinutes()));
    var str = vYear + "-" + vMonth + "-" + vDate + " " + vHour + ":" + vMinutes;
    return str;
}