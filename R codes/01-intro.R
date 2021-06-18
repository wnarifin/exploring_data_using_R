# Chapter 1 - Introduction to R

# Errata:
# ======
# 1.3 Functions and Objects, page 10:
# The object names (X, Y, Z) are capitalized.
# These should be x, y, and x instead.
# We apologize for the printing errors.

# 1.3 Functions and Objects
# try these three lines of codes
x <- 1
y = 2
z <- x + y  # sum up x and y
x
y
z

# 1.4 Packages
install.packages("car")
install.packages(c("car", "plyr"))

library("car")

# 1.5 Working Directory
setwd("C:/myfolder")
setwd("~/myfolder")

# 1.6 Getting Help
?car
?mean
??mean