package controle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import modelo.Recado;

public class RecadoDB {
    
    public static ArrayList getListaRecados(Connection conexao){
        ArrayList recados = new ArrayList();
        try{
            Statement st = conexao.createStatement();
            ResultSet rs = st.executeQuery("select * from recados order by codigo desc");
            while(rs.next()){
                int recCodigo = rs.getInt("codigo");
                String recNome = rs.getString("titulo");
                String recTexto = rs.getString("texto");
                Recado recado = new Recado(recCodigo, recNome,recTexto);
                recados.add(recado);
            }
        }
        catch(SQLException e){
            System.out.println("Erro de SQL de busca de Recados: "+e.getMessage());
        }
        finally{
            return recados;
        }
    }
    
    public static Map<String, String> incluirMensagem(Recado recado, Connection conexao){
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try {
            PreparedStatement ps = conexao.prepareStatement("insert into recados (codigo,titulo,texto) values (?,?,?)");
            ps.setInt(1, recado.getCodigo());
            ps.setString(2, recado.getTitulo());
            ps.setString(3, recado.getTexto());
            int valor  = ps.executeUpdate();
            if(valor == 1){
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Recado incluído com sucesso");
            }
            else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Não foi possível incluir o Recado");
            }
        }
        catch(SQLException e) {
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao incluir Recado: "+e.getMessage());
        }
        finally{
            return resposta;
        }
    }
    
    public static Map<String, String> alterarMensagem(Recado recado, Connection conexao){
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try{
            PreparedStatement ps = conexao.prepareStatement("update recados set titulo = ?, texto = ? where codigo = ?");
            ps.setString(1, recado.getTitulo());
            ps.setString(2, recado.getTexto());
            ps.setInt(3, recado.getCodigo());
            int valor = ps.executeUpdate();
            if(valor == 1){
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Recado incluído com sucesso");
            }
            else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Nâo foi possível alterar o recados");
            }
        }
        catch(SQLException e){
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao alterar recados: " + e.getMessage());
        }
        finally{
            return resposta;
        }
    }
    
    public static Map<String, String> excluirMensagem(int codigo, Connection conexao){
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try{
            PreparedStatement ps = conexao.prepareStatement("delete from recados where codigo = ?");
            ps.setInt(1, codigo);
            int valor = ps.executeUpdate();
            if(valor == 1){
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Recado excluído com sucesso");
            }
            else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Nâo foi possível excluir o recados");
            }
        }
        catch(SQLException e){
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao excluir Recado: " + e.getMessage());
        }
        finally{
            return resposta;
        }
    }
}