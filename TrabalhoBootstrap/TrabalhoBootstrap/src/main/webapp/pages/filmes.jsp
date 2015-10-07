<%@page import="modelo.Filme"%>
<%@page import="controle.FilmeDB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controle.Conexao"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Locadora NetMovie</title>

        <link href="../lib/css/bootstrap.min.css" rel="stylesheet">
        <link href="../lib/css/main.css" rel="stylesheet">
        <link href="../lib/css/metisMenu.min.css" rel="stylesheet">
        <link href="../lib/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <script>
            function excluirFilme(filCodigo) {
                try {
                    $.ajax({
                        async    : false,
                        data     : {
                            requisicao : "excluir",
                            filcodigo  : filCodigo
                        },
                        type     : "GET",
                        url      : 'manutencao/manutencaofilmes.jsp',
                        dataType : 'json',
                        success  : function(oRetorno) {
                            if(oRetorno["erro"] == "ok") {
                                reloadPagina();
                            }
                            else {
                                alerta("manutencao-excluir", oRetorno["resposta"]);
                            }
                        }
                    });         
                }
                catch(e){
                    alert("ERRO: "+e);
                }
            }
            function incluirFilme(){
                try {
                    $.ajax({
                        async    : false,
                        data     : {
                            requisicao  : "incluir",
                            filnome     : $("#nome").val(),
                            fildesricao : $("#descricao").val()
                        },
                        type     : "GET",
                        url      : 'manutencao/manutencaofilmes.jsp',
                        dataType : 'json',
                        success  : function(oRetorno) {
                            if(oRetorno["erro"] == "ok") {
                                reloadPagina();
                            }
                            else {
                                alerta("incluir", oRetorno["resposta"]);
                            }
                        }
                    });         
                }
                catch(e){
                    alert("ERRO: "+e);
                }
            }
            
            function chamaAlterarFilme(codigo, nome, descricao){
                $("#codigo-alterar").val(codigo);
                $("#nome-alterar").val(nome);
                $("#descricao-alterar").val(descricao);
                $("#container-alterar").trigger("click");
            }
            
            function alterarFilme() {
                try {
                    $.ajax({
                        async    : false,
                        data     : {
                            requisicao   : "alterar",
                            filcodigo    : $("#codigo-alterar").val(),
                            filnome      : $("#nome-alterar").val(),
                            fildescricao : $("#descricao-alterar").val()
                        },
                        type     : "GET",
                        url      : 'manutencao/manutencaofilmes.jsp',
                        dataType : 'json',
                        success  : function(oRetorno) {
                            if(oRetorno["erro"] == "ok") {
                                reloadPagina();
                            }
                            else {
                                alerta("alterar", oRetorno["resposta"]);
                            }
                        }
                    });         
                }
                catch(e){
                    alert("ERRO: "+e);
                }
            }
        </script>
    </head>

    <body>
        <br>
        <div id="wrapper">
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a href="../index.jsp">
                        <div class="logo"></div>
                    </a>
                </div>
                <ul class="nav navbar-nav navbar-top-links navbar-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                            <i class="fa fa-user fa-fw"></i> 
                            <i class="fa fa-caret-down"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-user">
                            <li>
                                <a href="index.jsp"><i class="fa fa-user fa-fw"></i>Perfil de usuário</a>
                            </li>
                            <li>
                                <a href="mensagem.jsp"><i class="fa fa-envelope fa-fw"></i> Mensagens</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="#"><i class="fa fa-sign-out fa-fw"></i> Sair</a>
                            </li>
                        </ul>
                    </li>
                </ul>
                <div class="navbar-default sidebar" role="navigation">
                    <div class="sidebar-nav navbar-default navbar-collapse">
                        <ul class="nav" id="side-menu">
                            <li>
                                <a href="../index.jsp"><i class="fa fa-home fa-fw"></i> Home</a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-tasks fa-fw"></i> Filme<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="generos.jsp"><i class="fa fa-edit fa-fw"></i> Gêneros</a>
                                    </li>
                                    <li>
                                        <a href="filmes.jsp"><i class="fa fa-folder-open fa-fw"></i> Filmes</a>
                                    </li>
                                </ul>
                            </li>                     
                            <li>
                                <a href="#"><i class="fa fa-shopping-cart fa-fw"></i> Locadora<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="locacoes.jsp"><i class="fa fa-briefcase fa-fw"></i> Locações</a>
                                    </li>
                                    <li>
                                        <a href="usuarios.jsp"><i class="fa fa-user fa-fw"></i> Usuários</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Filmes</h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="row">
                            <div class="col-lg-12 panel panel-default">
                                <div class="form-group col-lg-12" id="container-mensagem-manutencao-excluir" name="container-mensagem-manutencao-excluir"></div>
                                <div class="dataTable_wrapper">
                                    <div class="form-group col-lg-12" style="text-align: right;">
                                        <a href="" data-toggle="modal" data-target="#ContainerIncluir"><i class="fa fa-plus-square fa-fw" style="font-size: 32px;"></i></a>
                                    </div>
                                    <table class="table table-striped table-bordered table-hover" id="data-table-filmes">
                                        <thead>
                                            <tr>
                                                <th>Código</th>
                                                <th>Nome</th>
                                                <th>Descrição</th>
                                                <th>Ações</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                Connection conexao = Conexao.getConexao();
                                                ArrayList lista = FilmeDB.getListaFilmes(conexao);
                                                for (int i = 0; i < lista.size(); i++) {
                                                    Filme genero = (Filme) lista.get(i);
                                                    out.println("<tr class='odd gradeX'>");
                                                    out.println("<td>" + genero.getCodigo() + "</td>");
                                                    out.println("<td>" + genero.getNome() + "</td>");
                                                    out.println("<td>" + genero.getDescricao()+ "</td>");
                                                    out.println("<td style='width:80px;'>");
                                                    out.println("<a href='javascript:excluirFilme(" + genero.getCodigo() + ")'><i class='fa fa-trash fa-fw' style='font-size: 20px;'></i></a>");
                                                    out.println("<a href='javascript:chamaAlterarFilme(" + genero.getCodigo() + ", \"" + genero.getNome() + "\", \"" + genero.getDescricao()+ "\")'><i class='fa fa-file-text-o fa-fw' style='font-size: 20px;'></i></a>");
                                                    out.println("</td>");
                                                    out.println("</tr>");
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modal fade" id="ContainerIncluir" tabindex="-1" role="dialog" aria-labelledby="ContainerLabelIncluir" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="ContainerLabelIncluir">Novo Filme</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="col-lg-12" id="container-mensagem-incluir" name="container-mensagem-incluir"></div>
                                        Nome
                                        <input type="text" id="nome" name="nome" class="form-control" maxlength="100">
                                        Descrição
                                        <input type="text" id="descricao" name="descricao" class="form-control" maxlength="300">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="close-modal-genero">Cancelar</button>
                                        <button type="button" class="btn btn-primary" onclick="incluirFilme()"i>Incluir</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button href="" style="display: none;" id="container-alterar" data-toggle="modal" data-target="#ContainerAlterar">Alterar</button>
                        <div class="modal fade" id="ContainerAlterar" tabindex="-1" role="dialog" aria-labelledby="ContainerLabelAlterar" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="ContainerLabelAlterar">Alterar Filme</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="col-lg-12" id="container-mensagem-alterar" name="container-mensagem-alterar"></div>
                                        Nome
                                        <input type="text" id="nome-alterar" name="nome-alterar" class="form-control" maxlength="100">
                                        Descrição
                                        <input type="text" id="descricao-alterar" name="descricao-alterar" class="form-control" maxlength="100">
                                        <input type="hidden" id="codigo-alterar" name="codigo-alterar">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="close-modal-genero">Cancelar</button>
                                        <button type="button" class="btn btn-primary" onclick="alterarFilme()"i>Alterar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="../lib/js/jquery.min.js"></script>
            <script src="../lib/js/bootstrap.min.js"></script>
            <script src="../lib/js/metisMenu.min.js"></script>
            <script src="../lib/js/jquery.dataTables.min.js"></script>
            <script src="../lib/js/dataTables.bootstrap.min.js"></script>
            <script src="../lib/js/main.js"></script>
            <script>
                $(document).ready(function() {
                    $('#data-table-filmes').DataTable({
                        responsive: true
                    });
                });
            </script>
        </div>
    </body>
</html>