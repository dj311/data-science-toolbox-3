library(caret)
library(data.table)
library(ggplot2)
library(ranger)
library(ROSE)
require(dplyr)
set.seed(0xC0FFEE)

connection_events <- readRDS(file='./data/data_without_smurf_neptune_and_high_accuracy_attacks.rds')
# final will be the final data after oversampling
final=data.frame()
for(i in unique(connection_events$label)){
  if(i=="normal."){
    temp <- connection_events
    temp2 <- temp[which(temp$label=="normal."),]
    final=rbind(final,temp2)
  }
  else{
    print(i)
    name = paste0("resample_",i)
    temp <- connection_events %>% 
      filter(connection_events$label == "normal." | connection_events$label == i)
    temp <- ovun.sample(label ~ ., data = temp, method="over", N=194554)$data
    temp2 <- temp[which(temp$label!="normal."),]
    assign(name,temp) 
    final=rbind(final,temp2)
  }
}
connection_events=final
