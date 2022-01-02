
require(plyr)
require(effectsize)
require(data.table)
require(rstatix)
require(ggplot2)
require(ggpubr)
require(psych)

theme_local <- theme_bw() %+replace%
            theme(
              plot.title = element_text(face = "bold", size = 12, hjust = 0,  margin = margin(t = 10, b = 10)),
              legend.background = element_rect(fill = "white", size = 4, colour = "white"),
              #legend.justification = c(0, 1),
              #legend.position = c(0.02, 0.98),
              axis.ticks = element_line(colour = "grey70", size = 0.2),
              panel.grid.major = element_line(colour = "grey70", size = 0.2),
              panel.grid.minor = element_blank()
          # theme(
          #   axis.text = element_text(colour = "black", size = rel(1.5)),
          #   axis.title = element_text(size = rel(1.5), colour = "black"),
          #   complete = TRUE
          # )
)

theme_set(theme_local)
