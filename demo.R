library(shiny)
library(vroom)
library(bs4Dash)
library(dplyr)
library(magrittr)
library(gargoyle) # NOTE: USE THIS
library(tidyr)
library(stringr)
library(shinyWidgets) # extra UI elems
library(reactlog)
library(base64enc)
options("gargoyle.talkative" = TRUE) # for debugging
options(shiny.maxRequestSize = 30*1024^2)


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
            sidebar = boxSidebar(
                id = "ui_sidebar_1",
                width = 25,
                fileInput("upload", NULL, buttonLabel = "Upload image", 
                           accept = "image/png", multiple = FALSE)
            ),
            uiOutput("image")
        )
    )
}


imageServer <- function(id) {
    moduleServer( id, function(input, output, session) {
        ns <- session$ns

        # Create gargoyle watchers
#        init("render_table")

        base64_img <- reactive({
            uploaded_img <- input$upload
            if(!is.null(uploaded_img)) {
                dataURI(file = uploaded_img$datapath, mime = "image/png")
            }
        })

        output$image <- renderUI({
            if(!is.null(base64_img())) {
                tags$div(
                    tages$img(src = base64_img(), width = "100%"),
                    style = "width: 400 px;"
                )
            }
        })




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


