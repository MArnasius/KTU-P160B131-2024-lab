library(tidyverse)
library(ggplot2)
data = readRDS("../data/494100.rds")

#-------------------------------------------------------------------------------------------

gr1 = data %>%  
  ggplot(aes(x=avgWage)) + 
  geom_histogram(bins = 100, fill='blue') + 
  labs(title = "Histograma", x="vid. atlygis", y="kiekis")
  ggsave('../img/gr1.png', gr1, width = 12)

#-------------------------------------------------------------------------------------------
  
topimones = data%>% group_by(name)%>% summarise(topines=max(avgWage))%>% arrange(desc(topines)) %>% head(5)
gr2 = data%>%
  filter(name %in% topimones$name) %>%
  ggplot(aes(x=ym(month), y=avgWage, col = name)) +
    geom_line() + labs(title = "Linijinis Grafikas", x= "menesiai", y= "vid. atlygis")
ggsave('../img/gr2.png', gr2, width = 13)

#------------------------------------------------------------------------------------------

apdraustieji = data %>% filter(name %in% topimones$name) %>% group_by(name) %>% summarise(max = max(numInsured))
apdraustieji$name=factor(apdraustieji$name, levels=apdraustieji$name[order(apdraustieji$max, decreasing = TRUE)])

gr3 = apdraustieji %>%
  ggplot(aes(x=name, y=max, fill = name)) + geom_col() + labs(title = "Stulpeline diagrama", 
                                                              x= "Imones", y = "Apdraustuju sk.")
ggsave('../img/gr3.png', gr3, width = 12)
