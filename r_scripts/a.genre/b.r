source("/home/mich/Documents/steam-insights/r_scripts/base.r")
# put code here
all_genres <- dbGetQuery(db, "SELECT DISTINCT genre FROM genres")
all_ids <- dbGetQuery(db, "SELECT DISTINCT app_id FROM genres")
# always make last line
dbDisconnect(db)
