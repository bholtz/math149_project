#/usr/bin/env python

def get_dist_matrix(filename):
  return [map(float, line.split(',')) for line in open(filename)]

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

def get_letter_to_col_map(clmap):
  lcmap = collections.defaultdict(lambda: [])
  for col in clmap:
    lcmap[clmap[col]].append(col)
  return lcmap


