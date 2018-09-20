function CookieFunc() { }
CookieFunc.getCookie = function (name) {
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
    if (arr = document.cookie.match(reg))
        return unescape(arr[2]);
    else
        return null;
}
CookieFunc.setCookie = function (name, value) {
    var username = document.cookie.split(";")[0].split("=")[1];
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
}
CookieFunc.delCookie = function (name) {
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval = CookieFunc.getCookie(name);
    if (cval != null)
        document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
}

CookieFunc.setCookiewithTime = function (name, value, time) {
    function getsec(str) {
        var str1 = str.substring(1, str.length) * 1;
        var str2 = str.substring(0, 1);
        if (str2 == "s") {
            return str1 * 1000;
        }
        else if (str2 == "h") {
            return str1 * 60 * 60 * 1000;
        }
        else if (str2 == "d") {
            return str1 * 24 * 60 * 60 * 1000;
        }
    }
    var strsec = getsec(time);
    var exp = new Date();
    exp.setTime(exp.getTime() + strsec * 1);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
}

CookieFunc.Checkuser=function(){//这里放定制用户操作
    var username = CookieFunc.getCookie("username");
    var authorArr = (JSONfunc.LoadJSON("/menu/userathor.txt"))[username];
    var cell = $("[author]");
    for (var i = 0; i < cell.length;i++) {
        var ifremove = true;
        for (var j in authorArr) {
            if ($(cell[i]).attr("author") == authorArr[j].author) {
                ifremove = false;
                break;
            }            
        }
        if (ifremove) {
            $(cell[i]).remove();
        }
    }
}

