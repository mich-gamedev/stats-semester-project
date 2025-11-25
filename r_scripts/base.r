# config
cfg_path <- "/home/mich/Documents/steam-insights/config.r"
source(cfg_path)
# libraries
library("httpgd")
library("RMySQL")
library("RSQLite")
# db setup
db <- dbConnect(RSQLite::SQLite(), db_path)
dbListTables(db)
# data frames
categories   <- dbGetQuery(db, "SELECT * FROM categories") # `SELECT * FROM ___` will grab the table called ___
descriptions <- dbGetQuery(db, "SELECT * FROM descriptions")
games        <- dbGetQuery(db, "SELECT * FROM games")
genres       <- dbGetQuery(db, "SELECT * FROM genres")
reviews      <- dbGetQuery(db, "SELECT * FROM reviews")
steamspy     <- dbGetQuery(db, "SELECT * FROM steamspy_insights")
tags         <- dbGetQuery(db, "SELECT * FROM tags")
httpgd::hgd()