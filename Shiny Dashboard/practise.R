library(shiny)
library(shinythemes)
ui <- fluidPage(theme = shinytheme("cerulean"),
                navbarPage(
                  "My first app",
                  tabPanel("Navbar 1",
                           sidebarPanel(
                             tags$h3("Input:"),
                             textInput("txt1", "Given Name:", ""),
                             textInput("txt2", "Surname:", ""),
                             
                           
                           # Input: Slider for the number of bins ----
                           sliderInput(inputId = "bins",
                                       label = "Number of bins:",
                                       min = 1,
                                       max = 50,
                                       value =30),
                           ), # sidebarPanel
                           mainPanel(
                             h1("Header 1"),
                             h4("Output 1"),
                             verbatimTextOutput("txtout"),
                             # Output: Histogram ----
                             plotOutput(outputId = "distPlot")
                             
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  tabPanel("Navbar 2", "This panel is intentionally left blank"),
                  tabPanel("Navbar 3", "This panel is intentionally left blank")
                  
                ) # navbarPage
) # fluidPage


# Define server function  
server <- function(input, output) {
  
  output$txtout <- renderText({
    paste( input$txt1, input$txt2, sep = " " )
  })
  output$distPlot <- renderPlot({
    
    x    <- airquality$Ozone
    x    <- na.omit(x)
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "#75AADB", border = "black",
         xlab = "Ozone level",
         main = "Histogram of Ozone level")
    
  })
} # server


# Create Shiny object
shinyApp(ui = ui, server = server)