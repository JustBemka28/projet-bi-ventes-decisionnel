-- Table de dimension g�ographique contenant les lieux uniques
CREATE TABLE Dim_Lieu (
    id_lieu INT PRIMARY KEY,                  -- Identifiant unique pour chaque lieu
    pays NVARCHAR(100),                       -- Nom du pays
    ville NVARCHAR(100),                      -- Nom de la ville
    �tat NVARCHAR(100),                       -- Nom de l��tat ou province
    r�gion NVARCHAR(100),                     -- R�gion administrative
    code_postal INT                  -- Code postal
);


-- Table de dimension client contenant les informations clients
CREATE TABLE Dim_Client (
    id_client NVARCHAR(50) PRIMARY KEY,       -- Identifiant unique du client
    nom_client NVARCHAR(255),                 -- Nom complet du client
    segment_client NVARCHAR(100),             -- Type ou segment de client�le (ex. entreprise, particulier)
    id_lieu INT FOREIGN KEY REFERENCES Dim_Lieu(id_lieu)  -- R�f�rence au lieu du client
);


-- Table de dimension produit contenant les informations produits
CREATE TABLE Dim_Produit (
    id_produit NVARCHAR(50) PRIMARY KEY,      -- Identifiant unique du produit
    nom_produit NVARCHAR(255),                -- Nom complet du produit
    cat�gorie NVARCHAR(100),                  -- Cat�gorie principale (ex. mobilier, technologie)
    sous_cat�gorie NVARCHAR(100)            -- Sous-cat�gorie (ex. chaise, t�l�phone)
);


-- Table de dimension commande contenant les informations de livraison
CREATE TABLE Dim_Commande (
    id_commande NVARCHAR(50) PRIMARY KEY,     -- Identifiant unique de la commande
    date_commande DATE,                       -- Date de la commande
    date_exp�dition DATE,                     -- Date d�exp�dition
    mode_livraison NVARCHAR(100),             -- Mode de livraison (ex. standard, express)
    D�lai_Livraison INT                     -- D�lai entre commande et exp�dition (en jours)
);


-- Table de dimension temps utilis�e pour les analyses temporelles
CREATE TABLE Dim_Temps (
    id_date DATE PRIMARY KEY,                 -- Date unique utilis�e comme identifiant
    ann�e INT,                                -- Ann�e de la commande
    mois INT,                                 -- Mois de la commande
    jour INT                                  -- Jour du mois
);
