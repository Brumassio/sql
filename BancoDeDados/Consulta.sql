create database clinica;
use clinica;

create table Especialidade(
    idEspecialidade int,
    nomeEspecialidade varchar(20),
    primary key PK_ESPECIALIDADE (idEspecialidade)
);

create table Convenio(
    idConvenio int,
    nomeConvenio varchar(20),
    primary key (idconvenio)
);

create table Medico(
    crm int,
    NomeMedico varchar(50),
    idEspecialidade int,
    primary key PK_MEDICO (crm),
    foreign key FK_ESPECIALIDADE (idEspecialidade) references Especialidade (idEspecialidade)
);

create table Paciente(
    idPaciente int AUTO_INCREMENT,
    nomePaciente varchar(50),
    idConvenio int,
    primary key PK_PACIENTE (idPaciente),
    foreign key FK_CONVENIO (idConvenio) references Convenio (idConvenio) 
);

create table Agenda (
    idAgenda int AUTO_INCREMENT,
    idPaciente int,
    crm int,
    dataAgenda date,
    horaAgenda date,
    primary key PK_AGENDA(idAgenda),
    foreign key FK_PACIENTE (idPaciente) references Paciente (idPaciente),
    foreign key FK_MEDICO (crm) references Medico (crm)

);

create table Consulta (
    idAgenda int,
    -- idPaciente int, 
    -- crm int,
    dataAgenda date,
    horaAgenda date,
    primary key PK_CONSULTA (idAgenda, idPaciente, crm)
);