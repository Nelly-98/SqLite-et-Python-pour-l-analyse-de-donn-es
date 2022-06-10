
# Calculer une estimation de la populaion en 2050

import pandas as pd
import math
import sqlite3

connexion = sqlite3.connect("../factbook.db/factbook.db")

# fonction de la librairie pandas qui va nous permettre de lire nos données dans un dataframe(une sorte de tableau)
# Elle prend 2 paramètres : la requête sql et con qui est la variable de connexion
a = pd.read_sql_query('select * from facts;', con = connexion)
print(a)

# Utilisation d'une méthode permettant de rétirer les valeurs manquantes c'est la méthode dropna()
# N = N0*e**(rt)
# N est la population finale qu'on calcule
# N0 est la population initiale
# e est une constante
# r est le taux de croissance annuelle
# t est le nombre d'années entre l'estimation et l'initiale

# exemple, on a 5000 habitants, le taux de croissance r de 4% 2015 --> 2050, donc t = 2050 - 2015 = 35
# d'ou N = 5000*e**(0.04*35)

# définition de la fonction qui calcule une estimation de la population en 2015
def pop_growth(x):
    return x['population'] * math.e ** ((x['population_growth']/100) * 35)

# Application de la fonction pop_growth à chaque pays + créatio d'une colonne pop_2050 qui va contenir les résultats
a['pop_2050'] = a.apply(lambda row: pop_growth(row), axis=1)

# Suppression des lignes contenant des valeurs manquantes
a = a.dropna(axis = 0)

# On filtre les pays qui ont une surface terrestre > 0 et une population > 0
a = a[(a['area_land']>0) & (a['population']>0)]

# On trie les pays par population décroissante
b = a.sort_values(['pop_2050'], ascending = [False])

# On assigne à la variable b les noms des pays correspondants limités à 10 valeurs
b = b['name'].iloc[0:9]
# On affiche b
print(b)
