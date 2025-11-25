source("/home/mich/Documents/steam-insights/r_scripts/base.r")
# put code here
# a.genre
print(table(genres$genre))
# always make last line
dbDisconnect(db)
