--PARTIE 1 :
--QUESTION 1 :
CREATE OR REPLACE TYPE B_Point AS OBJECT (
    x NUMBER,
    y NUMBER
);

--QUESTION 2 :
CREATE OR REPLACE TYPE Ligne AS OBJECT (
    p1 B_Point,
    p2 B_Point
);

--QUESTION 3 :
CREATE OR REPLACE TYPE Polygone AS OBJECT (
    p1 B_Point,
    p2 B_Point,
    p3 B_Point,
    p4 B_Point
);

--QUESTION 4 :
CREATE TABLE REGION (
    id_region NUMBER,
    nom_region VARCHAR2(50),
    poly Polygone
);

--QUESTION 5 :
INSERT INTO REGION VALUES (1, 'Aquitaine',  Polygone(  B_Point(1, 2),  B_Point(3, 4),  B_Point(5, 6),  B_Point(7, 8)));

--QUESTION 6 :
CREATE OR REPLACE TYPE Rect AS OBJECT (
    min B_Point,
    max B_Point
);

--QUESTION 7 :
CREATE TABLE VILLE (
    id_ville NUMBER,
    nom_ville VARCHAR2(50),
    rectangle Rect
);

--QUESTION 8 :
INSERT INTO VILLE VALUES (1, 'ANGLET', Rect(B_Point(8950, 4840), B_Point(9180, 5050)));
INSERT INTO VILLE VALUES (2, 'LYON', Rect(B_point(8820,7020), B_Point(9080,7230)));
INSERT INTO VILLE VALUES (3, 'PARIS', Rect(B_Point(6310,2940),B_Point(6560,3110)));

--QUESTION 9 :
SELECT v.nom_ville, (v.rectangle.max.y)- (v.rectangle.min.y) AS longY,
       (v.rectangle.max.x)- (v.rectangle.min.x) AS longX
       FROM VILLE v;

--QUESTION 10 :
SELECT v.nom_ville
FROM VILLE v
WHERE (v.rectangle.max.y)- (v.rectangle.min.y) > 10 OR (v.rectangle.max.x)- (v.rectangle.min.x) > 10;


--PARTIE 2
DROP TABLE TWEET;
DROP TABLE LIEN_TABLE;
--1
CREATE OR REPLACE TYPE Geo AS OBJECT (
  latitude NUMBER,
  longitude NUMBER
);


CREATE OR REPLACE TYPE MetaDonnee AS OBJECT (
  auteur VARCHAR2(50),
  localisation Geo,
  date_inscription DATE
);


CREATE OR REPLACE TYPE Lien AS OBJECT (
  uri VARCHAR2(100),
  relation VARCHAR2(50)
);

CREATE OR REPLACE TYPE TabLiens AS TABLE OF Lien;

CREATE TABLE Tweet (
  uri VARCHAR2(100) PRIMARY KEY,
  texte VARCHAR2(500),
  objet_mime VARCHAR2(50),
  date_heure TIMESTAMP,
  metadonnees MetaDonnee,
  liens TabLiens
) NESTED TABLE liens STORE AS Liens_Tweet;


--2
INSERT INTO Tweet VALUES ('Ma-photo1','Sous grosse khapta avec les collegues','Photo',TO_TIMESTAMP('12/05/2009', 'DD/MM/YYYY'),
  MetaDonnee('X. Tintin',Geo(43.83452678223681, -0.3515625),TO_DATE('03/04/2008', 'DD/MM/YYYY')),
  TabLiens(Lien('Ma-photo2', 'thème'),Lien('Ma-photo12', 'réponse'))
);


INSERT INTO Tweet VALUES ('Photo-Belle','Photo d’une belle artiste','Photo',TO_TIMESTAMP('16/10/2014', 'DD/MM/YYYY'),
  MetaDonnee('Y. Dupond',Geo(33.43144133557, 34.453125),TO_DATE('03/04/2008', 'DD/MM/YYYY')),
  TabLiens(Lien('Chanson12', 'réponse'))
);

--3
SELECT * FROM Tweet t
WHERE t.metadonnees.auteur LIKE '%Dupond%';

--4

UPDATE TABLE (SELECT t.liens FROM Tweet t WHERE t.uri = 'Ma-photo1')
SET relation = 'similaire'
WHERE uri = 'Ma-photo12';


--5

INSERT INTO TABLE (SELECT t.liens FROM Tweet t WHERE t.uri = 'Photo-Belle')
VALUES (Lien('pop', 'même catégorie')
);


--6

SELECT l.uri, l.relation
FROM TABLE (
  SELECT t.liens FROM Tweet t WHERE t.uri = 'Photo-Belle'
) l;

-- alternative sans where avec jointure 
SELECT l.uri, l.relation
FROM TWEET t, TABLE(t.liens) l;


--7
SELECT t2.*
FROM Tweet t1, TABLE(t1.liens) l, Tweet t2
WHERE t1.texte LIKE 'Master%' AND l.relation = 'similaire' AND l.uri = t2.uri;



SELECT t.uri, t.metadonnees.geolocalisation, COUNT(t.liens) AS nb_lien
FROM Tweet t
GROUP BY t.uri, t.metadonnees.geolocalisation 
HAVING nb_lien > 1;


--TD3
--QUESTION 1 :
CREATE OR REPLACE TYPE t_Rect2 AS OBJECT (
    min B_Point,
    max B_Point,
    MEMBER PROCEDURE inserer2Points(newPoint IN B_Point, newPoint2 IN B_Point),
    MEMBER FUNCTION SURFACE RETURN NUMBER
);
CREATE OR REPLACE TYPE BODY t_Rect2 AS 
    MEMBER PROCEDURE inserer2Points(newPoint IN B_Point, newPoint2 IN B_Point) IS
    BEGIN
        self.min := newPoint;
        self.max := newPoint2;
    END;
    MEMBER FUNCTION SURFACE RETURN NUMBER IS
    BEGIN
        RETURN ABS((self.max.x - self.min.x) * (self.max.y - self.min.y));
    END;
END;

CREATE TABLE VILLE2 (
    id_ville NUMBER,
    nom_ville VARCHAR2(50),
    rectangle t_Rect2
);
--appel de la procédure
DECLARE
    v_rect t_Rect2;
    v_min B_Point := B_Point(1, 3);
    v_max B_Point := B_Point(2, 4);
    Empv EXCEPTION;
    surface NUMBER;
BEGIN
    v_rect := t_Rect2(NULL, NULL);
    v_rect.inserer2Points(v_min, v_max);
    DBMS_OUTPUT.PUT_LINE('RECTANGLE INSERER : ' || v_rect.min.x || ' ' || v_rect.min.y || ' ' || v_rect.max.x || ' ' || v_rect.max.y);
    INSERT INTO VILLE2 VALUES (1, 'BAYONNE', v_rect);
    surface := v_rect.surface();
    DBMS_OUTPUT.PUT_LINE('SURFACE : ' || surface);
    Commit;
EXCEPTION 
    WHEN Empv THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END;

