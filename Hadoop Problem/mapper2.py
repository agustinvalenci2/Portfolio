#mapper2

import sys

# Initialize variables to keep track of document IDs and ratings
current_doc_id = None
current_rating = None

# Process input from stdin
for line in sys.stdin:
    doc_id, word, tfidf = line.strip().split('\t')

    # If the document ID changes, output the previous document's rating
    if doc_id != current_doc_id:
        if current_doc_id is not None:
            print(f"{current_doc_id}\t{current_rating}")

        # Update current document ID and rating
        current_doc_id = doc_id
        current_rating = None

    # If the word is "__rating", it means this line contains the rating
    if word == "__rating":
        current_rating = float(tfidf)

# Output the rating for the last document
if current_doc_id is not None:
    print(f"{current_doc_id}\t{current_rating}")
