package controle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import modelo.Genero;

public class GeneroDB {

    public static ArrayList getListaGeneros(Connection conexao) {
        ArrayList generos = new ArrayList();
        try {
            Statement st = conexao.createStatement();
            ResultSet rs = st.executeQuery("select * from genero");
            while (rs.next()) {
                int genCodigo = rs.getInt("gencodigo");
                String genNome = rs.getString("gennome");
                Genero genero = new Genero(genCodigo, genNome);
                generos.add(genero);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL de busta de Generos: " + e.getMessage());
        } finally {
            return generos;
        }
    }

    public static Map<String, String> incluirGenero(String gennome, Connection conexao) {
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try {
            PreparedStatement ps = conexao.prepareStatement("insert into genero (gennome) values (?)");
            ps.setString(1, gennome);
            int valor = ps.executeUpdate();
            if (valor == 1) {
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Gênero incluído com sucesso");
            } else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Não foi possível incluir o gênero");
            }
        } catch (SQLException e) {
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao incluir gênero: " + e.getMessage());
        } finally {
            return resposta;
        }
    }

    public static Map<String, String> alterarGenero(Genero genero, Connection conexao) {
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try {
            PreparedStatement ps = conexao.prepareStatement("update genero set gennome = ? where gencodigo = ?");
            ps.setString(1, genero.getNome());
            ps.setInt(2, genero.getCodigo());
            int valor = ps.executeUpdate();
            if (valor == 1) {
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Gênero incluído com sucesso");
            } else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Nâo foi possível alterar o gênero");
            }
        } catch (SQLException e) {
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao alterar gênero: " + e.getMessage());
        } finally {
            return resposta;
        }
    }

    public static Map<String, String> excluirGenero(int codigo, Connection conexao) {
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try {
            PreparedStatement ps = conexao.prepareStatement("delete from genero where gencodigo = ?");
            ps.setInt(1, codigo);
            int valor = ps.executeUpdate();
            if (valor == 1) {
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Gênero excluído com sucesso");
            } else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Nâo foi possível excluir o gênero");
            }
        } catch (SQLException e) {
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao excluir gênero: " + e.getMessage());
        } finally {
            return resposta;
        }
    }
}
