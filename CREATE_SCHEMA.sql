CREATE DATABASE ClinicaMedica
GO		-- either end a command line with ';' or the function 'GO'


USE ClinicaMedica;	-- enters a database and lets you work within it

-- Creating tables in database
CREATE TABLE Pacientes (
	idPaciente INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Nome VARCHAR(50) NOT NULL,
	Sobrenome VARCHAR(50) NOT NULL,
	CPF NUMERIC NOT NULL UNIQUE,
	DataNascimento DATE NOT NULL,
	idEndereco INT
);

CREATE TABLE PacientesParticulares (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idPaciente INT NOT NULL,
	ValorConsulta DECIMAL(8,2) NOT NULL
);

-- Alters idPaciente to UNIQUE
ALTER TABLE PacientesParticulares
ADD CONSTRAINT constraint_idpaciente_unique UNIQUE (idPaciente);
/*
  To remove a constraint, use DROP instead of ADD
	with just the keyname (not column name) and nothing else
*/

CREATE TABLE PacientesConveniados (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idConvenio INT NOT NULL,
	idPaciente INT NOT NULL,
	NumCarteirinha NUMERIC NOT NULL UNIQUE,
	ValidadeConvenio DATE NOT NULL,
	idTipoPlano INT NOT NULL
);

CREATE TABLE Convenios (
	idConvenio INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NomeConvenio VARCHAR(20) NOT NULL,
	SiteConvenio VARCHAR(20),
	CNPJ NUMERIC NOT NULL UNIQUE
);

CREATE TABLE Medicos (
	idMedico INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	CRM VARCHAR(9) NOT NULL UNIQUE,
	Nome VARCHAR(50) NOT NULL,
	Sobrenome VARCHAR(50) NOT NULL,
	DataContratacao DATE NOT NULL
);

CREATE TABLE TelefonesConvenios (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	CodPais NUMERIC NOT NULL,
	CodArea NUMERIC NOT NULL,
	Numero NUMERIC NOT NULL,
	idConvenio INT NOT NULL
);

CREATE TABLE TelefonesPacientes (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	CodPais NUMERIC NOT NULL,
	CodArea NUMERIC NOT NULL,
	Numero NUMERIC NOT NULL,
	idPaciente INT NOT NULL
);

CREATE TABLE TelefonesMedicos (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	CodPais NUMERIC NOT NULL,
	CodArea NUMERIC NOT NULL,
	Numero NUMERIC NOT NULL,
	idMedico INT NOT NULL
);

CREATE TABLE TiposPlanos (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	TipoPlano VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE Enderecos(
	idEndereco INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Logradouro NVARCHAR(20) NOT NULL,
	Numero NUMERIC,
	Complemento VARCHAR(10),
	Bairro NVARCHAR(30) NOT NULL,
	Cidade VARCHAR(30) NOT NULL,
	CEP NUMERIC
);

CREATE TABLE Consultas (
	idConsulta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	DataHora DATETIME NOT NULL,
	TipoConsulta INT NOT NULL,
	StatusConsulta INT NOT NULL,
	Observacoes NVARCHAR(255),
	Diagnostico NVARCHAR(255) NOT NULL,
	idPaciente INT NOT NULL,
	idMedico INT NOT NULL
);

CREATE TABLE TiposConsulta (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	TipoConsulta VARCHAR NOT NULL UNIQUE,
	TempoEstimado INT NOT NULL,
	ValorConsulta DECIMAL(8,2) NOT NULL
);

CREATE TABLE StatusConsultas (
	idStatus INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	StatusConsulta VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE Emails (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	Email VARCHAR(20) NOT NULL,
	idPaciente INT NOT NULL
);

CREATE TABLE Especialidades (
	idEspecialidade INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NomeEspecialidade NVARCHAR(20) NOT NULL UNIQUE,
	Descricao NVARCHAR(255)
);

CREATE TABLE MedicosEspecialidade (
	id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	idMedico INT NOT NULL,
	idEspecialidade INT NOT NULL,
);

-- Creating relations (by altering table keys)
ALTER TABLE PacientesParticulares
ADD FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente);

ALTER TABLE PacientesConveniados
ADD FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente),
FOREIGN KEY (idConvenio) REFERENCES Convenios(idConvenio),
FOREIGN KEY (idTipoPlano) REFERENCES TiposPlanos(id);

ALTER TABLE Pacientes
ADD FOREIGN KEY (idEndereco) REFERENCES Enderecos(idEndereco);

ALTER TABLE Emails
ADD FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente);

ALTER TABLE TelefonesPacientes
ADD FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente);

ALTER TABLE Consultas
ADD FOREIGN KEY (idPaciente) REFERENCES Pacientes(idPaciente),
FOREIGN KEY (idMedico) REFERENCES Medicos(idMedico),
FOREIGN KEY (TipoConsulta) REFERENCES TiposConsulta(id),
FOREIGN KEY (StatusConsulta) REFERENCES StatusConsultas(idStatus);

ALTER TABLE TelefonesConvenios
ADD FOREIGN KEY (idConvenio) REFERENCES Convenios(idConvenio);

ALTER TABLE TelefonesMedicos
ADD FOREIGN KEY (idMedico) REFERENCES Medicos(idMedico);

ALTER TABLE MedicosEspecialidade
ADD FOREIGN KEY (idMedico) REFERENCES Medicos(idMedico),
FOREIGN KEY (idEspecialidade) REFERENCES Especialidades(idEspecialidade);

