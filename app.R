#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# make bar chart of top 10-50 products with slider - adjust number of products shown

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(readr)

# Define UI for application that draws a dot plot
ui <- fluidPage(

    # Application title
    titlePanel("Compare the nutrition value of common foods"),
    
    # Sidebar with a slider input for number of foods 
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId= "dataset", 
                        label="Select nutrient", 
                        choices = c("Highest calories","Lowest calories",
                                                    "Highest protein", 
                                                     "Highest fat",
                                                     "Highest fibre",
                                                     "Highest sugar"),
                                        selected = "Highest fibre"),
        ),
    
    
    # Show a plot of the generated bars
    mainPanel(
        p("Nutrition value are in units per 100g. Data is taken from Food Standards Australia New Zealand."),
        tableOutput("view")
    )
        ))



# Define server logic required to draw a bar chart
server <- function(input, output) {
    # Monitor 'Sample' button. When pressed, generate data from dataset to show on plot
    # based on selected number of foods from slider input.
    
    
    food <- read_csv("food.csv")
    calories <- na.omit(food, cols = "Calories")
    calories <- calories[order(calories$Calories),]
    calories_least <- head(calories, 50)
    calories_most <- tail(calories, 50)
    
    # foods appear in ascending order of glucose
    glucose <- na.omit(food, cols = "Glucose")
    glucose <- glucose[order(glucose$Glucose),]
    glucose_most <- tail(glucose, 50)
    
    
    # foods appear in ascending order of fat
    fat <- na.omit(food, cols = "Fat")
    fat <- fat[order(fat$Fat),]
    fat_most <- tail(fat, 50)
    
    
    # order data so that foods appear in descending order of protein
    protein <- na.omit(food, cols = "Protein")
    protein <- protein[order(-protein$Protein),]
    protein_most <- head(protein, 50)
    
    # foods appear in descending order of fibre
    fibre <- na.omit(food, cols = "Fibre")
    fibre <- fat[order(-fibre$Fibre),]
    fibre_most <- head(fibre, 50)
        
        datasetInput <- reactive({switch(input$dataset,
                       "Highest Calories" = calories_most,
                       "Lowest Calories" = calories_least,
                       "Highest protein" = protein_most, 
                       "Highest fat" = fat_most,
                       "Highest fibre" = fibre_most,
                       "Highest sugar" = glucose_most)})
        # show the selected number of foods
        output$view <- renderTable({datasetInput()})
        }

# Run the application 
shinyApp(ui = ui, server = server)
