<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="controle.GeneroDB"%>
<%@page import="modelo.Genero"%>
<%@page import="controle.Conexao"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("application/json"); 
    response.setCharacterEncoding("UTF-8"); 
    Map<String, String> resposta = new LinkedHashMap<String, String>();
    
    String requisicao = request.getParameter("requisicao");
    if(requisicao.equals("excluir")) {
        int codigo = Integer.valueOf(request.getParameter("gencodigo"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = GeneroDB.excluirGenero(codigo, conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    else if(requisicao.equals("incluir")) {
        String gennome = String.valueOf(request.getParameter("gennome"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = GeneroDB.incluirGenero(gennome, conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    else if(requisicao.equals("alterar")) {
        int gencodigo = Integer.valueOf(request.getParameter("gencodigo"));
        String gennome = String.valueOf(request.getParameter("gennome"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = GeneroDB.alterarGenero(new Genero(gencodigo, gennome), conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    String json = new Gson().toJson(resposta);
    response.getWriter().write(json);
%>