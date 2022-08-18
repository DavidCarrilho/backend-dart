SELECT * FROM users;

# busca somente a coluna name e email da tabela users
SELECT name, email FROM users;

# realiza a inserção de 2 users na tabela, informando os campos de name, email e senha 
INSERT INTO users (name, email, password) VALUES ('David', 'deivid@email.com', '123456');
INSERT INTO users (name, email, password) VALUES ('Joao', 'joao@email.com', '123456');

# busca todas as informações * na tabela users onde a id corresponda a 2
select * from users where id = 2;

# busca todas as informações * na tabela users onde a id corresponda a 2 OU name corresponda a XPTO
select * from users where id = 2 or name = 'XPTO';

# atualiza na tabela users a coluna name e a coluna PASSWORD com novos valores ONDE a id sejá 1
UPDATE users set name = 'Deivid Willyan', password = 'ABC123' where id = 1;

# APAGA na tabela de users onde o id seja igual a 2
DELETE from users where id = 2;

# busca todas as informações da tabela news
SELECT * FROM news;

# insete na tabela noticas informando os campos title, description e id_users os valores
insert into news (title, description, id_user) values ('Noticia XPTO', 'Se Chove a Terra Molha!!!!', 1);
insert into news (title, description, id_user) values ('Noticia Quente', 'Hoje fez 30 graus', 2);

# atualiza na tabela noticia o titlu onde a id da noticia for 1 e o id do usuario foi 1.
update news set title = 'Noticia da Chuva', description = '' where id = 1 and id_user = 1;

# busca todas as news para o usuario com id 1
select * from news where id_user = 1;

# title news, description noticia, dt atualizacao noticia, name do usuario que incluiu a noticia
SELECT
	n.title as 'title',
    n.description as 'Descricão',
    n.dt_update as 'Ultima Atualizacão',
    u.name as 'Autor'
FROM news n
INNER JOIN users u on u.id = n.id_user
WHERE u.name like 'D%';

# realiza a busca juntando as tabelas de news e usuario pelo id e ordenando pela dt atualizacao decrescente.
SELECT
	n.title as 'title',
    n.description as 'Descricão',
    n.dt_update as 'Ultima Atualizacão',
    u.name as 'Autor'
FROM news n
INNER JOIN users u on u.id = n.id_user
ORDER BY n.dt_update DESC;

# busca todas as news limitando o resultado para 2 items.
SELECT * FROM news limit 2;
