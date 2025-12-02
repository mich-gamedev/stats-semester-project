source("/home/mich/Documents/steam-insights/r_scripts/base.r")
reviews_filtered <- dbGetQuery(db, "SELECT * FROM reviews WHERE review_score_description LIKE '% Positive' OR review_score_description LIKE '% Negative' OR review_score_description = 'Mixed')
table()