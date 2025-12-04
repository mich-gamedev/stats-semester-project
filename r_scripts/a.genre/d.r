source("./r_scripts/base.r")
barplot(table(genres$genre))
dbDisconnect(db)