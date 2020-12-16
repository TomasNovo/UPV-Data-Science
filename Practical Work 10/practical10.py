import recommendations as recommendations

# LOAD DATA
critics = recommendations.critics

##############
# Exercise 1 #
##############
def compare_recommendations_distances(d1, d2):
    if d1 > d2:
        return "Gene Seymour"
    else:
        return "Toby"

distance1 = recommendations.sim_distance(critics, 'Lisa Rose', 'Gene Seymour')
distance2 = recommendations.sim_distance(critics, 'Lisa Rose', 'Toby')

print("Distance:")
print("More similar to Lisa Rose: " + compare_recommendations_distances(distance1, distance2))
print(distance1, distance2)
print("\n")

distance_pearson1 = recommendations.sim_pearson(critics, 'Lisa Rose', 'Gene Seymour')
distance_pearson2 = recommendations.sim_pearson(critics, 'Lisa Rose', 'Toby')

print("Pearson:")
print("More similar to Lisa Rose: " + compare_recommendations_distances(distance_pearson1, distance_pearson2))
print(distance_pearson1, distance_pearson2)
print("\n")

print("Toby's best 3 matches:")
best_Toby_3_matches = recommendations.topMatches(critics, 'Toby', n=3)
print(best_Toby_3_matches)

recommendation_pearson = recommendations.getRecommendations(critics, 'Toby')
recommendation_euclidean = recommendations.getRecommendations(critics, 'Toby', similarity=recommendations.sim_distance)

print("Pearson Recommendation:")
print(recommendation_pearson)
print("Euclidean Recommendation:")
print(recommendation_euclidean)

print("The recommendations are given in the same order by both similarity functions\n")

##############
# Exercise 2 #
##############
similars = recommendations.calculateSimilarItems(critics, n=10)

print("All similar movies:")
print(similars)
print('\n')
print("Similar 'Lady in the Water' movies:")
print(similars['Lady in the Water'])
print('\n')

recommended_Toby_items = recommendations.getRecommendedItems(critics, similars,'Toby') 
print(recommended_Toby_items)
print("The orders are different in the recommendations but the items are the same\n")

##############
# Exercise 3 #
##############

data = recommendations.loadMovieLens()
print("User 87 ratings:")
print(data['87'])
print('\n')

best_30_recommendations = recommendations.getRecommendations(data, '87')[:30]
print("30 best collaborative-filter recommendations: ")
print(best_30_recommendations)
print('\n')



closest_50_items = recommendations.calculateSimilarItems(data, n=50)
best_30_recommendations_items = recommendations.getRecommendedItems(data, closest_50_items,'87')[:30]
print("30 best content-based-filter recommendations using the 50 closest items each: ")
print(best_30_recommendations_items)
print('\nComparations between both kinds of recommendations:')
print('- Different outputs')
print('- Content-based-filtering -> content of both user and item ')
print('- Collaborative-filtering -> users behaviour and preferences are used for recommendations')