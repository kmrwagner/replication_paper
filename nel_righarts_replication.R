knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(warning = FALSE, message = FALSE)

library(latex2exp)
library(dplyr)

rep_df <- load("nel_righarts_data.RData")
x <- x %>%                           
  group_by(state) %>%
  mutate(imr_t_1 = lag(imr),
         imr_sq_t_1 = lag(imr_sq),
         vccall_tp1 = lead(vccall),
         vccmajor_tp1 = lead(vccmajor)) 

## Table 1

#Model 1
t1_1 <- logistf::logistf(vccall ~ allND_pc + imr_t_1 + imr_sq_t_1 + mixedx + gdpgrox + brevity, 
              data = x, firth = TRUE)

#Model 2
t1_2 <- logistf::logistf(vccall ~ allND_pc + imr_t_1 + imr_sq_t_1 + mixed + gdpgro + brevity, 
             data = rep_df, firth = TRUE)

#Model 3
t1_3 <- logistf::logistf(vccall ~ allND_pc + gdppc_ln + mixed + gdpgro + brevity, 
             data = x, firth = TRUE)

#Model 4
t1_4 <- logistf::logistf(vccall ~ allND_pc + mixed + gdpgro + youth_bulge + brevity, 
              data = x, firth = TRUE)

#Model 5
t1_5 <- logistf::logistf(vccall_tp1 ~ allND_pc + imr_t_1 + imr_sq_t_1 + mixed + gdpgro + brevity, 
             data = x)

# Extract the summary of the logistf model
extract_logistf <- function(model) {
  summary_model <- summary(model)
  data.frame(
    Variable = rownames(summary_model$coefficients),
    Coefficient = summary_model$coefficients[, "coef"],
    SE = summary_model$coefficients[, "se(coef)"],
    `Lower 95%` = summary_model$coefficients[, "lower 0.95"],
    `Upper 95%` = summary_model$coefficients[, "upper 0.95"],
    p = summary_model$coefficients[, "p"]
  )
}

# Example: Extract from a logistf model
results <- extract_logistf(t1_1)

write.csv(results, file = "logistf_results.csv", row.names = FALSE)