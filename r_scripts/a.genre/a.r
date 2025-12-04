source("./r_scripts/base.r") # `./some_file.r` grabs a file relative to the working directory, which should always be steam-insights/
# put code here
print(table(genres$genre))
# always make last line
dbDisconnect(db)
