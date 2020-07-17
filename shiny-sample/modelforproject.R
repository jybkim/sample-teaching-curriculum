

# Copy library.

library(ggplot2)
library(tidyverse)
library(dplyr)


# Load in the csv file (this folder will be replicated into the Shiny folder). 

sample_excel <- read.csv("sample_excel.csv")

# Start all the data twisting that we've done. 

######COPY&PASTED FROM BEFORE######

# Let's begin our correlation. Let's just play around with the correlation, using the cor command.
# We can subset the data by making a new dataset altogether.
# For the purposes of this workshop, we will only subset for columns that are numeric.

data2 <- sample_excel %>%
  select_if(is.numeric)

# Let's view the subsetted dataset. There's two columns 'lotsize' and 'hoa' with NA values,
# and we do not want to include them because this could hinder what we want to do in the end.

# We could filter out all the NA observations in the dataset.

data_na_play <- data2 %>%
  filter(!is.na(lotsize)) %>%
  filter(!is.na(hoa))

# There's only 11 observations with all the values intact, which isn't a lot. So what else can we do?

# We can remove the select columns.

data_without_na <- data2 %>%
  select(!lotsize) %>%
  select(!hoa)

# So what can we do? Let's make a specific column that does this.

modified_data <- data_without_na %>%
  mutate(newprice = ifelse(year < 2000, price + 100000, price))

# The syntax is - I want to 'mutate' the original dataset by making a new column 'newprice', and 
# the conditions are IF the year < 2000, then add 100000 to price and if not keep it as price value

# while we're at it, let's make a categorical variable that shows which houses are made before 2000 and after.
modified_data <- modified_data%>%
  mutate(whenmade = ifelse(year < 2000, "Old", "New"))


########THE GRAPHS############

# We probably want to see a scatterplot to show individual datapoints, correct? So let's do that.

sampleplot <- ggplot(modified_data, aes(x = sqft, y = newprice, color = whenmade)) + 
  
  # To specify which kind of graph we want, we use geom_ - for the purpose of this, 
  # we will be using geom_point
  
  geom_point() + 
  
  # This is where we will insert a line of best fit to see how the relationship looks like.
  
  geom_smooth(formula = y ~ x, 
              method = "lm", se = FALSE, color = "black") + 
  
  # label 
  
  labs(title = "Relationship Between Sq. Ft and Price",
       subtitle = "100000 added to New Homes", 
       y = "Price", x = "Sq. Footage", color = "Year Made") + 
  
  # scale the color manually
  
  scale_color_manual(values = c("blue", "red")) + 
  
  # make it theme_classic (lots of themes if you search online)
  
  theme_classic()

# There's a chance that the numbers could come out in Scientific notation. What we can do is this: 

# disable scientific notation 
options(scipen = 999)

# moving onto our graph

sampleplot2 <- modified_data %>%
  subset(sqft < 5500) %>%
  
  ggplot(aes(x = sqft, y = newprice, color = whenmade)) + 
  
  # To specify which kind of graph we want, we use geom_ - for the purpose of this, 
  # we will be using geom_point
  
  geom_point() + 
  
  # This is where we will insert a line of best fit to see how the relationship looks like.
  
  geom_smooth(formula = y ~ x, 
              method = "lm", se = FALSE, color = "black") + 
  
  # label 
  
  labs(title = "Relationship Between Sq. Ft and Price",
       subtitle = "100000 added to New Homes", 
       y = "Price", x = "Sq. Footage", color = "Year Made") + 
  
  # scale the color manually
  
  scale_color_manual(values = c("red", "blue")) + 
  
  # change x scale
  
  scale_x_continuous(
    breaks = c(0, 2500, 5000),
    labels = c("0", "2,5K", "5K")
  )+ 
  
  # make it theme_classic (lots of themes if you search online)
  
  theme_classic()

#######################

# So we know the graphs we want to incorporate are titled sampleplot and sampleplot2. 

# Back to app.R file!

