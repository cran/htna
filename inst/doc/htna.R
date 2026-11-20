## ----options, include = FALSE-----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = FALSE,
                      fig.width = 7, fig.height = 5.5, fig.align = "center",
                      dpi = 96)
old_options <- options(digits = 3, width = 90)

## ----setup------------------------------------------------------------------------------
library(htna)

## ----data-------------------------------------------------------------------------------
with(human_ai, table(actor_type))

## ----build------------------------------------------------------------------------------
net <- build_htna(human_ai, actor_type = "actor_type")
summary(net)

## ----edges------------------------------------------------------------------------------
head(as.data.frame(net))

## ----actor-pairs------------------------------------------------------------------------
as.data.frame(summary(net), what = "actor_pairs")

## ----plot, fig.height = 6---------------------------------------------------------------
plot_htna(net)

## ----centralities-----------------------------------------------------------------------
centralities_htna(net, measures = c("InStrength", "OutStrength",
                                    "Betweenness"))

## ----plot-centralities, fig.height = 5--------------------------------------------------
plot_centralities(net, measures = c("InStrength", "Betweenness"),
                  by = "group")

## ----prune------------------------------------------------------------------------------
pruned <- prune_htna(net, threshold = 0.05)
as.data.frame(summary(pruned), what = "actor_pairs")

## ----meta-paths-------------------------------------------------------------------------
extract_meta_paths(net, level = "type", length = 3)

## ----schema-----------------------------------------------------------------------------
print(extract_meta_paths(net, schema = "Human->AI->Human"), n = 5)

## ----sequences, fig.height = 5.5--------------------------------------------------------
sequence_plot_htna(net, type = "heatmap")

## ----bootstrap--------------------------------------------------------------------------
boot <- bootstrap_htna(net, iter = 100, seed = 1)
boot

## ----bootstrap-plot, fig.height = 6-----------------------------------------------------
plot_htna_bootstrap(boot)

## ----stability--------------------------------------------------------------------------
cs <- centrality_stability_htna(net, iter = 100, seed = 1)
as.data.frame(cs)

## ----reliability------------------------------------------------------------------------
rel <- reliability_htna(net, iter = 100, seed = 1)
summary(rel)

## ----restore-options, include = FALSE-----------------------------------------
options(old_options)

