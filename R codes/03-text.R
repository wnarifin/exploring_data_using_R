# Chapter 3: Descriptive Statistics
# Book: Exploring Data Using R
# Authors: Kamarul Imran Musa, Wan Nor Arifin


# 3.1 One Variable
head(chickwts)
tail(chickwts)

str(chickwts)

levels(chickwts$feed)

mean(chickwts$weight)
median(chickwts$weight)

min(chickwts$weight)
max(chickwts$weight)
range(chickwts$weight)

sd(chickwts$weight)
var(chickwts$weight)

quantile(chickwts$weight)
IQR(chickwts$weight)

quantile(chickwts$weight, type = 6)
IQR(chickwts$weight, type = 6)

mad(chickwts$weight)

summary(chickwts$weight)

install.packages("psych")
library(psych)
describe(chickwts$weight)

summary(chickwts$feed)
table(chickwts$feed)

prop.table(table(chickwts$feed))
prop.table(table(chickwts$feed))*100

cbind(n = table(chickwts$feed), 
      "%" = prop.table(table(chickwts$feed))*100)


# 3.2 Two Variables and More
head(women)
tail(women)
str(women)

summary(women)

library(psych)
describe(women)

head(infert)
str(infert)

?infert

infert$induced <- factor(infert$induced, levels = 0:2, 
                         labels = c("0", "1", "2 or more"))
infert$case <- factor(infert$case, levels = 0:1, 
                      labels = c("control", "case"))
infert$spontaneous <- factor(infert$spontaneous, 
                             levels = 0:2, 
                             labels = c("0", "1", "2 or more"))
str(infert)

summary(infert[c("education", "induced", "case", "spontaneous")])

lapply(infert[c("education", "induced", "case", "spontaneous")], 
       function(x) summary(x)/length(x))
lapply(infert[c("education", "induced", "case", "spontaneous")], 
       function(x) summary(x)/length(x)*100)

lapply(infert[c("education", "induced", "case", "spontaneous")], 
       summary)
lapply(infert[c("education", "induced", "case", "spontaneous")], 
       table)
lapply(infert[c("education", "induced", "case", "spontaneous")], 
       function(x) prop.table(table(x)))
lapply(infert[c("education", "induced", "case", "spontaneous")], 
       function(x) prop.table(table(x))*100)


# 3.3 By groups
by(infert[c("age", "parity")], infert$case, summary)
by(infert[c("age", "parity")], infert$case, describe)

describeBy(infert[c("age", "parity")], group = infert$case)

by(infert[c("age", "parity")], infert$case, 
   function(x) lapply(x, mean))
by(infert[c("age", "parity")], infert$case, 
   function(x) lapply(x, IQR))

by(infert[c("education", "induced", "spontaneous")], infert$case, 
   summary)
by(infert[c("education", "induced", "spontaneous")], infert$case, 
   function(x) lapply(x, function(x) summary(x)/length(x)))
by(infert[c("education", "induced", "spontaneous")], infert$case, 
   function(x) lapply(x, function(x) summary(x)/length(x)*100))

by(infert[c("education", "induced", "spontaneous")], infert$case, 
   function(x) lapply(x, table))
by(infert[c("education", "induced", "spontaneous")], infert$case, 
   function(x) lapply(x, function(x) prop.table(table(x))))
by(infert[c("education", "induced", "spontaneous")], infert$case, 
   function(x) lapply(x, function(x) prop.table(table(x))*100))

table(infert$education, infert$case)

table(education = infert$education, case = infert$case)

lapply(infert[c("education", "induced", "spontaneous")], 
       function(x) table(x, infert$case))

table(infert$education, infert$case, infert$induced)

by(infert[c("education", "case")], infert$induced, table)

# 3.4 Customizing Text Outputs
library(foreign)
cholest <- read.spss("cholest.sav", to.data.frame = TRUE)

str(data)

mean(cholest$age)
sd(cholest$age)
length(cholest$age)

cbind(mean = mean(cholest$age), sd = sd(cholest$age), 
      n = length(cholest$age))

chol_c <- cbind(mean = mean(cholest$age), sd = sd(cholest$age), 
                n = length(cholest$age))
rownames(chol_c) <- "Cholestrol"
chol_c

rbind(mean = mean(cholest$age), sd = sd(cholest$age), 
      n = length(cholest$age))
chol_r = rbind(mean = mean(cholest$age), sd = sd(cholest$age), 
               n = length(cholest$age))
colnames(chol_r) <- "Cholestrol"
chol_r

mean_cholest <- lapply(cholest[, c("chol", "age", "exercise")], mean)
sd_cholest <- lapply(cholest[, c("chol", "age", "exercise")], sd)
cbind(mean = mean_cholest, SD = sd_cholest, 
      n = lengths(cholest[, c("chol", "age", "exercise")]))
rbind(mean = mean_cholest, SD = sd_cholest, 
      n = lengths(cholest[, c("chol", "age", "exercise")]))

names(mean_cholest) <- c("Cholestrol", "Age", "Exercise")
cbind(mean = mean_cholest, SD = sd_cholest, 
      n = lengths(cholest[, c("chol", "age", "exercise")]))
rbind(mean = mean_cholest, SD = sd_cholest, 
      n = lengths(cholest[, c("chol", "age", "exercise")]))

count_cholest <- sapply(cholest[c("sex", "categ")], summary)
count_cholest
perc_cholest <- sapply(cholest[c("sex", "categ")], function(x) summary(x)/length(x)*100)
perc_cholest

list(Sex = cbind(n = count_cholest$sex, "%" = perc_cholest$sex),
     Category = cbind(n = count_cholest$categ, 
                      "%" = perc_cholest$categ))

data.frame(mean = mean_cholest, SD = sd_cholest, 
      n = lengths(cholest[, c("chol", "age", "exercise")]))

matrix(c(mean_cholest, sd_cholest, 
         n = lengths(cholest[, c("chol", "age", "exercise")])), 
       nrow = 3, ncol = 3,
       dimnames = list(names(cholest[, c("chol", "age", "exercise")]),
                       c("mean", "SD", "n")))

tab_categ = table(Category = cholest$categ)
per_categ = prop.table(tab_categ)*100
cell_categ = paste0(tab_categ, " (", per_categ, "%)")
tab_per_categ = tab_categ  # just to set the dimension of `tab_per_categ`
tab_per_categ[] = cell_categ[]
tab_per_categ

tab = table(Category = cholest$categ, Gender = cholest$sex); tab  # count
per = prop.table(table(Category = cholest$categ, Gender = cholest$sex))*100
per  # % 
cbind(tab, per)
addmargins(tab)  # marginal counts
# nicer view
cell = paste0(tab, " (", per, "%)")
str(tab)
tab1 = tab
tab1[] = cell[]
tab1
ftable(tab1)  # nicer 'flat' view

cat("For cholestrol, the mean was ", round(mean(cholest$chol), 2), 
    " (SD = ", round(sd(cholest$chol)), ") in a sample of ",
    length(cholest$chol), " subjects.", sep = "")
