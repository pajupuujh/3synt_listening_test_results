
require(plyr)
require(effectsize)
require(data.table)
require(rstatix)
require(ggplot2)
require(ggpubr)
require(psych)

theme_local <- theme_bw() %+replace%
            theme(
              legend.background = element_rect(fill = "white", size = 4, colour = "white"),
              #legend.justification = c(0, 1),
              #legend.position = c(0.02, 0.98),
              panel.grid.major = element_line(colour = "grey70", size = 0.2),
              panel.grid.minor = element_blank(),
              axis.text = element_text(size = rel(0.8),colour = "black"),
              axis.title = element_text(size = rel(1.0),colour = "black"),
              axis.ticks = element_line(colour = "grey70", size = 0.2)
              #,complete = TRUE
           )

theme_set(theme_local)
