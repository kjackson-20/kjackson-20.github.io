#!/usr/bin/env python
# coding: utf-8

# In[11]:


import matplotlib.pyplot as plt
import numpy as np

# creating list and dictionary for the games we analyzed and the points each one scored in our rubrics
games = ['League of Legends', 'DOTA 2', 'Apex Legends', 'Valorant', 'CSGO', 'Rocket League', 'Fortnite', 'FIFA', 'Mortal Kombat 1', 'PUBG Mobile', 'Smash Ultimate', 'Brawl Stars', 'Tetris (NES)', 'Street Fighter 6', 'Tekken 8']
category_points = {
    'League of Legends': [3, 0, 4, 3],
    'DOTA 2': [3, 0, 2, 2],
    'Apex Legends': [4, 2, 5, 4],
    'Valorant': [2, 0, 3, 2],
    'CSGO': [1, 0, 2, 2],
    'Rocket League': [4, 3, 3, 3],
    'Fortnite': [5, 3, 5, 4],
    'FIFA': [4, 3, 3, 3],
    'Mortal Kombat 1': [4, 2, 2, 3],
    'PUBG Mobile': [2, 2, 3, 2],
    'Smash Ultimate': [3, 1, 1, 3],
    'Brawl Stars': [2, 1, 0, 2],
    'Tetris (NES)': [0, 0, 0, 0],
    'Street Fighter 6': [5, 3, 1, 4],
    'Tekken 8': [5, 3, 0, 3]
}

categories = ['Input Customization and Controller Support', 'Responsiveness and Feedback', 'Sensitivity', 'Quality']


bar_width = 0.2
x = np.arange(len(games))
fig, ax = plt.subplots(figsize=(12, 6))

# for loop to plot each category's scores for each game
for i, cat in enumerate(categories):
    scores = [category_points[game][i] for game in games]
    ax.bar(x + i * bar_width, scores, bar_width, label=cat)

# adding labels and title for the graph
ax.set_xlabel('Games')
ax.set_ylabel('Points')
ax.set_title('Rubric Scores for Analyzed Games')
ax.set_xticks(x + bar_width * (len(categories) - 1) / 2)
ax.set_xticklabels(games, rotation=45, ha='right')
ax.legend(loc='center left', bbox_to_anchor=(1, 0.5))

plt.tight_layout()
plt.show()


# In[ ]:




