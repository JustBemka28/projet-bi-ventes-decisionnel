-- Table des faits contenant les mesures quantitatives (ventes) et les cl�s de liaison vers les dimensions
CREATE TABLE Faits_Ventes (
    id_ligne NVARCHAR(50) PRIMARY KEY,            -- Identifiant unique de la ligne de vente (cl� primaire de la table des faits)

    id_commande NVARCHAR(50),                     -- Cl� �trang�re vers la commande (Dim_Commande)
    id_client NVARCHAR(50),                       -- Cl� �trang�re vers le client (Dim_Client)
    id_produit NVARCHAR(50),                      -- Cl� �trang�re vers le produit (Dim_Produit)
    date_commande DATE,                           -- Cl� �trang�re vers la dimension temps (Dim_Temps)
    
    ventes INT,                         -- Mesure principale : le montant des ventes (avec 2 d�cimales)
    D�lai_Livraison INT,                        -- Mesure secondaire : d�lai en jours entre commande et livraison

    id_lieu INT,                                  -- Cl� �trang�re vers le lieu g�ographique (Dim_Lieu)

    -- D�finition des contraintes d�int�grit� r�f�rentielle (foreign keys)
    FOREIGN KEY (id_commande) REFERENCES Dim_Commande(id_commande),   -- Relation vers Dim_Commande
    FOREIGN KEY (id_client) REFERENCES Dim_Client(id_client),         -- Relation vers Dim_Client
    FOREIGN KEY (id_produit) REFERENCES Dim_Produit(id_produit),      -- Relation vers Dim_Produit
    FOREIGN KEY (id_lieu) REFERENCES Dim_Lieu(id_lieu),               -- Relation vers Dim_Lieu
    FOREIGN KEY (date_commande) REFERENCES Dim_Temps(id_date)         -- Relation vers Dim_Temps (temps)
);
