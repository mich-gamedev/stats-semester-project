source("./r_scripts/base.r")

df <- dbGetQuery(db, "
SELECT 
    review_score_description,
    COUNT(CASE
        WHEN app_id IN (SELECT app_id FROM tags WHERE tag = 'Indie')
            THEN app_id
        ELSE NULL    
        END) AS indie,
    COUNT(*) AS total
FROM reviews
WHERE app_id IN (SELECT app_id FROM tags WHERE tag = 'Multiplayer') AND
(review_score_description LIKE '%Positive'
OR review_score_description LIKE '%Negative'
OR review_score_description = 'Mixed')
GROUP BY review_score_description
ORDER BY CASE
    WHEN review_score_description = 'Overwhelmingly Negative' THEN 1
    WHEN review_score_description = 'Very Negative' THEN 2
    WHEN review_score_description = 'Negative' THEN 3
    WHEN review_score_description = 'Mostly Negative' THEN 4
    WHEN review_score_description = 'Mixed' THEN 5
    WHEN review_score_description = 'Mostly Positive' THEN 6
    WHEN review_score_description = 'Positive' THEN 7
    WHEN review_score_description = 'Very Positive' THEN 8
    WHEN review_score_description = 'Overwhelmingly Positive' THEN 9
    END ASC
")
colors <- c(
    list(color = 'rgb(164,0,109)'), # overwhelmingly neg
    list(color = 'rgb(225, 121, 77)'), # very neg
    list(color = 'rgb(235,161,90)'), # neg
    list(color = 'rgb(246,203,103)'), # mostly neg
    list(color = 'rgb(255,239,115)'), # mixed
    list(color = 'rgb(201,243,139)'), # mostly pos
    list(color = 'rgb(144,248,163)'), # pos
    list(color = 'rgb(99,251,190)'), # very pos
    list(color = 'rgb(0,229,255)') # overwhelmingly pos
)
print(df)
fig <- plot_ly(
    df, 
    x = df$review_score_description, 
    y = (df$indie / df$total) * 100, 
    text = paste(df$indie, df$total, sep = " / "), 
    type = 'bar',
    marker = list(color = c('rgb(164,0,109)', 'rgb(225, 121, 77)', 'rgb(235,161,90)', 'rgb(246,203,103)', 'rgb(255,239,115)', 'rgb(201,243,139)', 'rgb(144,248,163)', 'rgb(99,251,190)', 'rgb(0,229,255)')),
    showlegend = FALSE
)
fig <- add_trace(
    fig,
    y = 100 - ((df$indie / df$total) * 100),
    marker = list(color = c('rgba(164,0,109,0.1)', 'rgba(225, 121, 77,0.1)', 'rgba(235,161,90,0.1)', 'rgba(246,203,103,0.1)', 'rgba(255,239,115,0.1)', 'rgba(201,243,139,0.1)', 'rgba(144,248,163,0.1)', 'rgba(99,251,190,0.1)', 'rgba(0,229,255,0.1)')),
    text = paste(df$total - df$indie, df$total, sep = " / "),
    textposition = "outside",
    textfont = list(color = 'rgb(160, 160, 160)')
)
fig <- layout(
    fig, 
    xaxis = list(categoryorder = "array", categoryarray = df$review_score_description, title = "Review category"),
    yaxis = list(title = "Percent (%)"),
    title = "Percentage of indie games in each review category among multiplayer games",
    barmode = "stack"
)
print(fig)