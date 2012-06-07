#!/usr/bin/env python
import collections
import sys

def get_col_to_letter_map(filename):
  f = open(filename)
  col_to_letter = {}
  for line in f:
    (idx, letter) = line.split(' ')
    col_to_letter[int(idx)] = letter
  f.close()
  return col_to_letter

def get_dist_matrix(filename):
  return [map(float, line.split(',')) for line in open(filename)]

def predict_letter(clmap, row, dist_matrix):
  neighbors = range(len(clmap))
  neighbors.sort(key=lambda col : dist_matrix[row][col])
  # neighbors contains indices of columns of distance matrix,
  # sorted in increasing order of distance from row (thing we're classifying)

  most_common_neighbor = ''
  most_common_neighbor_freq = 0
  nearest_neighbors = collections.defaultdict(lambda: 0)
  # histogram of the letter of the nearest neighbors

  for col in neighbors[:3]: # look at 3 nearest neighbors
    # TODO: exclude self (at distance 0) from classification?
    nearest_neighbors[clmap[col]] += 1
    if nearest_neighbors[clmap[col]] > most_common_neighbor_freq:
      most_common_neighbor_freq = nearest_neighbors[clmap[col]]
      most_common_neighbor = clmap[col]

  return most_common_neighbor

def test_classifier(clmap, dist_matrix):
  num_correct_predictions = 0
  for i in clmap:
    actual_letter = clmap[i]
    predicted_letter = predict_letter(clmap, i, dist_matrix)
    if predicted_letter == actual_letter:
      num_correct_predictions += 1
    print "Predicted: " + predicted_letter + " | ",
    print "Actual: " + actual_letter
  print "Accuracy: " + str(num_correct_predictions/float(len(clmap)))

clmap = get_col_to_letter_map(sys.argv[1])
dist_matrix = get_dist_matrix(sys.argv[2])
test_classifier(clmap, dist_matrix)
