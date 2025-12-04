source("./r_scripts/d/a.r")

new_fig <- plot_ly(df, y = ~total, x = ~publishers, text = ~review_score, textposition = 'auto', mean = means, type = "box", boxpoints = 'suspectedoutliers')
print(new_fig)