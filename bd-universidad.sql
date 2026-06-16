CREATE DATABASE universidad
    DEFAULT CHARACTER SET = 'utf8mb4';


USE universidad;

CREATE TABLE profesores(
    id_profesor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE alumnos(
    id_alumno INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL, 
    edad INT NOT NULL CHECK(edad > 0 AND edad <= 150)
);

CREATE TABLE materias(
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    id_profesor INT NOT NULL,
    nombre VARCHAR(100) NOT NULL, 

    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor)
);

CREATE TABLE inscripciones(
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_materia INT NOT NULL,
    fecha DATE NOT NULL,

    FOREIGN KEY(id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY(id_materia) REFERENCES materias(id_materia)
);

CREATE TABLE notas(
    id_notas INT AUTO_INCREMENT PRIMARY KEY,
    id_inscripcion INT NOT NULL,
    nota DECIMAL(4,2) NOT NULL,
    fecha DATE NOT NULL,

    FOREIGN KEY (id_inscripcion) REFERENCES inscripciones(id_inscripcion)
);


INSERT INTO profesores(nombre)
VALUES ('Juan Perez');

INSERT INTO materias(nombre, id_profesor)
VALUES ('Base de datos' , 1);

INSERT INTO alumnos(nombre, edad)
VALUES ('Macarena Aguirre' , 28);

INSERT INTO inscripciones(
id_alumno,
id_materia,
fecha,
anio_cursada
)
VALUES(
1,
1,
'2026-06-16',
2027
);

INSERT INTO notas(
    id_inscripcion,
    nota,
    fecha
)VALUES(
    1,
    9,
    '2026-06-16'
);

--* PROBLEMA: sin querer presioné dos veces la misma fila de inscripción
-- que estaba agregando, y se guardaron dos veces la misma.

-- Nueva regla:
-- anio_cursada no va a permitir que existan dos inscripciones iguales.
-- Primero agregamos la columna anio_cursada

-- A la tabla inscripciones que ya existe, agregale una columna
-- llamada anio_cursada de tipo entero y obligatoria

ALTER TABLE inscripciones
ADD COLUMN anio_cursada INT NOT NULL;

--Traducido del idioma SQL al idioma humano:
--Vamos a agregar una restricción(CONSTRAINT) y quiero llamarla unica_inscripcion
--"La universidad tiene una regla: un alumno no puede anotarse dos
-- veces a la misma materia en el mismo año. La base de datos va a 
-- cuidar esa regla por mí."

ALTER TABLE inscripciones
ADD CONSTRAINT unica_inscripcion -- Le ponemos un NOMBRE a la regla que estamos creando.
UNIQUE(id_alumno, id_materia, anio_cursada);


SELECT * FROM inscripciones;
