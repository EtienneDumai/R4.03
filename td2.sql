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


--
--PARTIE 2 :
--

--QUESTION 1 :
CREATE OR REPLACE TYPE Metadonnees AS OBJECT (
    auteur VARCHAR2(50),
    geolocalisation VARCHAR2(100),
    date_inscription DATE
);
CREATE OR REPLACE TYPE Url AS TABLE(
    url VARCHAR2(100)
);
CREATE OR REPLACE TYPE Relation AS TABLE(
    nom_relation VARCHAR2(50),
);
CREATE OR REPLACE TYPE Liens AS OBJECT(
    url Url,
    relation Relation
);

CREATE TABLE Tweet (
    url VARCHAR2(100),
    texte VARCHAR2(1000),
    objet_mime VARCHAR2(50),
    date_creation DATE,
    metadonnees Metadonnees,
    liens Liens);

INSERT INTO Tweet VALUES (
    'Ma-photo1', 'Photo prise lors d''une soirée avec les amis', 'image/jpeg', '12-05-2009', 
    Metadonnees('X. Tintin', '43.834526782236814 - 0.3515625', '03-04-2008'), Liens(Url('Ma-photo2', 'Ma-photo12'), Relation('thème','réponse')));

INSERT INTO Tweet VALUES (
    'Photo-belle', 'Photot d''une belle artiste', 'image/jpeg', '16-10-2014', 
    Metadonnees('Y. Dupond', '33.43144133557529 - 34.453125', '03-04-2008'), Liens(Url('Chanson12'), Relation('réponse')));

UPDATE Tweet t 
SET t.metadonnees = Metadonnees(t.metadonnees.auteur, NULL, t.metadonnees.date_inscription) 
WHERE t.url = 'Ma-photo1';
--Modifier la geolocalisation en null des tweets ayant des Liens avec 'reponse' comme relation
UPDATE Tweet t
SET t.metadonnees.geolocalisation = NULL
WHERE 'réponse' MEMBER OF t.liens.relation;

UPDATE Tweet t 
SET t.metadonnees.geolocalisation = NULL
WHERE 

SELECT t.metadonnees.geolocalisation
FROM Tweet t
WHERE 'reponse' MEMBER OF t.liens.relation;

SELECT t.uri, t.metadonnees.geolocalisation
FROM Tweet t, TABLE(t.liens.url) l
WHERE l.relation = 'reponse';


SELECT t.uri
FROM Tweet t, TABLE(t.liens) l 



