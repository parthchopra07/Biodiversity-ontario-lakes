# Created by Parth Chopra on 05/04/24
# Revised on 07/04/24
###
# Data analysis on different variables impacting biodiversity in lakes in ontario.
library("ggplot2")
library("pastecs")
library("car")
library("MASS")
library("bestNormalize")
library("psych")
library("tidyr")
setwd("set-path-for-lake.csv")
lake<-read.csv("lakes2024.csv")
View(lake)

#Q1
by(lake$Phos, lake$Ecozone, stat.desc, basic = F,
   norm = T) #Normal test

# Transformation
result <- bestNormalize(lake$Phos)
lake$normPhos<- result$x.t

by(lake$normPhos, lake$Ecozone, stat.desc, basic = F,
   norm = T) #Normal Test

#omitting na for the graph
lake_cleaned <- na.omit(lake)

ggplot(lake_cleaned, aes(x = normPhos)) + geom_histogram() +
  facet_wrap(~Ecozone) + labs(x="Normalised Phosphorus Levels", y= "Frequency of Ecozone") #Histogram
ggsave("1.pdf")
t.test(normPhos~Ecozone, data = lake) # Welch two sample t-test

#Boxplot
ggplot(lake_cleaned, aes(x = Ecozone, y = normPhos)) + geom_boxplot()+ ylab("Normalised Phosphate Levels")+ theme(panel.background = element_rect(fill = "white",
colour = "black"), panel.grid.major = element_blank(),
panel.grid.minor = element_blank(), axis.line =
element_line(colour = "black"))+ geom_jitter(position = position_jitter(width = 0.6))
ggsave("2.pdf")

#Descriptive tests
desc_lake<-describe(lake)
View(desc_lake)
stat.desc(lake)

#Q2
by(lake$normPhos, lake$Fishery, stat.desc, basic = F,
   norm = T)# Normal test 

leveneTest(lake$normPhos, interaction(lake$Fishery,lake$Ecozone)) #Homovariance test

calANOVA <- aov(normPhos~Fishery, data = lake)# ANOVA test
summary(calANOVA) #Difference detected

TukeyHSD(calANOVA)#Post hoc

#Graph
calSUMMARY <-
  data.frame(treatment=levels(factor(lake$Fishery)),
             mean=tapply(lake$Phos, lake$Fishery, mean),
             n=tapply(lake$Phos, lake$Fishery, length),
             sd=tapply(lake$Phos, lake$Fishery, sd))
calSUMMARY$sem <- calSUMMARY$sd/sqrt(calSUMMARY$n)
calSUMMARY$ci <- qt(1-0.05/2, df = calSUMMARY$n) *
  calSUMMARY$sem

calSUMMARY$posthoc <- c("a","b","c","d","e")

ggplot(calSUMMARY, aes(x = treatment, y = mean)) +
geom_bar(position = position_dodge(), stat="identity",
fill="grey", width = .75) + geom_errorbar(aes(ymin=mean-ci, ymax=mean+ci), width = .3) + ylab("Normalised Phosphate levels") + xlab("Fishery") + theme_bw() +
theme(panel.grid.major = element_blank()) + geom_text(aes(label=posthoc), vjust = -2.5, size = 4)
ggsave("3.pdf")

#Boxplot to visualise variance
ggplot(lake_cleaned, aes(x = Fishery, y = normPhos)) +
  geom_boxplot() +ylab("Normalised Phosphate levels")
ggsave("4.pdf")
#Q3
shapiro.test(lake$Species)

ggplot(lake, aes(Phos, Species)) + geom_point() +
  labs(x = "Phosphate Levels (micrograms per litre)", y = "Number of Species") +
  geom_smooth(method="lm", se=F)
ggsave("5.pdf")
#Correlation test
cor.test(lake$Phos, lake$Species, method = "pearson",
         conf.level = 0.95) # No there is not a  correlation

Specie_num <- lm(lake$Species~lake$Phos, na.action =
                 na.exclude)# slope not significant but intercept is 
summary(Specie_num)

lake$resids <- resid(Specie_num)

by(lake$resids, lake$Fishery, stat.desc, basic = F,
   norm = T)

#Price Prediction calculation
prediction <- 0*18.2 +11.968
print(prediction)