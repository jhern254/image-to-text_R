library(shiny)
library(DTedit)
library(vroom)
library(bs4Dash)
library(dplyr)
library(magrittr)
library(gargoyle) # NOTE: USE THIS
library(DT)
library(tidyr)
library(stringr)
library(shinyWidgets) # extra UI elems
library(reactlog)
options("gargoyle.talkative" = TRUE) # for debugging

reactlog_enable()

# read demo data
#df_tibble <- vroom("personnel_data_final.csv", col_names = TRUE)


# make df
#df_orig <- data.frame(df_tibble)
#df_orig$salary_hourly <- as.numeric(df_orig$salary_hourly)


imageUI <- function(id) {
    ns <- NS(id)
    tagList(
        fluidRow(
            h1("Sort image!")
        ),
#        box(
#            title = "Search PI",
#            width = 12,
#            solidHeader = TRUE,     # what does this do?
#            background = "danger",  
#            closable = FALSE,
#            selectizeInput(ns("pi"), "Select PI", 
#                       choices = sort(unique(as.character(df_orig$name))),
#            ),
#            multiInput(ns("pi"), "Select PI",     
#                       choices = sort(unique(as.character(df_orig$name))), 
#                       selected = NULL, 
#                       options = list(limit = 1) # based on JS
#            ),
#            actionButton(ns("table_button"), "Render table")
#        ),
        box(
            title = "Sort list",
            width = 12,         
            solidHeader = TRUE,
            background = "danger",  
            closable = FALSE,
            maximizable = TRUE,
            fileInput("upload", NULL, buttonLabel = "Upload image", multiple = FALSE),
            tableOutput("files")
#            dteditmodUI(ns("pi_table"))
        )
    )
}


imageServer <- function(id) {
    moduleServer( id, function(input, output, session) {
        ns <- session$ns

        # Create gargoyle watchers
#        init("render_table")
        output$files <- renderTable(imageUi$upload)





    })
}



# app skeleton
if (TRUE) {
app  <- shinyApp(
ui = dashboardPage(
    title = "Cedars-Sinai Dashboard",
    header = dashboardHeader(),
    sidebar = dashboardSidebar(
        sidebarUserPanel(
            name = "Sort Master 9000"
        ),
        sidebarMenu(
            sidebarHeader("Sorting"),
            menuItem(
                "Sort stuff",
                tabName = "img_1",
                icon = icon("table")
            )
        )
    ),

    body = dashboardBody(
        tabItems(
            tabItem(
                tabName = "img_1",
                imageUI("img_1")
            )
        
        )
    )
   
),
server = function(input, output, session) {
    imageServer("img_1")
}
)
runApp(app, port=7777)
}


