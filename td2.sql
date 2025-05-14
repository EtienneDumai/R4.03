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
