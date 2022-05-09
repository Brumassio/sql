create database clinica;
use clinica;

create table Especialidade (
    idEspecialidade int,
    nomeEspecialidade varchar (20),
    primary key PK_ESPECIALIDADE (idEspecialidade)
);

create table Convenio (
    idConvenio int,
    nomeConvenio varchar (20),
    primary key PK_CONVENIO (idConvenio)
);

create table Medico (
    crm int, 
    NomeMedico varchar(50), 
    idEspecialidade int,
    primary key PK_MEDICO (crm),
    foreign key FK_ESPECIALIDADE (idEspecialidade) 
                references Especialidade (idEspecialidade));


create table Paciente (
    idPaciente int AUTO_INCREMENT, 
    nomePaciente varchar (50), 
    idConvenio int,
    primary key PK_PACIENTE (idPaciente),
    foreign key FK_CONVENIO (idConvenio) references Convenio (idConvenio));


create table Agenda  (
    idAgenda int AUTO_INCREMENT, 
    idPaciente int, 
    crm int, 
    dataAgenda date, 
    horaAgenda date,
    primary key PK_AGENDA (idAgenda),
    foreign key FK_PACIENTE (idPaciente) references Paciente (idPaciente),
    foreign key FK_MEDICO (crm) references Medico (crm)
    );

create table Consulta  (
    idAgenda int, 
    dataAgenda date, 
    horaAgenda date,
    primary key PK_CONSULTA (idAgenda)
    );

ALTER TABLE Especialidade;
MODIFY nomeEspecialidade VARCHAR (20) NOT NULL;


DELETE FROM Especialidade;  

DROP TABLE Agenda; 
DROP TABLE Medico;
DROP TABLE Especialidade;

create table Especialidade (
    idEspecialidade int AUTO_INCREMENT,
    nomeEspecialidade varchar (20),
    primary key PK_ESPECIALIDADE (idEspecialidade)
);

ALTER TABLE Convenio;
ADD COLUMN dataConvenio DATA NOT NULL;

INSERT INTO Especialidade VALUES (1,'CLINICO GERAL');
INSERT INTO Especialidade VALUES (2,'GASTRO');
INSERT INTO Especialidade VALUES (3,'PSIQUIATRIA');
INSERT INTO Especialidade VALUES (4,'NEFROLOGIA');
INSERT INTO Especialidade VALUES (null,'PNEUMOLOGIA');
INSERT INTO Especialidade VALUES (null,'GINECOLOGISTA');


desc Medico;
INSERT INTO Medico VALUES (1000,'VINI MALVADEZA',1);
INSERT INTO Medico VALUES (2000,'NEYMAR JR',2);
INSERT INTO Medico VALUES (3000,'PAQUETA',3);
INSERT INTO Medico VALUES (4000,'CASEMIRO',4);
INSERT INTO Medico VALUES (5000,'MARQUINHOS',5);
INSERT INTO Medico VALUES (6000,'GABRIEL JESUS',6);
INSERT INTO Medico VALUES (8000,'CR7',1);
INSERT INTO Medico VALUES (7000,'MESSI',5);

SELECT * FROM Medico;
SELECT * FROM Especialidade;
SELECT * FROM Medico JOIN Especialidade;

--JUNÇÕES--
--JOIN--

SELECT * 
FROM Medico JOIN Especialidade 
ON Medico.idEspecialidade = Especialidade.idEspecialidade;

SELECT NomeMedico,nomeEspecialidade 
FROM Medico JOIN Especialidade 
ON Medico.idEspecialidade = Especialidade.idEspecialidade;

SELECT NomeMedico AS Medico,nomeEspecialidade AS Especialidade 
FROM Medico JOIN Especialidade 
ON Medico.idEspecialidade = Especialidade.idEspecialidade;

SELECT NomeMedico AS Medico,nomeEspecialidade AS Especialidade 
FROM Medico m JOIN Especialidade e 
ON m.idEspecialidade = e.idEspecialidade;


---POSSIVEL ARMADILHA---
--NATURAL JOIN--
SELECT NomeMedico AS Medico,nomeEspecialidade AS Especialidade 
FROM Medico NATURAL JOIN Especialidade; 
--Funciona apenas quando tem chave estrangeira
--Se tiver chave composta, junta as duas;



--LEFT ALTER JOIN--
SELECT NomeMedico AS Medico,nomeEspecialidade AS Especialidade 
FROM Medico m LEFT ALTER JOIN Especialidade e 
ON m.idEspecialidade = e.idEspecialidade;


--RIGHT OUTER JOIN--
SELECT NomeMedico AS Medico,nomeEspecialidade AS Especialidade 
FROM Medico m RIGHT OUTER JOIN Especialidade e 
ON m.idEspecialidade = e.idEspecialidade;

--FILTROS--
SELECT NomeMedico AS Medico,nomeEspecialidade AS Especialidade 
FROM Medico m LEFT OUTER JOIN Especialidade e 
ON m.idEspecialidade = e.idEspecialidade;
WHERE NomeMedico IS NULL;

SELECT NomeMedico AS Medico,nomeEspecialidade AS Especialidade 
FROM Medico m RIGHT OUTER JOIN Especialidade e 
ON m.idEspecialidade = e.idEspecialidade;
WHERE NomeMedico IS NULL;

--INNER JOIN-- Mesma coisa que JOIN
SELECT NomeMedico AS Medico,nomeEspecialidade AS Especialidade 
FROM Medico m INNER JOIN Especialidade e 
ON m.idEspecialidade = e.idEspecialidade;
WHERE NomeMedico IS NULL;


--LIKE
SELECT m.crm, m.nomeMedico, e.nomeEspecialidade FROM Especialidade e left join  Medico m ON m.idEspecialidade = e.idEspecialidade WHERE nomeMedico LIKE 'GABRIEL%';

--FUNÇÕES DE AGRUPAMENTO//contador de elementos na tabela
select count(idEspecialidade) 'ESPECIALISTAS DA CLINICA' from Especialidade;

--GROUP BY--RELATÓRIO DE ESPECIALIDADES POR MEDICO
select e.nomeEspecialidade,count(e.nomeEspecialidade) FROM Medico m RIGHT JOIN Especialidade e ON m.idEspecialidade = e.idEspecialidade GROUP BY m.idEspecialidade;

--RELATÓRIO DE MÉDICOS POR ESPECIALIDADE MAS COM ESPECIALIDADES SEM MÉDICOS
select e.nomeEspecialidade,count(e.nomeEspecialidade) FROM Medico m LEFT JOIN Especialidade e ON m.idEspecialidade = e.idEspecialidade GROUP BY e.idEspecialidade;


--TIRAR A MEDIA SALARIAL POR ESPECIALIDADE MÉDICA
ALTER TABLE Medico ADD COLUMN Salario float;
ALTER TABLE Medico DROP COLUMN Salario float;
ALTER TABLE Medico ADD COLUMN Salario float (10,2);

--****  ! SCRIPT PARA INSERÇÃO AUTOMÁTICA DE SALÁRIO
select crm, idEspecialidade from Medico;
select "UPDATE Medico SET Salario = " 5000*idEspecialidade";" from Medico; --DA ERRO 
--SÓ PRA TESTAR COMO VAI FICAR !!
select CONCAT("UPDATE Medico SET Salario = " +5000*idEspecialidade"; " from Medico);
--MUDA TUDO, SEM VOLTA !!
UPDATE Medico  SET Salario = 5000*idEspecialidade;

--SOMAR OS SALARIOS DOS MEDICOS
select SUM(Salario) as "Salário do Médico" from Medico;
select CONCAT ("SALARIOS PAGOS A MEDICOS: R$", SUM(Salario)) as "SALARIO" from Medico;


--TIRAR A MEDIA SALARIAL DOS MEDICOS
select SUM(Salario)/COUNT(crm) as MEDIASAL from Medico;
select CONCAT('Média Salarial da clínica: ',SUM(Salario)/COUNT(crm)) as "MEDIA SALARIAL DA CLINICA"  from Medico;
select AVG(Salario) as MediaSal from Medico;

--FORMATANDO SAIDA
select FORMAT(AVG(Salario),2) as MediaSal from Medico;

--SOMAR OS SALARIOS POR ESPECIALIDADE MÉDICA
select SUM(Salario) from Medico where idEspecialidade=1; --PEGAR A SOMA DOS SALARIOS DE UM ID SÓ
select idEspecialidade, SUM(Salario) from Medico GROUP BY (idEspecialidade);

--ALTERANDO ESPECIALIDADE DE UM MÉDICO
update Medico set idEspecialidade = 6 WHERE crm = 3000;
update Medico set idEspecialidade = 2, Salario = 10000  WHERE crm = 3000;

--APRESENTANDO O NOME 
 select e.nomeEspecialidade, SUM(m.Salario) from Medico m LEFT JOIN Especialidade e ON m.idEspecialidade = e.idEspecialidade GROUP BY (e.nomeEspecialidade);



