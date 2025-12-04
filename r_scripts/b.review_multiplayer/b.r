source("./r_scripts/base.r")
table <- dbGetQuery(db, "SELECT * FROM reviews WHERE total > 20 AND EXISTS (SELECT * FROM tags WHERE reviews.app_id = tags.app_id AND tag = 'PvP')") # nolint: line_length_linter.
hist(table$total, freq = TRUE, density=10)
dbDisconnect(db)