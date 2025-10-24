-- Arquivo: sql/schema.sql

CREATE TABLE usuario (
    id_user SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    tel VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE loja (
    id_loja SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    cnpj VARCHAR(18) UNIQUE,
    endereco VARCHAR(255),
    tel VARCHAR(20),
    email VARCHAR(100),
    id_user INTEGER NOT NULL,
    FOREIGN KEY (id_user) REFERENCES usuario (id_user) ON DELETE NO ACTION
);

CREATE TABLE equipamentos (
    id_equip SERIAL PRIMARY KEY,
    produto VARCHAR(100) NOT NULL,
    data_da_compra DATE NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    n_de_serie VARCHAR(100) UNIQUE,
    preco NUMERIC(10,2) CHECK (preco >= 0),
    id_loja INTEGER NOT NULL,
    id_user INTEGER NOT NULL,
    FOREIGN KEY (id_loja) REFERENCES loja (id_loja) ON DELETE NO ACTION,
    FOREIGN KEY (id_user) REFERENCES usuario (id_user) ON DELETE NO ACTION
);

CREATE TABLE garantia (
    id_garantia SERIAL PRIMARY KEY,
    inicio DATE NOT NULL,
    fim DATE NOT NULL,
    tipo_garantia VARCHAR(50),
    id_loja INTEGER NOT NULL,
    id_equip INTEGER NOT NULL,
    CHECK (fim >= inicio),
    FOREIGN KEY (id_loja) REFERENCES loja (id_loja) ON DELETE NO ACTION,
    FOREIGN KEY (id_equip) REFERENCES equipamentos (id_equip) ON DELETE CASCADE
);

CREATE TABLE documento (
    id_doc SERIAL PRIMARY KEY,
    url_doc VARCHAR(255) NOT NULL,
    tipo_doc VARCHAR(50),
    num_doc VARCHAR(100) UNIQUE,
    data_emissao DATE,
    id_loja INTEGER,
    id_user INTEGER,
    id_equip INTEGER,
    id_garantia INTEGER,
    FOREIGN KEY (id_loja) REFERENCES loja (id_loja) ON DELETE SET NULL,
    FOREIGN KEY (id_user) REFERENCES usuario (id_user) ON DELETE SET NULL,
    FOREIGN KEY (id_equip) REFERENCES equipamentos (id_equip) ON DELETE SET NULL,
    FOREIGN KEY (id_garantia) REFERENCES garantia (id_garantia) ON DELETE SET NULL
);
