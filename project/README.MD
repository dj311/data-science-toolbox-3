The numumber of different types of data
```
smurf.              280790
neptune.            107201
normal.              97278
back.                 2203
satan.                1589
ipsweep.              1247
portsweep.            1040
warezclient.          1020
teardrop.              979
pod.                   264
nmap.                  231
guess_passwd.           53
buffer_overflow.        30
land.                   21
warezmaster.            20
imap.                   12
rootkit.                10
loadmodule.              9
ftp_write.               8
multihop.                7
phf.                     4
perl.                    3
spy.                     2
dtype: int64

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
1. kmeans get 20 centers for all four types (did not converge in 10 iterations: normal)
           dos normal  probe    r2l    u2r
  dos    331558      0  18754      5     12
  normal   1295   6419  14828   5244  61745
  probe     113      0   3579      2      3
  r2l         9      0     45    878     82
  u2r         0      0      0      0     49
  Terrible results compared with(although the predicted normal are 100% normal)
              dos normal  probe    r2l    u2r
  dos    350323      3      2      1      0
  normal      4  89514      4      8      1
  probe       0     20   3677      0      0
  r2l         1     29      0    982      2
  u2r         0     17      0      2     30
  
                    
                   buffer_overflow. ftp_write. ipsweep. multihop. nmap. normal. portsweep. rootkit. satan. warezclient. warezmaster.
  buffer_overflow.               29          0        0         0     0       1          0        0      0            0            0
  ftp_write.                      0          8        0         0     0       0          0        0      0            0            0
  ipsweep.                        0          0     1247         0     0       0          0        0      0            0            0
  multihop.                       0          0        0         5     0       1          0        0      0            0            1
  nmap.                           0          0        5         0   226       0          0        0      0            0            0
  normal.                         0          0        1         0     0   97271          0        0      0            5            0
  portsweep.                      0          0        1         0     0       1       1038        0      0            0            0
  rootkit.                        0          0        0         0     0       2          0        8      0            0            0
  satan.                          0          0        0         0     0       3          0        0   1586            0            0
  warezclient.                    0          0        0         0     0       2          0        0      0         1018            0
  warezmaster.                    0          0        0         0     0       0          0        0      0            0           20
  
  
                    
                    back. buffer_overflow. ftp_write. guess_passwd.  imap. ipsweep.  land. loadmodule. multihop. neptune.  nmap. normal.  perl.   phf.   pod. portsweep. rootkit.
  back.              2203                0          0             0      0        0      0           0         0        0      0       0      0      0      0          0        0
  buffer_overflow.      0               29          0             0      0        0      0           0         0        0      0       1      0      0      0          0        0
  ftp_write.            0                0          6             0      0        0      0           0         0        0      0       1      0      0      0          0        0
  guess_passwd.         0                0          0            53      0        0      0           0         0        0      0       0      0      0      0          0        0
  imap.                 0                0          0             0     12        0      0           0         0        0      0       0      0      0      0          0        0
  ipsweep.              0                0          0             0      0     1245      0           0         0        0      0       2      0      0      0          0        0
  land.                 0                0          0             0      0        0     21           0         0        0      0       0      0      0      0          0        0
  loadmodule.           0                1          0             0      0        0      0           8         0        0      0       0      0      0      0          0        0
  multihop.             0                0          0             0      0        0      0           0         4        0      0       2      0      0      0          0        0
  neptune.              0                0          0             0      0        0      0           0         0   107201      0       0      0      0      0          0        0
  nmap.                 0                0          0             0      0       55      0           0         0        0    174       2      0      0      0          0        0
  normal.               0                1          0             0      0        0      1           0         0        0      0   97269      0      0      1          0        0
  perl.                 0                0          0             0      0        0      0           0         0        0      0       0      3      0      0          0        0
  phf.                  0                0          0             0      0        0      0           0         0        0      0       0      0      4      0          0        0
  pod.                  0                0          0             0      0        0      0           0         0        0      0       0      0      0    264          0        0
  portsweep.            0                0          0             0      0        1      0           0         0        0      0       0      0      0      0       1039        0
  rootkit.              0                0          0             0      0        0      0           0         0        0      0       3      0      0      0          0        7
  satan.                0                0          0             0      0        0      0           0         0        0      0       1      0      0      0          0        0
  smurf.                0                0          0             0      0        0      0           0         0        0      0       0      0      0      0          0        0
  spy.                  0                0          0             0      0        0      0           0         0        0      0       0      0      0      0          0        0
  teardrop.             0                0          0             0      0        0      0           0         0        0      0       0      0      0      0          0        0
  warezclient.          0                0          0             0      0        0      0           0         0        0      0       2      0      0      0          0        0
  warezmaster.          0                0          0             0      0        0      0           0         0        0      0       0      0      0      0          0        0
                  
                   satan. smurf.   spy. teardrop. warezclient. warezmaster.
  back.                 0      0      0         0            0            0
  buffer_overflow.      0      0      0         0            0            0
  ftp_write.            0      0      0         0            1            0
  guess_passwd.         0      0      0         0            0            0
  imap.                 0      0      0         0            0            0
  ipsweep.              0      0      0         0            0            0
  land.                 0      0      0         0            0            0
  loadmodule.           0      0      0         0            0            0
  multihop.             0      0      0         0            0            1
  neptune.              0      0      0         0            0            0
  nmap.                 0      0      0         0            0            0
  normal.               0      0      0         0            5            0
  perl.                 0      0      0         0            0            0
  phf.                  0      0      0         0            0            0
  pod.                  0      0      0         0            0            0
  portsweep.            0      0      0         0            0            0
  rootkit.              0      0      0         0            0            0
  satan.             1588      0      0         0            0            0
  smurf.                0 280790      0         0            0            0
  spy.                  0      0      2         0            0            0
  teardrop.             0      0      0       979            0            0
  warezclient.          0      0      0         0         1018            0
  warezmaster.          0      0      0         0            0           20
  
2. from normal to detect the abnormal events

