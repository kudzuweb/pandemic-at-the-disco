#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

    output$avgPlot <- renderPlot({
#generate line plot of avg monthly valence each year
      avgdf <- fullmaster |>
       group_by(year, month) |>
       summarize(Average = mean(.data[[input$selectmetric]], na.rm = TRUE)) |>
       mutate(month = factor(month), year = factor(year))
      
      avgplot <- avgdf|> 
       ggplot(aes(month, Average, group = year, color = year)) +
       geom_line()
      avgplot
    })
    
#avg anova
    output$sigText <- renderText({
    avgdf <- fullmaster |>
      group_by(year, month) |>
      summarize(Average = mean(.data[[input$selectmetric]], na.rm = TRUE)) |>
      mutate(month = factor(month), year = factor(year))
    avg_anova <- aov(Average ~ year + Error(month/year), data = avgdf)
    anova_output <- summary(avg_anova)
    p_value1 <- anova_output[[2]][[1]][1,5]
    
    if (p_value1 < 0.05) {
      return("The difference between years is significant.")
      } else {
      return("The difference between years is not significant.")
      }
    
    })
#line plot of COVID deaths
    output$covidPlot <- renderPlot({
      monthlycovid |>
        mutate(month = as.numeric(month)) |>
        ggplot(aes(month, deaths)) +
        geom_line() +
        scale_x_continuous(breaks = 1:12)
    })
#bar chart of keys in each month
    output$keyPlot <- renderPlot({
      if (input$selectmonth != "All") {
      
      countdf <- fullmaster |>
        filter(month == input$selectmonth) |>
        group_by(year, month, key) |>
        mutate(key = c("C", "C#", "D", "D#", "E", "F", "F#", "G", "G#","A", "A#", "B")[key+1], year = factor(year)) |>
        mutate(key = factor(key, levels = c("C", "C#", "D", "D#", "E", "F", "F#", "G", "G#","A", "A#", "B"))) |>
        drop_na(key) |>
        summarise(count = n())
      
      countplot <- countdf |>
        ggplot(aes(x=year, y= count, fill= key))+
        geom_bar(stat = "identity", position = "fill", color= "black", size= 0.1, width= 0.5)+
        labs(x="Month", y="Number of Songs")
      countplot}
      
      else {fullmaster |>
        group_by(year, month, key) |>
        mutate(key = c("C", "C#", "D", "D#", "E", "F", "F#", "G", "G#","A", "A#", "B")[key+1], year = factor(year)) |>
        mutate(key = factor(key, levels = c("C", "C#", "D", "D#", "E", "F", "F#", "G", "G#","A", "A#", "B"))) |>
        drop_na(key) |>
        summarise(count = n()) |>
        ggplot(aes(x=year, y= count, fill= key))+
        geom_bar(stat = "identity", position = "fill", color= "black", size= 0.1, width= 0.5)+
        facet_wrap(~month)+
        labs(x="Month", y="Number of Songs")}
    })
    
    
    #key CHI SQUARE
    output$sigText2 <- renderText({
      if (input$selectmonth != "All"){
      key_chi_square <- key_contingencies |>
        filter(month== input$selectmonth) |>
        select(`2019`, `2020`) |>
        chisq.test()
      p_value2 <- key_chi_square$p.value
      
      if (p_value2 < 0.05) {
        return("The difference between years is significant.")
      } else {
        return("The difference between years is not significant.")
      }
      }
      else {return("Select a month to see chi square results.")}
    })
    output$domKey <- renderDataTable({
      dom_key_clean
    })
}
