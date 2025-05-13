-- QUESTION 1 :
CREATE TYPE coordonnees AS OBJECT(
    Ville VARCHAR2(50),
    CP VARCHAR2(10),
    Telephone VARCHAR2(20),
    Fax VARCHAR2(20)
);
CREATE TABLE EMP (
    NUMEMP INTEGER PRIMARY KEY,
    NomComplet VARCHAR2(100),
    SALAIRE INTEGER,
    Coordonnee coordonnees
);
-- QUESTION 2 :
INSERT INTO EMP VALUES (14, 'XAVIER Richard',NULL , 
    coordonnees('Lyon', '69000', '0472546585',NULL));
INSERT INTO EMP VALUES (15, 'NICOLLE Chris',NULL , coordonnees('Paris', '75000',NULL ,NULL ));
INSERT INTO EMP VALUES (16, 'CRINIERE Belle',NULL, 
    coordonnees('Grenoble', '38001',NULL ,NULL ));
INSERT INTO EMP VALUES (17, 'AUBERT Louis',2000, coordonnees('Lyon','69100','0478556585',NULL));
INSERT INTO EMP VALUES (18, 'MAURI John', 1500, coordonnees('Anglet','64200',NULL,NULL));

-- QUESTION 3 :
UPDATE EMP e SET e.SALAIRE = 30000 AND e.Coordonnee.Ville='Anglet' AND e.Coordonnee.CP='64200' WHERE NUMEMP=14;
UPDATE EMP e SET e.SALAIRE = 20000 AND e.Coordonnee.Ville='Anglet' AND e.Coordonnee.CP='64200' AND WHERE NUMEMP=15;

--QUestion 4 : 
UPDATE EMP e SET e.salaire = &nv_salaire WHERE NUMEMP = &numemp;
-- QUESTION 5 :
SELECT DISTINCT e.coordonnees.Ville FROM EMP e;
--Question 6 :
SELECT e.coordonnees.Ville, e.NomComplet FROM EMP e;
-- QUESTION 7 :
SELECT COUNT(DISTINCT e.coordonnees.Ville) FROM EMP e;
-- QUESTION 8 :
SELECT e.NomComplet FROM EMP e WHERE e.coordonnees.Ville = 'Anglet';
-- QUESTION 9 :
SELECT e.NomComplet FROM EMP e WHERE e.coordonnees.Telephone IS NOT NULL;
-- QUESTION 10 :
UPDATE EMP e SET e.coordonnees.Telephone = '0478556585', e.coordonnees.Fax='0809090909' WHERE e.NomComplet = 'XAVIER Richard';