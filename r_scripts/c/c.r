source("/home/mich/Documents/steam-insights/r_scripts/c/a.r")
library(plotly)
rows_names <- dimnames(tbl_df)[1]
print(rows_names)

plot_tag_data <- data.frame(rows_names,
    neg_3 = tbl_df$'Overwhelmingly Negative', 
    neg_2 = tbl_df$'Mostly Negative',
    neg_1 = tbl_df$'Very Negative',
    mixed = tbl_df$'Mixed',
    pos_1 = tbl_df$'Very Positive',
    pos_2 = tbl_df$'Mostly Positive',
    pos_3 = tbl_df$'Overwhelmingly Positive'
)
#print(plot_tag_data)
colors <- c(
    list(color = 'rgb(164,0,109)'),
    list(color = 'rgb(228,130,80)'),
    list(color = 'rgb(243,193,100)'),
    list(color = 'rgb(255,239,115)'),
    list(color = 'rgb(215,242,118)'),
    list(color = 'rgb(157,247,122)'),
    list(color = 'rgb(0,255,106)')
)
get_text <- function(value, total) {
    return(paste(round((value/total) * 100, digits=1), "%", sep = ""))
}
# documentation: https://plotly.com/r/bar-charts/#stacked-bar-chart
# part of plotly library
total <- plot_tag_data$neg_3 + plot_tag_data$neg_2 + plot_tag_data$neg_1 + plot_tag_data$mixed + plot_tag_data$pos_1 + plot_tag_data$pos_2 + plot_tag_data$pos_3
print(total)
fig <- plot_ly(plot_tag_data, x = plot_tag_data$'c..Action.RPG....Action.Adventure....Arcade....Auto.Battler...', # I am not sure why the row name is this, not matter what i name it or even if it isn't named
y = plot_tag_data$neg_3, 
type = 'bar', name = 'Overwhemingly Negative', 
text = get_text(plot_tag_data$neg_3, total), textposition = 'auto', marker = colors[1])
fig <- add_trace(fig, y = plot_tag_data$neg_2, name = 'Mostly Negative',         text = get_text(plot_tag_data$neg_2, total), textposition = 'auto', marker = colors[2])
fig <- add_trace(fig, y = plot_tag_data$neg_1, name = 'Very Negative',           text = get_text(plot_tag_data$neg_1, total), textposition = 'auto', marker = colors[3])
fig <- add_trace(fig, y = plot_tag_data$mixed, name = 'Mixed',                   text = get_text(plot_tag_data$mixed, total), textposition = 'auto', marker = colors[4])
fig <- add_trace(fig, y = plot_tag_data$pos_1, name = 'Very Positive',           text = get_text(plot_tag_data$pos_1, total), textposition = 'auto', marker = colors[5])
fig <- add_trace(fig, y = plot_tag_data$pos_2, name = 'Mostly Positive',         text = get_text(plot_tag_data$pos_2, total), textposition = 'auto', marker = colors[6])
fig <- add_trace(fig, y = plot_tag_data$pos_3, name = 'Overwhelmingly Positive', text = get_text(plot_tag_data$pos_3, total), textposition = 'auto', marker = colors[7])
fig <- layout(fig, yaxis = list(title = 'Count'), barmode = 'stack')

print(fig)