<%@page import="modelo.Locacao"%>
<%@page import="controle.LocacaoDB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controle.Conexao"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
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
            function incluirLocacao(){
                try {
                    $.ajax({
                        async    : false,
                        data     : {
                            requisicao : "incluir",
                            usuario    : $("#usuario").val(),
                            filme      : $("#filme").val(),
                            valor      : $("#valor").val()
                        },
                        type     : "GET",
                        url      : 'manutencao/manutencaolocacoes.jsp',
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
                                <a href="#"><i class="fa fa-user fa-fw"></i>Perfil de usuário</a>
                            </li>
                            <li>
                                <a href="mensagem.jsp"><i class="fa fa-envelope fa-fw"></i> Mensagens</a>
                            </li>
                            <li>
                                <a href="chamaRelatorioLocacao.jsp"><i class="fa fa-envelope fa-fw"></i> Relatorio Locacao</a>
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
                        <h1 class="page-header">Locações</h1>
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
                                    <table class="table table-striped table-bordered table-hover" id="data-table-locacaos">
                                        <thead>
                                            <tr>
                                                <th>Código</th>
                                                <th>Filme</th>
                                                <th>Usuario</th>
                                                <th>Valor</th>
                                                <th>Data</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                Connection conexao = Conexao.getConexao();
                                                ArrayList lista = LocacaoDB.getListaLocacoes(conexao);
                                                for (int i = 0; i < lista.size(); i++) {
                                                    Locacao locacao = (Locacao) lista.get(i);
                                                    out.println("<tr class='odd gradeX'>");
                                                    out.println("<td>" + locacao.getCodigolocacao() + "</td>");
                                                    out.println("<td>" + locacao.getFilme().getNome()+ "</td>");
                                                    out.println("<td>" + locacao.getUsuario().getNome() + "</td>");
                                                    out.println("<td>" + locacao.getValor() + "</td>");
                                                    out.println("<td>" + locacao.getData() + "</td>");
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
                                        <h4 class="modal-title" id="ContainerLabelIncluir">Nova Locação</h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="col-lg-12" id="container-mensagem-manutencao" name="container-mensagem-incluir"></div>
                                        Código Usuário
                                        <input type="text" id="usuario" name="usuario" class="form-control" maxlength="100">
                                        Código Filme
                                        <input type="text" id="filme" name="filme" class="form-control" maxlength="100">
                                        Valor Locação
                                        <input type="text" id="valor" name="valor" class="form-control" maxlength="100">
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-primary" data-dismiss="modal" id="close-modal-locacao">Cancelar</button>
                                        <button type="button" class="btn btn-primary" onclick="incluirLocacao()"i>Incluir</button>
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
                    $('#data-table-locacaos').DataTable({
                        responsive: true
                    });
                });
            </script>
        </div>
    </body>
</html>