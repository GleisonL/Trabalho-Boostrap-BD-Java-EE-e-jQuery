/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package view;

import controle.Conexao;
import java.sql.Connection;

/**
 *
 * @author Gleison
 */
public class TestaConexao {

    public static void main(String[] args) {
        Connection conexao = Conexao.getConexao();
        Conexao.fechaConexao(conexao);
        System.out.println("Conectado com Sucesso!");
    }
}
