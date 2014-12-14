library(shiny)

# Define UI for dataset viewer application
shinyUI(fluidPage(
  
  # Application title.
  titlePanel("Next Word Prediction"),
  
  # Sidebar with controls to select a dataset and specify the
  # number of observations to view. The helpText function is
  # also used to include clarifying text. Most notably, the
  # inclusion of a submitButton defers the rendering of output
  # until the user explicitly clicks the button (rather than
  # doing it immediately when inputs change). This is useful if
  # the computations required to render output are inordinately
  # time-consuming.
  sidebarLayout(
    sidebarPanel(
      textInput("Phrase", "Phrase:", "Enter Phrase"),
      
      helpText("Note: Enter a phrase above and press the button",
               "to get the next word. Model is based on twitter and",
               "news data."),
      
      submitButton("Predict Next Word")
    ),
    
    # Show a summary of the dataset and an HTML table with the
    # requested number of observations. Note the use of the h4
    # function to provide an additional header above each output
    # section.
    mainPanel(
      h4("You entered:"),
      textOutput("text1"),
      
      h4("Predicted Next Word:"),
      textOutput("text2")
    )
  )
))