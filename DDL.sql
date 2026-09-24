CREATE TABLE Leitor (
	IdLeitor INT IDENTITY(1,1) PRIMARY KEY,
	Nome NVARCHAR(100) NOT NULL,
	Email NVARCHAR(150) UNIQUE,
	DataCadastro DATE NOT NULL DEFAULT GETDATE(),
	Ativo BIT DEFAULT 1
);

CREATE TABLE Livro (
	IdLivro INT IDENTITY(1,1) PRIMARY KEY,
	Titulo NVARCHAR(150) NOT NULL,
	AnoPublicacao INT NOT NULL DEFAULT 2026,
	QuantidadeEstoque INT NOT NULL CHECK(QuantidadeEstoque >= 0),
	Preco DECIMAL(10,2) NOT NULL CHECK(Preco >= 0),
	Ativo BIT DEFAULT 1
);

CREATE TABLE Categoria (
	IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
	Nome NVARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE Autor (
	IdAutor INT IDENTITY(1,1) PRIMARY KEY,
	Nome NVARCHAR(100) NOT NULL,
	Nacionalidade NVARCHAR(50) NULL
);

CREATE TABLE LivroAutor (
	IdLivro INT NOT NULL,
	IdAutor INT NOT NULL,
	PRIMARY KEY(IdLivro, IdAutor),
	FOREIGN KEY (IdLivro) REFERENCES Livro(IdLivro),
	FOREIGN KEY (IdAutor) REFERENCES Autor(IdAutor)
);

CREATE TABLE LivroCategoria (
	IdLivro INT NOT NULL,
	IdCategoria INT NOT NULL,
	PRIMARY KEY(IdLivro, IdCategoria),
	FOREIGN KEY (IdLivro) REFERENCES Livro(IdLivro),
	FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);

CREATE TABLE Emprestimo (
	IdEmprestimo INT IDENTITY(1,1) PRIMARY KEY,
	IdLeitor INT NOT NULL,
	DataEmprestimo DATE NOT NULL DEFAULT GETDATE(),
	DataPrevistaDevolucao DATE NOT NULL,
	DataDevolucao DATE NULL,
	Situacao NVARCHAR(20) NOT NULL,
	FOREIGN KEY (IdLeitor) REFERENCES Leitor(IdLeitor)
);

CREATE TABLE ItemEmprestimo (
	IdEmprestimo INT NOT NULL,
	IdLivro INT NOT NULL,
	Quantidade INT NOT NULL CHECK(Quantidade > 0),
	PRIMARY KEY(IdEmprestimo, IdLivro),
	FOREIGN KEY (IdLivro) REFERENCES Livro(IdLivro),
	FOREIGN KEY (IdEmprestimo) REFERENCES Emprestimo(IdEmprestimo)
);