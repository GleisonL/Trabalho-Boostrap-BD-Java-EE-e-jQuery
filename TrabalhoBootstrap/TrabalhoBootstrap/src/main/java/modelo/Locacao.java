package modelo;

public class Locacao {
    protected int codigolocacao;
    protected Filme filme;
    protected Usuario usuario;
    protected float valor;
    protected String data;

    public Locacao(int codigolocacao, Filme filme, Usuario usuario, float valor, String data) {
        this.codigolocacao = codigolocacao;
        this.filme = filme;
        this.usuario = usuario;
        this.valor = valor;
        this.data = data;
    }

    public Locacao(Filme filme, Usuario usuario, float valor) {
        this.filme = filme;
        this.usuario = usuario;
        this.valor = valor;
    }
    
    public int getCodigolocacao() {
        return codigolocacao;
    }

    public void setCodigolocacao(int codigolocacao) {
        this.codigolocacao = codigolocacao;
    }

    public Filme getFilme() {
        return filme;
    }

    public void setFilme(Filme filme) {
        this.filme = filme;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public float getValor() {
        return valor;
    }

    public void setValor(float valor) {
        this.valor = valor;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}