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
import modelo.Locacao;
import modelo.Usuario;

public class LocacaoDB {

    public static ArrayList getListaLocacoes(Connection conexao) {
        ArrayList locacaos = new ArrayList();
        try {
            Statement st = conexao.createStatement();
            ResultSet rs = st.executeQuery("select * from locacao join usuario on usuario.usucodigo = locacao.usucodigo join filme on filme.filcodigo = locacao.filcodigo");
            while (rs.next()) {
                int loccodigo = rs.getInt("loccodigo");
                Usuario usuario = new Usuario(rs.getInt("usucodigo"), rs.getString("usunome"));
                Filme filme = new Filme(rs.getInt("filcodigo"), rs.getString("filnome"), rs.getString("fildescricao"));
                String locdata = rs.getString("locdata");
                float locvalor = rs.getFloat("locvalor");
                Locacao locacao = new Locacao(loccodigo, filme, usuario, locvalor, locdata);
                locacaos.add(locacao);
            }
        } catch (SQLException e) {
            System.out.println("Erro de SQL de busta de Locacaos: " + e.getMessage());
        } finally {
            return locacaos;
        }
    }

    public static Map<String, String> incluirLocacao(Locacao locacao, Connection conexao) {
        Map<String, String> resposta = new LinkedHashMap<String, String>();
        try {
            PreparedStatement ps = conexao.prepareStatement("insert into locacao (usucodigo, filcodigo, locvalor) values (?, ?, ?)");
            ps.setInt(1, locacao.getUsuario().getCodigo());
            ps.setInt(2, locacao.getFilme().getCodigo());
            ps.setFloat(3, locacao.getValor());
            int valor = ps.executeUpdate();
            if (valor == 1) {
                resposta.put("retorno", "ok");
                resposta.put("mensagem", "Locacao incluída com sucesso");
            } else {
                resposta.put("retorno", "erro");
                resposta.put("mensagem", "Não foi possível incluir a locacao");
            }
        } catch (SQLException e) {
            resposta.put("retorno", "erro");
            resposta.put("mensagem", "Erro ao incluir locacao: " + e.getMessage());
        } finally {
            return resposta;
        }
    }
}
