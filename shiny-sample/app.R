#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(shinythemes)

# might haveto make sure their working directory is correct
# check with getwd() first in Console, then if it doesnt work, do the entire setwd("blahblahblah/shiny-sample")

source("modelforproject.R", local = TRUE)

# Define UI for application 
ui <- navbarPage(
  theme = shinytheme("cerulean"),
  
  # insert title of page
                 
  title = "HCAP FYSP Project",
  
  # first panel
  
  tabPanel("Model",
           fluidPage(
             titlePanel("Sample Data Graphs"),
             sidebarLayout(
               sidebarPanel(
                 selectInput(
                   "plot_type",
                   
                   # Title of the sidebar
                   
                   "Plot Type",
                   
                   # listing out the options
                   
                   c("Outlier" = "a", "Rescaled" = "b")
                 )),
               mainPanel(plotOutput("line_plot")))
           )),
  tabPanel("About", 
           titlePanel("About"),
           h3("Project Background and Motivations"),
           p("Hello, I literally made this project for a sample teaching curriculum."),
           h3("About Me"),
           p("My name is Brian Kim and I study Government and East Asian Studies. 
             You can reach me at jkim4@college.harvard.edu.")))

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$line_plot <- renderPlot({
    # Generate type based on input$plot_type from ui
    
    ifelse(
      input$plot_type == "a",
      
      # If input$plot_type is "a", which shows the Outlier graph, we know that is the "sample" graph 
      
      return(sampleplot),
      
      # If input$plot_type is "b", plot histogram of "eruptions" column
      # from the faithful dataframe
      
      return(sampleplot2)
    )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
