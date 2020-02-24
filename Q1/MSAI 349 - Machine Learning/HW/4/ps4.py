import numpy as np


# loading .npy array files
array1 = np.load('pixel_rep.npy')
array2 = np.load('vgg_rep.npy')


# definition of cosine similarity
def cosinesimilarity():
    inner_prod = np.dot(array1, array2)                  # numerator
    norm_vector1 = np.linalg.norm(array1)               # ||A|| in denominator
    norm_vector2 = np.linalg.norm(array2)               # ||B|| in denominator
    return inner_prod / (norm_vector1 * norm_vector2)  # expression
