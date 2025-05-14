CREATE OR REPLACE TYPE B_Point AS OBJECT (
    x NUMBER,
    y NUMBER
);

CREATE OR REPLACE TYPE t_Rect2 AS OBJECT (
    min B_Point,
    max B_Point,
    MEMBER PROCEDURE inserer2Points(newPoint IN B_Point, newPoint2 IN B_Point)
);
CREATE OR REPLACE TYPE BODY t_Rect2 AS 
    MEMBER PROCEDURE inserer2Points(newPoint IN B_Point, newPoint2 IN B_Point) IS
    BEGIN
        self.min := newPoint;
        self.max := newPoint2;
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
BEGIN
    v_rect := t_Rect2();
    v_rect.inserer2Points();
    DBMS_OUTPUT.PUT_LINE('RECTANGLE INSERER : ' || v_rect.min.x || ' ' || v_rect.min.y || ' ' || v_rect.max.x || ' ' || v_rect.max.y);
    INSERT INTO VILLE2 VALUES (1, 'BAYONNE', v_rect);
    ERROR WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
    END;
END;
