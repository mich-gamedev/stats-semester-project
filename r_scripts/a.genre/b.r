source("./r_scripts/base.r")
# put code here
tbl <- table(genres$genre)
prop <- prop.table(tbl)
print(prop)
# always make last line
dbDisconnect(db)
