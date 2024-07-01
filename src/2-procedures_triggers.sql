DELIMITER $$

CREATE PROCEDURE inserir_imovel (
  IN p_cliente_usuario_id INTEGER,
  p_estado VARCHAR(2),
  p_cidade VARCHAR(50),
  p_bairro VARCHAR(50),
  p_rua VARCHAR(50),
  p_numero INTEGER,
  p_data_construcao DATE,
  p_modalidade VARCHAR(20),
  p_disponivel BOOL,
  p_valor DECIMAL,
  OUT imovel_id INTEGER
)
BEGIN
  INSERT INTO imovel (
    cliente_usuario_id,
    estado,
    cidade,
    bairro,
    rua,
    numero,
    data_construcao,
    modalidade,
    disponivel,
    valor
  ) VALUES (
    p_cliente_usuario_id,
    p_estado,
    p_cidade,
    p_bairro,
    p_rua,
    p_numero,
    p_data_construcao,
    p_modalidade,
    p_disponivel,
    p_valor
  );

  SET imovel_id = LAST_INSERT_ID();
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE inserir_apartamento (
  IN p_cliente_usuario_id INTEGER,
  p_estado VARCHAR(2),
  p_cidade VARCHAR(50),
  p_bairro VARCHAR(50),
  p_rua VARCHAR(50),
  p_numero INTEGER,
  p_data_construcao DATE,
  p_modalidade VARCHAR(20),
  p_disponivel BOOL,
  p_valor DECIMAL,
  p_quantidade_quarto INTEGER,
  p_quantidade_suite INTEGER,
  p_quantidade_sala_estar INTEGER,
  p_quantidade_sala_jantar INTEGER,
  p_numero_vaga_garagem INTEGER,
  p_area INTEGER,
  p_armario_embutido BOOL,
  p_descricao VARCHAR(512),
  p_andar INTEGER,
  p_valor_condominio DECIMAL,
  p_portaria_dia_todo BOOL
)
BEGIN
  CALL inserir_imovel(
    p_cliente_usuario_id,
    p_estado,
    p_cidade,
    p_bairro,
    p_rua,
    p_numero,
    p_data_construcao,
    p_modalidade,
    p_disponivel,
    p_valor,
    @imovel_id
  );

  INSERT INTO imovel_apartamento (
    imovel_id,
    quantidade_quarto,
    quantidade_suite,
    quantidade_sala_estar,
    quantidade_sala_jantar,
    numero_vaga_garagem,
    area,
    armario_embutido,
    descricao,
    andar,
    valor_condominio,
    portaria_dia_todo
  ) VALUES (
    @imovel_id,
    p_quantidade_quarto,
    p_quantidade_suite,
    p_quantidade_sala_estar,
    p_quantidade_sala_jantar,
    p_numero_vaga_garagem,
    p_area,
    p_armario_embutido,
    p_descricao,
    p_andar,
    p_valor_condominio,
    p_portaria_dia_todo
  );
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE inserir_sala_comercial (
  IN p_cliente_usuario_id INTEGER,
  p_estado VARCHAR(2),
  p_cidade VARCHAR(50),
  p_bairro VARCHAR(50),
  p_rua VARCHAR(50),
  p_numero INTEGER,
  p_data_construcao DATE,
  p_modalidade VARCHAR(20),
  p_disponivel BOOL,
  p_valor DECIMAL,
  p_quantidade_banheiro INTEGER,
  p_quantidade_comodo INTEGER,
  p_area INTEGER
)
BEGIN
  CALL inserir_imovel(
    p_cliente_usuario_id,
    p_estado,
    p_cidade,
    p_bairro,
    p_rua,
    p_numero,
    p_data_construcao,
    p_modalidade,
    p_disponivel,
    p_valor,
    @imovel_id
  );

  INSERT INTO imovel_sala_comercial (
    imovel_id,
    quantidade_banheiro,
    quantidade_comodo,
    area
  ) VALUES (
    @imovel_id,
    p_quantidade_banheiro,
    p_quantidade_comodo,
    p_area
  );
END $$

DELIMITER ;

CALL inserir_apartamento(1, "SC", "Joinville", "Fátima", "Vasco da Grama", 420, "2020-07-19", "locacao", TRUE, 700.00, 1, 1, 1, 1, 1, 53, TRUE, "Apartamento muito bonito", 2, 200.00, FALSE);
SELECT * FROM imovel_apartamento ia;

CALL inserir_sala_comercial(1, "PR", "Curitiba", "Porto Belo", "Navegantes", 69, "2023-09-11", "venda", FALSE, 950.00, 1, 2, 74);
SELECT * FROM imovel_sala_comercial isc;




DELIMITER $$

CREATE TRIGGER trigger_inserir_funcionario_comissao AFTER INSERT ON registro_alocacao
FOR EACH ROW
BEGIN
  UPDATE funcionario
  SET salario = salario + NEW.valor_comissao
  WHERE id = NEW.funcionario_id;
END $$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trigger_remover_funcionario_comissao BEFORE DELETE ON registro_alocacao
FOR EACH ROW
BEGIN
  UPDATE funcionario
  SET salario = salario - OLD.valor_comissao
  WHERE id = OLD.funcionario_id;
END $$

DELIMITER ;


SELECT * FROM funcionario;
SELECT * FROM registro_alocacao ra ;

INSERT INTO registro_alocacao (funcionario_id, imovel_id, valor_recebido, valor_recebido_imobiliaria, valor_comissao)
VALUES (1, 1, 500.00, 400.00, 100.00);

DELETE FROM registro_alocacao WHERE funcionario_id = 1 AND imovel_id = 1 AND valor_comissao = 100;

SELECT * FROM funcionario;
SELECT * FROM registro_alocacao ra ;
