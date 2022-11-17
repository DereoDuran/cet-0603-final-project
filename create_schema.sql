DROP TABLE IF EXISTS Preco_Materiais;

DROP TABLE IF EXISTS Produto_Materiais;

DROP TABLE IF EXISTS Fornecedores;

DROP TABLE IF EXISTS Enderecos;

DROP TABLE IF EXISTS Compras;

DROP TABLE IF EXISTS Estoque_Materiais;

DROP TABLE IF EXISTS Estoque_Produtos;

DROP TABLE IF EXISTS Materiais;

DROP TABLE IF EXISTS Compradores;

DROP TABLE IF EXISTS Produtos;

DROP TABLE IF EXISTS Telefones;

CREATE TABLE Telefones (
  id_telefone INT AUTO_INCREMENT PRIMARY KEY,
  ddd VARCHAR(2),
  numero VARCHAR(9)
);

CREATE TABLE Enderecos (
  id_endereco INTEGER AUTO_INCREMENT PRIMARY KEY,
  rua VARCHAR(255),
  numero VARCHAR(10),
  complemento VARCHAR(255),
  bairro VARCHAR(255),
  cidade VARCHAR(255),
  estado VARCHAR(2),
  cep VARCHAR(8)
);

CREATE TABLE Fornecedores (
  id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
  id_telefone INT,
  id_endereco INT,
  nome_fantasia VARCHAR(100),
  razao_social VARCHAR(100),
  cnpj VARCHAR(14),
  FOREIGN KEY (id_telefone) REFERENCES Telefones(id_telefone),
  FOREIGN KEY (id_endereco) REFERENCES Enderecos(id_endereco)
);

CREATE TABLE Materiais (
  id_material INTEGER AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255),
  descricao VARCHAR(255),
  uom VARCHAR(255)
);

CREATE TABLE Preco_Materiais (
  id_material INTEGER,
  id_fornecedor INTEGER,
  preco FLOAT,
  PRIMARY KEY (id_material, id_fornecedor),
  FOREIGN KEY (id_material) REFERENCES Materiais(id_material),
  FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
);

CREATE TABLE Compradores (
  id_comprador INTEGER AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE Compras (
    id_compra INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_comprador INTEGER,
    id_fornecedor INTEGER,
    id_material INTEGER,
    quantidade INTEGER,
    valor_unitario DECIMAL(10,2),
    data_compra DATE,
    FOREIGN KEY (id_comprador) REFERENCES Compradores(id_comprador),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor),
    FOREIGN KEY (id_material) REFERENCES Materiais(id_material)
);

CREATE TABLE Produtos (
    id_produto INTEGER AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(255),
    descricao VARCHAR(255),
    valor_unitario DECIMAL(10,2)
);

CREATE TABLE Produto_Materiais (
    id_produto INTEGER,
    id_material INTEGER,
    quantidade INTEGER,
    PRIMARY KEY (id_produto, id_material),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto),
    FOREIGN KEY (id_material) REFERENCES Materiais(id_material)
);

CREATE TABLE Estoque_Materiais (
    id_estoque INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_material INTEGER,
    quantidade INTEGER,
    local VARCHAR(255),
    FOREIGN KEY (id_material) REFERENCES Materiais(id_material)
);

CREATE TABLE Estoque_Produtos (
    id_estoque INTEGER AUTO_INCREMENT PRIMARY KEY,
    id_produto INTEGER,
    quantidade INTEGER,
    local VARCHAR(255),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);