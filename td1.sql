-- QUESTION 1 : 
CREATE OR REPLACE TYPE coordonnees AS OBJECT(
    Ville VARCHAR2(50),
    CP VARCHAR2(10),
    Telephone VARCHAR2(20),
    Fax VARCHAR2(20),
);
CREATE OR REPLACE TABLE EMP (
    NUMEMP INTEGER PRIMARY KEY,
    NomComplet VARCHAR2(100),
    SALAIRE INTEGER,
    Coordonnee coordonnees,
);

-- Insertion des données
-- QUESTION 2 :
INSERT INTO EMP (14, 'XAVIER Richard', , 
    coordonnees('Lyon', '69000', '0472546585',''));
INSERT INTO EMP (15, 'NICOLLE Chris', , coordonnees('Paris', '75000','' ,'' ));
INSERT INTO EMP (16, 'CRINIERE Belle',, 
    coordonnees('Grenoble', '38001','' ,'' ));
INSERT INTO EMP (17, 'AUBERT Louis',2000, coordonnees('Lyon','69100','0478556585',''));
INSERT INTO EMP (18, 'MAURI John', 1500, coordonnees('Anglet','64200','',''));