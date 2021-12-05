# Chapter 4: Visual Exploration
# Book: Exploring Data Using R
# Authors: Kamarul Imran Musa, Wan Nor Arifin

# 4.4. Using the Graphics Package
library(foreign)
cholest <- read.dta("cholest.dta")
## str(cholest)

head(cholest); tail(cholest)
summary(cholest)

hist(cholest$chol)

hist(cholest$chol, breaks = 10, col = "red",
     main = "Cholesterol (mmol/l) distribution", xlab = "Cholesterol (mmol/l)")

d.plot <- density(cholest$chol) # returns the density data 
plot(d.plot, main = "Kernel Density of Serum Cholesterol") # plots the results

hist(cholest$chol, breaks = 10, freq = FALSE, col = "red",
     main = "Cholesterol (mmol/l) distribution", xlab = "Cholesterol (mmol/l)")
lines(density(cholest$chol, adjust = 1.5))

boxplot(cholest$chol, main = "Cholesterol (mmol/l) distribution",
        ylab = "Cholesterol (mmol/l)")

boxplot(attitude, col = rainbow(7))

plot(cholest$age, cholest$chol, main = "Scatterplot",
     xlab = "Age", ylab = "Cholestrol", pch = 19)
abline(line(cholest$age, cholest$chol))

str(iris)
plot(iris[1:3])

str(attitude)
plot(attitude)

counts <- table(cholest$categ)
counts

barplot(counts, main="Frequency by intervention group", 
        ylab = "Intervention group", xlab = "Frequency",
        col = rainbow(3, alpha = 0.5))

barplot(counts, main="Frequency by intervention group", 
         xlab = "Intervention group", ylab = "Frequency",
         col = rainbow(3, alpha = 0.5), ylim = c(0, 40)) -> bplot_setting
text(bplot_setting, counts + 5, paste0("n = ", counts))

# group `age` into `age_cat` = `< 35`, `35-45`, `> 45`
cholest$age_cat <- cut(cholest$age,
                      breaks = c(-Inf, 35, 45, Inf),
                      labels = c("<35", "35-45", ">45"))

cross <- table(cholest$sex, cholest$age_cat)
addmargins(cross)  # just to get an overview of the height of the bars

barplot(cross, main = "Frequency by age group",
        xlab = "Age group", ylab = "Frequency",
        col = rainbow(2, alpha = 0.5), ylim = c(0, 60),
        legend = rownames(cross)) -> bplot_setting
text(rep(bplot_setting, each = 2), c(4, 12, 12, 39, 4, 9),
     paste0("n = ", cross))  # adjust y coordinates to your liking

png(file = "hist.png")
hist(cholest$chol)
dev.off()

pdf("plots.pdf")
hist(cholest$chol, freq = FALSE)
lines(density(cholest$chol))
barplot(table(cholest$sex))
plot(cholest$chol, cholest$age)
dev.off()

# 4.5 Using the lattice Package
library(lattice)

histogram(~ chol, data = cholest, xlab = 'Cholesterol level')

densityplot(~ chol, data = cholest, xlab = 'Cholesterol level')

bwplot(~ chol, data = cholest, xlab = 'Cholesterol level')

histogram(~ chol | sex, data = cholest, xlab = 'Cholesterol level')
histogram(~ chol | sex, data = cholest, layout = c(1, 2), xlab = 'Cholesterol level')

densityplot(~ chol | sex, data = cholest, xlab = 'Cholesterol level')
densityplot(~ chol | sex, data = cholest, layout = c(1, 2), xlab = 'Cholesterol level')

bwplot(chol ~ sex, data = cholest, ylab = 'Cholesterol level')
bwplot(sex ~ chol, data = cholest, xlab = 'Cholesterol level')  # note the change in x-y axis.
bwplot(~ chol | sex, data = cholest, layout = c(1, 2), xlab = 'Cholesterol level')

bwplot(age_cat ~ chol | sex, data = cholest, layout = c(2, 1))

xyplot(chol ~ age, data = cholest)

xyplot(chol ~ age, data = cholest,
       panel = function(x, y) {
         panel.xyplot(x, y)
         panel.abline(line(x, y))
         })

xyplot(chol ~ age | sex, data = cholest,
       panel = function(x, y) {
         panel.xyplot(x, y)
         panel.abline(line(x, y))
       })

counts <- table(cholest$categ)
counts

barchart(counts, ylab = "Intervention group", xlab = "Frequency", 
         col = rainbow(3))

cross <- table(cholest$sex, cholest$age_cat)
barchart(cross, auto.key = T, ylab = "Sex", xlab = "Frequency")
barchart(t(cross), auto.key = T, ylab = "Age group", xlab = "Frequency")

counts_df <- as.data.frame(counts)
colnames(counts_df) <- c("Category", "Count")  # set the column names
counts_df

barchart(Count ~ Category, data = counts_df,
         col = rainbow(3, alpha = 0.5), ylim = c(0, 40))

barchart(Count ~ Sex | Age_Group, data = cross_df, 
         ylim = c(0, 30), col = rainbow(2, alpha = 0.5),
         xlab = "Sex", layout = c(3, 1))
barchart(Count ~ Age_Group | Sex, data = cross_df, 
         ylim = c(0, 30), col = rainbow(3, alpha = 0.5),
         xlab = "Age Group", layout = c(2, 1))

cat(names(attitude), sep = " + ")

histogram(~ rating + complaints + privileges + learning + raises + critical 
          + advance, data = attitude)

densityplot(~ rating + complaints + privileges + learning + raises + critical 
            + advance, data = attitude, auto.key = T)

# Using the ggplot2 Package
library(ggplot2)

myplot <- ggplot(data = cholest, aes(x = chol))
myplot + geom_histogram(binwidth = 0.5)

ggplot(cholest, aes(x = chol)) + geom_histogram(binwidth = 0.5, 
                                                colour = "black", fill = "white")

ggplot(data = cholest, aes(x = chol)) + geom_density()

ggplot(data = cholest, aes(x = chol)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.5, colour = "black", fill = "white") +
  geom_density(alpha = .2, fill = "#FF6666")


sex_bar <- ggplot(data = cholest, aes(sex))
sex_bar + geom_bar()

ggplot(data = cholest, mapping = aes(sex, fill = sex)) + 
  geom_bar() + xlab('Sex') + ylab('Freq') +
  ggtitle('Freq of male and female')


ggplot(cholest, aes(x = chol, fill = sex)) +
    geom_histogram(binwidth = .5, alpha = .5, position = "identity")

ggplot(cholest, aes(x = chol, fill = sex)) +
    geom_histogram(binwidth = .5, position = "dodge")

ggplot(cholest, aes(x = chol, colour = sex)) + geom_density()

# Density plots with semi-transparent fill
ggplot(cholest, aes(x = chol, colour = sex, fill = sex)) + geom_density(alpha = .3)

ggplot(data = cholest, aes(x = chol)) + 
  geom_histogram(binwidth = .5, colour = "black", fill = "white") + 
  facet_grid(sex ~ .)

ggplot(data = cholest, aes(x = chol)) + 
  geom_histogram(binwidth = .5, colour = "black", fill = "white") + 
  facet_grid(. ~ sex)

ggsave("myhistogram.png", width = 5, height = 5)
ggsave("myhistogram.pdf", width = 5, height = 5)
