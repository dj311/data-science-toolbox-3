The numumber of different types of data
```
> length(which(connection_events$type=="u2r"))
[1] 52
> length(which(connection_events$type=="dos"))
[1] 389255
> length(which(connection_events$type=="probe"))
[1] 4107
> length(which(connection_events$type=="r2l"))
[1] 1126
> 
```

For this unbalanced size, we should definitely do something...
1. Add data from other dataset<br>
2. Anomaly detection?
3. Add weights for some categories have less number?

1. Try to resize the data size by using the whole dataset, but for type 3 and 4... 
Generally, just probe's data increases
```
#Levels: dos probe r2l u2r

> length(which(connection_events$type=='normal'))
[1] 974981
> length(which(connection_events$type==1))
[1] 3881167
> length(which(connection_events$type==2))
[1] 41102
> length(which(connection_events$type==3))
[1] 1126
> length(which(connection_events$type==4))
[1] 54
> ```
For training 4 types data, the confusion matrix shows that it has a good performance for classifing the dos, normal and probe events. However, for u2r which has 52 events only, the performance is terrible. How to improve it? `May be create some data eg.copy, SMOTE(binary?)`...

Look this tomorrow
https://www.quora.com/In-classification-how-do-you-handle-an-unbalanced-training-set


Two ways for imbalanced problem:
1. kmeans get 54 centers for all four types
2. from normal to detect the abnormal events

