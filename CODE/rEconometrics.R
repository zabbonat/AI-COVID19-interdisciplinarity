library(dplyr)
library(MASS) 
library(stargazer) 
library(ggplot2)
library(reshape2) 
library(sandwich)
library(lattice)
library(lmtest)
library(leaps)
library(readr)
library(tidyr)
library(plotly)



# Replace NA in citations with observable values 
df <- df %>% mutate(count_in_update_2k22 = ifelse(is.na(count_in_update_2k22), count_in, count_in_update_2k22))
df <- df %>% mutate(ai_collaborator = ifelse(score_group > 0, 1, 0))


#---- AGGREGATE -----

mod1 <- glm.nb(count_in_update_2k22 ~  score_group + reference_ai_score_mean + pmi_distance_author_3_recent + pmi_distance_reference + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, data = df)
mod2 <- lm(altmetrics_score_ln ~       score_group + reference_ai_score_mean + pmi_distance_author_3_recent + pmi_distance_reference + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, data = df)
mod3 <- lm(pmi_distance_citation ~     score_group + reference_ai_score_mean + pmi_distance_author_3_recent + pmi_distance_reference + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, data = df)

stargazer(mod1, mod2, mod3,
          dep.var.labels=c("Nb. Citations", "Attention Score (log)", "Spread Score (log)"),
          covariate.labels = c("mu_{AI}^{team}", "mu_{AI}^{kn}",
                               "mu_{GENERAL}^{team}", "mu_{GENERAL}^{kn}",
                               "AI collaborator", "Top AI guy",  
                               "Past Impact (log)", "Academic Age (log)", "Nb. Countries (log)", "Nb. References (log)"),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="text", 
          df = FALSE)




