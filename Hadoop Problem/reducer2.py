#reducer2

import sys

# Initialize variables to store TF-IDF vectors and ratings
current_doc_id = None
tfidf_vector = []
current_rating = None

# Process input from stdin
for line in sys.stdin:
    doc_id, rating = line.strip().split('\t')

    # If the document ID changes, output the TF-IDF vector and rating for the previous document
    if doc_id != current_doc_id:
        if current_doc_id is not None:
            # Output the TF-IDF vector and rating for the previous document
            print(f"{current_doc_id}\t{' '.join(map(str, tfidf_vector))}\t{current_rating}")

        # Reset variables for the new document
        current_doc_id = doc_id
        tfidf_vector = []
        current_rating = None

    # If the word is not "__rating", it means this line contains a TF-IDF value
    else:
        tfidf_vector.append(float(rating))

# Output the TF-IDF vector and rating for the last document
if current_doc_id is not None:
    print(f"{current_doc_id}\t{' '.join(map(str, tfidf_vector))}\t{current_rating}")
