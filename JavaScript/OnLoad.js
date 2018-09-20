
window.onload = function ()
{
    if (window.top != window.self) {//存在父页面
        var isChrome = window.google && window.chrome
        if (isChrome) {
            $(window).find("body").ready(function () {
                window.parent.ChildrenCallback();
            })
        }
        window.parent.ChildrenCallback();
    }
    if (window.ActiveXObject) {
        var ua = navigator.userAgent.toLowerCase();
        var ie = ua.match(/msie ([\d.]+)/)[1]
        if (ie == 6.0) {
            alert("您的浏览器版本过低，在本系统中不能达到良好的视觉效果，建议你升级到ie8以上！");
            window.location.reload("forie6.html");
        }
    }
}