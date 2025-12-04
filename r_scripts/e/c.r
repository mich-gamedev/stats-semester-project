source("/home/mich/Documents/steam-insights/r_scripts/e/b.r")
library(ggplot2)
print(reg)

#fig <- plot_ly(df, x = df$price/100.0, y = df$total, color = df$review_score_description, text=df$name)
#fig <- add_trace(fig, x = c(0:200), y = lm(df$total ~ df$price), mode = 'lines')
#fig <- layout(fig, xaxis = list(title = 'Price ($)'), yaxis = list(title = 'Total review count'), plot_bgcolor = '#282828')
#print(fig)

fig <- ggplot(df, aes(x = df$price/100.0, y=df$total,)) +
    geom_point(aes(color = factor(df$review_score))) +
    geom_smooth(method = 'lm')

print(ggplotly(fig))
