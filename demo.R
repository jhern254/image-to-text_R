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
            background = "primary",  
            closable = FALSE,
            maximizable = TRUE,
            sidebar = boxSidebar(
                id = "ui_sidebar_1",
                width = 25,
                actionButton(ns("reset"), "Reset image")
            ),
            fileInput(ns("upload"), "Upload image (.png)", 
                       accept = "image/png", multiple = FALSE),
            imageOutput(ns("image"))
        ),
        fluidRow(
            h1("image!"),
#            imageOutput(ns("image"))
        )
    )
}


imageServer <- function(id) {
    moduleServer( id, function(input, output, session) {
        ns <- session$ns

        # Create gargoyle watchers
        init("render_img")

        base64 <- reactive({
            watch("render_img")
            req(input$upload)
            uploaded_img <- input$upload
            uploaded_img <- uploaded_img$datapath

#            if (!is.null(uploaded_img)) {
#                uploaded_img <- uploaded_img$datapath
#                if (TRUE) {
#                    message("new uploaded image: ", uploaded_img)
#                }
#            }
#
            # change to validate if not right format
#            if (is.null(uploaded_img)) {
#                message("no image")
#            }
        }) 
#        bindEvent(input$upload, ignoreNULL = FALSE, ignoreInit = TRUE)

        observeEvent(input$upload, {
            # check this
            trigger("render_img")
        
            if (TRUE) {
#                message("uploaded image: ", base64()$uploaded_img)
#                message("uploaded image: ", print(base64()))
                message("uploaded image")
            }


#            uploaded_img <- input$upload

            # ez way
            if (TRUE) {
                output$image <- renderImage({
                    if (TRUE) {
                        message("printing image")
                    }
                    list(
#                    src = as.character(uploaded_img$datapath),
                        src = as.character(base64()),
                        contentType = "image/png",
                        width = "100%",
                        style = "width: 700px"
                    )
                }, deleteFile = FALSE)
            }


        })




        observeEvent(input$reset, {
            message("button clicked")
            output$image <- NULL
        })



    })
}



# app skeleton
if (TRUE) {
app  <- shinyApp(
ui = dashboardPage(
    title = "Toy Shiny",
    header = dashboardHeader(
                title = dashboardBrand(
                    title = tags$img(src = "https://i.insider.com/5b69ffdc7708e97dce12be09?width=700", 
                                     height = "110", 
                                     width = "230"
#                                     align = "right"
                            ) 
                ),
                status = "gray-dark"
             ),
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


