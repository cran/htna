## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse  = TRUE,
  comment   = "#>",
  message   = FALSE,
  warning   = FALSE,
  fig.width = 10,
  fig.height = 7,
  dpi = 90
)

## -----------------------------------------------------------------------------
library(htna)
data(human_ai)
data(human_simplified)
data(ai_simplified)
data(human_ai_codebook)

## -----------------------------------------------------------------------------
net_list <- build_htna(list(Human = human_simplified, AI = ai_simplified), 
                       actor = "session_id")
summary(net_list)

## ----fig.height = 7-----------------------------------------------------------
plot_htna(net_list)

## -----------------------------------------------------------------------------
net_actor_type <- build_htna(human_ai, 
                             actor_type = "actor_type", 
                             actor = "session_id", 
                             order = "order_in_session")

## -----------------------------------------------------------------------------
human_codes <- c("Specify", "Request", "Frustrate", "Check", "Inquire", "Refine")
ai_codes    <- c("Delegate", "Plan", "Execute", "Ask", "Repair", "Report")

net_node_groups <- build_htna(
  human_ai,
  actor = "session_id",
  node_groups = list(Human = human_codes, AI = ai_codes)
)
net_node_groups

## -----------------------------------------------------------------------------
head(human_ai_codebook)

net_node_groups_df <- build_htna(
  human_ai,
  session = "session_id",
  node_groups = human_ai_codebook
)

## ----fig.height = 9-----------------------------------------------------------
forms <- list(
  list_form        = net_list,
  actor_type_form  = net_actor_type,
  node_groups_list = net_node_groups,
  node_groups_df   = net_node_groups_df
)

op <- par(mfrow = c(2, 2), mar = c(1, 1, 3, 1))
for (nm in names(forms)) plot_htna(forms[[nm]], title = nm)
par(op)

## -----------------------------------------------------------------------------
overlap <- data.frame(
  session_id        = rep(paste0("s", 1:3), each = 6),
  code              = rep(c("Ask", "Reply", "Ask", "Reply", "Ask", "Reply"), 3),
  actor_type        = rep(c("Human", "Human", "AI", "AI", "Human", "AI"), 3),
  order_in_session  = rep(1:6, 3),
  stringsAsFactors  = FALSE
)

# Without disambiguate=, this errors:
try(build_htna(overlap, actor_type = "actor_type"))

# With disambiguate=, the two `Ask`s become distinct nodes:
net_dis <- build_htna(overlap, actor_type = "actor_type",
                      disambiguate = TRUE)
net_dis$nodes$label
plot(net_dis)

## -----------------------------------------------------------------------------
grp <- build_htna(human_ai, actor_type = "actor_type", group = "phase")
class(grp)
names(grp)

## ----fig.height = 7-----------------------------------------------------------
plot_htna(grp)

