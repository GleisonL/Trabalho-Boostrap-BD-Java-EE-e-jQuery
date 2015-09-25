<%@page import="modelo.Usuario"%>
<%@page import="modelo.Filme"%>
<%@page import="modelo.Locacao"%>
<%@page import="controle.LocacaoDB"%>
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
    response.setCharacterEncoding("utf-8"); 
    Map<String, String> resposta = new LinkedHashMap<String, String>();
    
    String requisicao = request.getParameter("requisicao");
    if(requisicao.equals("incluir")) {
        int filme   = Integer.valueOf(request.getParameter("filme"));
        int usuario = Integer.valueOf(request.getParameter("usuario"));
        float valor = Float.valueOf(request.getParameter("valor"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = LocacaoDB.incluirLocacao(new Locacao(new Filme(filme, "", ""), new Usuario(usuario, ""), valor), conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    String json = new Gson().toJson(resposta);
    response.getWriter().write(json);
%>