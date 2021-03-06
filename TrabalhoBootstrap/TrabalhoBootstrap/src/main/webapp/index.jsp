<%-- 
    Document   : index
    Created on : 30/09/2015, 19:41:33
    Author     : Patrick
--%>

<%@page import="modelo.Recado"%>
<%@page import="controle.RecadoDB"%>
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

        <link href="lib/css/bootstrap.min.css" rel="stylesheet">
        <link href="lib/css/main.css" rel="stylesheet">
        <link href="lib/css/metisMenu.min.css" rel="stylesheet">
        <link href="lib/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    </head>

    <body>
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
                                <a href="pages/mensagem.jsp"><i class="fa fa-envelope fa-fw"></i> Mensagens</a>
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
                                <a href="index.jsp"><i class="fa fa-home fa-fw"></i> Home</a>
                            </li>
                            <li>
                                <a href="#"><i class="fa fa-tasks fa-fw"></i> Filme<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="pages/generos.jsp"><i class="fa fa-edit fa-fw"></i> Gêneros</a>
                                    </li>
                                    <li>
                                        <a href="pages/filmes.jsp"><i class="fa fa-folder-open fa-fw"></i> Filmes</a>
                                    </li>
                                </ul>
                            </li>                     
                            <li>
                                <a href="#"><i class="fa fa-shopping-cart fa-fw"></i> Locadora<span class="fa arrow"></span></a>
                                <ul class="nav nav-second-level">
                                    <li>
                                        <a href="pages/locacoes.jsp"><i class="fa fa-briefcase fa-fw"></i> Locações</a>
                                    </li>
                                    <li>
                                        <a href="pages/usuarios.jsp"><i class="fa fa-user fa-fw"></i> Usuários</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <br>
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Estatísticas</h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <i class="fa fa-envelope-o fa-fw"></i> Mensagem
                            </div>
                            <div class="panel-body">
                                <ul class="chat">
                                    <%
                                                Connection conexao = Conexao.getConexao();
                                                ArrayList lista = RecadoDB.getListaRecados(conexao);
                                                int indice = 0;
                                                if (lista.size() > 5) {
                                                     indice = 5;
                                                }
                                                else{
                                                     indice = lista.size();
                                                }
                                                for (int i = 0; i < indice; i++) {
                                                    Recado recado = (Recado) lista.get(i);%>
                                                    <li class="left clearfix">
                                                        <div class="header">
                                                            <strong class="primary-font"><% out.println(recado.getTitulo()); %></strong>
                                                            <small class="pull-right text-muted">
                                                                <i class="fa fa-clock-o fa-fw"></i> 1 hora atrás
                                                            </small>
                                                        </div>
                                                        <p>
                                                           <% out.println(recado.getTexto()); %>
                                                        </p>
                                                    </li>
                                          <%      }
                                            %>
                                </ul>
                                 <a href="pages/mensagem.jsp" class="btn btn-default btn-block">Ver mais</a>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>

            <script src="lib/js/jquery.min.js"></script>
            <script src="lib/js/bootstrap.min.js"></script>
            <script src="lib/js/metisMenu.min.js"></script>
            <script src="lib/js/main.js"></script>
        </div>
    </body>
</html>