<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="controle.FilmeDB"%>
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
        int codigo = Integer.valueOf(request.getParameter("filcodigo"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = FilmeDB.excluirFilme(codigo, conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    else if(requisicao.equals("incluir")) {
        String filnome = String.valueOf(request.getParameter("filnome"));
        String fildesc = String.valueOf(request.getParameter("fildescricao"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = FilmeDB.incluirFilme(new Filme(filnome, fildesc), conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    else if(requisicao.equals("alterar")) {
        int filcodigo = Integer.valueOf(request.getParameter("filcodigo"));
        String filnome = String.valueOf(request.getParameter("filnome"));
        String fildesc = String.valueOf(request.getParameter("fildescricao"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = FilmeDB.alterarFilme(new Filme(filcodigo, filnome, fildesc), conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    String json = new Gson().toJson(resposta);
    response.getWriter().write(json);
%>