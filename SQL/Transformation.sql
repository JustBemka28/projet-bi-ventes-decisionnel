SELECT id_produit, COUNT(*) AS nbr -- 1️⃣ Vérifier les doublons
FROM Dim_Produit
GROUP BY id_produit
HAVING COUNT(*) > 1;


-- 2️⃣ Supprimer les doublons : on garde un seul enregistrement par id_produit

WITH CTE_Doublons AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY id_produit ORDER BY id_produit) AS rang
    FROM Dim_Produit
)
DELETE FROM CTE_Doublons
WHERE rang > 1;


-- 3️⃣ Ajouter la clé primaire
ALTER TABLE Dim_Produit
ADD CONSTRAINT PK_Dim_Produit PRIMARY KEY (id_produit);


ALTER TABLE Faits_Ventes
ADD CONSTRAINT FK_FaitsVentes_DimProduit
FOREIGN KEY (id_produit) REFERENCES Dim_Produit(id_produit);
