-- Creación de una base de datos 
CREATE DATABASE desafio2_rocio_alberto_174;

-- Se conecta La base de datos creada.

-- Creación de la tabla inscritos
CREATE TABLE IF NOT EXISTS inscritos(cantidad INT, fecha DATE, fuente VARCHAR);

-- Ingresar los registros en la tabla inscritos

INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );

-- Comprobamos que los registros se hayan agregado de manera correcta.

SELECT * FROM inscritos;

  cantidad |   fecha    | fuente
----------+------------+--------
      44 | 2021-01-01 | Blog
      56 | 2021-01-01 | Página
      39 | 2021-02-01 | Blog
      81 | 2021-02-01 | Página
      12 | 2021-03-01 | Blog
      91 | 2021-03-01 | Página
      48 | 2021-04-01 | Blog
      45 | 2021-04-01 | Página
      55 | 2021-05-01 | Blog
      33 | 2021-05-01 | Página
      18 | 2021-06-01 | Blog
      12 | 2021-06-01 | Página
      34 | 2021-07-01 | Blog
      24 | 2021-07-01 | Página
      83 | 2021-08-01 | Blog
      99 | 2021-08-01 | Página

-- ● ¿Cuántos registros hay?

SELECT COUNT(*) FROM inscritos;

  COUNT
-------
    16        

-- ● ¿Cuántos inscritos hay en total?

SELECT SUM(cantidad) FROM inscritos;

  sum
  -----
  774

-- ● ¿Cuál o cuáles son los registros de mayor antigüedad?

SELECT * FROM inscritos WHERE fecha = (SELECT MIN (fecha) FROM inscritos);

  cantidad |   fecha    | fuente
----------+------------+--------
      44 | 2021-01-01 | Blog
      56 | 2021-01-01 | Página

-- ● ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de
-- ahora en adelante)

SELECT fecha, SUM(cantidad) FROM inscritos GROUP BY fecha;

    fecha    | sum
------------+-----
  2021-02-01 | 120
  2021-08-01 | 182
  2021-05-01 |  88
  2021-04-01 |  93
  2021-06-01 |  30
  2021-07-01 |  58
  2021-03-01 | 103
  2021-01-01 | 100

-- ● ¿Cuántos inscritos hay por fuente?

SELECT fuente, SUM(cantidad) FROM inscritos GROUP BY fuente;

  fuente | sum
--------+-----
  Página | 441
  Blog   | 333

-- ● ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se
-- inscribieron en ese día?

SELECT SUM(cantidad) AS cant_inscritos, fecha FROM inscritos GROUP BY fecha ORDER BY cant_inscritos DESC lIMIT 1;

  cant_inscritos |   fecha
----------------+------------
    182 | 2021-08-01

-- ● ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog y cuántas
-- personas fueron?

SELECT fecha, MAX(cantidad) FROM inscritos WHERE cantidad = (SELECT MAX(cantidad) FROM inscritos WHERE fuente = 'Blog') GROUP BY fecha ;

    fecha    | max
------------+-----
  2021-08-01 |  83


-- ● ¿Cuántas personas en promedio se inscriben en un día?

SELECT AVG(cantidad) FROM (SELECT SUM(cantidad) AS cantidad FROM inscritos GROUP BY fecha) AS t1;

        avg
---------------------
  96.7500000000000000

-- ● ¿Qué días se inscribieron más de 50 personas?

SELECT fecha, SUM(cantidad) FROM inscritos GROUP BY fecha HAVING SUM(cantidad) > 50;

    fecha    | sum
------------+-----
  2021-02-01 | 120
  2021-08-01 | 182
  2021-05-01 |  88
  2021-04-01 |  93
  2021-07-01 |  58
  2021-03-01 | 103
  2021-01-01 | 100

-- ● ¿Cuántas personas se registraron en promedio cada día a partir del tercer día?

SELECT AVG(cantidad) FROM (SELECT SUM(cantidad) AS cantidad FROM inscritos GROUP BY fecha HAVING fecha > '2021-02-01') AS t1;

        avg
---------------------
  92.3333333333333333
