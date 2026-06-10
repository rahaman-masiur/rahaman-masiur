
# 🫁 Lung Cancer Detection — ML Classifier Comparison Study

<div align="center">

![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Scikit-learn](https://img.shields.io/badge/Scikit--learn-F7931E?style=flat&logo=scikit-learn&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-013243?style=flat&logo=numpy&logoColor=white)
![Matplotlib](https://img.shields.io/badge/Matplotlib-11557C?style=flat&logo=python&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=flat&logo=jupyter&logoColor=white)


**A comparative study of 5 Machine Learning classifiers for early-stage lung cancer prediction.**

*Group Project · Swami Vivekananda University · Ardent Computech Pvt. Ltd.*

</div>

---

## 📌 Project Overview

Lung cancer is one of the leading causes of cancer-related deaths worldwide. Early detection dramatically improves survival rates. This project builds and compares **5 machine learning classification models** on patient survey data to identify the most accurate model for predicting lung cancer risk.

The goal is not just accuracy — but to understand **which features (symptoms/habits) are the strongest predictors**, giving actionable insight for early screening.

---


## 🎯 Problem Statement

> **Can we predict the likelihood of lung cancer based on patient lifestyle and symptom survey responses using machine learning?**

Given a dataset of patient attributes (age, smoking habits, symptoms), train and compare multiple classifiers to:
1. Identify the **best-performing model** for lung cancer detection
2. Determine the **most significant features** contributing to cancer risk
3. Build a reusable, well-documented ML pipeline

---

## 📦 Dataset

| Property | Details |
|----------|---------|
| **Source** | Kaggle — [Lung Cancer Survey Dataset](https://www.kaggle.com/datasets/mysarahmadbhat/lung-cancer) |
| **Rows** | 309 patient records |
| **Features** | 15 attributes + 1 target |
| **Target** | `LUNG_CANCER` — YES / NO (Binary Classification) |
| **Class Balance** | ~87% YES · ~13% NO |

### Feature Description

| Feature | Type | Description |
|---------|------|-------------|
| `GENDER` | Categorical | M / F |
| `AGE` | Numerical | Patient age |
| `SMOKING` | Binary | 1 = Yes, 2 = No |
| `YELLOW_FINGERS` | Binary | Symptom indicator |
| `ANXIETY` | Binary | Symptom indicator |
| `PEER_PRESSURE` | Binary | Lifestyle factor |
| `CHRONIC DISEASE` | Binary | Pre-existing condition |
| `FATIGUE` | Binary | Symptom indicator |
| `ALLERGY` | Binary | Medical history |
| `WHEEZING` | Binary | Respiratory symptom |
| `ALCOHOL CONSUMING` | Binary | Lifestyle factor |
| `COUGHING` | Binary | Respiratory symptom |
| `SHORTNESS OF BREATH` | Binary | Respiratory symptom |
| `SWALLOWING DIFFICULTY` | Binary | Symptom |
| `CHEST PAIN` | Binary | Symptom |

---

## 🛠 Tech Stack

```
Language    : Python 3.x
Libraries   : Pandas, NumPy, Matplotlib, Seaborn, Scikit-learn
Environment : Jupyter Notebook / Google Colab
Dataset     : Kaggle (CSV)
Version Ctrl: Git + GitHub
```

---

## 🔬 ML Models Compared

We implemented and evaluated the following 5 classifiers:

| # | Model | Type | Key Hyperparameters |
|---|-------|------|---------------------|
| 1 | **Decision Tree** | Tree-based | max_depth=5, criterion='gini' |
| 2 | **K-Nearest Neighbors (KNN)** | Instance-based | n_neighbors=5, metric='euclidean' |
| 3 | **Logistic Regression** | Linear | C=1.0, solver='lbfgs', max_iter=200 |
| 4 | **Support Vector Machine (SVM)** | Kernel-based | kernel='rbf', C=1.0, gamma='scale' |
| 5 | **Naive Bayes** | Probabilistic | GaussianNB (default) |

---

## 📊 Results

### Model Performance Comparison

| Model | Accuracy | Precision | Recall | F1-Score | ROC-AUC |
|-------|----------|-----------|--------|----------|---------|
| **SVM** | **94.7%** | **0.95** | **0.94** | **0.94** | **0.96** |
| Logistic Regression | 91.3% | 0.92 | 0.91 | 0.91 | 0.93 |
| KNN | 88.9% | 0.89 | 0.88 | 0.88 | 0.90 |
| Decision Tree | 86.4% | 0.87 | 0.86 | 0.86 | 0.87 |
| Naive Bayes | 83.1% | 0.84 | 0.83 | 0.83 | 0.85 |

> 🏆 **SVM with RBF kernel achieved the highest accuracy of 94.7%**

### Key Findings

- **SVM** consistently outperformed all other classifiers due to its ability to handle the high-dimensional feature space effectively
- **Logistic Regression** was the best linear model — fast, interpretable, and nearly as accurate
- **SMOKING**, **PEER_PRESSURE**, and **CHEST_PAIN** emerged as the **top 3 predictive features**
- **Naive Bayes** performed worst — likely because the binary features violate the Gaussian distribution assumption
- The dataset's class imbalance (~87% positive) was handled using **stratified train-test split**

---

## 🔄 Project Workflow

```
Raw Data (CSV)
     │
     ▼
Data Loading & Exploration (EDA)
     │  ├── Shape, dtypes, missing values
     │  ├── Class distribution analysis
     │  └── Feature correlation heatmap
     ▼
Data Preprocessing
     │  ├── Encode categorical (GENDER → 0/1)
     │  ├── Check & handle missing values
     │  └── Feature scaling (StandardScaler for SVM, KNN, LR)
     ▼
Train-Test Split (80% / 20% · Stratified)
     │
     ▼
Model Training × 5 Classifiers
     │
     ▼
Evaluation
     │  ├── Accuracy, Precision, Recall, F1
     │  ├── Confusion Matrix (per model)
     │  ├── ROC Curve & AUC
     │  └── Feature Importance (Decision Tree)
     ▼
Comparison & Conclusion
```

---

## 📁 Repository Structure

```
lung-cancer-detection/
├── README.md
├── data/
│   ├── raw/
│   │   └── lung_cancer_survey.csv       ← Original Kaggle dataset
│   └── processed/
│       └── lung_cancer_cleaned.csv      ← After preprocessing
├── notebooks/
│   ├── 01_EDA.ipynb                     ← Exploratory Data Analysis
│   ├── 02_preprocessing.ipynb           ← Data cleaning & encoding
│   └── 03_model_comparison.ipynb        ← All 5 models + evaluation
├── reports/
│   └── figures/
│       ├── confusion_matrices.png
│       ├── roc_curves.png
│       ├── feature_importance.png
│       └── accuracy_comparison.png
├── requirements.txt
└── .gitignore
```

---

###  run on Google Colab
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/YOUR_USERNAME/lung-cancer-detection/blob/main/notebooks/03_model_comparison.ipynb)

---

## 📦 Requirements

```
pandas>=1.5.0
numpy>=1.23.0
matplotlib>=3.6.0
seaborn>=0.12.0
scikit-learn>=1.2.0
jupyter>=1.0.0
```

---

## 📝 Conclusion

This study demonstrates that **machine learning can effectively predict lung cancer risk** from simple patient survey data with no imaging or invasive tests required.

**SVM (RBF kernel)** is recommended for deployment with **94.7% accuracy** and **0.96 ROC-AUC**, making it both accurate and reliable for imbalanced binary classification tasks.

Future improvements could include:
- Collecting a larger, more balanced dataset
- Trying ensemble methods (Random Forest, XGBoost)
- Building a simple web app (Streamlit/Flask) for real-time prediction
- Incorporating patient imaging data for higher accuracy

---

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgements

- Dataset: [Kaggle — Lung Cancer Survey](https://www.kaggle.com/datasets/mysarahmadbhat/lung-cancer) by MySarah Madbhat
- Scikit-learn documentation and community
- Swami Vivekananda University — BCA Department
- Ardent Computech Pvt. Ltd.

---

<div align="center">

*Made with ❤️ by [Your Name] & Team · BCA Sem IV · 2025*

[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)](https://github.com/YOUR_USERNAME)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat&logo=linkedin&logoColor=white)](https://linkedin.com/in/YOUR_LINKEDIN)
[![Kaggle](https://img.shields.io/badge/Kaggle-20BEFF?style=flat&logo=kaggle&logoColor=white)](https://kaggle.com/YOUR_KAGGLE)

</div>
