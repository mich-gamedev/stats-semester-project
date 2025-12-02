source("/home/mich/Documents/steam-insights/r_scripts/base.r")
pie(table(genres$genre)) #TODO: Find a way to group small categories into "Other" category
dbDisconnect(db)
