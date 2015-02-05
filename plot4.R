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
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

png("plot4.png", width=480, height=480) 
par(mfrow=c(2,2))
plot(data$Time, data$Global_active_power, col="black", xlab = "", ylab = "Global Active Power", main = "", type = "l")

plot(data$Time, data$Voltage, xlab = "datetime", ylab = "Voltage", type="l")

plot(data$Time, data$Sub_metering_1, col="black", xlab = "", ylab = "Energy sub metering", main = "", type = "l")
lines(data$Time, data$Sub_metering_2, col="red", type = "l")
lines(data$Time, data$Sub_metering_3, col="blue", type = "l")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col= c("black","red","blue"), lwd = c(1,1,1), bty = "n")

plot(data$Time, data$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type="l")

dev.off() 
