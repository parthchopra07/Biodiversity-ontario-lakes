# Biodiversity in Ontario Lakes: Data Analysis Project

**Created by:** Parth Chopra  
**Created on:** 05/04/24  
**Last Revised:** 07/04/24

---

##  Overview

This project investigates various ecological variables impacting biodiversity in lakes across Ontario, using statistical and graphical analysis methods in R. The focus is on understanding relationships between phosphorus levels, ecozones, fishery types, and species count.

---

##  Dataset

**File used:** `lakes2024.csv`  
The dataset includes ecological metrics from multiple lakes in Ontario, including:
- **Phosphorus levels (Phos)**
- **Ecozone classification**
- **Fishery type**
- **Species count (Species)**  
...along with other related environmental variables.

---

##  Main Objectives

### **Q1: Ecozone vs. Phosphorus Levels**
- Test for normality of phosphorus distribution per ecozone
- Normalize phosphorus data
- Visualize distribution using histograms and boxplots
- Run a Welch t-test to compare means

### **Q2: Fishery vs. Phosphorus Levels**
- Perform ANOVA and post-hoc Tukey tests
- Visualize results using bar graphs with confidence intervals and boxplots
- Assess homogeneity of variances using Levene's Test

### **Q3: Phosphorus vs. Species Count**
- Perform correlation analysis
- Linear regression modeling
- Visualization with scatter plots and regression line

---

##  R Packages Used

- `ggplot2`: Data visualization
- `pastecs`: Descriptive statistics
- `car`: Levene’s Test
- `MASS`: Statistical functions
- `bestNormalize`: Data transformation
- `psych`: Summary statistics
- `tidyr`: Data wrangling

---

##  Project Structure

| File | Description |
|------|-------------|
| `lakes2024.csv` | Primary dataset |
| `1.pdf` | Histogram of normalized phosphorus by ecozone |
| `2.pdf` | Boxplot of normalized phosphorus by ecozone |
| `3.pdf` | Bar graph (ANOVA results by fishery) |
| `4.pdf` | Boxplot of phosphorus by fishery |
| `5.pdf` | Scatter plot of phosphorus vs. species |

---

##  Key Findings

- Normalized phosphorus levels vary significantly by **ecozone** and **fishery type**.
- ANOVA suggests significant differences in phosphorus means across fishery categories.
- No strong correlation between phosphorus levels and species count based on Pearson’s test.
- Regression shows the intercept is significant, but the slope is not.

---

##  Sample Calculation

Prediction formula (for species estimate based on phosphate level of 18.2):

```
Prediction = 0 * 18.2 + 11.968 = 11.968 species (approx.)
```

---

##  Author Note

This project was completed as part of the final lab assignment in the **Biostatistics** course (Semester 6, Nipissing University). It reflects core statistical concepts such as normalization, ANOVA, correlation, and regression in an ecological context.
