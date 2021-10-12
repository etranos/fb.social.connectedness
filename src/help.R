path.data.county <- paste0(path, "/data/raw/county_county_aug2020.tsv.tsv")
df.county <- read_tsv(path.data)

df.county <- df.county %>% 
  left_join(lookup, by=c("user_loc" = "key")) %>% 
  rename(level.user = level) %>% 
  left_join(lookup, by=c("fr_loc" = "key")) %>% 
  rename(level.fr = level,
         weight = scaled_sci) %>% 
  arrange(desc(weight))
head(df.county)

Networks

```{r}
df.net <- graph_from_data_frame(df, directed = T)
is.weighted(df.net)
gsize(df.net)
gorder(df.net)

df.net.un <- graph_from_data_frame(df, directed = F, )
gsize(df.net.un)

# centralities <- cbind(vertex_attr(df.net), centralities)


a %>% 
  # mutate(l.user = nchar(user_loc),
  #        l.fr = nchar(fr_loc)) %>% 
  # filter(l.user == 5 & l.fr == 5) %>% 
  filter(startsWith(user_loc, "USA") &
           startsWith(fr_loc, "USA")) %>% 
  arrange(desc(scaled_sci))

```

centralities

```{r}
centralities <- tibble(
  names = vertex_attr(df.net),
  #degree = degree(df.net, mode = "in"),
  w.degree = graph.strength(df.net, mode = "all")) %>% 
  # btwnss = betweenness(df.net, weights = NA),
  # eigen = eigen_centrality(df.net)$vector,  # note the $vector
  # prank = page_rank(df.net, directed = T)$vector) %>% 
  arrange(desc(w.degree)) %>% 
  glimpse()

centralities.un <- tibble(
  names = vertex_attr(df.net.un),
  #degree = degree(df.net.un, mode = "in"),
  w.degree = graph.strength(df.net.un, mode = "all")) %>% 
  # btwnss = betweenness(df.net, weights = NA),
  # eigen = eigen_centrality(df.net)$vector,  # note the $vector
  # prank = page_rank(df.net, directed = T)$vector) %>% 
  arrange(desc(w.degree)) %>% 
  glimpse()


# c <- graph.strength(df.net_) %>% 
#   bind_cols(vertex_attr(df.net_)) %>% 
#   as_tibble() %>% 
#   rename(w.degree = '...1') %>% 
#   arrange(desc(w.degree))
```

