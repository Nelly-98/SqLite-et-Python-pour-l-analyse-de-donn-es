
# Utliser python avec sqlite

import sqlite3
connexion = sqlite3.connect("../factbook.db/factbook.db")
c = connexion.cursor()
c.execute("select * from facts order by population asc limit 10;")
result = c.fetchall()
print(result)