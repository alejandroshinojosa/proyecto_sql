DROP TABLE IF EXISTS
  alumno_proyecto, profesor_promocion, matriculas,
  alumnos, profesores, proyectos, promociones,
  modalidad, verticales, campus
CASCADE;

CREATE TABLE "campus" (
  "id_campus" serial PRIMARY KEY,
  "nombre_campus" varchar(50) UNIQUE NOT NULL
);

CREATE TABLE "verticales" (
  "id_vertical" serial PRIMARY KEY,
  "nombre_vertical" varchar(50) UNIQUE NOT NULL
);

CREATE TABLE "modalidad" (
  "id_modalidad" serial PRIMARY KEY,
  "nombre_modalidad" varchar(50) UNIQUE NOT NULL
);

CREATE TABLE "promociones" (
  "id_promocion" serial PRIMARY KEY,
  "fecha_comienzo" date NOT NULL,
  "id_campus" integer NOT NULL,
  "id_vertical" integer NOT NULL
);

CREATE TABLE "proyectos" (
  "id_proyecto" serial PRIMARY KEY,
  "nombre_proyecto" varchar(100) NOT NULL,
  "id_vertical" integer NOT NULL
);

CREATE TABLE "alumnos" (
  "id_alumno" serial PRIMARY KEY,
  "nombre_alumno" varchar(100) NOT NULL,
  "email" varchar(150) UNIQUE NOT NULL
);

CREATE TABLE "profesores" (
  "id_profesor" serial PRIMARY KEY,
  "nombre_profesor" varchar(100) UNIQUE NOT NULL
);

CREATE TABLE "matriculas" (
  "id_matricula" serial PRIMARY KEY,
  "id_alumno" integer NOT NULL,
  "id_promocion" integer NOT NULL
);

CREATE TABLE "profesor_promocion" (
  "id_profesor_promocion" serial PRIMARY KEY,
  "id_profesor" integer NOT NULL,
  "id_promocion" integer NOT NULL,
  "id_modalidad" integer NOT NULL,
  "rol" varchar(10) NOT NULL,
  CHECK ("rol" IN ('TA', 'LI'))
);

CREATE TABLE "alumno_proyecto" (
  "id_alumno_proyecto" serial PRIMARY KEY,
  "id_matricula" integer NOT NULL,
  "id_proyecto" integer NOT NULL,
  "resultado" varchar(10) NOT NULL,
  CHECK ("resultado" IN ('Apto', 'No Apto'))
);

CREATE UNIQUE INDEX ON "promociones" ("fecha_comienzo", "id_campus", "id_vertical");

CREATE UNIQUE INDEX ON "proyectos" ("nombre_proyecto", "id_vertical");

CREATE UNIQUE INDEX ON "matriculas" ("id_alumno", "id_promocion");

CREATE UNIQUE INDEX ON "profesor_promocion" ("id_profesor", "id_promocion");

CREATE UNIQUE INDEX ON "alumno_proyecto" ("id_matricula", "id_proyecto");

COMMENT ON COLUMN "profesor_promocion"."rol" IS 'TA o LI';

COMMENT ON COLUMN "alumno_proyecto"."resultado" IS 'Apto o No Apto';

ALTER TABLE "promociones" ADD FOREIGN KEY ("id_campus") REFERENCES "campus" ("id_campus") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "promociones" ADD FOREIGN KEY ("id_vertical") REFERENCES "verticales" ("id_vertical") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "proyectos" ADD FOREIGN KEY ("id_vertical") REFERENCES "verticales" ("id_vertical") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "matriculas" ADD FOREIGN KEY ("id_alumno") REFERENCES "alumnos" ("id_alumno") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "matriculas" ADD FOREIGN KEY ("id_promocion") REFERENCES "promociones" ("id_promocion") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "profesor_promocion" ADD FOREIGN KEY ("id_profesor") REFERENCES "profesores" ("id_profesor") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "profesor_promocion" ADD FOREIGN KEY ("id_promocion") REFERENCES "promociones" ("id_promocion") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "profesor_promocion" ADD FOREIGN KEY ("id_modalidad") REFERENCES "modalidad" ("id_modalidad") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "alumno_proyecto" ADD FOREIGN KEY ("id_matricula") REFERENCES "matriculas" ("id_matricula") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "alumno_proyecto" ADD FOREIGN KEY ("id_proyecto") REFERENCES "proyectos" ("id_proyecto") DEFERRABLE INITIALLY IMMEDIATE;
