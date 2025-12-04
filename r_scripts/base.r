# config
print(getwd())
# libraries
library("httpgd")
library("RMySQL")
library("RSQLite")
library("plotly")
# db setup
# documentation (SQL in R): https://jcfly3000.github.io/Into-R/data%20manipulation/7%20SQL%20database.html
# documentation (SQL)     : https://www.w3schools.com/sql/
db <- dbConnect(RSQLite::SQLite(), "/home/mich/Documents/steam-insights/steam.db")
dbListTables(db)
# data frames
categories   <- dbGetQuery(db, "SELECT * FROM categories") # `SELECT * FROM ___` will grab the table called ___
descriptions <- dbGetQuery(db, "SELECT * FROM descriptions")
games        <- dbGetQuery(db, "SELECT * FROM games")
genres       <- dbGetQuery(db, "SELECT * FROM genres WHERE genre IN (SELECT tl_genre FROM tag_info)")
reviews      <- dbGetQuery(db, "SELECT * FROM reviews WHERE total BETWEEN 2000 AND 8000000")
steamspy     <- dbGetQuery(db, "SELECT * FROM steamspy_insights")
tags         <- dbGetQuery(db, "SELECT * FROM tags")
httpgd::hgd_close()
httpgd::hgd()
httpgd::hgd_view()