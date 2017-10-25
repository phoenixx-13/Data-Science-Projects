## app.R ##

ui <- dashboardPage(skin = "blue",
      
  dashboardHeader(title = "Web scraping Project"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Main Page", tabName = "mainpage", icon = icon("mainpage")),
      menuItem("EDA Graphs", tabName = "eda", icon = icon("eda")),
      menuItem("Duration vs release year", tabName = "sims", icon = icon("sim")),
      menuItem("Dataset", tabName = "data", icon = icon("data"))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "mainpage",
              fluidRow(
                    box(h2("Brief dataset overview"),
                    DT::dataTableOutput("plot01"))
                
                )
              ),    
           
      tabItem(tabName = "eda",
              box(plotOutput("plot2", height = 500)),
              
              box(
              radioButtons(inputId = "eda_graph", "Choose variable to see graph:",
                           list("Duration", "Release month", "Release year", "Rating", "Sentiment",
                                "Duration vs release date","Duration vs release year","Certificate")))
            
           ),
      tabItem(tabName = "sims",
              fluidRow(
                box(plotOutput("plot3", height = 500)),
                box(
                  
               
                 sliderInput("dur", h4("Duration vs rating"), 0, 400, c(60, 90)))
              )   
      ),  
      
      tabItem(tabName = "data",
             
              h2("Film review complete dataset"),
             
              box(DT::dataTableOutput("data01"))
              
             )
      
    )
  )
)