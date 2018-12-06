# Meeting notes

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


#### Note
We also considered doing straight stacking, i.e:
  1. First, run k-nn and come up with `malicious vs non-malicious` predictions. Call them `knn_label`.
  2. Second, run svm and come up with `malicious vs non-malicious` predictions. Call them `svm_label`.
  3. Now we have original 41 features + 2 new ones `knn_label` and `svm_label`.
  4. Run a classifier on all 43 features.
