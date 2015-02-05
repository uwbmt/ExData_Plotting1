data <- read.table('./household_power_consumption.txt', sep = ";", nrows = 1, stringsAsFactors=FALSE)

fileName="household_power_consumption.txt"
con = file(fileName,open="r")
lin = readLines(con)

for (i in 1:length(lin)){
        if (grepl("^(1|2)/2/2007", lin[i])){
                line <- unlist(strsplit(lin[i], split = ";"))
                data <- rbind(data, line)
        }
}
close(con)

colnames(data) <- read.table('./household_power_consumption.txt', sep = ";", nrows = 1, stringsAsFactors=FALSE)
data = data[-1,]
rownames(data) <- NULL
data$Time <- paste(data$Date, data$Time, sep = " ")
data[,1] <- NULL
data$Time <- strptime(data$Time, format = "%d/%m/%Y %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)

png("plot2.png", width=480, height=480)   
plot(data$Time, data$Global_active_power, col="black", xlab = "", ylab = "Global Active Power (kilowatts)", main = "", type = "l")
dev.off() 
