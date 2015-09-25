package controle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import modelo.Usuario;

public class UsuarioDB {
    
    public static ArrayList getListaUsuarios(Connection conexao){
        ArrayList usuarios = new ArrayList();
        try{
            Statement st = conexao.createStatement();
            ResultSet rs = st.executeQuery("select * from usuario");
            while(rs.next()){
                int genCodigo = rs.getInt("usucodigo");
                String genNome = rs.getString("usunome");
                Usuario usuario = new Usuario(genCodigo, genNome);
                usuarios.add(usuario);
            }
        }
        catch(SQLException e){
            System.out.println("Erro de SQL de busta de Usuarios: "+e.getMessage());
        }
        finally{
            return usuarios;
        }
    }
    
    public static Map<String, String> incluirUsuario(String usunome, Connection conexao){
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try {
            PreparedStatement ps = conexao.prepareStatement("insert into usuario (usunome) values (?)");
            ps.setString(1, usunome);
            int valor  = ps.executeUpdate();
            if(valor == 1){
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Usuário incluído com sucesso");
            }
            else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Não foi possível incluir o usuário");
            }
        }
        catch(SQLException e) {
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao incluir usuário: "+e.getMessage());
        }
        finally{
            return resposta;
        }
    }
    
    public static Map<String, String> alterarUsuario(Usuario usuario, Connection conexao){
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try{
            PreparedStatement ps = conexao.prepareStatement("update usuario set usunome = ? where usucodigo = ?");
            ps.setString(1, usuario.getNome());
            ps.setInt(2, usuario.getCodigo());
            int valor = ps.executeUpdate();
            if(valor == 1){
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Usuário incluído com sucesso");
            }
            else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Nâo foi possível alterar o usuário");
            }
        }
        catch(SQLException e){
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao alterar usuário: " + e.getMessage());
        }
        finally{
            return resposta;
        }
    }
    
    public static Map<String, String> excluirUsuario(int codigo, Connection conexao){
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try{
            PreparedStatement ps = conexao.prepareStatement("delete from usuario where usucodigo = ?");
            ps.setInt(1, codigo);
            int valor = ps.executeUpdate();
            if(valor == 1){
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Usuário excluído com sucesso");
            }
            else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Nâo foi possível excluir o usuário");
            }
        }
        catch(SQLException e){
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao excluir usuário: " + e.getMessage());
        }
        finally{
            return resposta;
        }
    }
}