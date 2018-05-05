var dt = [
    { "date": "2018-05-05", "time": "12:07:34" },
    { "date": "2018-05-03", "time": "16:23:24" },
    { "date": "2018-05-02", "time": "11:09:14" },
    { "date": "2018-05-01", "time": "8:06:04" },
]


function formatDate(nowDate) {
    var year = nowDate.getFullYear();
    var month = nowDate.getMonth() + 1 < 10 ? "0" + (nowDate.getMonth() + 1) : nowDate.getMonth() + 1;
    var date = nowDate.getDate() < 10 ? "0" + nowDate.getDate() : nowDate.getDate();
    // var hour = nowDate.getHours()< 10 ? "0" + nowDate.getHours() : nowDate.getHours();    
    // var minute = nowDate.getMinutes()< 10 ? "0" + nowDate.getMinutes() : nowDate.getMinutes();    
    // var second = nowDate.getSeconds()< 10 ? "0" + nowDate.getSeconds() : nowDate.getSeconds();    
    return year + "-" + month + "-" + date;
}
Date.prototype.addDays = function (d) {
    this.setDate(this.getDate() + d);
};

$(document).ready(function () {
        var date = new Date();
        for (var i = 52; i >= 0; --i) {
            for (var j = 6; j >= 0; --j) {
                tx = i * 13;
                ty = j * 13;
                var svgNS = "http://www.w3.org/2000/svg";
                var vnb = document.createElementNS(svgNS, "rect");
                var nb = $(vnb);
                nb.attr("fill", "#ebedf0");
                nb.attr("x", tx);
                nb.attr("y", ty);
                nb.attr("width", 10);
                nb.attr("height", 10);
                nb.attr("date", formatDate(date));
                nb.attr("title", date.toDateString());
                nb.tooltip();
                $("#calendar-graph").append(nb);
                date.setDate(date.getDate() - 1);
            }
        }
        for (var i in dt) {
            var cur = $("[date = " + dt[i].date + "]");
            cur.attr("fill", "#007acc");
            cur.attr("data-original-title", cur.attr("data-original-title") + ": " + dt[i].time);
        }
    }
);