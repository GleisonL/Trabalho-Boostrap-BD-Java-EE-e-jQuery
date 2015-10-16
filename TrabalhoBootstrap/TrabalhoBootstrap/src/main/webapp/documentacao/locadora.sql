
CREATE TABLE public.Recados (
                codigo INTEGER NOT NULL,
                titulo VARCHAR,
                texto VARCHAR,
                CONSTRAINT recados_pk PRIMARY KEY (codigo)
);


CREATE SEQUENCE public.usuario_usucodigo_seq_1;

CREATE TABLE public.usuario (
                usucodigo BIGINT NOT NULL DEFAULT nextval('public.usuario_usucodigo_seq_1'),
                usunome VARCHAR,
                CONSTRAINT usuario_pk PRIMARY KEY (usucodigo)
);


ALTER SEQUENCE public.usuario_usucodigo_seq_1 OWNED BY public.usuario.usucodigo;

CREATE SEQUENCE public.filme_filcodigo_seq;

CREATE TABLE public.filme (
                filcodigo BIGINT NOT NULL DEFAULT nextval('public.filme_filcodigo_seq'),
                filnome VARCHAR,
                fildescricao VARCHAR,
                CONSTRAINT filme_pk PRIMARY KEY (filcodigo)
);


ALTER SEQUENCE public.filme_filcodigo_seq OWNED BY public.filme.filcodigo;

CREATE SEQUENCE public.locacao_loccodigo_seq;

CREATE TABLE public.locacao (
                loccodigo BIGINT NOT NULL DEFAULT nextval('public.locacao_loccodigo_seq'),
                usucodigo BIGINT NOT NULL,
                filcodigo BIGINT NOT NULL,
                locdata DATE DEFAULT now() NOT NULL,
                locvalor NUMERIC(15,2) NOT NULL,
                CONSTRAINT locacao_pk PRIMARY KEY (loccodigo, usucodigo, filcodigo)
);


ALTER SEQUENCE public.locacao_loccodigo_seq OWNED BY public.locacao.loccodigo;

CREATE SEQUENCE public.genero_gencodigo_seq;

CREATE TABLE public.genero (
                gencodigo BIGINT NOT NULL DEFAULT nextval('public.genero_gencodigo_seq'),
                gennome VARCHAR,
                CONSTRAINT genero_pk PRIMARY KEY (gencodigo)
);


ALTER SEQUENCE public.genero_gencodigo_seq OWNED BY public.genero.gencodigo;

ALTER TABLE public.locacao ADD CONSTRAINT usuario_locacao_fk
FOREIGN KEY (usucodigo)
REFERENCES public.usuario (usucodigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.locacao ADD CONSTRAINT filme_locacao_fk
FOREIGN KEY (filcodigo)
REFERENCES public.filme (filcodigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
