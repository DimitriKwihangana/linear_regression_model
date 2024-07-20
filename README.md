# Linear Regression Summative

## Overview

This project consists of two linear regression models and a Flutter application integrated with a FastAPI backend.

1. **Univariate Linear Regression Model**: Predicts sales based on TV advertising expenditure.
2. **Multivariate Linear Regression Model**: Predicts student performance based on hours slept, past scores, extracurricular activities, and past paper corrections.

## Univariate Linear Regression Model

### Description

The univariate linear regression model aims to predict sales based on the amount spent on TV advertising. This model uses a single feature, TV advertising expenditure, to predict the target variable, sales.

### Data

- **Feature**: TV advertising expenditure
- **Target**: Sales

### Implementation

The model is implemented using Python and the `scikit-learn` library. It involves loading the dataset, splitting it into training and testing sets, training the model on the training set, and evaluating its performance on the testing set.

## Multivariate Linear Regression Model

### Description

The multivariate linear regression model predicts student performance based on several features, including hours slept, past scores, participation in extracurricular activities, and the number of past papers corrected.

### Data

- **Features**: Hours slept, past scores, extracurricular activities, past paper corrections
- **Target**: Student performance

### Implementation

This model is also implemented using Python and the `scikit-learn` library. The process includes loading the dataset, splitting it into training and testing sets, training the model on the training set, and evaluating its performance on the testing set.

### FastAPI Backend

A FastAPI backend was created to serve the multivariate linear regression model. The backend is hosted on Render, making the model accessible via API endpoints.

## Flutter Application

### Description

The Flutter application provides a user-friendly interface to input the features required by the multivariate linear regression model and display the predicted student performance. The app communicates with the FastAPI backend to retrieve predictions.

### Integration

- **Frontend**: Flutter
- **Backend**: FastAPI hosted on Render

Users can enter the necessary features (hours slept, past scores, extracurricular activities, past paper corrections) into the Flutter app, which sends the data to the FastAPI backend. The backend processes the data using the trained multivariate linear regression model and returns the predicted student performance, which is then displayed in the app.

## Conclusion

This project demonstrates the implementation and deployment of both univariate and multivariate linear regression models. The integration of the multivariate model with a FastAPI backend and a Flutter frontend showcases how machine learning models can be deployed and utilized in real-world applications.
