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
SELECT DISTINCT e.coordonnee.Ville FROM EMP e;
--Question 6 :
SELECT e.coordonnee.Ville, e.NomComplet FROM EMP e;
-- QUESTION 7 :
SELECT COUNT(DISTINCT e.coordonnee.Ville) FROM EMP e;
-- QUESTION 8 :
SELECT e.NomComplet FROM EMP e WHERE e.coordonnee.Ville = 'Anglet';
-- QUESTION 9 :
SELECT e.NomComplet FROM EMP e WHERE e.coordonnee.Telephone IS NOT NULL;
-- QUESTION 10 :
UPDATE EMP e SET e.coordonnee.Telephone = '0478556585', e.coordonnee.Fax='0809090909' WHERE e.NomComplet = 'XAVIER Richard';

-- PARTIE 2 PLSQL :
--QUESTION 1 : 
CREATE OR REPLACE PROCEDURE INSERT_EMP(
    p_numemp IN EMP.NUMEMP%TYPE,
    p_nomcomplet IN EMP.NOMCOMPLET%TYPE,
    p_salaire IN EMP.SALAIRE%TYPE,
    p_ville IN coordonnees.Ville%TYPE,
    p_cp IN coordonnees.CP%TYPE,
    p_telephone IN coordonnees.Telephone%TYPE,
    p_fax IN coordonnees.Fax%TYPE
) IS
BEGIN
    INSERT INTO EMP (NUMEMP, NOMCOMPLET, SALAIRE, COORDONNEE)
    VALUES (
        p_numemp,
        p_nomcomplet,
        p_salaire,
        coordonnees(p_ville, p_cp, p_telephone, p_fax)
    );
    DBMS_OUTPUT.PUT_LINE('Employé inséré : ' || p_nomcomplet);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Numéro d employé déjà existant.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END;
-- QUESTION 2 :
CREATE OR REPLACE PROCEDURE MAJ_EMP(NomEmp, salaire)
IS
    v_salaire EMP.SALAIRE%TYPE;
BEGIN
    SELECT SALAIRE INTO v_salaire FROM EMP WHERE NOMCOMPLET = NomEmp;
    IF v_salaire IS NOT NULL THEN
        UPDATE EMP SET SALAIRE = salaire WHERE NOMCOMPLET = NomEmp;
        DBMS_OUTPUT.PUT_LINE('Salaire mis à jour pour ' || NomEmp);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Erreur : Employé non trouvé.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Employé non trouvé.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END;
-- QUESTION 3 :
CREATE OR REPLACE PROCEDURE COUNT_EMP() IS
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM EMP;
    DBMS_OUTPUT.PUT_LINE('Nombre d employés : ' || v_count);
END;

--QUESTION 4 :
CREATE OR REPLACE PROCEDURE COUNT_EMP(ville)
IS 
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM EMP WHERE COORDONNEE.VILLE = ville;
    DBMS_OUTPUT.PUT_LINE('Nombre d employés à ' || ville || ' : ' || v_count);
END;
