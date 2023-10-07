use sistemainicial;

DELIMITER //
CREATE PROCEDURE InsertarPersonal (IN p_CI VARCHAR(20), IN p_Nombre VARCHAR(50), IN p_Apellido VARCHAR(50), IN p_Telefono VARCHAR(15), IN p_Email VARCHAR(100))
BEGIN
    INSERT INTO personal (CI, Nombre, Apellido, Telefono, Email) VALUES (p_CI, p_Nombre, p_Apellido, p_Telefono, p_Email);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarPersonal (IN p_CI VARCHAR(20), IN p_Nombre VARCHAR(50), IN p_Apellido VARCHAR(50), IN p_Telefono VARCHAR(15), IN p_Email VARCHAR(100))
BEGIN
    UPDATE personal SET Nombre = p_Nombre, Apellido = p_Apellido, Telefono = p_Telefono, Email = p_Email WHERE CI = p_CI;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarPersonal (IN p_CI VARCHAR(20))
BEGIN
    DELETE FROM personal WHERE CI = p_CI;
END //
DELIMITER ;

DELIMITER //
DELIMITER //
CREATE PROCEDURE InsertarUsuario (
    IN p_CI VARCHAR(20),
    IN p_Password VARCHAR(255)
)
BEGIN
    DECLARE p_Nombre VARCHAR(50);
    DECLARE p_Apellido VARCHAR(50);
    SELECT Nombre, Apellido INTO p_Nombre, p_Apellido FROM personal WHERE CI = p_CI;
    SET @primera_letra_nombre = LEFT(p_Nombre, 1);
       SET @primera_palabra_apellido = SUBSTRING_INDEX(p_Apellido, ' ', 1);
     SET @nombre_usuario = CONCAT(@primera_letra_nombre, @primera_palabra_apellido);
        SET p_Password = SHA2(p_Password, 256);
        INSERT INTO usuario (CI, Nombre_Usuario, Password) VALUES (p_CI, @nombre_usuario, p_Password);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ActualizarUsuario (IN p_ID INT, IN p_Nombre_Usuario VARCHAR(50), IN p_Password VARCHAR(255))
BEGIN
    SET p_Password = SHA2(p_Password, 256);
    UPDATE usuario SET Nombre_Usuario = p_Nombre_Usuario, Password = p_Password WHERE ID = p_ID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarUsuario (IN p_ID INT)
BEGIN
    DELETE FROM usuario WHERE ID = p_ID;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ListarPersonales ()
BEGIN
    SELECT * FROM personal;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ListarUsuarios ()
BEGIN
    SELECT ID, CI, Nombre_Usuario FROM usuario;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ListarUsuariosConPassword ()
BEGIN
    SELECT ID, CI, Nombre_Usuario, Password FROM usuario;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE IniciarSesion (IN p_Nombre_Usuario VARCHAR(50), IN p_Password VARCHAR(255), OUT p_Resultado INT)
BEGIN
    -- Asignamos un valor predeterminado al resultado
    SET p_Resultado = 0;

    -- Verifica si el nombre de usuario y la contraseña coinciden con algún registro en la base de datos
    IF EXISTS (SELECT 1 FROM usuario WHERE Nombre_Usuario = p_Nombre_Usuario AND Password = SHA2(p_Password, 256)) THEN
        SET p_Resultado = 1;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtenerNombreUsuario (IN p_Nombre_Usuario VARCHAR(50), OUT p_Nombre VARCHAR(50), OUT p_Apellido VARCHAR(50))
BEGIN
    SELECT p.Nombre, p.Apellido INTO p_Nombre, p_Apellido 
    FROM personal p
    INNER JOIN usuario u ON p.CI = u.CI
    WHERE u.Nombre_Usuario = p_Nombre_Usuario;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE InsertarPais(IN nombre_pais VARCHAR(255))
BEGIN
    INSERT INTO pais (nombre) VALUES (nombre_pais);
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE InsertarCiudad(IN nombre_ciudad VARCHAR(255), IN pais_id INT)
BEGIN
    INSERT INTO ciudad (nombre, id_pais) VALUES (nombre_ciudad, pais_id);
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE ActualizarPais(IN pais_id INT, IN nuevo_nombre VARCHAR(255))
BEGIN
    UPDATE pais SET nombre = nuevo_nombre WHERE id = pais_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarCiudad(IN ciudad_id INT, IN nuevo_nombre VARCHAR(255), IN pais_id INT)
BEGIN
    UPDATE ciudad SET nombre = nuevo_nombre, id_pais = pais_id WHERE id = ciudad_id;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE EliminarPais(IN pais_id INT)
BEGIN
    DELETE FROM pais WHERE id = pais_id;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE EliminarCiudad(IN ciudad_id INT)
BEGIN
    DELETE FROM ciudad WHERE id = ciudad_id;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE BuscarPaises()
BEGIN
    SELECT * FROM pais;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE BuscarCiudades()
BEGIN
    SELECT * FROM ciudad;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE BuscarCiudadesPorPais(IN pais_id INT)
BEGIN
    SELECT * FROM ciudad WHERE id_pais = pais_id;
END //
DELIMITER ;
