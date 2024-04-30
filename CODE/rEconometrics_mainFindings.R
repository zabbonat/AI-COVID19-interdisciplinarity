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
#names(df) #names of columns
df = df %>% mutate(altmetrics_score_2024_ln = log(altmetrics_score_2024+1),
                   Dominant_Topic = as.factor(Dominant_Topic))


### Nb. Citations ---

a <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_journal 
                            + pmi_distance_2024_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                            data = df)


b <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Balance_author_journal 
            + Balance_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df)


c <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Disparity_author_journal 
                            + Disparity_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                            data = df)

d <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Variety_author_journal 
                            + Variety_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                            data = df)

### Attention score ---

e <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_journal 
                         + pmi_distance_2024_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                         + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                         data = df)


f <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Balance_author_journal 
                         + Balance_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                         + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                         data = df)

g <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Disparity_author_journal 
                        + Disparity_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                        data = df)

h <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Variety_author_journal 
                      + Variety_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
                      + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
                      data = df)



stargazer(a,b,c,d, e,f,g,h,
          dep.var.labels=c("Nb. Citations","","","Attention Score", "", "" ),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="text", 
          df = FALSE)


### Interdisciplinarity Spread ---


i <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_journal 
        + pmi_distance_2024_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)


l <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + Balance_author_journal 
               + Balance_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
               + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
               data = df)

m <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + Disparity_author_journal 
               + Disparity_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
               + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
               data = df)

n <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + Variety_author_journal 
               + Variety_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
               + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
               data = df)


stargazer(i, l, m,n,
          dep.var.labels=c("Interd. Spread",'',''),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="text", 
          df = FALSE)


