source("/home/mich/Documents/steam-insights/r_scripts/base.r")
barplot(table(genres$genre))
dbDisconnect(db)