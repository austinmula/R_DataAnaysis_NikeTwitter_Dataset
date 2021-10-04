#navigate to csv file
setwd("C:/Users/25470/Desktop/Coding/Rstudio") # set working directory folder
H_NIKE <- read.csv("C:/Users/25470/Desktop/Coding/Rstudio/H_NIKE.csv")

library(rtweet)
library(dplyr)

#Extract user information
user_info <- users_data(H_NIKE)
head(user_info)
names(user_info) #view column names of the extracted user info

#aggregate screen_name, followers_count, and friends count
followAndfriend_count <- user_info %>%
  group_by(screen_name)%>%
  summarize(follower = mean(followers_count),
            friend = mean(friends_count))

followers <- followAndfriend_count
head(followAndfriend_count, 10) # view aggregated screen_name, followers_count, and friends count

#create new column and categorize followers count as above or less than 500
followAndfriend_count$followersGreater <- ifelse(followAndfriend_count$follower > 500, "1", "0")
head(followAndfriend_count, 10)

#calculate the golden ratio and add a new column "ratio"
followAndfriend_count$ratio <- followAndfriend_count$follower/followAndfriend_count$friend
head(followAndfriend_count)
#sort the data frame in decreasing count of followers
counts_sort <- arrange(followAndfriend_count, desc(follower))
head(counts_sort)

#select rows with followers count greater than 4000
counts_sort[counts_sort$follower > 4000, ]

#select rows with followers count less than 2000
counts_sort[counts_sort$follower < 2000, ]

library(ggplot2)
#create a time series plot with 
ts_plot(H_NIKE, by = "hours", color = "red")


#extract source and destination vectors
retweet_df <- H_NIKE[, c("screen_name", "retweet_screen_name")]
head(retweet_df, 30) #view top 30 data in the data frame 


#Replace empty spaces in the data with NA
retweet_df <- mutate_all(retweet_df, list(~na_if(.,"")))
# Remove rows with missing values
rtwt_df_new <- retweet_df[complete.cases(retweet_df), ]
head(rtwt_df_new, 10)
rtwt_df_new_graph <- rtwt_df_new # rtwt_df_new_graph used to make the network plot less crowded

#convert the data to a matrix
matrx <- as.matrix(rtwt_df_new)
matrx

library(igraph)
nw_retweet <- graph_from_edgelist(el = matrx , directed = TRUE)
# View the retweet network
print.igraph(nw_retweet)


#calculate out degree 
out_deg <- degree(nw_retweet, mode = c("out"))
#out_deg
#out degree in descending order
out_degree_sort <- sort (out_deg, decreasing = TRUE)
#top 3 users with highest out degree
out_degree_sort[1:3]

#calculate in degree
in_deg <- degree(nw_retweet, mode = c("in"))
#in_deg
#in degree scores sorted in descending order
in_degree_sort <- sort (in_deg, decreasing = TRUE)
#top 3 users
in_degree_sort[1:3]

#calculate betweenness scores in descreasing order
betwn_nw <- betweenness(nw_retweet, directed = TRUE)
#sort betweenness scores 
betwn_nw_sort <- betwn_nw  %>%
                  sort(decreasing = TRUE) %>%
                  round()
betwn_nw_sort [1:3] #view top 3 betweenness scores

out_degree_sort[1:10]
in_degree_sort[1:10]
betwn_nw_sort[1:10]

# reduce the number of edges in the network to make the plot more visible
# this is done by selecting a sample from the data using sample_n function below
#here I use a sample of 60 edges chosen randomly with replacement
rtwt_df_new_graph <- sample_n(rtwt_df_new_graph,60, replace = TRUE)
new_matrx <- as.matrix(rtwt_df_new_graph)
new_nw_retweet <- graph_from_edgelist(el = new_matrx , directed = TRUE)
#sampling is done with replacement
# proceed to plot the network with fewer edges for visibility.


#create the base network plot
plot.igraph(new_nw_retweet)

#create a network plot, vertex color red and vertex size 15
set.seed(1234)
plot(new_nw_retweet, asp = 9/16, vertex.size = 15, vertex.color ="red",
     edge.arrow.size = 0.5, edge.color = "black", vertex.label.cex = 0.9,
     vertex.label.color = "black")

# Create a variable for out-degree
deg_out <- degree(new_nw_retweet, mode = c("out"))
deg_out

# Amplify the out-degree values to a minimum value of 5
vert_size <- (deg_out * 3) + 5

# Set vertex size to amplified out-degree values
set.seed(1234)
plot(new_nw_retweet, asp = 10/11, 
     vertex.size = vert_size, vertex.color = "tomato",
     edge.arrow.size = 0.5,
     edge.color = "grey",
     vertex.label.cex = 0.8,
     vertex.label.color = "black")

followers$follow <- ifelse(followers$follower > 500, "1", "0")

# Assign the new column as vertex attribute to the retweet network
V(new_nw_retweet)$followers <- followers$follow

# View the vertex attributes
vertex_attr(new_nw_retweet)

# Set the vertex colors based on follower count and create a plot
sub_color <- c("steelblue", "tomato")
plot(new_nw_retweet, asp = 9/12,
     vertex.size = vert_size, edge.arrow.size = 0.5,
     vertex.label.cex = 0.8,
     vertex.color = sub_color[as.factor(vertex_attr(new_nw_retweet, "followers"))],
     vertex.label.color = "black", vertex.frame.color = "lightgreen")






