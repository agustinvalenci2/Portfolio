# reducer.py

import sys
from sklearn.feature_extraction.text import TfidfVectorizer
def reducer():
    current_filename = None
    reviews = []

    for line in sys.stdin:
        # Split the line into filename, rating, and review text
        filename, rating, review = line.strip().split('\t', 2)

        # Check if the filename has changed
        if current_filename != filename:
            if current_filename is not None:
                # Process reviews for the previous filename
                process_reviews(current_filename, reviews)

            # Reset for the new filename
            current_filename = filename
            reviews = []

        # Append the current review to the list
        reviews.append((int(rating), review))

    # Process the last set of reviews
    if current_filename is not None:
        process_reviews(current_filename, reviews)

def process_reviews(filename, reviews):
    # Implement TF-IDF extraction for the reviews
    # Use TfidfVectorizer from scikit-learn for simplicity
    vectorizer = TfidfVectorizer(stop_words='english')
    reviews_text = [review[1] for review in reviews]
    tfidf_matrix = vectorizer.fit_transform(reviews_text)

    # Output the TF-IDF matrix
    for i in range(len(reviews)):
        rating, _ = reviews[i]
        tfidf_values = tfidf_matrix[i].toarray()[0]
        tfidf_str = ' '.join(map(str, tfidf_values))
        print(f'{filename}\t{rating}\t{tfidf_str}')

if __name__ == "__main__":
    reducer()
