source("./r_scripts/base.r")
# put code here
tbl <- table(tags$tag)
prop <- prop.table(tbl)
print(prop)
# always make last line
dbDisconnect(db)
