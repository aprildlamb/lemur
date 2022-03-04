

# Load libraries
if (!requireNamespace('devtools', quietly = TRUE))
  install.packages('devtools')

devtools::install_github('kevinblighe/PCAtools')
library(PCAtools)
library(RColorBrewer)


# Raw PCA Data with traits
all.traits <- read.csv('/Users/april/Desktop/Lemur/Output/All_molarS_PCA.csv', header=T) 
UL.traits <- read.csv('/Users/april/Desktop/Lemur/Output/Upper_left_molar_PCA.csv', header=T) 
LL.traits <- read.csv('/Users/april/Desktop/Lemur/Output/Lower_left_molar_PCA.csv', header=T) 
UR.traits <- read.csv('/Users/april/Desktop/Lemur/Output/Upper_right_molar_PCA.csv', header=T) 
LR.traits <- read.csv('/Users/april/Desktop/Lemur/Output/Lower_right_molar_PCA.csv', header=T) 




We need to do a bit of data manipulation to the files to add back in the trait data we want by species mean
```{r cleanup}
# All teeth
names(all.data)[names(all.data) == "X"] <- "Species_name" # Rename column 1 so dataframes can be joined
all.data <- merge(all.data, traits[,123:128], by= "Species_name") # Add in traits
drops <- c("Tooth") # Drop tooth column 
all.data <- all.data[ , !(names(all.data) %in% drops)]
all.data <- distinct(all.data) # Remove rows with duplicate data

# Upper left
names(UL.data)[names(UL.data) == "X"] <- "Species_name" 
UL.data <- merge(UL.data, traits[,123:128], by= "Species_name") 
drops <- c("Tooth") 
UL.data <- UL.data[ , !(names(UL.data) %in% drops)]
UL.data <- distinct(UL.data) 

# Lower left
names(LL.data)[names(LL.data) == "X"] <- "Species_name" 
LL.data <- merge(LL.data, traits[,123:128], by= "Species_name") 
drops <- c("Tooth")  
LL.data <- LL.data[ , !(names(LL.data) %in% drops)]
LL.data <- distinct(LL.data) 

# Upper right
names(UR.data)[names(UR.data) == "X"] <- "Species_name"
UR.data <- merge(UR.data, traits[,123:128], by= "Species_name") 
drops <- c("Tooth") 
UR.data <- UR.data[ , !(names(UR.data) %in% drops)]
UR.data <- distinct(UR.data) 

# Lower right
names(LR.data)[names(LR.data) == "X"] <- "Species_name" 
LR.data <- merge(LR.data, traits[,123:128], by= "Species_name") 
drops <- c("Tooth")
LR.data <- LR.data[ , !(names(all.data) %in% drops)]
LR.data <- distinct(LR.data)









# Phylomorphospace by factor- diet
(tip.cols <-
  with(data,
       data.frame(diet = levels(diet),
                  color = I(brewer.pal(nlevels(diet), name = 'Dark2')))))    

     