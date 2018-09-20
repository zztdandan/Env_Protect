function DateString()
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
Date.prototype.pattern = function (fmt)
{
    var o = {
        "M+": this.getMonth() + 1, //月份         
        "d+": this.getDate(), //日         
        "h+": this.getHours() % 12 == 0 ? 12 : this.getHours() % 12, //小时         
        "H+": this.getHours(), //小时         
        "m+": this.getMinutes(), //分         
        "s+": this.getSeconds(), //秒         
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度         
        "S": this.getMilliseconds() //毫秒         
    };
    var week = {
        "0": "周一",
        "1": "周二",
        "2": "周三",
        "3": "周四",
        "4": "周五",
        "5": "周六",
        "6": "周日"
    };
    if (/(y+)/.test(fmt))
    {
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    if (/(E+)/.test(fmt))
    {
        fmt = fmt.replace(RegExp.$1, ((RegExp.$1.length > 1) ? (RegExp.$1.length > 2 ? "/u661f/u671f" : "/u5468") : "") + week[this.getDay() + ""]);
    }
    for (var k in o)
    {
        if (new RegExp("(" + k + ")").test(fmt))
        {
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        }
    }
    return fmt;
}
function GetRequest() {

    var url = location.search; //获取url中"?"符后的字串

    var theRequest = new Object();

    if (url.indexOf("?") != -1) {

        var str = url.substr(1);

        strs = str.split("&");

        for (var i = 0; i < strs.length; i++) {

            theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);

        }

    }

    return theRequest;

}
function monthend(year, month) {
    var new_year = year;  //取当前的年份    
    var new_month = month++;//取下一个月的第一天，方便计算（最后一天不固定）    
    if(month>12)      //如果当前大于12月，则年份转到下一年    
    {    
        new_month -=12;    //月份减    
        new_year++;      //年份增    
    }    
    var new_date = new Date(new_year,new_month,1);        //取当年当月中的第一天    
    return (new Date(new_date.getTime()-1000*60*60*24)).getDate();//获取当月最后一天日期    

}