#  Book Recommendation System using Content-Based Filtering

A machine learning project that recommends books similar to a given title using **Content-Based Filtering** with **Cosine Similarity** — powered by NLP techniques like stemming and bag-of-words vectorization.

---

##  Overview

With millions of books available, finding your next great read can be overwhelming. This project builds a content-based recommendation engine that analyzes the description, category, and author of a book to find and suggest the **5 most similar books** — no user history or ratings needed.

---

## 📂 Dataset

**File:** `data.csv`

A books dataset containing metadata about books sourced from Google Books / Kaggle.

| Column | Description |
|---|---|
| `isbn13` | Unique book identifier |
| `title` | Title of the book |
| `authors` | Author(s) of the book |
| `categories` | Genre / category of the book |
| `description` | Short description / summary of the book |
| `average_rating` | Average reader rating *(used for reference, dropped in processing)* |

> **Kept columns for modeling:** `isbn13`, `title`, `authors`, `categories`, `description`

---

##  Tech Stack

- **Language:** Python 3
- **Libraries:**
  - `numpy` — numerical operations
  - `pandas` — data loading and preprocessing
  - `scikit-learn` — vectorization and cosine similarity
  - `nltk` — natural language processing (Porter Stemmer)

---

##  Project Workflow

### 1. Data Loading
Loads `data.csv` and inspects structure, column types, and data shape.

### 2. Data Preprocessing
- Removes duplicate books (by `title`)
- Keeps only relevant columns: `isbn13`, `title`, `authors`, `categories`, `description`
- Drops rows with null values
- Resets the index after cleaning

### 3. Tag Engineering
- Removes spaces within author names and category names (prevents vectorizer from splitting them)
- Combines `categories`, `description`, and `authors` into a single **`tags`** column:
  ```
  tags = categories + "." + description + authors
  ```
- Drops the original `categories`, `description`, and `authors` columns

### 4. Text Stemming
- Applies **Porter Stemmer** (from NLTK) to the `tags` column
- Reduces words to their root form (e.g., *"running"* → *"run"*) to improve matching accuracy

### 5. Vectorization
- Uses **CountVectorizer** with:
  - `max_features=1000` — top 1000 most frequent words
  - `stop_words='english'` — removes common words like "the", "is", "and"
- Converts the `tags` column into a **bag-of-words matrix**

### 6. Cosine Similarity
- Computes a **cosine similarity matrix** across all books
- Books with higher cosine similarity scores share more overlapping tags — meaning similar genre, description, and author style

### 7. Recommendation
- Takes a book title as input
- Finds its index in the dataset
- Sorts all books by cosine similarity score (descending)
- Returns the **top 5 most similar books** (excluding itself)

### 8. Export Cleaned Data
- Saves the cleaned and processed DataFrame to `cleaned_data.csv` for reuse

---

##  How Cosine Similarity Works

Each book is represented as a vector of word frequencies. The cosine similarity between two books measures the **angle between their vectors** — the smaller the angle, the more similar the books.

```
Cosine Similarity = (A · B) / (||A|| × ||B||)

Range: 0 (completely different) → 1 (identical)
```

---

##  How to Run

1. **Clone the repository**
   ```bash
   git clone https://github.com/rahaman-masiur/Machine-Learning.git
   cd Machine-Learning
   ```

2. **Install dependencies**
   ```bash
   pip install numpy pandas scikit-learn nltk
   ```

3. **Download NLTK data** (only once)
   ```python
   import nltk
   nltk.download('punkt')
   ```

4. **Place the dataset** `data.csv` in the same directory as the notebook.

5. **Run the notebook**
   ```bash
   jupyter notebook Book_Recommendation.ipynb
   ```

6. **Enter a book title** when prompted to get 5 similar recommendations.

---

##  Sample Output

```
Enter name of a book: Harry Potter and the Sorcerer's Stone

Recommended Books:
1. Harry Potter and the Chamber of Secrets
2. Harry Potter and the Prisoner of Azkaban
3. The Magicians
4. Percy Jackson & the Olympians: The Lightning Thief
5. The Name of the Wind
```

---

##  Project Structure

```
Book_Recommendation/
│
├── Book_Recommendation.ipynb   # Main Jupyter Notebook
├── data.csv                    # Raw dataset
├── cleaned_data.csv            # Cleaned & processed dataset (generated)
└── README.md                   # Project documentation
```

---

##  Why Content-Based Filtering?

| Approach | Needs User History | Needs Ratings | Works for New Users |
|---|---|---|---|
| **Content-Based (this project)** | ❌ No | ❌ No | ✅ Yes |
| Collaborative Filtering | ✅ Yes | ✅ Yes | ❌ No |

Content-based filtering recommends books based purely on **what a book is about** — not who read it. This makes it ideal for cold-start scenarios where no user data is available.

---

##  Author

**Masiur Rahaman**
BCA 3rd Year | Swami Vivekananda University
[LinkedIn](https://linkedin.com/in/masiur-rahaman-734552387)

---

## 📄 License

This project is intended for academic and educational purposes.
