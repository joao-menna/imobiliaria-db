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
