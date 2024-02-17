# mapper.py

import sys
import re
from sklearn.feature_extraction.text import TfidfVectorizer

# Load the stopwords list if needed
# stopwords = set(open('stopwords.txt').read().strip().split())

def extract_ratings(filename):
    # Parse the filename to extract ratings
    return int(re.search(r'\d+', filename).group())

def mapper():
    for line in sys.stdin:
        # Split the line into filename and review text
        filename, review = line.strip().split('\t', 1)

        # Extract ratings from the filename
        rating = extract_ratings(filename)

        # Output the filename, rating, and review text
        print(f'{filename}\t{rating}\t{review}')

if __name__ == "__main__":
    mapper()
