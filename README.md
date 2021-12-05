# Exploring Data Using R
This repository contains data sets and R code for our Exploring Data Using R book.

~ Kamarul Imran Musa & Wan Nor Arifin ~

![book1](https://wnarifin.github.io/img/rbook1.jpg)

## Errata:

### 1.3 Functions and Objects, page 10:
The object names (X, Y, Z) are capitalized. These should be x, y, and z instead.

### 2.4.3 Selecting based on logical expressions, page 32:
Operators for the expressions are missing. These should be:

1. Equal ==
2. More than or equal >=
3. Less than or equal <=
4. More than >
5. Less than <
6. Not equal !=

### 2.6.2.1 From a numerical variable
The text:

> What is meant by `breaks = c(-Inf, 40, 50, Inf)` here is "from minus infinity to below 40, between 40 to 50, from above 50 to infinity".

Should be read:

> What is meant by `breaks = c(-Inf, 40, 50, Inf)` here is "from minus infinity to 40, from above 40 to 50, from above 50 to infinity".

The labels should be:

> `labels = c("<= 40", "> 40-50", "> 50")` instead of `labels = c("< 40", "40-50", "> 50")`

The following can be added to exclude the upper limit:

> `cut(..., right = FALSE)`

Then the label will be:

> `labels = c("< 40", "=> 40 to < 50", "=> 50")`

We apologize for the errors.
