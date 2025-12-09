source("./r_scripts/e/b.r")
library(ggplot2)
library(htmltools)
print(reg)

#fig <- ggplot(df, aes(x = df$price/100.0, y=df$total,)) +
#    geom_point(aes(color = factor(df$review_score))) +
#    geom_smooth(method = 'lm')

fig <- plotly::subplot(
    ggplot(df, aes(x = df$price/100.0, y=df$total)) +
    geom_point(aes(color = factor(df$review_score), text=df$name)) +
    geom_smooth(method = 'lm') +
    labs(title = "Linear Regression & Local Regression (LOESS)", x = "Price ($)", y = "Review count"),

    ggplot(df, aes(x = df$price/100.0, y=df$total)) +
    geom_point(aes(color = factor(df$review_score), text=df$name)) +
    geom_smooth(method = 'loess') +
    labs(title = "Linear Regression & Local Regression (LOESS)", x = "Price ($)", y = "Review count")
)

#htmltools::tagList(ggplotly(fig))
#print(htmltools::tagList(plotly::subplot(ggplotly(fig))))
print(fig)