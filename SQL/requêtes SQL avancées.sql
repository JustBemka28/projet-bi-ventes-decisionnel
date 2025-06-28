-- 1. SLICE : Analyse des ventes en 2017

SELECT 
    T.annee, 
    SUM(F.ventes) AS total_ventes
FROM Faits_Ventes F
JOIN Dim_Temps T ON F.date_commande = T.id_date
WHERE T.annee = 2017
GROUP BY T.annee;


-- 2. DICE : Ventes en 2016 pour les produits technologiques livrés en moins de 3 jours

SELECT 
    P.nom_produit, 
    C.nom_client, 
    F.ventes, 
    F.Delai_Livraison
FROM Faits_Ventes F
JOIN Dim_Produit P ON F.id_produit = P.id_produit
JOIN Dim_Client C ON F.id_client = C.id_client
JOIN Dim_Temps T ON F.date_commande = T.id_date
WHERE 
    P.categorie = 'technology'
    AND F.delai_livraison < 3
    AND T.annee = 2016;

-- 3. ROLL-UP : Total des ventes par pays, puis par région

SELECT 
    L.pays, 
    L.region, 
    SUM(F.ventes) AS total_ventes
FROM Faits_Ventes F
JOIN Dim_Lieu L ON F.id_lieu = L.id_lieu
GROUP BY ROLLUP (L.pays, L.region);


-- 4. DRILL-DOWN : Détail des ventes par mois pour l’année 2017

SELECT 
    T.annee, 
    T.mois, 
    SUM(F.ventes) AS total_ventes
FROM Faits_Ventes F
JOIN Dim_Temps T ON F.date_commande = T.id_date
WHERE T.annee = 2017
GROUP BY T.annee, T.mois
ORDER BY T.mois;


-- 5. PIVOT : Total des ventes par catégorie et par année

SELECT *
FROM (
    SELECT 
        P.categorie, 
        T.annee, 
        F.ventes
    FROM Faits_Ventes F
    JOIN Dim_Produit P ON F.id_produit = P.id_produit
    JOIN Dim_Temps T ON F.date_commande = T.id_date
) AS source_table
PIVOT (
    SUM(ventes) 
    FOR annee IN ([2015], [2016], [2017])
) AS pivot_table;

--6. Analyse du délai moyen de livraison par mode de livraison

SELECT 
    DC.mode_livraison, 
    AVG(F.Delai_Livraison) AS delai_moyen
FROM Faits_Ventes F
JOIN Dim_Commande DC ON F.id_commande = DC.id_commande
GROUP BY DC.mode_livraison;


-- 7. Top 5 produits les plus vendus (en valeur totale)

SELECT TOP 5 
    P.nom_produit, 
    SUM(F.ventes) AS total_ventes
FROM Faits_Ventes F
JOIN Dim_Produit P ON F.id_produit = P.id_produit
GROUP BY P.nom_produit
ORDER BY total_ventes DESC;

-- 8. Pourcentage des ventes par segment de clientèle

SELECT 
    C.segment_client,
    SUM(F.ventes) AS total_ventes,
    ROUND(SUM(F.ventes) * 100.0 / SUM(SUM(F.ventes)) OVER (), 2) AS pourcentage
FROM Faits_Ventes F
JOIN Dim_Client C ON F.id_client = C.id_client
GROUP BY C.segment_client;


-- 9. Requêtes temporelles : croissance mensuelle des ventes

SELECT 
    annee,
    mois,
    SUM(ventes) AS total_ventes,
    LAG(SUM(ventes)) OVER (ORDER BY annee, mois) AS ventes_mois_précédent,
    (SUM(ventes) - LAG(SUM(ventes)) OVER (ORDER BY annee, mois)) * 1.0 / 
     NULLIF(LAG(SUM(ventes)) OVER (ORDER BY annee, mois), 0) * 100 AS croissance_pourcentage
FROM Faits_Ventes F
JOIN Dim_Temps T ON F.date_commande = T.id_date
GROUP BY annee, mois
ORDER BY annee, mois;


-- 10. Nombre de commandes livrées en retard (> délai moyen)

WITH Moyenne_Delai AS (
    SELECT AVG(Delai_Livraison) AS delai_moyen
    FROM Faits_Ventes
)
SELECT COUNT(*) AS commandes_en_retard
FROM Faits_Ventes F
CROSS JOIN Moyenne_Delai M
WHERE F.Delai_Livraison > M.delai_moyen;
