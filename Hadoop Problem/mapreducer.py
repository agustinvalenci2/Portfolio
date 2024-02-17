#maplearn

import sys
import numpy as np
from sklearn.model_selection import train_test_split, cross_val_score, GridSearchCV
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# Read input from stdin
training_data = []
training_targets = []
test_data = []
test_targets = []

for line in sys.stdin:
    data = line.strip().split('\t')
    target = int(data[0])
    features = list(map(float, data[1].split()))

    # Separate training and test data
    if 'train' in data[2]:
        training_data.append(features)
        training_targets.append(target)
    else:
        test_data.append(features)
        test_targets.append(target)

# Convert ratings to binary classes: positive (1) for ratings > 5, negative (0) otherwise
training_targets = np.array([1 if rating > 5 else 0 for rating in training_targets])
test_targets = np.array([1 if rating > 5 else 0 for rating in test_targets])

# Normalize data
scaler = StandardScaler()
training_data_normalized = scaler.fit_transform(training_data)
test_data_normalized = scaler.transform(test_data)

# Train a Random Forest classifier with cross-validation for parameter tuning
rf_classifier = RandomForestClassifier()
param_grid = {'n_estimators': [10, 50, 100], 'max_depth': [None, 5, 10]}
grid_search = GridSearchCV(rf_classifier, param_grid, cv=5)
grid_search.fit(training_data_normalized, training_targets)

# Get the best model
best_rf_classifier = grid_search.best_estimator_

# Evaluate model performance on training data using cross-validation
cv_scores = cross_val_score(best_rf_classifier, training_data_normalized, training_targets, cv=5)

# Test the best model on test data
test_predictions = best_rf_classifier.predict(test_data_normalized)
test_accuracy = accuracy_score(test_targets, test_predictions)

# Print results
print(f"Cross-validation scores: {cv_scores}")
print(f"Mean cross-validation score: {np.mean(cv_scores)}")
print(f"Best parameters: {grid_search.best_params_}")
print(f"Test accuracy: {test_accuracy}")
