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
3. Add weight for some categories.

