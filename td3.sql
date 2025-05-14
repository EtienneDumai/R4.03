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
