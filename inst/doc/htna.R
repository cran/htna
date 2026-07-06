## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  message  = FALSE,
  warning  = FALSE,
  fig.width  = 10,
  fig.height = 7,
  dpi = 90
)

## -----------------------------------------------------------------------------
library(htna)
data(human_ai)

net <- build_htna(human_ai, actor_type = "actor_type", actor = "session_id")

## -----------------------------------------------------------------------------
plot_htna(net)

## ----fig.height = 5-----------------------------------------------------------
sequence_plot_htna(net, by = "state", type = "index")

## -----------------------------------------------------------------------------
sequence_plot_htna(net, by = "state", type = "heatmap")

## ----fig.height=4-------------------------------------------------------------
sequence_plot_htna(net, by = "group", type = "distribution", na_color = "white")

## -----------------------------------------------------------------------------
centralities_htna(net)

## ----fig.height = 9-----------------------------------------------------------
plot_centralities(net, by = "state")

## ----fig.height = 9-----------------------------------------------------------
plot_centralities(net, by = "group")

## -----------------------------------------------------------------------------
boot <- bootstrap_htna(net)
plot_htna_bootstrap(boot)

## -----------------------------------------------------------------------------
plot_htna_bootstrap(boot, display = "significant")

## -----------------------------------------------------------------------------
cs <- centrality_stability_htna(net, iter = 100, seed = 1)
cs$cs

## -----------------------------------------------------------------------------
rel <- reliability_htna(net, iter = 100, seed = 1)
rel$summary

## -----------------------------------------------------------------------------
grouped <-  build_htna(human_ai, actor_type = "actor_type", group = "phase")

early <- grouped[["Early"]]
late  <- grouped[["Late"]]

plot_htna_diff(early, late)

## -----------------------------------------------------------------------------
perm <- permutation_htna(early, late, iter = 200)
plot_htna_diff(perm)

## -----------------------------------------------------------------------------
plot_htna_diff(perm, show_nonsig = TRUE)

## -----------------------------------------------------------------------------
extract_meta_paths(net, length = 3)

## -----------------------------------------------------------------------------
extract_meta_paths(net, schema = "Human->AI->Human")
extract_meta_paths(net, schema = "Human->Ask->*")

## -----------------------------------------------------------------------------
extract_meta_paths(net, length = 3, min_lift = 2)
extract_meta_paths(net, level = "type", length = 3, min_lift = 1.2)

