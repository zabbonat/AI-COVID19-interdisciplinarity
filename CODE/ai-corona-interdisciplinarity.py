#!/usr/bin/env python
# coding: utf-8

# **Libraries**

# In[1]:


import pandas as pd 
import os
from collections import defaultdict
from itertools import product
from itertools import combinations
import networkx as nx
import collections
from tqdm import tqdm
import numpy as np
import matplotlib.pyplot as plt
import ast 


# **Methods**

# In[ ]:


# Create a new list by iterating through each sublist in 'original_list' and appending its elements to 'll'
def flattenList(original_list):
    ll = [element for sublist in original_list for element in sublist]
    return ll


def avDistPmi(clist):
    lista = []
    # Iterate through each edge (u,v) in 'clist'
    for (u, v) in clist:
        try:
            # Append the inverse pointwise mutual information (pmi) of edge (u,v) in graph 'G' to 'lista'
            lista.append(1 - G[u][v]['pmi'])
        except:
            # If edge (u,v) is not in graph 'G', append 1 to 'lista'
            lista.append(1)
    # Return the average of all elements in 'lista'
    return np.mean(lista)


def is_any_ai_element_present(x, words_ai):
    if any(element in x for element in words_ai) :
        return 1
    else:
        return 0 


# # How  to build General team metric, General knowledge metric, Interdisciplinary spread from a random sample (sample_1ok.csv)

# $W_{ij}$ co-citation weighted graph $\rightarrow$ two journal cited togheter based on references 
# 
# Journal similarity calculated as pointwise mutual information $pmi_{ij}$
# 
# $ p_{ij} = \frac{w_{ij}}{\sum_{ij} w_{ij}}$
#     
# $p_{i} = 0.5 \sum_{j} p_{ij}$\hspace{0.2cm} $p_{j} = 0.5 \sum_{i} p_{ij}$
#     
# $pmi_{ij}=\frac{1}{log_{2}p_{ij}}log_{2}\frac{p_{ij}}{p_{i}p_{j}}$
# 
# Journal distance $D$ calculated as 1-journal similarity 
# 

# In[3]:


df = pd.read_csv('sample_1ok.csv')
# Filter DataFrame to include only rows where 'ISSN' is not null, and select '_id' and 'ISSN' columns
dfRed = df[~df['ISSN'].isna()][['_id','ISSN']] 
# Group 'ISSN' values by '_id', convert to set, and reset index to create new DataFrame 'dfList'
dfList = dfRed.groupby('_id')['ISSN'].apply(set).reset_index()
# Create new column 'combinations' in 'dfList' with list of all possible ISSN combinations for each '_id'
dfList['combinations'] = [list(combinations(test_list, 2)) for test_list in dfList['ISSN']]
# Flatten list of lists in 'combinations' column using custom 'flattenList' function and create dictionary 'dEd' with frequency of each combination
allEdges = flattenList(list(dfList['combinations']))
dEd = collections.Counter(allEdges)


# In[12]:


len(dEd)


# In[ ]:


#create empty graph with networkx and add edges from dEd dict with all combinations
G = nx.Graph()
G.add_edges_from(dEd.keys())


# In[16]:


# Iterate through all edges (u,v) in a graph 'G'
for (u, v) in G.edges():
    # Set the weight of edge (u,v) in 'G' to the maximum frequency of either (u,v) or (v,u) in dictionary 'dEd'
    G[u][v]['weight'] = max(dEd[(u, v)], dEd[(v, u)])


# In[17]:


# Calculate the total weight of all edges in the graph G
totW = sum([G[u][v]['weight'] for (u, v) in G.edges()])

# Iterate through all edges (u,v) in G
for (u, v) in G.edges():
    # Set the 'wNorm' attribute of edge (u,v) in G to its weight divided by the total weight of all edges in G
    G[u][v]['wNorm'] = G[u][v]['weight'] / totW


# $p_{ij}=\frac{w_{ij}}{\sum_{ij}w_{ij}}$

# $p_i=0.5\sum_jp_{ij} \quad p_j=0.5\sum_ip_{ij}$

# $pmi_{ij}=\frac{1}{log_2 p_{ij}} log_2(\frac{p_{ij}}{p_ip_j})$

# In[18]:


pk = dict(G.degree(weight='wNorm'))
for i in pk.keys():
    pk[i]=0.5*pk[i]


# In[19]:


for (u,v) in G.edges():
    pmi = -(np.log2(G[u][v]['wNorm']/(pk[u]*pk[v])))/(np.log2(G[u][v]['wNorm']))
    if pmi > 0:
        G[u][v]['pmi'] = pmi
    else:
        G[u][v]['pmi'] = 0


# In[20]:


totW = sum([G[u][v]['weight'] for (u,v) in G.edges()])
for (u,v) in G.edges():
    G[u][v]['wNorm'] = G[u][v]['weight']/totW

pk = dict(G.degree(weight='wNorm'))
for i in pk.keys():
    pk[i]=0.5*pk[i]

for (u,v) in G.edges():
    pmi = -(np.log2(G[u][v]['wNorm']/(pk[u]*pk[v])))/(np.log2(G[u][v]['wNorm']))
    if pmi>0:
        G[u][v]['pmi'] = pmi
    else:
        G[u][v]['pmi'] = 0


# In[23]:


#save it to be use 
nx.write_gexf(G,'journal_similarity_matrix_per_SAMPLE.gexf')


# **mutual entropy**

# **calculate it on reference for example**  $\rightarrow$ **General knowledge metric**

# In[32]:


dfList = pd.read_csv('kn_interdisc_score_reference.csv')
dfList['combinations'] = dfList['combinations'].progress_apply(lambda x : ast.literal_eval(x))
dfList['pmi_distance_sample'] = dfList['combinations'].progress_apply(lambda x:avDistPmi(x))
dfList['pmi_distance_sample'].plot.hist(bins=20,ec='k',fc='orange')


# # How to calculate AI team metric and AI knowledge metric

# In[3]:


words_ai = ['artificial intelligence','deep learning','machine learning',
          'convolutional neural','computer vision','convolutional', 
          'neural network','natural language',
          'neural networks',
          'neural networking',
          'image recognition', 'semantic analysis','unsupervised learning','supervised learning',
          'recurrent neural',
          'sentiment analysis',
          'reinforcement learning','statistical learning','adversarial neural',
          'text mining','nlp','pattern recognition',
          'object detection','image detection','ai applications','ai application','data mining',
          'keras','tensorflow','meta learning','trajectory forecasting','trasnfer learning',
          'machine translation','data science','object detection','intelligent machine',
          'semi supervised learning','speech recognition','backpropagation','semantic search',
          'Abductive logic programming',  'Abductive reasoning',  'Abstract data type',
          'Action language','Action model learning', 'Action selection', 'Activation function', 
          'Adaptive algorithm', 'Adaptiveneuro fuzzy inference system',  'Admissible heuristic',  
          'Affective computing',  'Agent architecture','AI accelerator ', 'AI complete', 'AlphaGo',
          'Ambient intelligence','Answer set programming', 'Anytime algorithm', 
          'Application programming interface', 'Approximate string matching', 
          'Approximation error', 'Argumentation framework', 'Artificial general intelligence', 
          'Artificial immune system', 'AIML', 'Artificial neural network', 
          'Association for the Advancement of Artificial Intelligence', 'Asymptotic computational complexity', 
          'Attributional calculus', 'Augmented reality',  
          'Automata theory',  'Automated planning and scheduling',  
          'Automated reasoning',  'Autonomic computing', 'Autonomous car', 
          'Autonomous robot', 'Backpropagation', 'Backpropagation through time', 
          'Backward chaining', 'Bag of words model', 
          'Bag of words model in computer vision','Batch normalization',
          'Bayesian programming', 'Bees algorithm', 'Behavior informatics', 
          'Behavior tree',  'Belief desire intention software model',  
          'Bias-variance tradeoff',  'Big data',  'Big O notation', 
          'Binary tree', 'Blackboard system', 'Boltzmann machine', 
          'Boolean satisfiability problem','Brain technology', 
          'Branching factor', 'Brute-force search', 'Capsule neural network', 
          'Case basedreasoning', 'Chatbot', 'Cloud robotics', 'Cluster analysis', 
          'Cobweb', 'Cognitive architecture', 'Cognitive computing', 
          'Cognitive science', 'Combinatorial optimization', 'Committee machine', 
          'Commonsense knowledge', 'Commonsense reasoning', 'Computational chemistry', 
          'Computational complexity theory', 'Computational creativity', 'Computational cybernetics', 
          'Computational humor','Computational intelligence', 'Computational learning theory', 
          'Computational linguistics', 'Computational mathematics',  'Computational neuroscience', 
          'Computational number theory',  'Computational problem', 'Computational statistics',
          'Computer automated design', 'Machine listening','Computer vision', 'Concept drift',
          'Connectionism', 'Consistent heuristic', 'Constrained conditional model',
          'Constraint logic programming', 'Constraint programming', 'Constructed language', 
          'Control theory', 'Convolutional neural network', 'Darkforest', 'Dartmouth workshop', 
          'Data augmentation', 'Data fusion', 'Data integration', 'Data mining', 'Data science', 
          'Datalog', 'Decision boundary','Decision support system',  'Decision theory',  
          'Decision tree learning',  'Declarative programming','Deductive classifier', 'Deep Blue', 
          'Deep learning', 'DeepMind Technologies', 'Default logic', 'Description logic', 
          'Developmental robotics', 'Dialogue system', 'Dimensionality reduction', 'Discrete system', 
          'Distributed artificial intelligence', 'Dynamic epistemic logic', 'Eager learning',
          'Ebert test','Echo state network', 'Embodied agent', 'Embodied cognitive science', 
          'Error driven learning', 'Ensemble averaging ', 'Ethics of artificial intelligence', 
          'Evolutionary algorithm', 'Evolutionary computation',  'Evolving classification function', 
          'Existential risk from artificial general intelligence','Expert system', 
          'Fast and frugal trees', 'Feature extraction', 'Feature learning', 'Feature selection',
          'Federated learning', 'First order logic', 'Forward chaining', 'Friendly artificial intelligence', 
          'Fuzzy control system', 'Fuzzy logic', 'Fuzzy rule', 'Fuzzy set', 'General game playing',
          'Generative adversarial network', 'Genetic algorithm', 'Genetic operator', 
          'Glowworm swarm optimization', 'Graph database', 'Graph theory', 'Graph traversal', 
          'Halting problem', 'Hyper heuristic', 'IEEE Computational Intelligence Society', 
          'Incremental learning',  'Inference engine',  'Information integration',
          'Information Processing Language', 'Intelligence amplification', 'Intelligence explosion', 
          'Intelligent agent',  'Intelligent control',  'Intelligent personal assistant', 
          'Issue tree',  'Junction tree algorithm','Kernel method', 'KL ONE', 'Knowledge acquisition', 
          'Knowledge-based system', 'Knowledge engineering', 'Knowledge extraction',
          'Knowledge Interchange Format', 'Knowledge representation andreasoning', 
          'Lazy learning', 'Lisp', 'Logic programming', 'Long short term memory', 
          'Machine vision', 'Markov chain', 'Markov decision process', 
          'Mathematical optimization', 'Machine learning','Machine listening',
          'Machine perception', 'Mechanism design', 'Mechatronics', 
          'Metabolic network reconstruction and simulation',
          'Metaheuristic', 'Model checking', 'Modus ponens', 'Modus tollens','Monte Carlo tree search', 
          'Multi agent system', 'Multi swarm optimization', 'Mycin', 'Naive Bayes classifier',
          'Naive semantics', 'Name binding', 'Named entity recognition', 'Named graph', 
          'Natural language generation', 'Natural language processing', 'Natural language programming', 
          'Network motif', 'Neural machine translation', 'Neural Turing machine', 'Neuro fuzzy', 
          'Neurocybernetics', 'Neuromorphic engineering', 'Nondeterministic algorithm',  
          'Nouvelle AI',  'NP completeness','NP hardness', 'Occam s razor', 'Offline learning',
          'Online machine learning', 'Ontology learning','OpenAI', 'OpenCog', 'Open Mind Common Sense', 
          'Partial order reduction', 'Partially observable Markov decision process', 
          'Particle swarm optimization', 'Pathfinding', 'Pattern recognition', 'Predicate logic', 
          'Predictive analytics', 'Principal component analysis', 'Principle of rationality', 
          'Probabilistic programming', 'Prolog', 'Propositional calculus', 'Qualification problem',
          'Quantum computing', 'Query language', 'Radial basis function network', 'Random forest', 
          'Reasoning system', 'Recurrent neural network', 'Region connection calculus', 
          'Reinforcement learning', 'Reservoir computing','Resource Description Framework', 
          'Restricted Boltzmann machine', 'Rete algorithm', 'Robot', 'Robotics','Rule-based system', 
          'Satisfiability', 'Search algorithm', 'Self-management', 'Semantic network', 
          'Semantic reasoner', 'Semantic query' 'Sensor fusion', 'Separation logic', 
          'Similarity learning', 'Simulated annealing', 'situated approach',
          'Situation calculus', 'SLD resolution','Software',  'Software engineering', 
          'Spatial-temporal reasoning',  'SPARQL',  'Speech recognition',
          'Spiking neural network', 'Statistical classification', 'Statistical relational learning',
          'Stochastic optimization', 'Stochastic semantic analysis', 
          'Stanford Research Institute Problem Solver', 
          'Subject matter expert', 'Superintelligence',
          'Supervised learning', 'Support vector machine', 'Support vector machine',  
          'Swarm intelligence',  'Symbolic artificial intelligence',  
          'Synthetic intelligence',  'Systemsneuroscience', 'Technological singularity', 
          'Temporal difference learning', 'Tensor network theory','TensorFlow', 
          'Theoretical computer science', 'Theory of computation', 'Thompson sampling',
          'Time complexity', 'Transhumanism', 'Transition system', 'Tree traversal', 
          'True quantified Boolean formula', 'Turing machine', 'Turing test',
          'Type system', 'Unsupervised learning', 'Vision processing unit', 
          'Watson', 'Weak AI', 'hidden unit', 'hidden layer']
          
words_ai = list(set(map(lambda x:x.lower(),words_ai))) #lower and unique 


# In[6]:


df_reference = pd.read_csv('df_reference.csv')


# In[ ]:


#calculate the intensity score (0,1) for AI refererence based on their abstract 
df_reference['ai_reference']  = df_reference['abstract'].apply(lambda x : sum([is_any_ai_element_present(x,words_ai) for x in x])/len(x))

