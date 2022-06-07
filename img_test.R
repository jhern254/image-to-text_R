library(shiny)
library(base64enc)
options(shiny.maxRequestSize = 30*1024^2)


# app skeleton
if (TRUE) {
app  <- shinyApp(
ui = fluidPage(
    fileInput("upload", "Upload image", accept = "image/png", multiple = FALSE),
#    uiOutput("image")    
    imageOutput("image")    
),
server = function(input, output, session) {
    base64 <- reactive({
        req(input$upload)
        uploaded_img <- input$upload
        message("data path: ", uploaded_img$datapath)
#        if(!is.null(uploaded_img)) {
#            dataURI(file = uploaded_img$datapath, mime = "image/png")
#        }
        uploaded_img$datapath
    })

    # from stackoverflow
#    output$image <- renderUI({
#        if (TRUE) {
#            message("base64", base64())
#        }
#        if(!is.null(base64())) {
#            tags$div(
#                tags$img(src = base64(), width = "100%"),
#                style = "width: 400px;"
#            )
#        }
#    })
    
    output$image <- renderImage({
        if (TRUE) {
            message("base64: ", base64())
        }
        list(src = base64(),
             contentType = "image/png",
             width = 500,
             height = 650
        )
    }, deleteFile = FALSE)




}
)
runApp(app, port=7777)
}


