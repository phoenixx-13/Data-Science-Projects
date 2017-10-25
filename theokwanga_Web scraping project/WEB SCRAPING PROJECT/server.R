#SERVER.R
library(shiny)
library(shinydashboard)
library(shinythemes)
library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(gridExtra)
library(grid)
library(DT)
setwd("C:/Users/OLYMPIA/Desktop/WEB SCRAPING PROJECT/")

film_reviews = read.csv("global/film_reviews.csv")

server <- function(input, output) {
 
  output$plot01 <- DT::renderDataTable({
    film_reviews[,c(1,2,3,4,5,11,12,7)][1:8,]
})
  output$plot2 <- renderPlot({
     
    if(input$eda_graph=="Duration"){
      
      hist(film_reviews$duration, main="Histogram for duration of film", 
           xlab= "Duration in minutes", col="green")
      
    }else{
      
      if(input$eda_graph=="Release month"){
        
        ggplot(film_reviews, aes(x = release_month))  + geom_histogram(fill="blue", bins = 36) 
         
      }else{
      
      if(input$eda_graph=="Release year"){
        
      ggplot(film_reviews01, aes(x = release_year, group=rating, fill=rating)) + geom_histogram(bins = 20) +
        stat_count() + theme(axis.text.x  = element_text(angle=45, vjust=0.5, size=8))
        
      }else{
        
        if(input$eda_graph=="Rating"){
          
          ggplot(film_reviews, aes(x = rating))  + geom_histogram(fill="blue") 
          
        }else{
          
          if(input$eda_graph=="Duration vs release date"){
          
          qplot(x = release_date, y = duration, colour = rating, xlab="Release date", ylab="Duration", data = film_reviews01)
         
          }else{
            
            if(input$eda_graph=="Duration vs release year"){
              
              qplot(x = release_year, y = duration, colour = rating, xlab="Release year", ylab="Duration", data = film_reviews01)
          
          
        }else{
          
          if(input$eda_graph=="Sentiment"){
            
          
          ggplot(film_reviews, aes(x = sentiment)) + geom_histogram(stat = "count", fill="blue") 
             
          }else{
            
         if(input$eda_graph=="Certificate"){
              
         
         ggplot(film_reviews, aes(x = certificate)) + geom_histogram(stat = "count", fill="blue")    
          
       }}}}}}}}
    
  })
  
  film_reviews01 =subset(film_reviews, film_reviews$release_year > "1975")
  
  output$plot2b <- renderPlot({
    ggplot(film_reviews01, aes(x = release_year, group=rating, fill=rating)) + geom_histogram(stat = "count") +
      theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=8))
    
  })
  
  output$plot2c <- renderPlot({
  
  ggplot(film_reviews01, aes(x = release_year, group=certificate, fill=certificate)) + geom_histogram(stat = "count")+
    theme(axis.text.x  = element_text(angle=90, vjust=0.5, size=8))
  })
  output$plot3 <- renderPlot({
  
      ggplot(film_reviews, aes(x = duration, group=rating, fill=rating)) +
    
      geom_histogram(data=subset(film_reviews, (film_reviews$duration > input$dur[1] &  film_reviews$duration < input$dur[2])))
    
  })
  
  output$data01 <- DT::renderDataTable({
    film_reviews[,c(1,2,3,4,5,11,12,7,8)]
    
  })
}
  
 

