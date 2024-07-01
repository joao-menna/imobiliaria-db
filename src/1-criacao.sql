DROP DATABASE IF EXISTS imobiliaria;

CREATE DATABASE IF NOT EXISTS imobiliaria;

USE imobiliaria;


CREATE TABLE cliente (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  cpf VARCHAR(15) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  telefone VARCHAR(16) NOT NULL,
  celular VARCHAR(16) NOT NULL,
  email VARCHAR(50) NOT NULL,
  sexo CHAR(1) NOT NULL,
  estado_civil VARCHAR(20) NOT NULL,
  profissao VARCHAR(100) NOT NULL
);


CREATE TABLE imovel (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  cliente_usuario_id INTEGER,
  estado VARCHAR(2) NOT NULL,
  cidade VARCHAR(50) NOT NULL,
  bairro VARCHAR(50) NOT NULL,
  rua VARCHAR(50) NOT NULL,
  numero INTEGER NOT NULL,
  data_construcao DATE NOT NULL,
  modalidade VARCHAR(20) NOT NULL DEFAULT "locacao",
  disponivel BOOL NOT NULL DEFAULT TRUE,
  valor DECIMAL NOT NULL
);


CREATE TABLE imovel_foto (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  imovel_id INTEGER NOT NULL,
  caminho_foto VARCHAR(255) NOT NULL,
  FOREIGN KEY(imovel_id) REFERENCES imovel(id)
);


CREATE TABLE imovel_apartamento (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  imovel_id INTEGER NOT NULL,
  quantidade_quarto INTEGER NOT NULL,
  quantidade_suite INTEGER NOT NULL,
  quantidade_sala_estar INTEGER NOT NULL,
  quantidade_sala_jantar INTEGER NOT NULL,
  numero_vaga_garagem INTEGER NOT NULL,
  area INTEGER NOT NULL,
  armario_embutido BOOL NOT NULL,
  descricao VARCHAR(512) NOT NULL,
  andar INTEGER NOT NULL,
  valor_condominio DECIMAL NOT NULL,
  portaria_dia_todo BOOL NOT NULL,
	FOREIGN KEY(imovel_id) REFERENCES imovel(id)
);


CREATE TABLE imovel_casa (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  imovel_id INTEGER NOT NULL,
  quantidade_quarto INTEGER NOT NULL,
  quantidade_suite INTEGER NOT NULL,
  quantidade_sala_estar INTEGER NOT NULL,
  quantidade_sala_jantar INTEGER NOT NULL,
  numero_vaga_garagem INTEGER NOT NULL,
  area INTEGER NOT NULL,
  armario_embutido BOOL NOT NULL,
  descricao VARCHAR(512) NOT NULL,
  FOREIGN KEY(imovel_id) REFERENCES imovel(id)
);


CREATE TABLE imovel_sala_comercial (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  imovel_id INTEGER NOT NULL,
  quantidade_banheiro INTEGER NOT NULL,
  quantidade_comodo INTEGER NOT NULL,
  area INTEGER NOT NULL,
  FOREIGN KEY(imovel_id) REFERENCES imovel(id)
);


CREATE TABLE imovel_terreno (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  imovel_id INTEGER NOT NULL,
  area INTEGER NOT NULL,
  largura DECIMAL NOT NULL,
  comprimento DECIMAL NOT NULL,
  desnivel BOOL NOT NULL,
  FOREIGN KEY(imovel_id) REFERENCES imovel(id)
);


CREATE TABLE imovel_proprietario (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  imovel_id INTEGER NOT NULL,
  cliente_proprietario_id INTEGER NOT NULL,
  FOREIGN KEY(imovel_id) REFERENCES imovel(id),
  FOREIGN key(cliente_proprietario_id) REFERENCES cliente(id)
);


CREATE TABLE cliente_fiador (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  cliente_id INTEGER NOT NULL,
  cliente_fiador_id INTEGER NOT NULL,
  FOREIGN KEY(cliente_id) REFERENCES cliente(id),
  FOREIGN KEY(cliente_fiador_id) REFERENCES cliente(id)
);


CREATE TABLE cliente_indicacao (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  cliente_id INTEGER NOT NULL,
  indicacao VARCHAR(255) NOT NULL,
  FOREIGN KEY(cliente_id) REFERENCES cliente(id)
);


CREATE TABLE cargo (
	id INTEGER PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	salario_base DECIMAL NOT NULL
);


CREATE TABLE funcionario (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  cpf VARCHAR(15) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  telefone VARCHAR(16) NOT NULL,
  telefone_contato VARCHAR(16) NOT NULL,
  telefone_celular VARCHAR(16) NOT NULL,
  data_ingresso DATE NOT NULL,
  salario DECIMAL NOT NULL,
  cargo_id INTEGER NOT NULL,
  FOREIGN KEY(cargo_id) REFERENCES cargo(id)
);


CREATE TABLE registro_alocacao (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  funcionario_id INTEGER NOT NULL,
  imovel_id INTEGER NOT NULL,
  valor_recebido DECIMAL NOT NULL,
  valor_recebido_imobiliaria DECIMAL NOT NULL,
  valor_comissao DECIMAL NOT NULL,
  FOREIGN KEY(funcionario_id) REFERENCES funcionario(id),
  FOREIGN KEY(imovel_id) REFERENCES imovel(id)
);
