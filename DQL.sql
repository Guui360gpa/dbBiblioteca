SELECT * FROM Leitor;
SELECT * FROM Autor;
SELECT * FROM Categoria;
SELECT * FROM Livro;
SELECT * FROM Emprestimo;
SELECT * FROM LivroAutor;
SELECT * FROM ItemEmprestimo;

-- Liste Nome e Email de todos os leitores ativos (Ativo = 1), ordenados por Nome em ordem alfabética.
SELECT Nome, Email 
FROM Leitor 
WHERE Ativo = 1
ORDER BY Nome ASC;

-- Liste os livros cujo Preco esteja entre 30 e 50, incluindo os limites, do mais caro para o mais barato.
SELECT Titulo, AnoPublicacao, QuantidadeEstoque, Preco, Ativo 
FROM Livro 
WHERE Preco BETWEEN 30 and 50
ORDER BY Preco DESC;

-- Liste os títulos de livros publicados a partir do ano 1950 ou com QuantidadeEstoque maior que 10.
SELECT Titulo
FROM Livro
WHERE AnoPublicacao > 1950 OR QuantidadeEstoque > 10;

-- Liste os empréstimos cuja Situacao seja 'Atrasado' ou 'Em andamento'.
SELECT *
FROM Emprestimo
WHERE Situacao = N'Atrasado' OR Situacao = N'Em andamento';


-- Liste os leitores cujo Email seja NULL. Depois escreva uma segunda consulta para leitores com e-mail igual a texto vazio ('').
SELECT *
FROM Leitor
WHERE Email IS NULL OR Email = N'';

-- Mostre os 3 livros mais caros (TOP (3)), com uma coluna extra Faixa que mostre 'Premium' para preço >= 60 e 'Padrão' para os demais.
SELECT TOP(3) Titulo,AnoPublicacao,QuantidadeEstoque, Preco, CASE
	WHEN Preco >= 60 THEN N'Premium'
	ELSE N'Padrão'
	END AS Faixa
FROM Livro
ORDER BY Preco DESC;

-- Liste o nome do leitor, a data prevista de devolução e a data de devolução de 
-- cada empréstimo; quando a devolução ainda não ocorreu (DataDevolucao é NULL), 
-- mostre 'Sob Consulta' no lugar, usando COALESCE. Converta a data para texto 
-- antes de combinar com COALESCE, pois os tipos DATE e NVARCHAR não são compatíveis 
-- diretamente.
SELECT l.Nome, e.DataPrevistaDevolucao,COALESCE(CONVERT(NVARCHAR(10), e.DataDevolucao, 103),N'Não Devolvido') AS DataDevolucao
FROM Emprestimo e
LEFT JOIN Leitor l ON l.IdLeitor = e.IdLeitor;

-- Conte quantos livros estão ativos (Ativo = 1) usando COUNT(*).
SELECT COUNT(*) AS QntLivroAtivo
FROM Livro
WHERE Ativo = 1
GROUP BY Ativo;

-- Calcule o preço médio (AVG) e o preço total (SUM) de todos os livros em estoque.
SELECT AVG(Preco) AS PrecoMedio, SUM(QuantidadeEstoque*Preco) AS PrecoTotal
FROM Livro;

-- Escreva uma consulta com OFFSET/FETCH que mostre a "segunda página" de livros, 3 por página, ordenados por IdLivro.
SELECT *
FROM Livro
ORDER BY IdLivro 
OFFSET 3 ROWS FETCH NEXT 3 ROWS ONLY;

-- Conte quantos empréstimos existem por Situacao.
SELECT Situacao, COUNT(*) AS QuantidadeEmprestimo
FROM Emprestimo
GROUP BY Situacao;

-- Mostre apenas as situações de empréstimo que aparecem 2 vezes ou mais.
SELECT Situacao, COUNT(*) AS QuantidadeEmprestimo
FROM Emprestimo
GROUP BY Situacao
HAVING COUNT(*) >= 2;

-- Para cada leitor, mostre quantos empréstimos ele já fez — incluindo os leitores que nunca fizeram nenhum
SELECT l.Nome, COUNT(e.IdEmprestimo) AS QntEmprestimo
FROM Leitor l
LEFT JOIN Emprestimo e ON e.IdLeitor = l.IdLeitor
GROUP BY L.Nome
ORDER BY l.Nome;

-- Para cada autor, conte quantos livros ele tem cadastrados.
SELECT a.Nome, COUNT(la.IdAutor) AS	QntLivro
FROM Autor a
LEFT JOIN LivroAutor la ON la.IdAutor = a.IdAutor
GROUP BY a.Nome
ORDER BY a.Nome;

-- Liste Nome do leitor, IdEmprestimo e Situacao de todos os empréstimos, usando INNER JOIN entre Leitor e Emprestimo.
SELECT l.Nome, e.IdEmprestimo, e.Situacao
FROM Leitor l
INNER JOIN Emprestimo e ON e.IdLeitor = l.IdLeitor;

-- Liste todos os leitores e seus empréstimos (se houver), incluindo os que nunca emprestaram nada. 
-- Depois adicione WHERE Situacao = 'Devolvido'.
SELECT * 
FROM Leitor l
LEFT JOIN Emprestimo e ON e.IdLeitor = l.IdLeitor
WHERE Situacao = N'Devolvido';

-- Liste apenas os leitores que nunca fizeram nenhum empréstimo.
SELECT * 
FROM Leitor l
LEFT JOIN Emprestimo e ON e.IdLeitor = l.IdLeitor
WHERE e.IdLeitor IS NULL;

-- Para cada empréstimo, calcule o valor total somando Quantidade * Preco de todos 
-- os itens envolvidos. Relacione Leitor, Emprestimo, ItemEmprestimo e Livro em cadeia 
-- (Leitor → Emprestimo → ItemEmprestimo → Livro), já que o preço fica armazenado na 
-- tabela Livro, e não no próprio item. Agrupe por leitor e empréstimo, e ordene do 
-- valor mais caro para o mais barato.
SELECT l.Nome, e.IdEmprestimo,SUM(ie.Quantidade*li.Preco) AS TotalPrecoEmprestimo
FROM Leitor l
INNER JOIN Emprestimo e ON e.IdLeitor = l.IdLeitor
INNER JOIN ItemEmprestimo ie ON ie.IdEmprestimo = e.IdEmprestimo
INNER JOIN Livro li ON li.IdLivro = ie.IdLivro
GROUP BY l.Nome,e.IdEmprestimo
ORDER BY TotalPrecoEmprestimo DESC;

-- Liste o título de cada livro junto com o nome do(s) autor(es).
SELECT l.Titulo AS Livro, a.Nome AS Autor
FROM Livro l
INNER JOIN LivroAutor la ON la.IdLivro = l.IdLivro
INNER JOIN Autor a ON a.IdAutor = la.IdAutor
ORDER BY l.Titulo,a.Nome;

-- Liste o total emprestado (em quantidade) por livro, incluindo os livros que nunca foram emprestados.
SELECT l.Titulo, ISNULL(SUM(ie.Quantidade),0) AS TotalEmprestado
FROM LIVRO l
LEFT JOIN ItemEmprestimo ie ON ie.IdLivro = l.IdLivro
GROUP BY l.Titulo;