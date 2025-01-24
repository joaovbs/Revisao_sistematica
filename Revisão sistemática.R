# An�lises para revis�o sistem�tica em efici�ncia
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

art<- read_excel("C:/Users/borge/Downloads/An�lises.xlsx")

art<- as.data.frame(art)
is.data.frame(art)
View(art)
str(art)
## Histograma - m�todo

met<- art$M�todo

tiff("test.tiff", units="in", width=5, height=5, res=300) # C�digo para imagens em alta resolu��o

m<- ggplot(data = art, aes(x=met, fill = as.factor(met)))
m + geom_bar() + xlab("") + ylab('') + labs(fill = "") + scale_fill_brewer(palette = "Accent")

dev.off() # C�digo final para imagens em alta resolu��o

## Gr�fico de pizza - objeto



ob<- c("Ecoefici�ncia", "Efici�ncia", "Socioecoefici�ncia")
valores<- c(25, 43, 1)
obj<- cbind.data.frame(ob, valores)

tiff("test.tiff", units="in", width=5, height=5, res=300)

o<- ggplot(data = obj, aes(x='', y=valores, fill=ob))
o + geom_bar(width = 1, size = 1, stat = "identity") + coord_polar("y", start=0) + labs(x = NULL, y = NULL, fill = NULL)  + theme_classic() + theme(axis.line = element_blank(), axis.text = element_blank(), axis.ticks = element_blank()) + scale_fill_brewer(palette="Dark2")

dev.off()

### Com plotly ---- esse � BEM melhor que o ggplot2 para gr�fico de pizza!

tiff("test.tiff", units="in", width=5, height=5, res=300)

o<-plot_ly(data=obj, labels= ~ob, values = ~valores, type="pie") %>%
layout(title = "",
       xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
       yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

dev.off()

## Gr�fico de linha - efici�ncia x ecoefici�ncia entre 2014-2019
tiff("test.tiff", units="in", width=7, height=4, res=300)

Ano<- c("2014", "2015", "2016", "2017", "2018", "2019")
eco<- c(1, 0, 3, 10, 8, 4)
ef<- c(1, 5, 3, 12, 18, 4)
g<-c(eco,ef)
ev<- cbind.data.frame(Ano, eco, ef)
p<- ggplot() + geom_line(data = ev, aes(x=Ano, y=eco, group = 1, color="firebrick"), size=0.8) +
  geom_line(data = ev, aes(x=Ano, y=ef, group=1,color = "aquamarine4"), size=0.8)  +
  ylab("N� de artigos") + xlab('') + labs(color = "Legenda") +
  scale_color_manual(name = "Legenda", labels = c("Efici�ncia", "Ecoefici�ncia"),values=c("firebrick", "aquamarine4"))
p

dev.off()