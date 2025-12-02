source("/home/mich/Documents/steam-insights/r_scripts/base.r")
boxplot(reviews$total)
dbDisconnect(db)