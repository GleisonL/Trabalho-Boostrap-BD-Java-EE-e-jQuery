<%@page import="modelo.Recado"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="controle.RecadoDB"%>
<%@page import="modelo.Filme"%>
<%@page import="controle.Conexao"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("application/json"); 
    response.setCharacterEncoding("utf-8"); 
    Map<String, String> resposta = new LinkedHashMap<String, String>();
    
    String requisicao = request.getParameter("requisicao");
    if(requisicao.equals("excluir")) {
        int codigo = Integer.valueOf(request.getParameter("codigo"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = RecadoDB.excluirMensagem(codigo, conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    else if(requisicao.equals("incluir")) {
        int codigo = Integer.valueOf(request.getParameter("codigo"));
        String rectitulo = String.valueOf(request.getParameter("titulo"));
        String recDesc = String.valueOf(request.getParameter("descricao"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = RecadoDB.incluirMensagem(new Recado(codigo,rectitulo, recDesc), conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    else if(requisicao.equals("alterar")) {
        int reccodigo = Integer.valueOf(request.getParameter("codigo"));
        String rectitulo = String.valueOf(request.getParameter("titulo"));
        String recDesc = String.valueOf(request.getParameter("descricao"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = RecadoDB.alterarMensagem(new Recado(reccodigo, rectitulo, recDesc), conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    String json = new Gson().toJson(resposta);
    response.getWriter().write(json);
%>