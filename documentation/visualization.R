library(Rtsne)

# test for choosing 200 data randomly
sam <- sample(494020,200)

Labels<-connection_events$label[sam]
connection_events$label[sam]<-as.factor(connection_events$label[sam])
## for plotting
colors = rainbow(length(unique(connection_events$label[sam])))
names(colors) = unique(connection_events$label[sam])
## create color labels for plotting
colorslabel<-c()
for(i in connection_events$label[sam]){
  colorslabel <- c(colorslabel,colors[name=i])
}

ts <- Rtsne(connection_events[sam,-42], dims = 2, perplexity=30, verbose=TRUE, max_iter = 500, check_duplicates=FALSE)

plot(ts$Y, pch=16, cex=.3, xaxt='n', yaxt='n', ann=FALSE, col=colorslabel)
