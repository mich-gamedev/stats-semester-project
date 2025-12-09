source("./r_scripts/base.r")
df_indie <- dbGetQuery(db, "
SELECT review_score_description
FROM reviews
WHERE app_id IN (SELECT app_id FROM tags WHERE tag = 'PvP') AND
app_id IN (SELECT app_id FROM tags WHERE tag = 'Indie') AND
(review_score_description LIKE '%Positive' OR
review_score_description LIKE '%Negative' OR
review_score_description = 'Mixed')
")
df_total <- dbGetQuery(db, "
SELECT review_score_description
FROM reviews
WHERE app_id IN (SELECT app_id FROM tags WHERE tag = 'PvP') AND
(review_score_description LIKE '%Positive' OR
review_score_description LIKE '%Negative' OR
review_score_description = 'Mixed')
")
df_all_indie <- df_indie <- dbGetQuery(db, "
SELECT review_score_description
FROM reviews
WHERE app_id IN (SELECT app_id FROM tags WHERE tag = 'Indie') AND
(review_score_description LIKE '%Positive' OR
review_score_description LIKE '%Negative' OR
review_score_description = 'Mixed')
")
df_all_total <- dbGetQuery(db, "
SELECT review_score_description
FROM reviews
WHERE review_score_description LIKE '%Positive' OR
review_score_description LIKE '%Negative' OR
review_score_description = 'Mixed'
")

tbl_indie <- table(df_indie)
tbl_total <- table(df_total)
tbl_all_indie <- table(df_all_indie)
tbl_all_total <- table(df_all_total)

fig_0 <- plot_ly(y = tbl_indie / tbl_total, type = "bar")
fig_1 <- plot_ly(y = tbl_all_indie / tbl_all_total, type = "bar")
print(subplot(fig_0, fig_1))