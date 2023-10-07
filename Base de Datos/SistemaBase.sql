CREATE DATABASE sistemainicial;
USE sistemainicial;

CREATE TABLE personal (
    CI VARCHAR(20) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Telefono VARCHAR(15),
    Email VARCHAR(100)  NOT NULL
);

CREATE TABLE usuario (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    CI VARCHAR(20),
    Nombre_Usuario VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
        FOREIGN KEY (CI) REFERENCES personal(CI)
);


CREATE TABLE tokens (
    TokenID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID INT,
    Token VARCHAR(255) NOT NULL,
    Expiracion DATETIME NOT NULL,
    FOREIGN KEY (UsuarioID) REFERENCES usuario(ID)
);

CREATE TABLE pais (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE ciudad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    id_pais INT,
    FOREIGN KEY (id_pais) REFERENCES pais(id)
);
 

