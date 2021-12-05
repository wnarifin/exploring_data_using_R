# Chapter 2 - Data Management
# Book: Exploring Data Using R
# Authors: Kamarul Imran Musa, Wan Nor Arifin


# Errata:
# ======
# 2.4.3 Selecting based on logical expressions, page 32:
# Operators for the expressions are missing.
# These should be:
# 1. Equal ==
# 2. More than or equal >=
# 3. Less than or equal <=
# 4. More than >
# 5. Less than <
# 6. Not equal !=
# We apologize for the printing errors.
#
# 2.6.2.1 From a numerical variable
# The text:
# What is meant by `breaks = c(-Inf, 40, 50, Inf)` here is "from minus infinity to below 40, between 40 to 50, from above 50 to infinity".
# Should be read:
# What is meant by `breaks = c(-Inf, 40, 50, Inf)` here is "from minus infinity to 40, from above 40 to 50, from above 50 to infinity".
# The labels should be:
# labels = c("<= 40", "> 40-50", "> 50") instead of labels = c("< 40", "40-50", "> 50")
# The following can be added to exclude the upper limit:
# cut(..., right = FALSE)
# Then the label will be:
# labels = c("< 40", "40- < 50", "=> 50")

# 2.1 Reading, Viewing and Exporting Data ====
data <- read.csv("cholest.csv")

library("foreign")
data <- read.spss("cholest.sav", to.data.frame = TRUE)
data <- read.dta("cholest.dta", convert.factors = TRUE)

library("readxl")
data <- read_excel("cholest.xlsx", sheet = 1)

data
View(data)
head(data)
tail(data)
dim(data)
names(data)
str(data)

write.csv(data, 'data.csv')
write.dta(data, 'data.dta')


# 2.2 Built-in Datasets in R ====
data()

?chickwts


# 2.3 Data Structure ====
str(data)

data_num <- c(1,2,3,4,5); str(data_num)
data_cat <- factor( c("M", "F", "M", "F", "M") ); str(data_cat)

?typeof

data.frame(data_num, data_cat)
data_frame <- data.frame(data_num, data_cat); str(data_frame)

list(data_num, data_cat)
data_list <- list(data_num, data_cat); str(data_list)

matrix(data = c(data_num, data_cat), nrow = 5, ncol = 2)
data_matrix <- matrix(data = c(data_num, data_cat), nrow = 5, 
                     ncol = 2)
data_matrix
str(data_matrix)  # shown as numerical for both


# 2.4 Subsetting
library(foreign)  # to use `read.spss`
data <- read.spss("cholest.sav", to.data.frame = TRUE)

str(data)

head(data)
tail(data)

data$age
data[ , 2]
data[ , "age"]

data[7, ]
data[73, 2]
data[73, "age"]

data[ , c("chol", "age", "sex")]
head(data[ , c("chol", "age", "sex")], 10)

data[ , c(1:2, 4)]
head(data[ , c(1:2, 4)], 10)

data[ , c(1, 2, 4)]

head(data[ , c(1, 2, 4)], 10)

data[7:14, ]
data[7:14, c(2, 4)]
data[7:14, c("chol", "age")]
data[c(1:2, 7:14), c(2, 4)]
data[c(1:2, 7:14), c("chol", "age")]

data[ , -2]
head(data[ , -2], 10)

data[-c(1:35, 40:75), ]
data[-c(1:35, 40:75), -c(1:2, 4)]

# logical expressions
# 1. Equal ==
# 2. More than or equal >=
# 3. Less than or equal <=
# 4. More than >
# 5. Less than <
# 6. Not equal !=
subset(data, age > 45)

subset(data, sex == "female")
head(subset(data, sex == "female"), 10)

data[data$age > 45, ]
data[data[ , "age"] > 45, ]
data[data[ , 2] > 45, ]

head(data[data$sex == "female", ], 10)

subset(data, select = c("chol", "age", "sex"))

subset(data, select = c(chol, age, sex))

head(subset(data, select = c(chol, age, sex)), 10)

subset(data, select = chol:sex)

head(subset(data, select = chol:sex), 10)

subset(data, age >= 45, select = c(age, sex))

subset(data, age <= 35 & sex == "female", select = c(age, sex))
subset(data, age <= 35 | sex == "female", select = c(age, sex))

levels(data$sex)

data[data$age <=35 & data$sex == "female", c("age", "sex")]
data[data$age <=35 | data$sex == "female", c("age", "sex")]
data[data$age <=35 & data$sex == "female", ]$age  # view `age` only
# using [ , ] and $ combination.

data_short <- data[1:20, c("age", "sex")]
data_short
( data_short <- data[1:20, c("age", "sex")] )
str(data_short)

# 2.5 Sorting Data
sort(data$age)  # values in ascending order
sort(data$age, decreasing = TRUE)  # values in descending order

order(data$age)  # gives the index in ascending order
data[order(data$age), ]  # rows follow the index

order(data$age)  # gives the index in ascending order
head(data[order(data$age), ], 10)  # rows follow the index

data[order(data$age, decreasing = TRUE), ]  # descending order

head(data[order(data$age, decreasing = TRUE), ], 10)  # descending order

order(data$exercise, data$age)  # order by age, then exercise
data[order(data$exercise, data$age), ]  # ascending order

order(data$exercise, data$age)  # order by age, then exercise
head(data[order(data$exercise, data$age), ], 10)  # ascending order

data[order(data$exercise, data$age, decreasing = TRUE), ]  # descending order

head(data[order(data$exercise, data$age, decreasing = TRUE), ], 10)  # descending order

data[order(data$exercise, data$age, decreasing = c(TRUE, FALSE)), ]
# age ascending order, exercise descending order

head(data[order(data$exercise, data$age, decreasing = c(TRUE, FALSE)), ], 10)  # age ascending order, exercise descending order

library(plyr)
arrange(data, exercise, age)  # all ascending
head(arrange(data, exercise, age), 10)  # all ascending

arrange(data, desc(exercise), age)  # age ascending order,
# exercise descending order
head(arrange(data, desc(exercise), age), 10)  # age ascending order, exercise descending order


# 2.6 Editing Data
data$age_month <- data$age * 12
data$age_month

data$age_cat <- cut(data$age, breaks = c(-Inf, 40, 50, Inf),
                    labels = c("<= 40", "> 40-50", "> 50"))
# or to exclude upper limit,
data$age_cat <- cut(data$age, breaks = c(-Inf, 40, 50, Inf),
                    labels = c("< 40", "40-50", ">= 50"), right = FALSE)

table(data$age_cat)
str(data$age_cat)

levels(data$age_cat)
table(data$age_cat)

library(car)
data$age_cat1 <- recode(data$age_cat, 
                        "c('40-50','> 50') = '40 & above'")

levels(data$age_cat1)
table(data$age_cat1)  # combined

data$age_month <- NULL
names(data)

data[c("exercise", "categ")] <- NULL
names(data)

dim(data)
data[c(20, 39, 71), ] <- NA

data <- na.omit(data)
dim(data)

dim(data)
data <- data[-c(20, 39, 71), ]
dim(data)


# 2.7 Direct Data Entry
data_frame <- read.table(header = TRUE, text = "
ID Group BMI
1 Fat 30
2 Fat 31
3 Fat 32
4 Thin 20
5 Thin 19
6 Thin 18
")
str(data_frame)
data_frame

ID <- 1:6
Group <- c("Fat", "Fat", "Fat", "Thin", "Thin", "Thin")
BMI <- c(30, 31, 32, 20, 19, 18)
data_frame <- data.frame(ID, Group, BMI)
str(data_frame)
data_frame

data_table <- read.table(header = FALSE, text = "
80 10
5 100
                        ")
colnames(data_table) <- c("Cancer", "No Cancer")
rownames(data_table) <- c("Smoker", "Non-smoker")
str(data_table)  # data_table is a data frame

data_table <- as.matrix(data_table) # convert data_table to matrix
data_table <- as.table(data_table) # then to table
str(data_table)  # data_table is now a table
data_table


# 2.8 Miscellaneous
mtf <- read.csv("mtf.csv")

sum(mtf$Q1A)

rowSums(mtf)

colSums(mtf)

mtf$total_mark <- rowSums(mtf[ , 1:10])
mtf$percent <- (mtf$total_mark/10)*100
head(mtf)

data_na <- read.table(header = T, sep = ",", text = "
ID, age, gender
8110, 20, M
8110, 20, M
1627, 30, 
1234, 23, F
4567, , F
4567, 12, F
")  # we use comma separated values in this example
str(data_na); data_na

summary(data_na)  # NA in age, " " category in gender

anyNA(data_na)

is.na(data_na)

dim(data_na)  # 6 observations
data_na_clean <- na.omit(data_na)
dim(data_na)  # 5 observations
summary(data_na_clean)

data_na_cleaner <- data_na_clean[data_na_clean$gender != " ", ]
data_na_cleaner

duplicate <- read.table(header = T, text = "
ID age gender
8110 20 M
8110 20 M
1627 30 M
1234 23 F
4567 12 F
4567 12 F
")
str(duplicate); duplicate

anyDuplicated(duplicate)  # 2 duplicates

dupli <- duplicate[duplicated(duplicate), "ID"]
dupli

duplicate[duplicate$ID == dupli, ]

duplicate[duplicate$ID != dupli, ]

duplicate[!duplicated(duplicate), ]

noduplicate <- duplicate[data$ID != dupli, ]
