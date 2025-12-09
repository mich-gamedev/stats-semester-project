source("./r_scripts/base.r")
library(treemap)
library(wordcloud)
df <- dbGetQuery(db, "
SELECT COUNT(app_id) AS count, tag
FROM tags
GROUP BY tag
ORDER BY COUNT(app_id) DESC
")
wc <- wordcloud(words = df$tag, freq = df$count)
print(wc)

dbDisconnect(db)