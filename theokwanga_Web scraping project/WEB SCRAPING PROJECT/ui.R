##
library(shiny)
library(shinythemes)

fluidPage(theme = shinytheme("superhero"),  
  titlePanel("German Credit Data Visualization by Theo Kwanga (NYCDSA)"),
             sidebarLayout(
             sidebarPanel(
              
             # Using a conditional panel to display different sidebars for different tabs
               
              conditionalPanel(condition="input.conditionedPanels==1",
                    tags$div(class="header", checked=NA,
                    tags$p("This is a shiny application to visualize German credit data and highlight
                            major creditors and credit default trends which can be further investigated in 
                            order to improve lending services to identified groups and also mitigate credit defaulting."),
                    div(style = "height:25px;width:100%;background-color: #999999"),                 
                    tags$p("Caution: The statistical significance of the visual inferences has not been considered nor
                            analysed at this stage")),
                    
                    div(style = "height:25px;width:100%;background-color: #999999"),   
                        
                    radioButtons("plot_var1", h4("Select variable to view credit trend:"), selected = "Age",
                    list("Age", "Purpose", "Occupation", "Family status"))
              
             ),
               
               conditionalPanel(condition="input.conditionedPanels==2",
                 radioButtons("plot_var2", h4("Select variable to view credit trend:"), selected = "Age",
                    list("Age", "Purpose", "Occupation", "Family status"))),
                        
              
              conditionalPanel(condition="input.conditionedPanels==3",
                               
                               sliderInput("Age_input", h4("Enter Age range"), 20, 70, c(25, 35),
                               animate = animationOptions(interval = 1000, loop = TRUE)),
                                
                         sliderInput("Amount_input", "Enter Credit range", 0, 20000, c(0, 5000),step = 2500, post = "DM"),
              
                 radioButtons("Occup_input", "Choose Occupation",
                           choices = c("Highly qualified employee", "Skilled employee", "Unemployed/unskilled", "Unskilled"),
                           selected = "Unskilled"))
                              
                               ),
                              
             mainPanel(
                 
                 tabsetPanel(
                   
                  tabPanel("Grapical EDA", value=1,
                          
                  plotOutput("plot01")),
                 
                  
    
                  tabPanel("Credit default proportions", value=2, #fluid = TRUE,
                           
                 # fluidRow(verticalLayout(splitLayout(cellWidths = c("50%", "50%"))),
                           
                        #  column(10, offset=2,
                           
                           #plotOutput("plot01"),
                           plotOutput("plot02")),
                 
                 tabPanel("Credit default distributions", value=3,  fluid = TRUE,
                          plotOutput("var_scatterplot"),
                          tableOutput("data_subset")),
                 
                 id = "conditionedPanels"


       )
    )
  ) 
)




