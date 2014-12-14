library(shiny)
library(data.table)
library(stringr)
# Load data  
load("ngr2.final.Rda")
load("ngr3.final1.Rda")
load("ngr4.final1.Rda")
# Define function
getNextWord = function(x) {

	x <- tolower(x)
	x <- gsub("[^[:alnum:][:space:]']", "", x)
	words <- strsplit(x," ")
	x1 <- words[[1]]
	n <- length(x1)
	input1<-""
	input2<-""
	input3<-""
	if (n==1) {
		input1 <- word(x, -1)
	} else if (n==2) {
		input1 <- word(x, -1)
		input2 <- paste(word(x, -(2:1)), collapse=' ')
	} else if (n>=3) {
		input1 <- word(x, -1)
		input2 <- paste(word(x, -(2:1)), collapse=' ')
		input3 <- paste(word(x, -(3:1)), collapse=' ')
	}
	if (length(input3) != 0) {
		result <- get4gram(input3)
	}
	if (length(result) == 0 && length(input2) !=0) {
		result <- get3gram(input2)
	}
	if (length(result) == 0 && length(input1) !=0) {
		result <- get2gram(input1)
	}
	if (length(result) == 0) {
		result <- "the"
	} 
	result

}
get4gram = function(x) {
	x <- ngr4.final1[p1==x,][,grp.ranks:=rank(-1*freq,ties.method='first')][grp.ranks<=1,]
	x$p2

}
get3gram = function(x) {
	x <- ngr3.final1[p1==x,][,grp.ranks:=rank(-1*freq,ties.method='first')][grp.ranks<=1,]
	x$p2

}
get2gram = function(x) {
	x <- ngr2.final[p1==x,][,grp.ranks:=rank(-1*freq,ties.method='first')][grp.ranks<=1,]
	x$p2

}

# Define server logic required to summarize and view the 
# selected dataset
shinyServer(function(input, output) {

  
  # Generate a summary of the dataset
  output$text1 <- renderText({
    input$Phrase
  })
  
  # get the next word
  output$text2 <- renderText({
	 validate(
	      need(input$Phrase != "", "Please enter a phrase")
	  )
	 getNextWord(input$Phrase)  
  })

})


