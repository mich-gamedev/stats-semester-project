library(plotly)


#Constants

img_width = 1600

img_height = 900

scale_factor = 0.5



# Add invisible scatter trace.

# This trace is added to help the autoresize logic work.

fig <- plot_ly(width=img_width * scale_factor,

               height=img_height * scale_factor

) %>%

  add_trace( x= c(0, img_width * scale_factor),

             y= c(0, img_height * scale_factor),

             type = 'scatter',  mode = 'markers', alpha = 0)


# Configure axes

xconfig <- list(

  title = "",

  zeroline = FALSE,

  showline = FALSE,

  showticklabels = FALSE,

  showgrid = FALSE,

  range = c(0, img_width * scale_factor)

)


yconfig <- list(

  title = "",

  zeroline = FALSE,

  showline = FALSE,

  showticklabels = FALSE,

  showgrid = FALSE,

  range = c(0, img_height * scale_factor),

  scaleanchor="x"

)


fig <- fig %>% layout(xaxis = xconfig, yaxis = yconfig)


# Add image


fig <- fig %>% layout(

  images = list(

    list(

      source =  "./p2p_v_p2s.png",

      x=0,

      sizex=img_width * scale_factor,

      y=img_height * scale_factor,

      sizey=img_height * scale_factor,

      xref="x",

      yref="y",

      opacity=1.0,

      layer="below",

      sizing="stretch"

    )

  ))


# Configure other layout


m = list(r=0, l=0, b=0, t=0)

fig <- fig %>% layout(margin = m) %>%

  layout(plot_bgcolor='#e5ecf6',

          xaxis = list(

            zerolinecolor = '#ffff',

            zerolinewidth = 2,

            gridcolor = 'ffff'),

          yaxis = list(

            zerolinecolor = '#ffff',

            zerolinewidth = 2,

            gridcolor = 'ffff')

          )

print(fig)
