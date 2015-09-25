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
 * @author Patrick
 */
public class Conexao {
    private static final String servidor = "localhost";
    private static final String banco = "postgres";
    private static final String usuario = "postgres";
    private static final String senha = "admin";
    private static final String porta = "5432";
    private static final String url = "jdbc:postgresql://"+servidor+":"+porta+"/"+banco;
    private static final String driver = "org.postgresql.Driver";
    //private static String driver = "com.mysql.jdbc.Driver";
    
    public static Connection getConexao(){
        Connection conexao = null;
        try{
            Class.forName(driver);
            conexao = DriverManager.getConnection(url, usuario, senha);
        }
        catch(SQLException e){
            System.out.println("Erro de conexão: " + e.getMessage());
        }
        catch(ClassNotFoundException e){
            System.out.println("Erro de driver: " + e.getMessage());
        }
        finally{
            return conexao;
        }
    } 
    
    public static void fechaConexao(Connection conexao){
        if(conexao != null){
            try{
                conexao.close();
            }
            catch(SQLException e){
                System.out.println("Erro ao fechar a conexão: "+e.getMessage());
            }
        }
    }
    
}
