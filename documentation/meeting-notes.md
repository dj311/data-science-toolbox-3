# Meeting notes

## 2018-12-05

We looked into the feasibility of modelling as point-processes. We don't have a time axis, and the nodes aren't identified so it isn't doable.

## 2018-12-06

Potential approach:
  - Stick to the same inference goal as before: 'malicious vs non-malicious'.
  - Select good performing model from previous projects (e.g. svm, knn, random forests, regression etc).
    - Find papers which use these models and pick one that has shown to work well with the KDD-99 data set. Can then use the paper as justification for that approach.
  - Evaluate model when tested against different attacks (warez vs smurf vs portsweep...) or categories (probing, u2l, r2l, dos).
  - Select the attacks it is worst at predicting.
  - Use "Stacking":
     - Develop classifiers that work well to identify those particular attack tyes (e.g. make k-NN that can identify probing attacks very well)
     - Use these classifiers to add new features to the original data set e.g. `is_probing`.
     - Run the original classifier on the augmented data set (original + new features).
     - Evaluate: does it improve performance?

Example:
  1. First, run k-nn and come up with the prediction: "portsweep or not portsweep".
    - Call them knn_is_portsweep.
  2. Second, run svm and come up with the prediction: "warez or not warez".
    - Call them svm_is_warez.
  3. Run a classifier on the dataset, but with two new features.


**TODO** Dan is going to get a start on implementing a random forest classifier as our "main" model for Saturday. See how far he gets.


#### Note
We also considered doing straight stacking, i.e:
  1. First, run k-nn and come up with `malicious vs non-malicious` predictions. Call them `knn_label`.
  2. Second, run svm and come up with `malicious vs non-malicious` predictions. Call them `svm_label`.
  3. Now we have original 41 features + 2 new ones `knn_label` and `svm_label`.
  4. Run a classifier on all 43 features.



## 2018-12-11

We looked at the confusion matrix from [the random forest classifier](./daniel-jones-documentation.md#Random forest on all features) and analysed it as follows:


### Things we've noticed from this plot:

1. The only errors for the smurf category are when we predict normal but it's actually smurf.
  - Junfan plotted them with tsne dimenonsality reduction to plot in two axes, which showed three main clusters, and some point which are spread out. Are these the outliers? If so, can we add a step which identifies them?
2. There are far more situations where we predict as normal, but it's actually malicious than the other way round.
  - This isn't good, can we reduce it?


### Things we want to do

Junfan came up with some cool ideas:

1. Use K-means to find arbitrary groupings/clusters.
2. Add "attack types" as a label, e.g: smurf is DOS, portsweep is probing, etc.

Compare performance of 1 and 2. Then, use both of these as pre-processing for random forest. See which one gives best performance overall.


We also decided that we are going to use this random forest as our "baseline classifier" as required by the assessment spec.
