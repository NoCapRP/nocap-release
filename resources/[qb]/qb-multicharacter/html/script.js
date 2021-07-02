var selectedChar = null;
qbMultiCharacters = {}
$('.container').hide();

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;

        if (item.action == "openUI") {
            if (item.toggle == true) {
                $('.container').fadeIn(250);
                qbMultiCharacters.resetAll();
            } else {
                $('.container').fadeOut(250);
                qbMultiCharacters.resetAll();
            }
        }

        if (item.action == "setupCharacters") {
            setupCharacters(event.data.characters)
        }

        if (item.action == "setupCharInfo") {
            setupCharInfo(event.data.chardata)
        }
    });

    $('.continue-btn').click(function(e) {
        e.preventDefault();

        qbMultiCharacters.fadeOutUp('.welcomescreen', undefined, 400);
        qbMultiCharacters.fadeOutDown('.server-log', undefined, 400);
        setTimeout(function() {
            qbMultiCharacters.fadeInDown('.characters-list', '20%', 400);
            qbMultiCharacters.fadeInDown('.character-info', '20%', 400);
            $.post('http://qb-multicharacter/setupCharacters');
        }, 400)
    });

    $('.disconnect-btn').click(function(e) {
        e.preventDefault();

        $.post('http://qb-multicharacter/closeUI');
        $.post('http://qb-multicharacter/disconnectButton');
    });

    $('.datepicker').datepicker();
});

function setupCharInfo(cData) {
    if (cData == 'empty') {
        $('.character-info-valid').html('<span id="no-char">The selected character slot is not in use.<br><br>So this character has no information yet.</span>');
    } else {
        var gender = "Man"
        if (cData.charinfo.gender == 1) { gender = "Woman" }
        $('.character-info-valid').html(
            '<div class="character-info-box"><span id="info-label">Name: </span><span class="char-info-js">' + cData.charinfo.firstname + ' ' + cData.charinfo.lastname + '</span></div>' +
            '<div class="character-info-box"><span id="info-label">Date of birth: </span><span class="char-info-js">' + cData.charinfo.birthdate + '</span></div>' +
            '<div class="character-info-box"><span id="info-label">Gender: </span><span class="char-info-js">' + gender + '</span></div>' +
            '<div class="character-info-box"><span id="info-label">Nationality: </span><span class="char-info-js">' + cData.charinfo.nationality + '</span></div>' +
            '<div class="character-info-box"><span id="info-label">Job: </span><span class="char-info-js">' + cData.job.label + '</span></div>' +
            '<div class="character-info-box"><span id="info-label">Cash: </span><span class="char-info-js">&#36; ' + cData.money.cash + '</span></div>' +
            '<div class="character-info-box"><span id="info-label">Bank: </span><span class="char-info-js">&#36; ' + cData.money.bank + '</span></div><br>' +
            '<div class="character-info-box"><span id="info-label">Phone Number: </span><span class="char-info-js">' + cData.charinfo.phone + '</span></div>' +
            '<div class="character-info-box"><span id="info-label">Account number: </span><span class="char-info-js">' + cData.charinfo.account + '</span></div>');
    }
}

function setupCharacters(characters) {
    $.each(characters, function(index, char) {
        $('#char-' + char.cid).html("");
        $('#char-' + char.cid).data("citizenid", char.citizenid);
        setTimeout(function() {
            $('#char-' + char.cid).html('<span id="slot-name">' + char.charinfo.firstname + ' ' + char.charinfo.lastname + '<span id="cid">' + char.citizenid + '</span></span>');
            $('#char-' + char.cid).data('cData', char)
            $('#char-' + char.cid).data('cid', char.cid)
        }, 100)
    })
}

$(document).on('click', '#close-log', function(e) {
    e.preventDefault();
    selectedLog = null;
    $('.welcomescreen').css("filter", "none");
    $('.server-log').css("filter", "none");
    $('.server-log-info').fadeOut(250);
    logOpen = false;
});

$(document).on('click', '.character', function(e) {
    var cDataPed = $(this).data('cData');
    e.preventDefault();
    if (selectedChar === null) {
        selectedChar = $(this);
        if ((selectedChar).data('cid') == "") {
            $(selectedChar).addClass("char-selected");
            setupCharInfo('empty')
            $("#play-text").html("Create character");
            $("#play").css({ "display": "block" });
            $("#delete").css({ "display": "none" });
            $.post('http://qb-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        } else {
            $(selectedChar).addClass("char-selected");
            setupCharInfo($(this).data('cData'))
            $("#play-text").html("Play");
            $("#delete-text").html("Delete character");
            $("#play").css({ "display": "block" });
            $("#delete").css({ "display": "block" });
            $.post('http://qb-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        }
    } else {
        $(selectedChar).removeClass("char-selected");
        selectedChar = $(this);
        if ((selectedChar).data('cid') == "") {
            $(selectedChar).addClass("char-selected");
            setupCharInfo('empty')
            $("#play-text").html("Create character");
            $("#play").css({ "display": "block" });
            $("#delete").css({ "display": "none" });
            $.post('http://qb-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        } else {
            $(selectedChar).addClass("char-selected");
            setupCharInfo($(this).data('cData'))
            $("#play-text").html("PLAY");
            $("#delete-text").html("Delete character");
            $("#play").css({ "display": "block" });
            $("#delete").css({ "display": "block" });
            $.post('http://qb-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        }
    }
});

$(document).on('click', '#create', function(e) {
    e.preventDefault();
    $.post('http://qb-multicharacter/createNewCharacter', JSON.stringify({
        firstname: $('#first_name').val(),
        lastname: $('#last_name').val(),
        nationality: $('#nationality').val(),
        birthdate: $('#birthdate').val(),
        gender: $('select[name=gender]').val(),
        cid: $(selectedChar).attr('id').replace('char-', ''),
    }));
    $(".container").fadeOut(150);
    $('.characters-list').css("filter", "none");
    $('.character-info').css("filter", "none");
    qbMultiCharacters.fadeOutDown('.character-register', '125%', 400);
    refreshCharacters()
});

$(document).on('click', '#accept-delete', function(e) {
    $.post('http://qb-multicharacter/removeCharacter', JSON.stringify({
        citizenid: $(selectedChar).data("citizenid"),
    }));
    $('.character-delete').fadeOut(150);
    $('.characters-block').css("filter", "none");
    refreshCharacters()
});

function refreshCharacters() {
    $('.characters-list').html('<div class="character" id="char-1" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-2" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-3" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-4" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-5" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character-btn" id="play"><p id="play-text">Select a character</p></div><div class="character-btn" id="delete"><p id="delete-text">Select a character</p></div>')
    setTimeout(function() {
        $(selectedChar).removeClass("char-selected");
        selectedChar = null;
        $.post('http://qb-multicharacter/setupCharacters');
        $("#delete").css({ "display": "none" });
        $("#play").css({ "display": "none" });
        qbMultiCharacters.resetAll();
    }, 100)
}

$("#close-reg").click(function(e) {
    e.preventDefault();
    $('.characters-list').css("filter", "none")
    $('.character-info').css("filter", "none")
    qbMultiCharacters.fadeOutDown('.character-register', '125%', 400);
})

$("#close-del").click(function(e) {
    e.preventDefault();
    $('.characters-block').css("filter", "none");
    $('.character-delete').fadeOut(150);
})

$(document).on('click', '#play', function(e) {
    e.preventDefault();
    var charData = $(selectedChar).data('cid');

    if (selectedChar !== null) {
        if (charData !== "") {
            $.post('http://qb-multicharacter/selectCharacter', JSON.stringify({
                cData: $(selectedChar).data('cData')
            }));
            qbMultiCharacters.fadeInDown('.welcomescreen', '15%', 400);
            qbMultiCharacters.fadeInDown('.server-log', '25%', 400);
            setTimeout(function() {
                qbMultiCharacters.fadeOutDown('.characters-list', "-40%", 400);
                qbMultiCharacters.fadeOutDown('.character-info', "-40%", 400);
            }, 300);
            qbMultiCharacters.resetAll();
        } else {
            $('.characters-list').css("filter", "blur(2px)")
            $('.character-info').css("filter", "blur(2px)")
            qbMultiCharacters.fadeInDown('.character-register', '25%', 400);
        }
    }
});

$(document).on('click', '#delete', function(e) {
    e.preventDefault();
    var charData = $(selectedChar).data('cid');

    if (selectedChar !== null) {
        if (charData !== "") {
            $('.characters-block').css("filter", "blur(2px)")
            $('.character-delete').fadeIn(250);
        }
    }
});

qbMultiCharacters.fadeOutUp = function(element, time) {
    $(element).css({ "display": "block" }).animate({ top: "-80.5%", }, time, function() {
        $(element).css({ "display": "none" });
    });
}

qbMultiCharacters.fadeOutDown = function(element, percent, time) {
    console.log(percent)
    if (percent !== undefined) {
        $(element).css({ "display": "block" }).animate({ top: percent, }, time, function() {
            $(element).css({ "display": "none" });
        });
    } else {
        $(element).css({ "display": "block" }).animate({ top: "103.5%", }, time, function() {
            $(element).css({ "display": "none" });
        });
    }
}

qbMultiCharacters.fadeInDown = function(element, percent, time) {
    $(element).css({ "display": "block" }).animate({ top: percent, }, time);
}

qbMultiCharacters.resetAll = function() {
    $('.characters-list').hide();
    $('.characters-list').css("top", "-40");
    $('.character-info').hide();
    $('.character-info').css("top", "-40");
    $('.welcomescreen').show();
    $('.welcomescreen').css("top", "15%");
    $('.server-log').show();
    $('.server-log').css("top", "25%");
}