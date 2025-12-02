source("/home/mich/Documents/steam-insights/r_scripts/base.r")
# put code here
print(table(tags$tag))
# always make last line
dbDisconnect(db)
