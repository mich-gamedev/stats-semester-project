source("/home/mich/Documents/steam-insights/r_scripts/base.r")

df <- dbGetQuery(db, "
SELECT steamspy_insights.price, reviews.total, reviews.review_score, games.name
FROM steamspy_insights
INNER JOIN reviews ON steamspy_insights.app_id=reviews.app_id
INNER JOIN games ON steamspy_insights.app_id=games.app_id
WHERE (reviews.review_score_description LIKE '% Positive'
OR reviews.review_score_description LIKE '% Negative'
OR reviews.review_score_description='Mixed')
AND reviews.app_id IN (SELECT app_id FROM tags WHERE tags.tag = 'PvP')
AND reviews.app_id IN (SELECT app_id FROM tags WHERE tags.tag = 'Indie')
")
reg <- lm(df$total ~ df$price)
coeff <- cor(df$price, df$total)