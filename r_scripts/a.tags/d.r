source("/home/mich/Documents/steam-insights/r_scripts/base.r")
#barplot(table(tags$tag)) # TODO : figure out how to represent this better
library(treemap)
library(wordcloud)
df <- dbGetQuery(db, "
SELECT COUNT(app_id) AS count, tag
FROM tags
GROUP BY tag
ORDER BY COUNT(app_id) DESC
")
tm <- treemap(
    df,
    index = "tag",
    vSize = "count",
    type  = "index"
)
wc <- wordcloud(words = df$tag, freq = df$count)

dbDisconnect(db)