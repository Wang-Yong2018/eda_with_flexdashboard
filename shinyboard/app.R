#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(
    title="Basic dashboard"
  ),
  dashboardSidebar(
      sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Widgets", tabName = "widgets", icon = icon("th"))
      )
  ),
  dashboardBody(
    fluidRow(
      box(
        title='control',
        sliderInput("slider", "Number of observation:", 1,100,50) 
        ),
    ) ,
    fluidRow(
      box(title='output', plotOutput("plot1",height=250)),
    ) 
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata<-rnorm(500)
  output$plot1<-renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  } )
}

shinyApp(ui = ui, server = server)
