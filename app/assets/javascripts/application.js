// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets

$( function() {
    // 料金プランからアカウント登録へのモーダル切り替え
    $('#planToRegistration').click( function () {
        $('#planModal').modal('hide');
    });

    // ログインからアカウント登録へのモーダル切り替え
    $('#logInToRegistration').click( function () {
        $('#logInModal').modal('hide');
    });

    // アカウント登録から契約手続きへのモーダル切り替え
    $('#registrationToAgreement').click( function () {
        button = document.getElementById('registrationToAgreement');
        button.dataset.email = $('#em').val();
        button.dataset.pass = $('#pass').val();
        button.dataset.pid = $('#pid').val();
        $('#registrationModal').modal('hide');
    });

    // ログインからパスワードリマインダーへのモーダル切り替え
    $('#logInToPasswordReminder').click( function () {
        $('#logInModal').modal('hide');
    });

    // ログインからパスワードリマインダーへのモーダル切り替え
    $('#agreementToThanks').click( function () {
        $('#agreementModal').modal('hide');
    });

    // ログインからパスワードリマインダーへのモーダル切り替え
    $('#agreementToPlan').click( function () {
        $('#agreementModal').modal('hide');
    });

    // 料金プランのタブ切り替え
    $('#myTab li a').click( function () {
        $('.active').removeClass('active');
        $(this).addClass("active");
        $($(this).attr("href")).addClass("active");
    });

    // 規約同意のチェックボックスの状態によってボタンを切り替え
    $('#agreementCheck').click( function () {
        var btn = document.getElementById('agree');
        if ($('#agreementCheck').prop('checked')) {
            btn.removeAttribute('disabled');
        } else {
            btn.setAttribute('disabled', 'disabled');
        }
    });

    // モーダル上のプラン選択のラジオボタン切り替え
    $("[class^='plan_']").click( function () {
        $(`#${$(this).attr('class')}`).prop('checked',true);
        button = document.getElementById('planToRegistration');
        button.dataset.pid = $(`#${$(this).attr('class')}`).val();
        $('#pid').val($(`#${$(this).attr('class')}`).val());
    });

    $('#registrationModal').on('show.bs.modal', function (event) {
        // ボタンを取得
        var button = $(event.relatedTarget);
        // data-***の部分を取得
        var button_data = button.data('pid');;
        var modal = $(this);
        // モーダルに取得したパラメータを表示
        // 以下ではh5のモーダルタイトルのクラス名を取得している
        //$('#pid').val(button_data);
    })

    $('#agreementModal').on('show.bs.modal', function (event) {
        // ボタンを取得
        var button = $(event.relatedTarget);
        // data-***の部分を取得
        var em_data = button.data('email');
        var pass_data = button.data('pass');
        var pid_data = $('#pid').val();
        var modal = $(this);
        // モーダルに取得したパラメータを表示
        // 以下ではh5のモーダルタイトルのクラス名を取得している
        modal.find('#hem').val(em_data);
        modal.find('#hpass').val(pass_data);
        modal.find('#hpid').val(pid_data);
        modal.find('#select_plan').val(pid_data);
        if(gon.plans[pid_data-1].period == 'yearly'){
            price = gon.plans[pid_data-1].price * 12
            price = price.toLocaleString()
            modal.find('#total').text(`合計金額：${price}円`);
        }else{
            price = gon.plans[pid_data-1].price
            price = price.toLocaleString()
            modal.find('#total').text(`合計金額：${price}円`);
        }
    })
    
    $('#select_plan').change(function () {
        price = gon.plans[$(this).val() - 1].price
        if(gon.plans[$(this).val() - 1].period == 'yearly'){
            price = Number(price) * 12;
        }
        price = price.toLocaleString()

        $('#total').text(`合計金額：${price}円`);
        $('#hpid').val($(this).val())
    });

    $('#selectplan').change(function () {
        price = gon.plans[$(this).val() - 1].price
        if(gon.plans[$(this).val() - 1].period == 'yearly'){
            price = Number(price) * 12;
        }
        price = price.toLocaleString()

        $('#plan').text(`合計金額：${price}円`);
    });

});
