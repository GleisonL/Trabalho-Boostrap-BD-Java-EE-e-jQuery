$(function () {
    $('#side-menu').metisMenu();
});
//ao carregar redimenciona o menu automaticamente
//redimenciona o menu ao alterar o tamanho da tela
//seta o min-height da pagina
$(function () {
    $(window).bind("load resize", function () {
        topOffset = 50;
        width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
        if (width < 768) {
            $('div.navbar-collapse').addClass('collapse');
            topOffset = 100;
        }
        else {
            $('div.navbar-collapse').removeClass('collapse');
        }

        height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
        height = height - topOffset;
        if (height < 1)
            height = 1;
        if (height > topOffset) {
            $("#page-wrapper").css("min-height", (height) + "px");
        }
    });

    var url = window.location;
    var element = $('ul.nav a').filter(function () {
        return this.href == url || url.href.indexOf(this.href) == 0;
    }).addClass('active').parent().parent().addClass('in').parent();
    if (element.is('li')) {
        element.addClass('active');
    }
});

function alerta(sContainer, sMensagem){
    var sHTML = '';
    sHTML += '<div class="alert alert-danger">';
    sHTML += '<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>';
    sHTML += sMensagem;
    sHTML += '</div>';
    $("#container-mensagem-"+sContainer).html(sHTML);
}

function reloadPagina(){
    window.location.reload();
}