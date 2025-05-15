CREATE
OR REPLACE TYPE Categorie AS OBJECT(NoCat NUMBER, Libelle VARCHAR2(50));

CREATE TABLE Article(
    NoArt VARCHAR2(50),
    Description VARCHAR2(50),
    Couleur VARCHAR2(50),
    Cat Categorie,
    Prix NUMBER,
    Stock NUMBER
);

-- Supprimer l'ancien type
DROP TYPE T_Panier FORCE;

-- Créer le type élémentaire
CREATE
OR REPLACE TYPE T_Panier AS OBJECT (Cmde NUMBER);

-- Créer le type TABLE pour gérer un panier multiple
CREATE
OR REPLACE TYPE T_PanierTab AS TABLE OF T_Panier;

-- Supprimer la table Client si elle existe
DROP TABLE Client;

-- Recréer avec panier comme collection
CREATE TABLE Client(
    NoClient NUMBER,
    NomClient VARCHAR2(50),
    Ville VARCHAR2(50),
    Panier T_PanierTab
) NESTED TABLE Panier STORE AS Panier_Client;

CREATE
OR REPLACE TYPE T_Details AS OBJECT(Art VARCHAR2(50), QteCmde NUMBER);

CREATE
OR REPLACE TYPE T_DetailsTab AS TABLE OF T_Details;

CREATE TABLE Commande(
    NoCmde NUMBER,
    DateCmde DATE,
    Details T_DetailsTab
) NESTED TABLE Details STORE AS Details_Commande;

CREATE SEQUENCE SeqClient START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE SeqCommande START WITH 100 INCREMENT BY 1;

INSERT INTO
    Article
VALUES
    (
        'A1',
        'MacPro',
        'Rouge',
        Categorie(1, 'Apple'),
        1.50,
        500
    );

INSERT INTO
    Article
VALUES
    (
        'A2',
        'MacPro Air',
        'Blanc',
        Categorie(1, 'Apple'),
        1.50,
        800
    );

INSERT INTO
    Article
VALUES
    (
        'A3',
        'MacPro Server',
        'Noir',
        Categorie(1, 'Apple'),
        2.00,
        1000
    );

INSERT INTO
    Article
VALUES
    (
        'A4',
        'Dell',
        'Jaune',
        Categorie(2, 'PC'),
        1500,
        1
    );

INSERT INTO
    Article
VALUES
    (
        'A5',
        'HP',
        'Bleu',
        Categorie(1, 'Apple'),
        10.00,
        200
    );

INSERT INTO
    Article
VALUES
    (
        'A6',
        'Acer',
        'Gris',
        Categorie(3, 'Autre'),
        10.00,
        25
    );

INSERT INTO
    Article
VALUES
    (
        'A7',
        'Sony',
        'Noir',
        Categorie(2, 'PC'),
        120,
        300
    );

INSERT INTO
    Client
VALUES
    (
        SeqClient.NEXTVAL,
        'BARTH Florent',
        'Anglet',
        T_PanierTab(
            T_Panier(101),
            T_Panier(106),
            T_Panier(107)
        )
    );

INSERT INTO
    Client
VALUES
    (
        SeqClient.NEXTVAL,
        'FREE Marc',
        'Lyon',
        T_PanierTab(T_Panier(102))
    );

INSERT INTO
    Client
VALUES
    (
        SeqClient.NEXTVAL,
        'POISSON Christophe',
        'Lille',
        T_PanierTab(T_Panier(103), T_Panier(104))
    );

INSERT INTO
    Client
VALUES
    (
        SeqClient.NEXTVAL,
        'BLAKE John',
        'Metz',
        T_PanierTab(T_Panier(105))
    );

INSERT INTO
    Client
VALUES
    (
        SeqClient.NEXTVAL,
        'DUPONT Jean',
        'Paris',
        NULL
    );

INSERT INTO
    Commande
VALUES
    (
        SeqCommande.NEXTVAL,
        TO_DATE('10/10/2008', 'DD/MM/YYYY'),
        T_DetailsTab(
            T_Details('A1', 5),
            T_Details('A2', 6),
            T_Details('A3', 4)
        )
    );

INSERT INTO
    Commande
VALUES
    (
        SeqCommande.NEXTVAL,
        TO_DATE('12/11/2007', 'DD/MM/YYYY'),
        T_DetailsTab(T_Details('A4', 2))
    );

INSERT INTO
    Commande
VALUES
    (
        SeqCommande.NEXTVAL,
        TO_DATE('13/02/2008', 'DD/MM/YYYY'),
        T_DetailsTab(
            T_Details('A5', 3),
            T_Details('A1', 2)
        )
    );

INSERT INTO
    Commande
VALUES
    (
        SeqCommande.NEXTVAL,
        TO_DATE('12/12/2006', 'DD/MM/YYYY'),
        T_DetailsTab(T_Details('A2', 1))
    );

INSERT INTO
    Commande
VALUES
    (
        SeqCommande.NEXTVAL,
        TO_DATE('01/05/2008', 'DD/MM/YYYY'),
        T_DetailsTab(T_Details('A3', 2))
    );

INSERT INTO
    Commande
VALUES
    (
        SeqCommande.NEXTVAL,
        TO_DATE('02/02/2008', 'DD/MM/YYYY'),
        T_DetailsTab(T_Details('A6', 3))
    );

INSERT INTO
    Commande
VALUES
    (
        SeqCommande.NEXTVAL,
        TO_DATE('03/06/2005', 'DD/MM/YYYY'),
        T_DetailsTab(T_Details('A4', 2))
    );


--Q4 REQ 1 : 
SELECT a.NoArt, a.Description, a.Prix, d.QteCmde, a.Prix * d.QteCmde AS Montant
FROM Article a, TABLE(a.Panier) d, Commande c 
WHERE a.NoArt = d.Art AND c.NoCmde = :nocmde;

--Q4 REQ 2 :
SELECT SUM(d.QteCmde) AS QteTotale
FROM  Commande c, TABLE(c.Details) d;