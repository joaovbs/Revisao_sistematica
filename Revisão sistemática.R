# Análises para revisão sistemática em eficiência
install.packages("RColorBrewer")
install.packages("wesanderson")
install.packages("plotly")
library(plotly)
library(readxl)
library(ggplot2)
library(RColorBrewer)
library(wesanderson)
options(scipen = 999)

## Carregar arquivo xlsx

art<- read_excel("C:/Users/borge/Downloads/Análises.xlsx")

art<- as.data.frame(art)
is.data.frame(art)
View(art)
str(art)
## Histograma - método

met<- art$Método

tiff("test.tiff", units="in", width=5, height=5, res=300) # Código para imagens em alta resolução

m<- ggplot(data = art, aes(x=met, fill = as.factor(met)))
m + geom_bar() + xlab("") + ylab('') + labs(fill = "") + scale_fill_brewer(palette = "Accent")

dev.off() # Código final para imagens em alta resolução

## Gráfico de pizza - objeto



ob<- c("Ecoeficiência", "Eficiência", "Socioecoeficiência")
valores<- c(25, 43, 1)
obj<- cbind.data.frame(ob, valores)

tiff("test.tiff", units="in", width=5, height=5, res=300)

o<- ggplot(data = obj, aes(x='', y=valores, fill=ob))
o + geom_bar(width = 1, size = 1, stat = "identity") + coord_polar("y", start=0) + labs(x = NULL, y = NULL, fill = NULL)  + theme_classic() + theme(axis.line = element_blank(), axis.text = element_blank(), axis.ticks = element_blank()) + scale_fill_brewer(palette="Dark2")

dev.off()

### Com plotly ---- esse é BEM melhor que o ggplot2 para gráfico de pizza!

tiff("test.tiff", units="in", width=5, height=5, res=300)

o<-plot_ly(data=obj, labels= ~ob, values = ~valores, type="pie") %>%
layout(title = "",
       xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
       yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

dev.off()

## Gráfico de linha - eficiência x ecoeficiência entre 2014-2019
tiff("test.tiff", units="in", width=7, height=4, res=300)

Ano<- c("2014", "2015", "2016", "2017", "2018", "2019")
eco<- c(1, 0, 3, 10, 8, 4)
ef<- c(1, 5, 3, 12, 18, 4)
g<-c(eco,ef)
ev<- cbind.data.frame(Ano, eco, ef)
p<- ggplot() + geom_line(data = ev, aes(x=Ano, y=eco, group = 1, color="firebrick"), size=0.8) +
  geom_line(data = ev, aes(x=Ano, y=ef, group=1,color = "aquamarine4"), size=0.8)  +
  ylab("Nº de artigos") + xlab('') + labs(color = "Legenda") +
  scale_color_manual(name = "Legenda", labels = c("Eficiência", "Ecoeficiência"),values=c("firebrick", "aquamarine4"))
p

dev.off()