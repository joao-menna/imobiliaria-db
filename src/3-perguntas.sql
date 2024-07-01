-- 1. Quantos clientes estão registrados.
SELECT COUNT() AS total_clientes FROM cliente;


-- 2. Soma o total de comissões recebidas por cada funcionário,
--    mostrando o nome do funcionário e o total de comissões.
SELECT 
  f.nome AS nome_funcionario,
  SUM(r.valor_comissao) AS total_comissoes
FROM funcionario f
INNER JOIN registro_alocacao r ON f.id = r.funcionario_id
GROUP BY f.nome;


-- 3. Conta quantos imóveis estão disponíveis para locação em cada estado.
SELECT 
  estado,
  COUNT() AS imoveis_disponiveis
FROM imovel
WHERE modalidade = 'locacao' AND disponivel = TRUE
GROUP BY estado;


-- 4. Soma o valor total dos imóveis para cada modalidade (locação ou venda).
SELECT 
  modalidade,
  SUM(valor) AS valor_total
FROM imovel
GROUP BY modalidade;


-- 5. Encontra clientes que possuem mais de um imóvel registrado.
SELECT 
  c.nome AS nome_cliente,
  COUNT(ip.imovel_id) AS quantidade_imoveis
FROM cliente c
INNER JOIN imovel_proprietario ip ON c.id = ip.cliente_proprietario_id
GROUP BY c.nome
HAVING COUNT(ip.imovel_id) > 1;


-- 6. Lista os imóveis disponíveis para locação que têm menos de 5 quartos.
SELECT 
  i.id AS imovel_id,
  i.estado,
  i.cidade,
  i.bairro,
  a.quantidade_quarto
FROM imovel i
INNER JOIN imovel_apartamento a ON i.id = a.imovel_id
WHERE i.modalidade = 'locacao' AND a.quantidade_quarto < 5;


-- 7. Encontra o imóvel com o valor máximo em cada cidade.
SELECT 
  cidade,
  MAX(valor) AS valor_maximo
FROM imovel
GROUP BY cidade;


-- 8. Conta quantos imóveis foram locados por cada funcionário.
SELECT 
  f.nome AS nome_funcionario,
  COUNT(r.id) AS quantidade_alocacoes
FROM funcionario f
JOIN registro_alocacao r ON f.id = r.funcionario_id
GROUP BY f.nome;


-- 9. Lista imóveis comerciais com menos de 3 banheiros e seus valores.
SELECT 
  i.id AS imovel_id,
  i.estado,
  i.cidade,
  i.bairro,
  s.quantidade_banheiro,
  i.valor
FROM imovel_sala_comercial s
JOIN imovel i ON s.imovel_id = i.id
WHERE s.quantidade_banheiro < 3;


-- 10. Torna um imóvel específico indisponível.
UPDATE imovel
SET disponivel = FALSE
WHERE id = 10;


-- 11. Adiciona um contato de emergência.
ALTER TABLE cliente
ADD COLUMN contato_emergencia INT;


-- 12. Modifica o input (tipo de dados) da coluna "contato_emergencia".
ALTER TABLE cliente
MODIFY COLUMN contato_emergencia varchar(50);


-- 13. Modifica o nome da coluna "contato_emergencia".
ALTER TABLE cliente
RENAME COLUMN contato_emergencia TO contato_secundario;


-- 14. Apaga o atributo "estado_civil".
ALTER TABLE cliente DROP CLOUMN contato_secundario;


-- 15. cria uma view para listar imoveis disponiveis.
CREATE VIEW view_imoveis_disponiveis AS
  SELECT
    i.id AS imovel_id,
    i.estado,
    i.cidade,
    i.bairro,
    i.rua,
    i.numero,
    i.data_construcao,
    i.modalidade,
    i.valor,
    c.nome AS nome_cliente,
    c.telefone AS telefone_cliente,
    c.email AS email_cliente
  FROM imovel i
  INNER JOIN cliente c ON i.cliente_usuario_id = c.id
  WHERE i.disponivel = TRUE;
