source("./r_scripts/base.r")

df <- dbGetQuery(db, "
SELECT games.name, games.release_date, reviews.review_score_description, reviews.total
FROM games
INNER JOIN reviews ON reviews.app_id = games.app_id
WHERE games.app_id IN (SELECT app_id FROM tags WHERE tag = 'Multiplayer') AND
games.release_date <> '\\N' AND
(reviews.review_score_description LIKE '%Positive' OR reviews.review_score_description LIKE '%Negative' OR reviews.review_score_description = 'Mixed')
")
fig <- plotly::subplot(
    ggplot(df, aes(x = as.integer(strsplit(df$release_date, "-")[1]), y=df$total)) +
    geom_point(aes(color = factor(df$review_score_description), text=df$name)) +
    labs(title = "Linear Regression & Local Regression (LOESS)", x = "Release Month", y = "Review count") +
    scale_color_manual(values = c(
        "Overwhelmingly Negative" = "#680045",
        "Very Negative" = "#dd6b3b",
        "Negative" = "#ec9849",
        "Mostly Negative" = "#eeb93e",
        "Mixed" = "#f1d710",
        "Mostly Positive" = "#abda64",
        "Positive" = "#36d353",
        "Very Positive" = "#1ce092",
        "Overwhelmingly Positive" = "#00bcd1"
    )) +
    scale_fill_discrete(breaks = c("Overwhelmingly Negative", "Very Negative", "Negative", "Mostly Negative", "Mixed", "Mostly Positive", "Positive", "Very Positive", "Overwhelmingly Positive"))
)
print(fig)