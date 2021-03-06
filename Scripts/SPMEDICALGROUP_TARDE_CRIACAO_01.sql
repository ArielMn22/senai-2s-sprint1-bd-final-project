CREATE DATABASE SPMEDICALGROUP_TARDE;

USE SPMEDICALGROUP_TARDE;

CREATE TABLE CLINICA(
	ID INT IDENTITY PRIMARY KEY,
	NOME VARCHAR(255) NOT NULL,
	RAZAO_SOCIAL VARCHAR(255) NOT NULL,
	CNPJ CHAR(14) NOT NULL UNIQUE,
	HORARIO_FUNCIONAMENTO VARCHAR(255),
	LOCALIDADE VARCHAR(255) NOT NULL
);

CREATE TABLE TIPO_USUARIO(
	ID INT IDENTITY PRIMARY KEY,
	NOME VARCHAR(255) UNIQUE NOT NULL,
);

CREATE TABLE USUARIOS(
	ID INT IDENTITY PRIMARY KEY,
	NOME VARCHAR(255) NOT NULL,
	EMAIL VARCHAR(255) NOT NULL UNIQUE,
	SENHA VARCHAR(255) NOT NULL,
	TELEFONE VARCHAR(50),
	FOTOPERFIL VARCHAR(255), -- Guardar� o caminho da foto de perfil
	ID_TIPO_USUARIO INT FOREIGN KEY REFERENCES TIPO_USUARIO(ID),
	ID_CLINICA INT FOREIGN KEY REFERENCES CLINICA(ID)
);

CREATE TABLE ESPECIALIDADES(
	ID INT IDENTITY PRIMARY KEY,
	NOME VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE MEDICOS(
	ID INT IDENTITY PRIMARY KEY,
	ID_USUARIO INT FOREIGN KEY REFERENCES USUARIOS(ID),
	ID_ESPECIALIDADE INT FOREIGN KEY REFERENCES ESPECIALIDADES(ID),
	CRM VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE TIPO_STATUS(
	ID INT IDENTITY PRIMARY KEY,
	NOME VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE PACIENTES(
	ID INT IDENTITY PRIMARY KEY,
	ID_USUARIO INT FOREIGN KEY REFERENCES USUARIOS(ID),
	RG CHAR(9) NOT NULL UNIQUE, --SEM '-'
	CPF CHAR(11) NOT NULL UNIQUE, --SEM '-'
	DATA_NASCIMENTO DATETIME NOT NULL,
	ENDERECO VARCHAR(255) NOT NULL
);

CREATE TABLE CONSULTAS(
	ID INT IDENTITY PRIMARY KEY,
	ID_PACIENTE INT FOREIGN KEY REFERENCES PACIENTES(ID) NOT NULL,
	ID_MEDICO INT FOREIGN KEY REFERENCES MEDICOS(ID) NOT NULL,
	DATA_CONSULTA DATETIME NOT NULL,
	OBSERVACOES TEXT DEFAULT 'Sem observa��es',
	ID_STATUS INT FOREIGN KEY REFERENCES TIPO_STATUS(ID) NOT NULL,
	PRECO DECIMAL DEFAULT 0
);