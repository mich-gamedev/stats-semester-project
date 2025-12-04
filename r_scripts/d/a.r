source("/home/mich/Documents/steam-insights/r_scripts/base.r")
print("before SQL query")
df <- dbGetQuery(db, "
SELECT reviews.total, reviews.review_score, steamspy_insights.publisher AS publishers
FROM reviews
INNER JOIN steamspy_insights ON reviews.app_id=steamspy_insights.app_id
WHERE reviews.app_id IN (SELECT app_id FROM tags WHERE tags.tag = 'PvP')
AND reviews.app_id IN (SELECT app_id FROM tags WHERE tags.tag = 'Indie')
AND reviews.total > 500
AND NOT publishers='\\N'
AND (SELECT COUNT(publisher) FROM steamspy_insights WHERE steamspy_insights.publisher=publishers)>1
")
print("SQL Query finished")
means <- by(df$total, df$publisher, mean)
stdevs <- by(df$total, df$publisher, sd)
