# Test program for singularity container

import numpy as np

if __name__ == '__main__':
    mat1 = np.array(range(4)).reshape((2,2))
    mat2 = np.ones((2,2))
    out = mat1 + mat2

    print("Output: {}".format(out))