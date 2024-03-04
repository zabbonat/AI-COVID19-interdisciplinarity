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
library(tibble)


df = read_csv("data_main.csv")
names(df) #name of columns
df = df %>% mutate(altmetrics_score_2024_ln = log(altmetrics_score_2024+1),
                      ai_collaborator = ifelse(score_group > 0, 1, 0),
                      Dominant_Topic = as.factor(Dominant_Topic))



# Citation and Attention --------------------------------------------------



mod2B_JC_citation <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Balance_author_journal_concept + 
                              + Balance_reference_concept  + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                            data = df)
a = mod2B_JC_citation

#########
mod2B_JC_attention <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Balance_author_journal_concept 
                         + Balance_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                         + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                         data = df)

b = mod2B_JC_attention

#########
mod2D_JC_citation <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Disparity_author_journal_concept 
                            + Disparity_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                            data = df)
c = mod2D_JC_citation

#########
mod2D_JC_attention <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Disparity_author_journal_concept 
                         + Disparity_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                         + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                         data = df)
d = mod2D_JC_attention

#########
mod2V_JC_citation <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Variety_author_journal_concept 
                            + Variety_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                            data = df)
e = mod2V_JC_citation

#########
mod2V_JC_attention <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Variety_author_journal_concept 
                         + Variety_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                         + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                         data = df)
f = mod2V_JC_attention

#########

mod2S_JC_citation <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_concept 
                            + pmi_distance_2024_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                            data = df)
g = mod2S_JC_citation

#########

mod2S_JC_attention <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_concept 
                         + pmi_distance_2024_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                         + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                         data = df)
h = mod2S_JC_attention



stargazer(a,c,e,g, b,d,f,h,
          dep.var.labels=c("Nb. Citations","","","", "Attention Score", "", "","" ),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="text", 
          df = FALSE)



# Interd. Spread ----------------------------------------------------------



spread_B <- lm(pmi_distance_2024_citation_concept ~  score_group + reference_ai_score_mean + Balance_author_journal_concept 
               + Balance_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
               + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
               data = df)

spread_D <- lm(pmi_distance_2024_citation_concept ~  score_group + reference_ai_score_mean + Disparity_author_journal_concept 
               + Disparity_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
               + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
               data = df)

spread_V <- lm(pmi_distance_2024_citation_concept ~  score_group + reference_ai_score_mean + Variety_author_journal_concept 
               + Variety_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
               + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
               data = df)

spread_P <- lm(pmi_distance_2024_citation_concept ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_concept 
               + pmi_distance_2024_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
               + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
               data = df)


stargazer(spread_B, spread_D, spread_V, spread_P,
          dep.var.labels=c("Interd. Spread", "", "", ""),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="text", 
          df = FALSE)
