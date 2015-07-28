$('.button-reload').click(function () {
    $('#prize_rank option:first').attr('selected', true)
    window.location.reload();
});

userinterval = setInterval(loadUser, loadTime);

function loadUser() {
    var url = '/lottery/getUserCount';
    $.getJSON(url, function (data) {
        if (data.err == 0) {
            $('.usercount-label b').html(data.count);
        }

    })
}
$("#prize_rank").change(function () {
    var val = $(this).val();
    var url = '/lottery/getPrizeRecord';
    $('.prize-list').html('');
    if (val != '') {
        $.getJSON(url, {'pid': val}, function (data) {
            $('#prize_num').html(data.num);
            if (data.records) {
                var html = createHtml(data.records);
                $('.prize-list').html(html);
            }
        });
    } else {
        $('#prize_num').html(0);
    }

});


$('.button-run').click(function () {
    var pnum = $('#prize_num').html();
    if (pnum == 0) {
        alert("没有奖品了");
    } else {
        var prize_id = $('#prize_rank').val();
        var url = '/lottery/getUser';
        if (prize_id) {
            $.getJSON(url, {}, function (data) {
                if (data.length == 0) {
                    clearInterval(interval);
                    alert("奖池里没人了");
                } else {
                    interval = setInterval(function () {
                        var len = data.length - 1;
                        var i = GetRandomNum(0, len);
                        var d = $.parseJSON(data[i]);
                        $('#header').css('background-image', 'url(' + d.portrait + ')');
                        $('#header .nick-name').html(d.nickname);
                        $('.button-run').hide();
                        $('.button-stop').show();
                    }, 100);
                }
            });
        } else {
            alert("请先选择奖项");
        }
    }
});

$('.button-stop').click(function () {
    clearInterval(interval);

    var prize_id = $('#prize_rank').val();
    var url = '/lottery/setPrize';

    $.getJSON(url, {'pid': prize_id}, function (data) {
        var len = data.length;
        $('#header').css('background-image', 'url(' + data[len - 1].portrait + ')');
        $('#header .nick-name').html(data[len - 1].nickname);
        $('.button-run').show();
        $('.button-stop').hide();
        var html = createHtml(data, true);
        var right = $('.prize-list');
        right.html(html);
        var num = $('#prize_num').html() * 1;
        $('#prize_num').html(num - 1);
    });
});

function GetRandomNum(Min, Max) {
    var Range = Max - Min;
    var Rand = Math.random();
    return (Min + Math.round(Rand * Range));
}


function createHtml(data, state) {

    var len = data.length;
    var html = '';
    for (var i = len - 1; i >= 0; i--) {
        html += '<div class="result-line" style="display: block;"><div class="result-num">' + (i + 1) + '</div><div class="user"  style="background-image: url(' + data[i].portrait + ');"><span class="nick-name">' + data[i].nickname + '</span></div></div>';
    }
    return html;
}