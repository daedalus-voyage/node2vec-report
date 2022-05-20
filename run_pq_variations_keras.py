
# datasets
import time

import numpy as np
import pandas as pd

from lib.ClassifierResult import ClassifierResult
from lib.DataSet import DataSet
from lib.LogisticRegressionClassifier import LogisticRegressionClassifier
from lib.ProjectGraph import ProjectGraph, init_stellar_graph
from lib.WalkerConfig import WalkerConfig
from lib.Word2VecConfig import Word2VecConfig

hosap_data = DataSet('./data/Homo_sapiens.mat')
pos_data = DataSet('./data/POS.mat')

# which p/q values to explore
# p_values = np.append(
#     np.arange(0.1, 1.0, 0.1),
#     np.arange(1, 11, 1)
# )
# q_values = p_values.copy()
p_values = np.array([0.5, 2])
q_values = np.array([0.5, 2])

graph = init_stellar_graph(hosap_data)