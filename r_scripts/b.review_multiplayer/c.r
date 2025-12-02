source("/home/mich/Documents/steam-insights/r_scripts/base.r")
table <- dbGetQuery(db, "SELECT * FROM reviews WHERE EXISTS (SELECT * FROM tags WHERE reviews.app_id = tags.app_id AND tag = 'PvP')")
boxplot(table$total)
dbDisconnect(db)