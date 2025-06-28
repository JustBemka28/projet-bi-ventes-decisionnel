# 📊 Projet Business Intelligence – De l’exploration à la visualisation Power BI

Ce projet complet de Business Intelligence a été conçu pour analyser des données de ventes à grande échelle. Il couvre l’ensemble du cycle décisionnel : de l’analyse exploratoire à la visualisation dynamique avec Power BI, en passant par l’ingénierie des données, l’intégration (ETL), la modélisation et les calculs analytiques.

---

## 🛠️ Technologies utilisées

- **Python / Jupyter / Google Colab** – Exploration, transformation et nettoyage des données
- **SQL Server** – Stockage relationnel, modélisation en étoile
- - **Visual Studio Data Tools** – Intégration de données (ETL)
- **SSIS** – Intégration de données (ETL)
- **SSAS Tabulaire** – Modèle analytique et mesures DAX
- **Power BI Desktop** – Visualisation et rapports interactifs
- **Git** – Suivi de version
ss
---

## 🔍 1. Analyse exploratoire et préparation des données

Traitement réalisé sur Google Colab avec Python (Pandas, NumPy, Matplotlib, Seaborn) :

- Inspection du jeu de données brut
- Traitement des valeurs manquantes
- Normalisation et harmonisation des noms de colonnes
- Feature engineering (création de nouvelles colonnes comme le délai de livraison)
- Segmentation logique des données pour la modélisation en étoile

### Résultat :
- Découpage en plusieurs fichiers CSV :
  - `Dim_Client.csv`
  - `Dim_Produit.csv`
  - `Dim_Commande.csv`
  - `Dim_Lieu.csv`
  - `Dim_Temps.csv`
  - `Faits_Ventes.csv`

---

## 🧱 2. Création de la base de données relationnelle (SQL Server)

- Création d’un schéma en étoile (1 table de faits, 5 dimensions)
- Définition des clés primaires / étrangères
- Insertion des données nettoyées à partir des fichiers CSV exportés depuis Colab
- Vérification d'intégrité et indexation

---

## 🔄 3. Intégration avec SSIS (ETL)

Développement de flux de données pour :

- Charger les fichiers CSV nettoyés dans la base SQL
- Convertir les types de données
- Gérer les doublons et erreurs
- Appliquer des transformations supplémentaires si nécessaire (lookup, dérivés, split, etc.)

---

## 🧠 4. Modélisation analytique avec SSAS Tabulaire

- Connexion à la base SQL
- Création du modèle tabulaire (relations, hiérarchies temporelles)
- Déploiement et traitement du cube

### Mesures DAX principales :

```DAX
Total_Ventes := SUM(Faits_Ventes[ventes])
Nb_Commandes := DISTINCTCOUNT(Faits_Ventes[id_commande])
Clients_Actifs := DISTINCTCOUNT(Faits_Ventes[id_client])
Delai_Livraison_Moyen := AVERAGE(Faits_Ventes[Délai_Livraison])
Livraison_Retard := 
    DIVIDE(
        CALCULATE(COUNTROWS(Faits_Ventes), Faits_Ventes[Délai_Livraison] > 3),
        COUNTROWS(Faits_Ventes)
    )
Ventes_Moyennes_Commande := DIVIDE([Total_Ventes], [Nb_Commandes])
📈 5. Visualisation avec Power BI
Connexion directe au cube SSAS

Construction de rapports :

Dashboard global : KPI financiers + logistiques

Analyse client : comportement, localisation, fidélisation

Analyse produit : top produits, marges, concentration

Analyse temporelle : saisonnalité, ventes/jour/mois

Dashboard logistique : délais par produit, ville, mode de livraison

📌 Résultats obtenus
Détection de dépendances produit critiques (effet Canon)

Mise en évidence de la saisonnalité des ventes (novembre-décembre)

Segmentation client profitable (valeur Corporate plus élevée)

Recommandations logistiques (Same Day à activer, villes à risque)

Base solide pour un système de pilotage BI en continu

📁 Structure du dépôt
bash
Copier
Modifier
.
├── README.md
├── notebooks/
│   └── exploration_cleaning.ipynb
├── exports_csv/
│   ├── Dim_Client.csv
│   ├── Dim_Produit.csv
│   ├── Dim_Commande.csv
│   ├── Faits_Ventes.csv
│   └── ...
├── sql/
│   └── schema_et_insert.sql
├── ssis/
│   └── etl_package.dtsx
├── ssas/
│   └── modele_tabulaire.bim
├── powerbi/
│   └── dashboard.pbix
└── documentation/
    ├── analyse_metier.pdf
    ├── mesures_dax.tex
    └── dictionnaire_donnees.xlsx
🚀 Pour exécuter le projet
Ouvrir et exécuter le notebook Python dans /notebooks pour générer les fichiers CSV.

Importer les données dans SQL Server via SSIS (etl_package.dtsx).

Configurer et déployer le modèle SSAS (modele_tabulaire.bim).

Ouvrir le fichier Power BI (dashboard.pbix) et connecter au modèle tabulaire.

📬 Auteur
Kabem Sankara
🎓 Projet académique – Science et technologie de l'information (UQO)
📧 [ton-email@exemple.com]
🔗 [Lien LinkedIn, Portfolio ou GitHub si tu veux]

markdown
Copier
Modifier

---

### ✅ Tu peux maintenant :
- Le coller dans ton `README.md`
- Ajouter des captures d'écran Power BI si tu veux améliorer la lisibilité visuelle
- Ajouter un badge `Python`, `Power BI`, `SSIS`, etc. pour l'esthétique (facultatif)

Souhaites-tu que je t’aide à :
- Générer les badges GitHub ?
- Faire une version en anglais pour LinkedIn ou GitHub international ?
- Créer un fichier `.pdf` pro avec tout ça ?

Dis-moi comment tu veux finaliser ce travail 👇







