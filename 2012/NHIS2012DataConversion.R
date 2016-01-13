#2012 Person data
#Readig the data structure file
tbl<-read.csv("./NHIS/2012/personsx_summaryclean.csv")

#Reading the original fixed width file 
clmnlen<-tbl$Length
clmnnme<-tbl$FinalDocName
system.time(data<-read.fwf(unz("./NHIS/2012/personsx.zip","personsx.dat"),
                           clmnlen,col.names=clmnnme))

#Saving the data in RDS format that can be read in a fraction of a second
saveRDS(data, file = "./NHIS/2012/personsx.rds")



#2012 Family data
#Readig the data structure file
tbl<-read.csv("./NHIS/2012/familyxx_summaryclean.csv")

#Reading the original fixed width file 
clmnlen<-tbl$Length
clmnnme<-tbl$FinalDocName
system.time(data<-read.fwf(unz("./NHIS/2012/familyxx.zip","familyxx.dat"),
                           clmnlen,col.names=clmnnme))

#Saving the data in RDS format that can be read in a fraction of a second
saveRDS(data, file = "./NHIS/2012/familyxx.rds")



#2012 alternative data
#Readig the data structure file
tbl<-read.csv("./NHIS/2012/altdatastrclean.csv")

#Reading the original fixed width file 
clmnlen<-tbl$Length
clmnnme<-tbl$FinalDocName
system.time(data<-read.fwf(unz("./NHIS/2012/althealt.zip","althealt.dat"),
                           clmnlen,col.names=clmnnme))

#Saving the data in RDS format that can be read in a fraction of a second
saveRDS(data, file = "./NHIS/2012/althealt.rds")



#2012 adult summary data
#Readig the data structure file
tbl<-read.csv("./NHIS/2012/samadult_summaryclean.csv")

#Reading the original fixed width file 
clmnlen<-tbl$Length
clmnnme<-tbl$FinalDocName
system.time(data<-read.fwf(unz("./NHIS/2012/samadult.zip","samadult.dat"),
                           clmnlen,col.names=clmnnme))

#Saving the data in RDS format that can be read in a fraction of a second
saveRDS(data, file = "./NHIS/2012/althealt.rds")


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

