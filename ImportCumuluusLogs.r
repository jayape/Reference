#weather <- read.csv("C:/R Sessions/Data/Cumuluus/Jul16log.txt", stringsAsFactors = FALSE, header = FALSE)
#weathernames <- read.csv("C:/R Sessions/Data/Cumuluus/monthlyfileheader.txt", sep = ",", header = TRUE)
#names(weather) <- names(weathernames)

#weather[,1] <- as.POSIXct(weather[,1], "%d/%m/%y", tz = "")
#weather[,2] <- as.POSIXct(weather[,2])

#head(weather[,c(1,2)])

#setwd("C:/R Sessions")
#files <- list.files(path="./Data/Cumuluus", pattern="*log.txt", full.names=T, recursive=FALSE)
#files

setwd("C:/R Sessions")

file_list <- list.files(path="./Data/Cumuluus/Temp", pattern="*log.txt", full.names=T, recursive=FALSE)

for (file in file_list){
  # if the merged dataset doesn't exist, create it
  if (!exists("weather")){
    weather <- read.csv(file, stringsAsFactors = FALSE, header=FALSE)
    weather$V27 <- 0.00
  }
  
  # if the merged dataset does exist, append to it
  if (exists("weather")){
    temp <-read.csv(file, stringsAsFactors = FALSE, header=FALSE)
    one <- ncol(temp)
    two <- ncol(weather)
    if (ncol(temp) < ncol(weather)) {
      temp$V27 <- 0.00
    }
    weather <-rbind(weather, temp)
    rm(temp)
  }
  
}

weathernames <- read.csv("./Data/Cumuluus/monthlyfileheader.txt", sep = ",", header = TRUE)
names(weather) <- names(weathernames)

weather[,1] <- as.POSIXct(weather[,1], "%d/%m/%y", tz = "")

df <- weather[71683,]
