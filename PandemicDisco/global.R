library(tidyverse)
#library(DT)
fullmaster <- read_csv('./data/fullmasterfinal.csv')

key_contingencies <- fullmaster |>
  drop_na(key) |>
  count(year, month, key) |>
  spread(year, n, fill = 0)

dominant_keys <- fullmaster |>
  group_by(year, month, key, mode) |>
  summarise(count = n()) |>
  slice(which.max(count))
dom_key_clean <- dominant_keys |>
  group_by(year, month) |>
  slice(which.max(count))

#avg anova
#avg_anova <- aov(avgvalence ~ year + Error(month/year), data = avgdf)
#print(summary(avg_anova))

#old avg plot code 
#fullmaster |>
 # group_by(year, month) |>
  #summarize(Average = mean(.data[[input$select]], na.rm = TRUE)) |>
  #mutate(month = factor(month), year = factor(year)) |>
  #ggplot(aes(month, Average, group = year, color = year)) +
  #geom_line()

# new avg plot code
#avgdf <- fullmaster |>
 # group_by(year, month) |>
  #summarize(Average = mean(.data[[input$select]], na.rm = TRUE)) |>
  #mutate(month = factor(month), year = factor(year))

#avgplot <- avgdf|> 
 # ggplot(aes(month, Average, group = year, color = year)) +
  #geom_line()

#text to display SIGNIFICANCE
 #output$sigText <- renderText({
 #if (placeholder < 0.05) {
 #return("The difference between years is significant.")
 #} else {
  #return("The difference between years is not significant.")
#}
#})

#key CHI SQUARE
#output$sigText <- renderText({
# key_chi_square <- key_contingencies |>
#  group_split(month) |>
# map(~ chisq.test(select(.data[[input$select]], -month))) |>
#set_names(unique(fullmaster$month))
#p_value2 <- key_chi_square[[1]][3]

#if (p_value2 < 0.05) {
# return("The difference between years is significant.")
#} else {
# return("The difference between years is not significant.")
#}

#select CHI SQUARE DROPDOWN input 
#,
#selectInput("selectmonth", label = h3("Select month"), 
#    choices = c(1 = "January", 2 = "February", 3 = 'March', 4 = "April", 5 = "May", 6 = "June", 7 = "July", 8 = "August", 9 = "September", 10 = "October", 11 = "November", 12 = "December"), 
#)

#CREATE MULTIPLE TABS
#tabsetPanel(
 # tabPanel("Averages", 
  #         h2("Compare monthly averages of metrics between years"),
          
  #),
  #tabPanel("Keys", 
   #        h2("Compare the frequencies of musical keys each month between years"),
          
#  )
#)
#)

#fullmaster |>
 # filter(month == input$selectmonth) |>
  #group_by(year, month, key) |>
  #mutate(key = c("C", "C#", "D", "D#", "E", "F", "F#", "G", "G#","A", "A#", "B")[key+1], year = factor(year)) |>
  #mutate(key = factor(key, levels = c("C", "C#", "D", "D#", "E", "F", "F#", "G", "G#","A", "A#", "B"))) |>
  #drop_na(key) |>
  #summarise(count = n()) |>
  # ggplot(aes(x=year, y= count, fill= key))+
  # geom_bar(stat = "identity", position = "fill", color= "black", size= 0.1, width= 0.5)+
  # labs(x="Month", y="Number of Songs")

