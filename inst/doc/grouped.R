## ----options, include = FALSE-----------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", message = FALSE,
                      fig.width = 7, fig.height = 5, fig.align = "center",
                      dpi = 96)
old_options <- options(digits = 3, width = 90)

## ----setup------------------------------------------------------------------------------
library(htna)

## ----data-------------------------------------------------------------------------------
xtabs(~ phase, data = unique(subset(human_ai, select = c(session_id, phase))))
xtabs(~ phase, data = human_ai)

## ----build------------------------------------------------------------------------------
grp <- build_htna(human_ai, actor_type = "actor_type", group = "phase")
grp

## ----actor-pairs------------------------------------------------------------------------
as.data.frame(summary(grp), what = "actor_pairs")

## ----plot, fig.height = 4.5-------------------------------------------------------------
op <- par(mfrow = c(1, 2))
plot_htna(grp)
par(op)

## ----centralities-----------------------------------------------------------------------
centralities_htna(grp, measures = c("InStrength", "Betweenness"))

## ----plot-centralities, fig.height = 4.5------------------------------------------------
plot_centralities(grp, measures = c("InStrength", "Betweenness"))

## ----sequences, fig.height = 5----------------------------------------------------------
sequence_plot_htna(grp, type = "heatmap")

## ----bootstrap--------------------------------------------------------------------------
boots <- bootstrap_htna(grp, iter = 100, seed = 1)
boots

## ----bootstrap-plot, fig.height = 4.5---------------------------------------------------
op <- par(mfrow = c(1, 2))
plot_htna_bootstrap(boots, display = "significant")
par(op)

## ----stability--------------------------------------------------------------------------
stab <- centrality_stability_htna(grp, iter = 100, seed = 1)
as.data.frame(stab)

## ----compare----------------------------------------------------------------------------
compare_htna(grp)

## ----permutation------------------------------------------------------------------------
perm <- permutation_htna(grp, iter = 200, seed = 1)
perm

## ----permutation-plot, fig.height = 5.5-------------------------------------------------
plot_htna_diff(perm)

## ----restore-options, include = FALSE-----------------------------------------
options(old_options)

