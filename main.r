# Load required libraries
libraries <- c("audio", "rjson", "httr", "tm",
"SnowballC", "wordcloud", "RColorBrewer")
lapply(libraries, function(lib) {
  if (!require(lib, character.only = TRUE)) {
    install.packages(lib)
  }
})

# Function to record audio
record_audio <- function(rec_time) {
  library(audio)
  set.audio.driver(NULL)
  #rec_time <- 5
  Samples <- rep(NA_real_, 44100 * rec_time)
  print("Start speaking...")
  audio_obj <- record(Samples, 44100, 1)
  wait(rec_time+1)
  print("Stop speaking")
  rec <- audio_obj$data
  file.create("temp.wav")
  save.wave(rec, "temp.wav")
  print("Audio saved")
  return("temp.wav")
}

# Function to transcribe audio
transcribe_audio <- function(audio_path) {
  library(httr)
  library(rjson)
  headers = c(
    `Ocp-Apim-Subscription-Key` = "[replace with your own key]",
    `Content-Type` = "audio/wav"
  )
  params = list(`language` = 'en-US')
  print("Transcribing audio file...")
  data = upload_file(audio_path)
  response <- httr::POST(url = '[replace with your own url]',
                         httr::add_headers(.headers=headers), query = params, body = data)
  result <- fromJSON(httr::content(response, "text", encoding = "UTF-8"))
  print("Transcrb complete")
  txt_output <- as.data.frame(result)
  txt_input <- txt_output[1,4]
  writeLines(txt_input, "temp.txt")
  return("temp.txt")
}

# Function to generate word cloud from text
generate_wordcloud <- function(txt_path) {
    library("tm")
    library("SnowballC")
    library("wordcloud")
    library("RColorBrewer")
    text <- readLines(txt_path)
    docs <- Corpus(VectorSource(text))
    inspect(docs)
    to_space <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
    docs <- tm_map(docs, to_space, "/")
    docs <- tm_map(docs, to_space, "@")
    docs <- tm_map(docs, to_space, "\\|")

    # Convert the text to lower case
    docs <- tm_map(docs, content_transformer(tolower))
    # Remove numbers
    docs <- tm_map(docs, removeNumbers)
    # Remove english common stopwords
    docs <- tm_map(docs, removeWords, stopwords("english"))
    # Remove your own stop word
    # specify your stopwords as a character vector
    docs <- tm_map(docs, removeWords, c("blaa", "blaa2"))
    # Remove punctuations
    #docs <- tm_map(docs, removePunctuation)
    # Eliminate extra white spaces
    docs <- tm_map(docs, stripWhitespace)
    # Text stemming
    docs <- tm_map(docs, stemDocument)

    dtm <- TermDocumentMatrix(docs)
    m <- as.matrix(dtm)
    v <- sort(rowSums(m), decreasing = TRUE)
    d <- data.frame(word = names(v), freq = v)
    head(d, 10)

    set.seed(1234)
    wordcloud(words = d$word, freq = d$freq, min.freq = 1,
                        max.words = 500, random.order = FALSE, rot.per = 0.35,
                        colors = brewer.pal(8, "Dark2"))
}

# Function to run the program
main <- function() {
    cat("1) Record audio (beta - may not work properly)\n2) Import txt file\n3) Import wav file\n4) Exit\n")
    choice <- as.integer(readline(prompt="Enter your choice: "))
    switch(choice,
           "1" = {
             rec_time <- as.integer(readline(prompt="How much audio you want to record ? (sec): "))
             audio_path <- record_audio(rec_time)
             txt_path <- transcribe_audio(audio_path)
             generate_wordcloud(txt_path)
           },
           "2" = {
             txt_path <- file.choose()
             generate_wordcloud(txt_path)
           },
           "3" = {
             audio_path <- file.choose()
             txt_path <- transcribe_audio(audio_path)
             generate_wordcloud(txt_path)
           },
           "4" = {
             cat("Exiting...\n")
             break
           },
           {
             cat("Invalid choice. Please try again.\n")
           })
  
}

# Run the main function
main()

