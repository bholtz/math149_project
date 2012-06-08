#!/usr/bin/env python
import collections
import sys

def get_col_to_letter_map(filename):
  f = open(filename)
  col_list = map(int, f.read().strip('[]\n').split(','))
  f.close()

  col_to_letter = {}
  curr_col = 0
  curr_letter = 'A'
  for count in col_list:
    for i in range(count):
      col_to_letter[curr_col] = curr_letter
      curr_col = curr_col + 1
    curr_letter = 'a' if curr_letter == 'Z' \
                        else chr(ord(curr_letter) + 1)

  return col_to_letter

def get_dist_matrix(filename):
  return [map(float, line.split(',')) for line in open(filename)]

# clmap : row number |-> corresponding letter
def predict_letter(clmap, row, dist_matrix):
  neighbors = range(len(clmap))
  neighbors.sort(key=lambda col : dist_matrix[row][col])
  # neighbors contains indices of columns of distance matrix,
  # sorted in increasing order of distance from row (thing we're classifying)

  most_common_neighbor = ''
  most_common_neighbor_freq = 0
  nearest_neighbors = collections.defaultdict(lambda: 0)
  # histogram of the letter of the nearest neighbors

  for col in neighbors[1:3]: # look at 2 nearest neighbors (excludes self)
    nearest_neighbors[clmap[col]] += 1
    if nearest_neighbors[clmap[col]] > most_common_neighbor_freq:
      most_common_neighbor_freq = nearest_neighbors[clmap[col]]
      most_common_neighbor = clmap[col]

  return most_common_neighbor

def test_classifier(clmap, dist_matrix):
  letter_counts = collections.defaultdict(lambda: 0)
  for i in clmap:
    letter_counts[clmap[i]] += 1

  num_correct = collections.defaultdict(lambda: 0)
  num_correct_nocase = collections.defaultdict(lambda: 0)

  total_tested = 0
  total_correct_predictions = 0
  total_correct_nocase = 0
  for i in clmap:
    actual_letter = clmap[i]
    if letter_counts[actual_letter] < 3:
      continue

    total_tested += 1
    predicted_letter = predict_letter(clmap, i, dist_matrix)
    if predicted_letter == actual_letter:
      num_correct[actual_letter] += 1
      total_correct_predictions += 1
    if predicted_letter.lower() == actual_letter.lower():
      num_correct_nocase[actual_letter] += 1
      total_correct_nocase += 1

    print "Predicted: " + predicted_letter + " | ",
    print "Actual: " + actual_letter

  print ''

  for ch in letter_counts:
    if letter_counts[ch] < 3:
      continue

    print "Letter: " + ch,
    print " | Accuracy: " + str(float(num_correct[ch]) / letter_counts[ch]),
    print " | Accuracy (case insensitive): " + str(float(num_correct_nocase[ch]) / letter_counts[ch]),
    print " | Count: " + str(letter_counts[ch])

  print ''

  print "Overall accuracy: " + str(total_correct_predictions/float(total_tested))
  print "Overall accuracy (case insensitive): " + str(total_correct_nocase/float(total_tested))

clmap = get_col_to_letter_map(sys.argv[1])
dist_matrix = get_dist_matrix(sys.argv[2])
test_classifier(clmap, dist_matrix)
