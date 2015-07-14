#2012 Person data
#Readig the data structure file
tbl<-read.csv("./NHIS/2012/personsx_summaryclean.csv")

#Reading the original fixed width file 
clmnlen<-tbl$Length
clmnnme<-tbl$FinalDocName
system.time(data<-read.fwf(unz("./NHIS/2012/personsx.zip","personsx.dat"),
                           clmnlen,col.names=clmnnme))
#system.time(data<-read.fwf("./NHIS/2012/personsx.dat",clmnlen,col.names=clmnnme))

#Writing the fixed data into a CSV file (larger file but 70 times faster load)
write.table(data,"./NHIS/2012/personsx.csv", sep=",",col.names = TRUE,
            row.names=FALSE)
zip("./NHIS/2012/personsxcsv.zip", "./NHIS/2012/personsx.csv")
system.time(datacsv<-read.csv("./NHIS/2012/personsx.csv"))
file.remove("./NHIS/2012/personsx.csv")


#2012 Family data
#Readig the data structure file
tbl<-read.csv("./NHIS/2012/familyxx_summaryclean.csv")

#Reading the original fixed width file 
clmnlen<-tbl$Length
clmnnme<-tbl$FinalDocName
system.time(data<-read.fwf(unz("./NHIS/2012/familyxx.zip","familyxx.dat"),
                           clmnlen,col.names=clmnnme))
#system.time(data1<-read.fwf("./NHIS/2012/familyxx.dat",clmnlen,col.names=clmnnme))

#Writing the fixed data into a CSV file (larger file but 70 times faster load)
write.table(data,"./NHIS/2012/familyxx.csv", sep=",",col.names = TRUE, 
            row.names=FALSE)
zip("./NHIS/2012/familyxxcsv.zip", "./NHIS/2012/familyxx.csv")
system.time(datacsv<-read.csv("./NHIS/2012/familyxx.csv"))
file.remove("./NHIS/2012/familyxx.csv")




#2012 alternative data
#Readig the data structure file
tbl<-read.csv("./NHIS/2012/altdatastrclean.csv")

#Reading the original fixed width file 
clmnlen<-tbl$Length
clmnnme<-tbl$FinalDocName
system.time(data<-read.fwf(unz("./NHIS/2012/althealt.zip","althealt.dat"),
                           clmnlen,col.names=clmnnme))
#system.time(data<-read.fwf("./NHIS/2012/althealt.dat",clmnlen,col.names=clmnnme))

#Writing the fixed data into a CSV file (larger file but 80 times faster load)
write.table(data,"./NHIS/2012/althealt.csv", sep=",",col.names = TRUE,
            row.names=FALSE)
zip("./NHIS/2012/althealtcsv.zip", "./NHIS/2012/althealt.csv")
system.time(datacsv<-read.csv("./NHIS/2012/althealt.csv"))
file.remove("./NHIS/2012/althealt.csv")



#2012 adult summary data
#Readig the data structure file
tbl<-read.csv("./NHIS/2012/samadult_summaryclean.csv")

#Reading the original fixed width file 
clmnlen<-tbl$Length
clmnnme<-tbl$FinalDocName
system.time(data<-read.fwf(unz("./NHIS/2012/samadult.zip","samadult.dat"),
                           clmnlen,col.names=clmnnme))
#Writing the fixed data into a CSV file (larger file but 80 times faster load)
write.table(data,"./NHIS/2012/samadult.csv", sep=",",col.names = TRUE,
            row.names=FALSE)
zip("./NHIS/2012/samadultcsv.zip", "./NHIS/2012/samadult.csv")
system.time(datacsv<-read.csv("./NHIS/2012/samadult.csv"))
file.remove("./NHIS/2012/samadult.csv")


#Reading CSV files

#Person data
personsx<-read.csv(unzip("./NHIS/2012/personsxcsv.zip"))
file.remove("./NHIS/2012/personsx.csv")


#Family data
familyxx<-read.csv(unzip("./NHIS/2012/familyxxcsv.zip"))
file.remove("./NHIS/2012/familyxx.csv")


#Sample adult data
samadult<-read.csv(unzip("./NHIS/2012/samadultcsv.zip"))
file.remove("./NHIS/2012/samadult.csv")


#Alternative adult data
althealt<-read.csv(unzip("./NHIS/2012/althealtcsv.zip"))
file.remove("./NHIS/2012/althealt.csv")


#Joining data frames
library(dplyr)

#set up a key
althealth<-mutate(althealt, KEY=HHX*10000+FMX*100+FPX)
person<-mutate(personsx, KEY=HHX*10000+FMX*100+FPX)

#Filter persons for alternative health cases
personalt<-filter(person, KEY %in% althealth$KEY)

