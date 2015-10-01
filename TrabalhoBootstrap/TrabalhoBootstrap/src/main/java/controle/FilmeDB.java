package controle;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;
import modelo.Filme;

public class FilmeDB {

    public static ArrayList getListaFilmes(Connection conexao) {
        ArrayList filmes = new ArrayList();
        try {
            Statement st = conexao.createStatement();
            ResultSet rs = st.executeQuery("select * from filme");
            while (rs.next()) {
                int filCodigo = rs.getInt("filcodigo");
                String filNome = rs.getString("filnome");
                String filDescricao = rs.getString("fildescricao");
                Filme filme = new Filme(filCodigo, filNome, filDescricao);
                filmes.add(filme);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL de busta de Filmes: " + e.getMessage());
        } finally {
            return filmes;
        }
    }

    public static Map<String, String> incluirFilme(Filme filme, Connection conexao) {
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try {
            PreparedStatement ps = conexao.prepareStatement("insert into filme (filnome, fildescricao) values (?, ?)");
            ps.setString(1, filme.getNome());
            ps.setString(2, filme.getDescricao());
            int valor = ps.executeUpdate();
            if (valor == 1) {
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Filme incluído com sucesso");
            } else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Não foi possível incluir o filme");
            }
        } catch (SQLException e) {
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao incluir filme: " + e.getMessage());
        } finally {
            return resposta;
        }
    }

    public static Map<String, String> alterarFilme(Filme filme, Connection conexao) {
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try {
            PreparedStatement ps = conexao.prepareStatement("update filme set filnome = ?, fildescricao = ? where filcodigo = ?");
            ps.setString(1, filme.getNome());
            ps.setString(2, filme.getDescricao());
            ps.setInt(3, filme.getCodigo());
            int valor = ps.executeUpdate();
            if (valor == 1) {
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Filme alterado com sucesso");
            } else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Nâo foi possível alterar o Filme");
            }
        } catch (SQLException e) {
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao alterar Filme: " + e.getMessage());
        } finally {
            return resposta;
        }
    }

    public static Map<String, String> excluirFilme(int codigo, Connection conexao) {
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try {
            PreparedStatement ps = conexao.prepareStatement("delete from filme where filcodigo = ?");
            ps.setInt(1, codigo);
            int valor = ps.executeUpdate();
            if (valor == 1) {
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Filme excluído com sucesso");
            } else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Nâo foi possível excluir o Filme");
            }
        } catch (SQLException e) {
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao excluir Filme: " + e.getMessage());
        } finally {
            return resposta;
        }
    }
}
