# PS2-CHEME-5820-SP25
Repository for Problem Set 2 for CHEME 5820 Spring 2026

## 📚 Problem Set Overview

This problem set focuses on building and evaluating linear classifiers for a clinical dataset, specifically predicting heart-failure mortality based on routine risk factors. You will:
- Preprocess and visualize patient data using PCA
- Train and compare Perceptron and Logistic Regression classifiers
- Evaluate model performance using confusion matrices
- Analyze which clinical features best predict patient survival

**Time Estimate:** 3-5 hours

## 🎯 Learning Objectives

By completing this problem set, you will be able to:
- Preprocess clinical data for classification (binary recoding, z-score normalization)
- Use PCA to visualize high-dimensional data
- Train, evaluate, and compare linear classifiers
- Interpret confusion matrix metrics (accuracy, precision, recall)
- Make informed model deployment decisions based on real-world constraints

## 🚀 Getting Started

### Prerequisites
- **Julia 1.8+** (recommended: 1.9 or later)
- **Jupyter Notebook** or **JupyterLab**
- Basic knowledge of linear algebra, probability, and Julia programming

### Quick Start

1. **Clone and open:**
   ```bash
   git clone https://github.com/varnerlab/PS2-CHEME-5820-SP25.git
   cd PS2-CHEME-5820-SP25
   jupyter notebook PS2-CHEME-5820-Solution-S26.ipynb
   ```

2. **Run setup:**
   - Execute the first code cell (`include("Include.jl")`)
   - Packages will auto-install (may take 5-10 minutes first time)
   - Dataset loads from VLDataScienceMachineLearningPackage

3. **Work through tasks:**
   - Follow the table of contents in the notebook
   - Use checkpoint boxes (✅) to verify your progress
   - Complete discussion questions at the end

## 📊 Dataset

**Source:** [Chicco & Jurman (2020)](https://pubmed.ncbi.nlm.nih.gov/32013925/) - Heart failure clinical records

**Details:**
- 299 patients with heart failure
- 12 clinical features (age, creatinine, ejection fraction, etc.)
- Binary outcome: death_event (1 = died, 0 = survived)
- ~32% mortality rate

## 📝 Tasks

1. **PCA Visualization** - Reduce 12D → 2D and assess class separability
2. **Perceptron Classifier** - Train using online learning algorithm
3. **Logistic Regression** - Optimize using gradient descent
4. **Discussion** - Compare models, analyze hyperparameters, feature importance

## 💡 Tips for Success

- **Read checkpoints** (✅) to verify outputs at each stage
- **Run cells in order** - dependencies build sequentially  
- **Experiment boldly** - Try different hyperparameters in discussion questions
- **Check tests** - Final cell validates your key results

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| Package errors | Delete `Manifest.toml`, restart Julia, re-run `Include.jl` |
| Plots missing | Verify Plots.jl installed: `using Pkg; Pkg.add("Plots")` |
| Tests fail | Check cell outputs - tests show expected vs actual values |

## 📚 Resources

- [VLDataScienceMachineLearningPackage.jl Docs](https://varnerlab.github.io/VLDataScienceMachineLearningPackage.jl/)
- [Julia Documentation](https://docs.julialang.org/)
- [PCA Tutorial](https://en.wikipedia.org/wiki/Principal_component_analysis)

---

**Good luck! 🚀 Machine learning is iterative - experiment, analyze, and learn!**