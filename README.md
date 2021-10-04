# R_DataAnaysis_NikeTwitter_Dataset
I use packages/libraries such as rtweet, dplyr, ggplot2, igraph to analyze data extracted from twitter
## REQUIRED PACKAGES
rtweet igraph dplyr
## BACKGROUND
Nike, Inc. is an American multinational corporation that is engaged in the design, development,
manufacturing, and worldwide marketing and sales of footwear, apparel, equipment, accessories, and
services. The company is headquartered near Beaverton, Oregon, in the Portland metropolitan area. It
is the world's largest supplier of athletic shoes and apparel and a major manufacturer of sports
equipment, with revenue in excess of US$24.1 billion in its fiscal year 2012 (ending May 31, 2012). As
of 2012, it employed more than 44,000 people worldwide. In 2014 the brand alone was valued at $19
billion, making it the most valuable brand among sports businesses. As of 2017, the Nike brand is
valued at $29.6 billion. Nike ranked No. 89 in the 2018 Fortune 500 list of the largest United States
corporations by total revenue.
The company was founded on January 25, 1964, as Blue Ribbon Sports, by Bill Bowerman and Phil
Knight, and officially became Nike, Inc. on May 30, 1971. The company takes its name from Nike, the
Greek goddess of victory. Nike markets its products under its own brand, as well as Nike Golf, Nike
Pro, Nike+, Air Jordan, Nike Blazers, Air Force 1, Nike Dunk, Air Max, Foamposite, Nike
Skateboarding, Nike CR7, and subsidiaries including Brand Jordan, and Converse. Nike also owned
Bauer Hockey (later renamed Nike Bauer) from 1995 to 2008, and previously owned Cole Haan Umbro,
and Hurley International. In addition to manufacturing sportswear and equipment, the company operates
retail stores under the Niketown name. Nike sponsors many high-profile athletes and sports teams
around the world, with the highly recognized trademarks of "Just Do It" and the Swoosh logo.
## QUESTIONS
1. Preload the required packages together with the H_NIKE.csv file
2. Extract user information from the pre-loaded tweets data-frame
3. Aggregate the screen name with the corresponding follower and friend counts
a. Create a column and categorize follower counts above and below 500
4. Compute and store the golden ratio, sort your dataframe in decreasing order of follower count
5. Subset rows where follower counts are:
a. Greater than 4000
b. Less than 2000
6. Extract tweets on #Nike and exclude retweets
7. Create a time series plot with interval set to hours
8. A retweet network is a network of twitter users who retweet tweets posted by others
a. Using the tweet data on #Nike, extract source and target vertices from the tweet data frame
b. Remove rows with missing values and create a matrix
c. Covert the matrix to a retweet network
9. In a retweet network, the outdegree of a user indicates the number of times the user retweets post, the indegree indicates the number of times the user posts are retweeted. Compute the following scores from the retweet network:
a. Outdegree scores in descending order
b. Indegree scores in descending order
c. Betweenness scores in decreasing order
d. View the first ten out-degree, in-degree and betweenness scores
10. Visualization of twitter networks helps understand complex networks in an easier and appealing way. One can format a plot to enhance the readability and improve the visual appeal. Using the retweet network on #Nike:
a. Create a base network plot
b. Create a network plot with vertex color red and vertex size 15
c. Create a variable for the outdegree
i. amplify the values to have a minimum value if 5
ii. set vertex size to amplified out-degree values
d. Assign the column with categorization (refer to 3a) as a vertex attribute to the network
e. Set the vertex colors based on follower count and create a plot
