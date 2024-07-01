DROP VIEW IF EXISTS view_demografica_clientes;
DROP VIEW IF EXISTS view_imoveis_sem_fotos;


CREATE VIEW view_demografica_clientes AS
  SELECT
    c.sexo,
    COUNT(*) AS quantidade_clientes,
    (
      SELECT CONCAT(
        (
          (SELECT COUNT(*) FROM cliente WHERE cliente.sexo = c.sexo) / (SELECT COUNT(*) AS total FROM cliente)
        ) * 100, "%"
      )
    ) AS porcentagem
FROM cliente c
GROUP BY c.sexo;


CREATE VIEW view_imoveis_sem_fotos AS
SELECT
  i.id,
  i.numero,
  COUNT(IF(imovel_foto.id IS NOT NULL, 1, NULL)) AS quantidade_fotos
FROM imovel i
LEFT JOIN imovel_foto ON i.id = imovel_foto.imovel_id
GROUP BY i.id
HAVING quantidade_fotos = 0;


SELECT * FROM view_demografica_clientes;
SELECT * FROM view_imoveis_sem_fotos;
