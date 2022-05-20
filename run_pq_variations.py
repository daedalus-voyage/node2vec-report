
# datasets
import time

import numpy as np
import pandas as pd

from lib.ClassifierResult import ClassifierResult
from lib.DataSet import DataSet
from lib.LogisticRegressionClassifier import LogisticRegressionClassifier
from lib.ProjectGraph import ProjectGraph
from lib.WalkerConfig import WalkerConfig
from lib.Word2VecConfig import Word2VecConfig

hosap_data = DataSet('./data/Homo_sapiens.mat')
pos_data = DataSet('./data/POS.mat')

# which p/q values to explore
p_values = np.append(
    np.arange(0.1, 1.0, 0.1),
    np.arange(1, 11, 1)
)
q_values = p_values.copy()

p_values = np.array([0.5, 2])
q_values = np.array([0.5, 2])

#      p    q  accuracy  f1 (micro)  f1 (macro)
# 0  0.1  0.1  0.964910    0.964910    0.066557
# 1  0.2  0.1  0.965455    0.965455    0.068308
# 2  0.3  0.1  0.965392    0.965392    0.050278
# 3  0.4  0.1  0.965833    0.965833    0.052372
# 4  0.5  0.1  0.965308    0.965308    0.056235

# 10x80
#      p    q  accuracy  f1 (micro)  f1 (macro)
# 0  4.0  1.0  0.966084    0.966084    0.046929

# 15x120
# Elapsed time -->  762.6949992179871
#      p    q  accuracy  f1 (micro)  f1 (macro)
# 0  4.0  1.0   0.96514     0.96514    0.053323


# ######################################################################################################################
# Running P/Q variations
# ######################################################################################################################
# ######################################################################################################################

repeats = 1

# initialize the graph with data
project = ProjectGraph(hosap_data)

r_count = len(q_values) * len(p_values)
results = np.zeros([r_count, 5])
r = 0

for q in q_values:
    for p in p_values:

        aggregated_result = ClassifierResult()
        for i in np.arange(1, repeats+1):

            # create configs
            walker_config = WalkerConfig()
            walker_config.p = p
            walker_config.q = q
            walker_config.n = 120
            walker_config.length = 5

            word2vec_config = Word2VecConfig()
            word2vec_config.size = 128
            word2vec_config.window = 5
            word2vec_config.min_count = 5
            word2vec_config.workers = 6

            start_time = time.time()

            # run the random walker
            print("Walking p=", p, ", q=", q)
            walks = project.generate_walks(walker_config)
            time_to_walk = time.time() - start_time
            print("Elapsed time --> ", time_to_walk)

            # generate embeddings
            print("Running Word2Vec")
            embedding_model = project.create_embeddings(walks, word2vec_config)
            time_to_embed = time.time() - time_to_walk
            print("Elapsed time --> ", time_to_embed)

            # train and test a classifier on the embeddings
            print("Logistic Regression model (train + predict)")
            c = LogisticRegressionClassifier(embedding_model)
            c_result = c.train_and_predict(repeats=1, max_iter=1000)
            time_to_train = time.time() - time_to_embed
            print("Elapsed time --> ", time_to_train)

            aggregated_result = aggregated_result.append(c_result)

        # collect aggregated result into a result table
        results[r, :] = [
            p, q, aggregated_result.accuracy(), aggregated_result.f1_micro(), aggregated_result.f1_macro()
        ]

        # print output
        # clear_output(wait=True)
        results_df = pd.DataFrame(results[:r+1,:], columns=['p', 'q', 'accuracy', 'f1 (micro)', 'f1 (macro)'])
        results_df.to_pickle('./pq_variations_cli.pkl')
        results_df.to_excel('./pq_variations_cli.xlsx')
        print(results_df)

        # increment index for results
        r += 1