#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  
  # Application title
  titlePanel("Pandemic At The Disco"),
  tabsetPanel(
    tabPanel("Averages", 
             h2("Compare monthly averages of metrics between years with COVID-19 deaths trend"),
             
             
             # Sidebar with a dropdown for different variables
             sidebarLayout(
               sidebarPanel(
                 selectInput("selectmetric", label = h3("Select metric"), 
                             choices = c('acousticness', 'danceability', 'energy', 'liveness', 'loudness', 'speechiness', 'valence'), 
                 )
               ),
               
               # Show a plot of the generated distribution
               mainPanel(
                 plotOutput("avgPlot"),
                 textOutput("sigText"),
                 plotOutput("covidPlot"),
               )
             )
    ),
    tabPanel("Keys", 
             h2("Compare the frequencies of musical keys each month between years"),
             sidebarLayout(
               sidebarPanel(
                 selectInput("selectmonth", label = h3("Select month"), 
                             choices = c("All" = "All", "January" = "01", "February" = "02", 'March' = "03", "April" = "04", "May" = "05", "June" = "06", "July" = "07", "August" = "08", "September" = "09", "October" = "10", "November" = "11", "December" = "12"),  
                 )
               ),
               
               mainPanel(
                 plotOutput("keyPlot", height = "600px"),
                 textOutput("sigText2"),
                 dataTableOutput("domKey")
               )
             )
    )
  )
)
