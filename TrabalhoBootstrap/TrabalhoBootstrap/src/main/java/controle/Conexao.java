/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Gleison
 */
public class Conexao {

    private static final String servidor = "localhost";
    private static final String banco = "locadora";
    private static final String usuario = "root";
    private static final String senha = "";
    private static final String porta = "3306";
    private static final String url = "jdbc:mysql://" + servidor + ":" + porta + "/" + banco;
    private static final String driver = "com.mysql.jdbc.Driver";
    //private static final String url = "jdbc:postgresql://"+servidor+":"+porta+"/"+banco;
    //private static final String driver = "org.postgresql.Driver";

    public static Connection getConexao() {
        Connection conexao = null;
        try {
            Class.forName(driver);
            conexao = DriverManager.getConnection(url, usuario, senha);
        } catch (SQLException e) {
            System.out.println("Erro de conexão: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            System.out.println("Erro de driver: " + e.getMessage());
        } finally {
            return conexao;
        }
    }

    public static void fechaConexao(Connection conexao) {
        if (conexao != null) {
            try {
                conexao.close();
            } catch (SQLException e) {
                System.out.println("Erro ao fechar a conexão: " + e.getMessage());
            }
        }
    }

}
