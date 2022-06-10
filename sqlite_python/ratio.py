# Objectif est de calculer le ratio de la surface terrestre totale 
# Sur la surface des océans totale appartenant aux pays de la table facts

import pandas as pd
import sqlite3 

connexion = sqlite3.connect('../factbook.db/factbook.db')

# On affiche dans un tableau pandas les sommes des surfaces terrestres et surfaces de l'eau pour chaque pays
a = pd.read_sql_query('select sum(area_land), sum(area_water) from facts where area_land != "";', con = connexion)

# On affiche le ratio Terre / Mer
print(a['sum(area_land)']/a['sum(area_water)'])