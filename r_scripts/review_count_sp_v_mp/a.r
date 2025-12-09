source("./r_scripts/base.r")
df <- dbGetQuery(db, "
SELECT reviews.review_score_description, tags.tag
FROM reviews
INNER JOIN tags
ON tags.app_id=reviews.app_id
WHERE tags.tag IN ('Multiplayer', 'Singleplayer')
AND (reviews.review_score_description LIKE '%Positive'
OR reviews.review_score_description LIKE '%Negative'
OR reviews.review_score_description='Mixed')
")
library(DT)
tbl <- table(df$tag, df$review_score_description)
tbl_df <- as.data.frame.matrix(tbl)
library(plotly)
rows_names <- dimnames(tbl_df)[1]

plot_tag_data <- data.frame(rows_names,
    neg_3 = tbl_df$'Overwhelmingly Negative', 
    neg_2 = tbl_df$'Very Negative',
    neg_1 = tbl_df$'Negative',
    neg_0 = tbl_df$'Mostly Negative',
    mixed = tbl_df$'Mixed',
    pos_0 = tbl_df$'Mostly Positive',
    pos_1 = tbl_df$'Positive',
    pos_2 = tbl_df$'Very Positive',
    pos_3 = tbl_df$'Overwhelmingly Positive'
)
#print(plot_tag_data)
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
get_text <- function(value, total) {
    return(paste(round((value/total) * 100, digits=1), "%", sep = ""))
}
# documentation: https://plotly.com/r/bar-charts/#stacked-bar-chart
# part of plotly library
total <- plot_tag_data$neg_3 + plot_tag_data$neg_2 + plot_tag_data$neg_1 + plot_tag_data$neg_0 + plot_tag_data$mixed + plot_tag_data$pos_0 + plot_tag_data$pos_1 + plot_tag_data$pos_2 + plot_tag_data$pos_3
print(total)
fig <- plot_ly(plot_tag_data, x = plot_tag_data$'c..Multiplayer....Singleplayer..', # I am not sure why the row name is this, not matter what i name it or even if it isn't named
y = plot_tag_data$neg_3, 
type = 'bar', name = 'Overwhemingly Negative', 
text = get_text(plot_tag_data$neg_3, total), textposition = 'auto', marker = colors[1])
fig <- add_trace(fig, y = plot_tag_data$neg_2, name = 'Very Negative',           text = get_text(plot_tag_data$neg_2, total), textposition = 'auto', marker = colors[2])
fig <- add_trace(fig, y = plot_tag_data$neg_1, name = 'Negative',                text = get_text(plot_tag_data$neg_1, total), textposition = 'auto', marker = colors[3])
fig <- add_trace(fig, y = plot_tag_data$neg_0, name = 'Mostly Negative',         text = get_text(plot_tag_data$neg_0, total), textposition = 'auto', marker = colors[4])
fig <- add_trace(fig, y = plot_tag_data$mixed, name = 'Mixed',                   text = get_text(plot_tag_data$mixed, total), textposition = 'auto', marker = colors[5])
fig <- add_trace(fig, y = plot_tag_data$pos_0, name = 'Mostly Positive',         text = get_text(plot_tag_data$pos_0, total), textposition = 'auto', marker = colors[6])
fig <- add_trace(fig, y = plot_tag_data$pos_1, name = 'Positive',                text = get_text(plot_tag_data$pos_1, total), textposition = 'auto', marker = colors[7])
fig <- add_trace(fig, y = plot_tag_data$pos_2, name = 'Very Positive',           text = get_text(plot_tag_data$pos_2, total), textposition = 'auto', marker = colors[8])
fig <- add_trace(fig, y = plot_tag_data$pos_3, name = 'Overwhelmingly Positive', text = get_text(plot_tag_data$pos_3, total), textposition = 'auto', marker = colors[9])
fig <- layout(fig, yaxis = list(title = 'Count'), barmode = 'stack')

print(fig)

