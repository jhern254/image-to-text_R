library(shiny)
library(base64enc)
options(shiny.maxRequestSize = 30*1024^2)


# app skeleton
if (TRUE) {
app  <- shinyApp(
ui = fluidPage(
    fileInput("upload", "Upload image", accept = "image/png", multiple = FALSE),
    uiOutput("image")    
),
server = function(input, output, session) {
    base64 <- reactive({
        uploaded_img <- input$upload
        if(!is.null(uploaded_img)) {
            dataURI(file = uploaded_img$datapath, mime = "image/png")
        }
    })

    output$image <- renderUI({
        if(!is.null(base64())) {
            tags$div(
                tags$img(src = base64(), width = "100%"),
                style = "width: 400px;"
            )
        }
    })
}
)
runApp(app, port=7777)
}


