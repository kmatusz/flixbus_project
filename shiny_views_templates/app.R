#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
title <- titlePanel("Flixbus scraper interface")

ui_login <- fluidPage(

    title,

    sidebarLayout(
        sidebarPanel(
            h3("Login"),
            textInput("user", "User"),
            passwordInput("pass", "Password"),
            checkboxInput("keep", "Keep me logged in"),
            actionButton("l", "Log in")
        ),

        mainPanel(
        )
    )
)


ui_add_job <- fluidPage(
    
    title,
    
    sidebarLayout(
        sidebarPanel(
            h3("Add new parameters to request"),
            textInput("s", "Arrival City"),
            textInput("pass", "Departure City"),
            textInput("dfd", "Date"),
            actionButton("l", "Add parameters (this will also run scraper)")
        ),
        
        mainPanel(
        )
    )
)

ui_get <- fluidPage(
    
    title,
    
    sidebarLayout(
        sidebarPanel(
            h3("Get scraped results"),
            actionButton("l", "Fetch all requested results from the database")
        ),
        
        mainPanel(
            tableOutput("table")
        )
    )
)

ui_run <- fluidPage(
    
    title,
    
    sidebarLayout(
        sidebarPanel(
            h3("Run all requests"),
            actionButton("l", "Run")
        ),
        
        mainPanel(
        )
    )
)

ui_admin <- fluidPage(
    
    title,
    
    sidebarLayout(
        sidebarPanel(
            h3("Admin view - see defined jobs and execution logs")
        ),
        
        mainPanel(
            h3("Execution logs"),
            tableOutput("logs"),
            h3("Defined jobs"),
            tableOutput("jobs")
        )
    )
)




server <- function(input, output) {

    output$table <- renderTable({

        tribble(~`Arrival`, ~`Departure`, ~`Time`, ~Price, ~`Date obtained`,
                "Krakow", "Warsaw", "2020.10.10 18:30", "34.50", "2019.12.31",
                "...", "...", "...", "...", "...")
        
    })
    
    
    output$logs <- renderTable({
        
        tribble(~time_created, ~user_created, ~last_run_date,
                "...", "...", "...")
        
    })
    
    output$jobs <- renderTable({
        
        tribble(~user_created, ~`Arrival`, ~`Departure`, ~`Time`,
                "...", "...", "...", "...")
        
    })
}

shinyApp(ui = ui_admin, server = server)
