CREATE OR REPLACE TYPE Categorie AS OBJECT(
    NoCat NUMBER,
    Libelle VARCHAR2(50)
);

CREATE TABLE Article(
    NoArt VARCHAR2(50)
    Description VARCHAR2(50),
    Couleur VARCHAR2(50),
    Cat Categorie,
    Prix NUMBER,
    Stock NUMBER
);
CREATE OR REPLACE TYPE T_Panier AS OBJECT (
    Cmde NUMBER);

CREATE TABLE Client(
    NoClient NUMBER,
    NomClient VARCHAR2(50),
    Ville VARCHAR2(50),
    Panier PanierClient,
);

CREATE OR REPLACE TYPE T_Details AS OBJECT(
    Art VARCHAR2(50),
    QteCmde NUMBER
);
CREATE OR REPLACE TYPE T_DetailsTab AS TABLE OF T_Details;

CREATE TABLE Commande(
    NoCmde NUMBER,
    DateCmde DATE,
    Details T_DetailsTab
)NESTED TABLE Details STORE AS Details_Commande;