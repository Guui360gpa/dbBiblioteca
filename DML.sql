INSERT INTO Leitor(Nome, Email, DataCadastro, Ativo) VALUES
('Ana Beatriz Souza', 'ana.souza@email.com', '2024-01-15', 1),
('Carlos Eduardo Lima', 'carlos.lima@email.com', '2024-02-20', 1),
('Fernanda Oliveira', 'fernanda.oliveira@email.com', '2024-03-05', 1),
('João Pedro Santos', 'joao.santos@email.com', '2024-04-10', 0),
('Mariana Costa', 'mariana.costa@email.com', '2024-05-22', 1),
('Ricardo Almeida', 'ricardo.almeida@email.com', '2024-06-18', 1);

INSERT INTO Livro (Titulo, AnoPublicacao, QuantidadeEstoque, Preco, Ativo) VALUES
('Dom Casmurro', 1899, 10, 39.90, 1),
('O Cortiço', 1890, 5, 34.50, 1),
('Capitães da Areia', 1937, 8, 42.00, 1),
('1984', 1949, 12, 55.90, 1),
('O Senhor dos Anéis', 1954, 6, 89.90, 1),
('A Revolução dos Bichos', 1945, 15, 29.90, 1),
('Memórias Póstumas de Brás Cubas', 1881, 4, 37.00, 1),
('Harry Potter e a Pedra Filosofal', 1997, 20, 49.90, 1);

INSERT INTO Categoria (Nome) VALUES
('Romance'),
('Ficção Científica'),
('Fantasia'),
('Distopia'),
('Literatura Brasileira'),
('Infantojuvenil');

INSERT INTO Autor (Nome, Nacionalidade) VALUES
('Machado de Assis', 'Brasileira'),
('Aluísio Azevedo', 'Brasileira'),
('Jorge Amado', 'Brasileira'),
('George Orwell', 'Britânica'),
('J.R.R. Tolkien', 'Britânica'),
('J.K. Rowling', 'Britânica');

INSERT INTO LivroAutor (IdLivro, IdAutor) VALUES
(1, 1), 
(7, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(6, 4), 
(5, 5),
(8, 6); 

INSERT INTO LivroCategoria (IdLivro, IdCategoria) VALUES
(1, 1), (1, 5),
(2, 5),
(3, 5), (3, 1),
(4, 2), (4, 4),
(5, 3),
(6, 4), (6, 2),
(7, 1), (7, 5),
(8, 3), (8, 6);

INSERT INTO Emprestimo (IdLeitor, DataEmprestimo, DataPrevistaDevolucao, DataDevolucao, Situacao) VALUES
(1, '2026-08-01', '2026-08-15', '2026-08-14', 'Devolvido'),
(2, '2026-08-05', '2026-08-19', NULL, 'Em andamento'),
(3, '2026-08-10', '2026-08-24', '2026-08-25', 'Devolvido com atraso'),
(4, '2026-08-12', '2026-08-26', NULL, 'Atrasado'),
(5, '2026-09-01', '2026-09-15', '2026-09-13', 'Devolvido'),
(1, '2026-09-10', '2026-09-24', NULL, 'Em andamento');


INSERT INTO ItemEmprestimo (IdEmprestimo, IdLivro, Quantidade) VALUES
(1, 1, 1),
(1, 4, 1),
(2, 5, 1),
(3, 2, 1),
(3, 7, 1),
(4, 8, 1),
(5, 3, 1),
(5, 6, 1),
(6, 1, 1),
(6, 8, 2);