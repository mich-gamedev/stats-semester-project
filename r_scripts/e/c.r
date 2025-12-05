source("./r_scripts/e/b.r")
library(ggplot2)
library(htmltools)
print(reg)

fig <- ggplot(df, aes(x = df$price/100.0, y=df$total,)) +
    geom_point(aes(color = factor(df$review_score))) +
    geom_smooth(method = 'lm')

#htmltools::tagList(ggplotly(fig))
print(htmltools::tagList(plotly::subplot(ggplotly(fig))))
