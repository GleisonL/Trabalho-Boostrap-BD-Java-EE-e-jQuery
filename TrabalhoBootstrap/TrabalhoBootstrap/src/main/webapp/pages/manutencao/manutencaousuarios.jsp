<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="controle.UsuarioDB"%>
<%@page import="modelo.Usuario"%>
<%@page import="controle.Conexao"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("application/json"); 
    response.setCharacterEncoding("UTF-8"); 
    Map<String, String> resposta = new LinkedHashMap<String, String>();
    
    String requisicao = request.getParameter("requisicao");
    if(requisicao.equals("excluir")) {
        int codigo = Integer.valueOf(request.getParameter("usucodigo"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = UsuarioDB.excluirUsuario(codigo, conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    else if(requisicao.equals("incluir")) {
        String usunome = String.valueOf(request.getParameter("usunome"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = UsuarioDB.incluirUsuario(usunome, conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    else if(requisicao.equals("alterar")) {
        int usucodigo = Integer.valueOf(request.getParameter("usucodigo"));
        String usunome = String.valueOf(request.getParameter("usunome"));
        Connection conexao = Conexao.getConexao();
        Map<String, String> retorno = UsuarioDB.alterarUsuario(new Usuario(usucodigo, usunome), conexao);
        resposta.put("resposta", retorno.get("mensagem"));
        resposta.put("erro",     retorno.get("retorno"));
    }
    String json = new Gson().toJson(resposta);
    response.getWriter().write(json);
%>