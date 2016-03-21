# README Kinclong

It's an R-Package primarily built for data cleansing routines used by the Open Data team at Jakarta Provincial Government. It's a user input based through the terminal as the user interface. It starts by calling the function `validasi()`

To install and use:
````
install.packages("devtools")
library("devtools")
devtools::install_github("endiyan/kinclong")
library("kinclong")
`````
Call the function `validasi()` to start the terminal based UI or you can directly use the functions below

## Functions
all functions return a data frame

### dropColumn(dframe, colname)
remove a column

### changeType(dframe, colname, type)
change the datatype for a specific column

### loadMultipleFiles(file_names = dir(), colname)
load multiple files into a single dataframe

### setColumnNames(dframe,colname)
change column names

### setAsDate(date.format="%d/%m/%Y", dframe, colName)
set a column as date format