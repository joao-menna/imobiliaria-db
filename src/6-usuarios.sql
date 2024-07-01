CREATE USER usuario IDENTIFIED BY "123";

GRANT SELECT ON imobiliaria.view_demografica_clientes TO usuario;
GRANT INSERT, DELETE ON imobiliaria.view_imoveis_sem_fotos TO usuario;
