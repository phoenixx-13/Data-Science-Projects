#SERVER.R
library(shiny)
library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)
library(gridExtra)
library(grid)
library(shinythemes)
# setwd("~/SHINY_PROJECT/")
summary(german_credit)
german_credit_t = read.csv("global/german_credit_T.csv")
german_credit = read.csv("global/german_credit.csv")
german_credit_01 = german_credit
german_credit_01$Purpose = german_credit_t$Purpose
german_credit_01$Occupation = german_credit_t$Occupation

##
#Full_summary = summary(German_Credit_01)
#Sub_summary = summary(german_credit[,c(6,14,3,2)])
#Sub_summary = data.frame(Sub_summary)

##
german_credit_by_Age = german_credit_t %>%
  group_by(Age..years.) %>% 
  select(Age..years., Credit.Amount) %>%
  summarise_all(funs(sum))

german_credit_by_Age$Age..years. = factor(german_credit_by_Age$Age..years., levels = german_credit_by_Age$Age..years.[order(-german_credit_by_Age$Credit.Amount)])

#
german_credit_by_Purpose = german_credit_t %>%
  group_by(Purpose) %>% 
  select(Purpose, Credit.Amount) %>%
  summarise_all(funs(sum))

german_credit_by_Purpose$Purpose = factor(german_credit_by_Purpose$Purpose, levels = german_credit_by_Purpose$Purpose[order(-german_credit_by_Purpose$Credit.Amount)])
#
german_credit_by_occupation = german_credit_t %>%
  group_by(Occupation) %>% 
  select(Occupation, Credit.Amount) %>%
  summarise_all(funs(sum))
##
german_credit_by_occupation$Occupation = factor(german_credit_by_occupation$Occupation, levels = german_credit_by_occupation$Occupation[order(-german_credit_by_occupation$Credit.Amount)])
##
german_credit_by_fam_status = german_credit_t %>%
  group_by(Sex...Marital.Status) %>% 
  select(Sex...Marital.Status, Credit.Amount) %>%
  summarise_all(funs(sum))
##
german_credit_by_fam_status$Sex...Marital.Status = factor(german_credit_by_fam_status$Sex...Marital.Status, levels = german_credit_by_fam_status$Sex...Marital.Status[order(-german_credit_by_fam_status$Credit.Amount)])
##

#### "Group by" graphs

amount_grp_by_age = ggplot(german_credit_by_Age, aes(x = Age..years., y = Credit.Amount, fill = Credit.Amount)) + 
  geom_bar(stat = "identity") + theme(text=element_text(size=14)) +
  ggtitle("Credit Amounts grouped by Ages") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_y_continuous(name="Credit.Amount", limits=c(0, 1200000))
###
amount_grp_by_purpose = ggplot(german_credit_by_Purpose, aes(x = Purpose, y = Credit.Amount, fill = Credit.Amount)) +
  geom_bar(stat = "identity", fill = "green") + 
  ggtitle("Credit Amounts grouped by purpose") +
  xlab("Purpose") + theme(text=element_text(size=14)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_y_continuous(name="Credit amount in DM", limits=c(0, 750000))
###
amount_grp_by_occupation = ggplot(german_credit_by_occupation, aes(x = Occupation, y = Credit.Amount, fill = Credit.Amount)) +
  geom_bar(stat = "identity", fill = "darkred") + 
  ggtitle("Credit amounts grouped by Occupation") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_y_continuous(name="Credit amount in DM") + theme(text=element_text(size=14))
###
amount_grp_by_fam_status = ggplot(german_credit_by_fam_status, aes(x = Sex...Marital.Status, y = Credit.Amount, fill = Credit.Amount)) +
  geom_bar(stat = "identity", fill = "red") + 
  ggtitle("Credit amounts grouped by family status") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_y_continuous(name="Credit amount in DM") + theme(text=element_text(size=14))
### Credit default graphs
default_by_age_grp =  ggplot(german_credit_t, aes(x = reorder(Age..years., -Creditability), fill = factor(Creditability))) +
  geom_bar(position = "dodge") + xlab("Age..years.") + guides(fill=guide_legend(title="Creditability")) +
  ggtitle("Credit default proportion grouped by Ages") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_hue(labels=c("Not credible", "Credible")) + theme(text=element_text(size=14))
###
default_by_purpose =  ggplot(german_credit_t, aes(x = reorder(Purpose, -Creditability), fill = factor(Creditability))) +
  geom_bar(position = "dodge") + guides(fill=guide_legend(title="Creditability")) +
  ggtitle("Credit default proportion grouped by purpose") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_hue(labels=c("Not credible", "Credible")) + theme(text=element_text(size=14))
###
default_by_occupation =  ggplot(german_credit_t, aes(x = reorder(Occupation, -Creditability), fill = factor(Creditability))) +
  geom_bar(position = "dodge") + guides(fill=guide_legend(title="Creditability")) +
  ggtitle("Credit default proportion grouped by occupation") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_hue(labels=c("Not credible", "Credible")) + theme(text=element_text(size=14))
###
default_by_fam_status =  ggplot(german_credit_t, aes(x = reorder(Sex...Marital.Status, -Creditability), fill = factor(Creditability))) +
  geom_bar(position = "dodge") + guides(fill=guide_legend(title="Creditability")) +
  ggtitle("Credit default proportion grouped by family status") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_hue(labels=c("Not credible", "Credible")) + theme(text=element_text(size=14))
###
# An if else statement is used to determine which data subset (grouping) to be displayed.

server <- function(input, output,session) {
  
  output$plot01 <- renderPlot({plot(1:10 ,1:10)
    
    if(input$plot_var1=="Age"){
      amount_grp_by_age 
      
    }else{
      
      if(input$plot_var1=="Purpose"){
        
        amount_grp_by_purpose  
        
      }else{
        
        if(input$plot_var1=="Occupation"){
          
          amount_grp_by_occupation 
          
        }else{
          
          if(input$plot_var1=="Family status"){
            
            amount_grp_by_fam_status 
          }
        }}}
    
    
  }) #height = 400, width = 600)  
  
  output$plot02 <- renderPlot({plot(1:10 ,10:1)
    
    
  
      if(input$plot_var2=="Age"){
        default_by_age_grp

      }else{

        if(input$plot_var2=="Purpose"){

          default_by_purpose

        }else{

          if(input$plot_var2=="Occupation"){

            default_by_occupation

          }else{

            if(input$plot_var2=="Family status"){

              default_by_fam_status
            }
          }}}

  })
  
  # The section below uses the user imputs to generate a scatterplot
  
  output$var_scatterplot <- renderPlot({
  
    filtered_data =  german_credit_01 %>%
        filter(., (Age..years. >= input$Age_input[1] & Age..years. <= input$Age_input[2]),
               Occupation == input$Occup_input,
               (Credit.Amount >= input$Amount_input[1] & Credit.Amount <= input$Amount_input[2])
        )  
        
      ggplot(filtered_data, aes(y= Credit.Amount, x=Age..years.)) + geom_point(aes(colour = factor(Creditability)),  size = 3) +
      geom_smooth(method=lm) + theme(text=element_text(size=14))
    })
# position = position_jitterdodge()
  # Generate a subset of the data base on user selections 
  
  output$data_subset <- renderTable({
    
    filtered_data =  german_credit_01 %>%
        filter(., (Age..years. >= input$Age_input[1] & Age..years. <= input$Age_input[2]),
               Occupation == input$Occup_input,
               (Credit.Amount >= input$Amount_input[1] & Credit.Amount <= input$Amount_input[2])
        )  
    filtered_data = filtered_data[,c(1,6,14)] 
    
    head(summary(filtered_data), 4) # Print the fist 4 lines in the filtered_data summary
    
  })

}
