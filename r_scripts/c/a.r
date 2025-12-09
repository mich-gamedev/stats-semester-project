source("./r_scripts/base.r")

df <- dbGetQuery(db, "
SELECT reviews.review_score_description, tags.tag 
FROM reviews
INNER JOIN tags
ON reviews.app_id=tags.app_id
WHERE tags.tag IN (SELECT genre FROM tag_info)
AND (reviews.review_score_description LIKE '%Positive'
OR reviews.review_score_description LIKE '%Negative'
OR reviews.review_score_description='Mixed'
AND tags.app_id IN (SELECT app_id FROM tags WHERE tags.tag = 'PvP')
)
")
library(DT)
tbl <- table(df$tag, df$review_score_description)
tbl_df <- as.data.frame.matrix(tbl)