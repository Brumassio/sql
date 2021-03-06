CREATE DATABASE FITMANAGER;

USE FITMANAGER;

CREATE TABLE ACADEMIA(
    idAcademia INT AUTO_INCREMENT,
    nome VARCHAR(25),
    telefone VARCHAR(30),
    endereco VARCHAR(30),
    cnpj VARCHAR(20),
    PRIMARY KEY PK_ACADEMIA(idAcademia)   
);

CREATE TABLE PLANO( 
    idPlano INT AUTO_INCREMENT,
    idAcademia INT,
    nome VARCHAR(30),
    preco FLOAT,
    desconto FLOAT,
    PRIMARY KEY PK_PLANO(idPlano),
    FOREIGN KEY FK_ACADEMIA(idAcademia) REFERENCES ACADEMIA(idAcademia)
);


CREATE TABLE PESSOA(
    idPessoa INT AUTO_INCREMENT,
    idAcademia INT,
    nome VARCHAR(20),
    cpf VARCHAR(15),
    telefone VARCHAR(20),
    endereco VARCHAR(30),
    genero VARCHAR(10),
    dataNascimento VARCHAR(10),
    PRIMARY KEY PK_PESSOA (idPessoa),  
    FOREIGN KEY FK_ACADEMIA (idAcademia) REFERENCES ACADEMIA (idAcademia)
);


CREATE TABLE ADMINISTRADOR(
    idAdministrador INT AUTO_INCREMENT,
    idPessoa INT,
    setor VARCHAR(15),
    PRIMARY KEY PK_ADMINISTRADOR (idAdministrador),
    FOREIGN KEY FK_PESSOA (idPessoa) REFERENCES PESSOA (idPessoa)
);

CREATE TABLE PROFESSOR(
    idProfessor INT AUTO_INCREMENT,
    idPessoa INT,
    especializacao VARCHAR(20),
    PRIMARY KEY PK_PROFESSOR(idProfessor),
    FOREIGN KEY FK_PESSOA (idPessoa) REFERENCES PESSOA (idPessoa)
);

CREATE TABLE ALUNO(
    idAluno INT AUTO_INCREMENT,
    idProfessor INT,
    idPessoa INT,
    idPlano INT,
    dataMatricula VARCHAR(10),
    pontos INT,
    PRIMARY KEY PK_ALUNO (idAluno),
    FOREIGN KEY FK_PROFESSOR (idProfessor) REFERENCES PROFESSOR (idProfessor),
    FOREIGN KEY FK_PLANO (idPlano) REFERENCES PLANO (idPlano),
    FOREIGN  KEY FK_PESSOA(idPessoa) REFERENCES PESSOA(idPessoa)
);

CREATE TABLE TREINO(
    idTreino INT AUTO_INCREMENT,
    idAluno INT,
    idProfessor INT,
    idAcademia INT,
    PRIMARY KEY PK_TREINO (idTreino),
    FOREIGN KEY FK_PROFESSOR (idProfessor) REFERENCES PROFESSOR (idProfessor),
    FOREIGN KEY FK_ALUNO (idAluno) REFERENCES ALUNO (idAluno),
    FOREIGN KEY FK_ACADEMIA (idAcademia) REFERENCES ACADEMIA (idAcademia)
);

CREATE TABLE EXERCICIO (
    idExercicio INT AUTO_INCREMENT,
    idTreino INT,
    nome VARCHAR(20),
    descricao VARCHAR(100),
    numRepeticoes INT,
    series INT,
    PRIMARY KEY PK_EXERCICIO (idExercicio),
    FOREIGN KEY FK_TREINO (idTreino) REFERENCES TREINO (idTreino)
);

CREATE TABLE AGENDA(
    idAgenda INT AUTO_INCREMENT,
    idProfessor INT,
    idAcademia INT,
    dataAvaliacao VARCHAR(10),
    hora varchar(5),
    PRIMARY KEY PK_AGENDA(idAgenda),
    FOREIGN KEY FK_PROFESSOR(idProfessor) REFERENCES PROFESSOR(idProfessor),
    FOREIGN KEY FK_ACADEMIA (idAcademia) REFERENCES ACADEMIA(idAcademia)
);



INSERT INTO ACADEMIA VALUES(NULL,'BrumasPhysique','99284324','Rua Paulista','0928274923');

INSERT INTO PLANO VALUES(NULL,1,'Silver',500.50,25);
INSERT INTO PLANO VALUES(NULL,1,'Gold',600.90,30);
INSERT INTO PLANO VALUES(NULL,1,'Diamond',670.80,20);

INSERT INTO PESSOA VALUES(NULL,1, 'Diogo Brumassio', '321312321', '44984114189', 'Rua China', 'Masculino', '23/08/2002');
INSERT INTO PESSOA VALUES(NULL,1,'Gabriel Biscaia','098348235','999245235','Rua Sao Pedro','Masculino','23/09/2002');
INSERT INTO PESSOA VALUES(NULL,1,'Pedro Zafalon','098357235','988245235','Rua Greyskol','Masculino','10/05/2002');
INSERT INTO PESSOA VALUES(NULL,1,'Arthur Martins','098312335','123454235','Rua Catedral','Masculino','11/01/2002');

INSERT INTO ADMINISTRADOR VALUES (NULL, 1, 'CEO');

INSERT INTO PROFESSOR VALUES (NULL,2,'Hipertrofia');
INSERT INTO PROFESSOR VALUES (NULL,3,'Definicao');

INSERT INTO ALUNO VALUES (NULL,2,4,2,'20/09/2020',20);

INSERT INTO TREINO VALUES (NULL,1,2,1);

INSERT INTO EXERCICIO VALUES (NULL,1,'Remada','Fechar a escapula MINUCIOSAMENTE !',12,3);
INSERT INTO EXERCICIO VALUES (NULL,1,'Supino','Foco no pico de contra????o!',15,3);
INSERT INTO EXERCICIO VALUES (NULL,1,'Rosca','Botar o m??ximo de peso na rosca!',10,4);


INSERT INTO AGENDA VALUES (NULL,2,1,'07/03/2031','08:00');
INSERT INTO AGENDA VALUES (NULL,1,1,'23/05/2023','12:00');