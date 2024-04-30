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



# Level-0 concepts and 5 recent works per author --------------------------



### Nb. Citations

a <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_concepts_lvl0_5 
            + pmi_distance_2024_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df)


b <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Balance_author_journal_concepts_lvl0_5 
            + Balance_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df)


c <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Disparity_author_journal_concepts_lvl0_5 
            + Disparity_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df)

d <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Variety_author_journal_concepts_lvl0_5 
            + Variety_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df)

### Attention score

e <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_concepts_lvl0_5 
        + pmi_distance_2024_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)


f <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Balance_author_journal_concepts_lvl0_5 
        + Balance_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)

g <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Disparity_author_journal_concepts_lvl0_5 
        + Disparity_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)

h <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Variety_author_journal_concepts_lvl0_5 
        + Variety_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)



stargazer(a,b,c,d, e,f,g,h,
          dep.var.labels=c("Nb. Citations","","","Attention Score", "", "" ),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="text", 
          df = FALSE)


### Interdisciplinarity Spread 


i <- lm(pmi_distance_2024_citation_concept ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_concepts_lvl0_5 
        + pmi_distance_2024_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)


l <- lm(pmi_distance_2024_citation_concept ~  score_group + reference_ai_score_mean + Balance_author_journal_concepts_lvl0_5 
        + Balance_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)

m <- lm(pmi_distance_2024_citation_concept ~  score_group + reference_ai_score_mean + Disparity_author_journal_concepts_lvl0_5 
        + Disparity_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)

n <- lm(pmi_distance_2024_citation_concept ~  score_group + reference_ai_score_mean + Variety_author_journal_concepts_lvl0_5 
        + Variety_reference_concept + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)


stargazer(i, l, m,n,
          dep.var.labels=c("Interd. Spread",'',''),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="text", 
          df = FALSE)


# Level-1 concepts and 5 recent works per author --------------------------



### Nb. Citations

a <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_concepts_lvl1_5 
            + pmi_distance_reference_2024_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df)


b <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Balance_author_journal_concepts_lvl1_5 
            + Balance_reference_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df)


c <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Disparity_author_journal_concepts_lvl1_5 
            + Disparity_reference_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df)

d <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Variety_author_journal_concepts_lvl1_5 
            + Variety_reference_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df)

### Attention score

e <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_concepts_lvl1_5 
        + pmi_distance_reference_2024_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)


f <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Balance_author_journal_concepts_lvl1_5 
        + Balance_reference_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)

g <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Disparity_author_journal_concepts_lvl1_5 
        + Disparity_reference_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)

h <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Variety_author_journal_concepts_lvl1_5 
        + Variety_reference_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)



stargazer(a,b,c,d, e,f,g,h,
          dep.var.labels=c("Nb. Citations","","","Attention Score", "", "" ),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="text", 
          df = FALSE)


### Interdisciplinarity Spread 


i <- lm(pmi_distance_citation_2024_concepts_lvl1 ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_concepts_lvl1_5 
        + pmi_distance_reference_2024_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)


l <- lm(pmi_distance_citation_2024_concepts_lvl1 ~  score_group + reference_ai_score_mean + Balance_author_journal_concepts_lvl1_5 
        + Balance_reference_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)

m <- lm(pmi_distance_citation_2024_concepts_lvl1 ~  score_group + reference_ai_score_mean + Disparity_author_journal_concepts_lvl1_5 
        + Disparity_reference_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)

n <- lm(pmi_distance_citation_2024_concepts_lvl1 ~  score_group + reference_ai_score_mean + Variety_author_journal_concepts_lvl1_5 
        + Variety_reference_concepts_lvl1 + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df)


stargazer(i,l, m,n,
          dep.var.labels=c("Interd. Spread",'',''),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="text", 
          df = FALSE)



# Models without pre-prints  --------------------------



df_noP = read_csv("data_main_senza_preprint.csv")
#names(df) #names of columns
df_noP = df_noP %>% mutate(altmetrics_score_2024_ln = log(altmetrics_score_2024+1),
                   Dominant_Topic = as.factor(Dominant_Topic))


### Nb. Citations

a <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_journal 
            + pmi_distance_2024_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df_noP)


summary(a)
b <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Balance_author_journal 
            + Balance_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df_noP)


c <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Disparity_author_journal 
            + Disparity_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df_noP)

d <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Variety_author_journal 
            + Variety_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
            data = df_noP)

### Attention score

e <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_journal 
        + pmi_distance_2024_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df_noP)


f <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Balance_author_journal 
        + Balance_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df_noP)

g <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Disparity_author_journal 
        + Disparity_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df_noP)

h <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Variety_author_journal 
        + Variety_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df_noP)



stargazer(b,c,d,a,f,g,h,e,
          dep.var.labels=c("Nb. Citations","","","Attention Score", "", "" ),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="latex", 
          df = FALSE)


### Interdisciplinarity Spread 


i <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_journal 
        + pmi_distance_2024_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df_noP)


l <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + Balance_author_journal 
        + Balance_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df_noP)

m <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + Disparity_author_journal 
        + Disparity_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df_noP)

n <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + Variety_author_journal 
        + Variety_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, 
        data = df_noP)


stargazer( l, m,n, i,
          dep.var.labels=c("Interd. Spread",'',''),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="latex", 
          df = FALSE)
summary(n)



# Models with interaction terms  --------------------------


### Nb. Citations

a <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_journal 
            + pmi_distance_2024_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln +I(score_group*pmi_distance_2024_reference_journal) + month_year + Dominant_Topic , 
            data = df)


b <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Balance_author_journal 
            + Balance_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + I(score_group*Balance_reference_journal)+ month_year + Dominant_Topic, 
            data = df)


c <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Disparity_author_journal 
            + Disparity_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + I(score_group*Disparity_reference_journal)+ month_year + Dominant_Topic, 
            data = df)

d <- glm.nb(citation_2024_01 ~  score_group + reference_ai_score_mean + Variety_author_journal 
            + Variety_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + I(score_group*Variety_reference_journal)+ month_year + Dominant_Topic, 
            data = df)

### Attention score

e <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_journal 
        + pmi_distance_2024_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + I(score_group*pmi_distance_2024_reference_journal) +month_year + Dominant_Topic, 
        data = df)


f <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Balance_author_journal 
        + Balance_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + I(score_group*Balance_reference_journal)+ month_year + Dominant_Topic, 
        data = df)

g <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Disparity_author_journal 
        + Disparity_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + I(score_group*Disparity_reference_journal)+ month_year + Dominant_Topic, 
        data = df)

h <- lm(altmetrics_score_2024_ln ~  score_group + reference_ai_score_mean + Variety_author_journal 
        + Variety_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + I(score_group*Variety_reference_journal)+ month_year + Dominant_Topic, 
        data = df)



stargazer(b,c,d,a ,f,g,h,e,
          dep.var.labels=c("Nb. Citations","","","Attention Score", "", "" ),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="latex", 
          df = FALSE)


### Interdisciplinarity Spread 


i <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_journal 
        + pmi_distance_2024_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln +I(score_group*pmi_distance_2024_reference_journal) + month_year + Dominant_Topic, 
        data = df)


l <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + Balance_author_journal 
        + Balance_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + I(score_group*Balance_reference_journal)+ month_year + Dominant_Topic, 
        data = df)

m <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + Disparity_author_journal 
        + Disparity_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + I(score_group*Disparity_reference_journal)+ month_year + Dominant_Topic, 
        data = df)

n <- lm(pmi_distance_2024_citation_journal ~  score_group + reference_ai_score_mean + Variety_author_journal 
        + Variety_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
        + num_unique_country_ln + count_out_ln + I(score_group*Variety_reference_journal)+ month_year + Dominant_Topic, 
        data = df)


stargazer( l, m,n,i,
          dep.var.labels=c("Interd. Spread",'',''),
          omit = c("month_year", "Dominant_Topic", "Constant"),
          align=TRUE,
          type="latex", 
          df = FALSE)




# Models Quasi-Poisson  --------------------------


### Nb. Citations



a <- glm(citation_2024_01 ~  score_group + reference_ai_score_mean + pmi_distance_2024_AUTORI_journal 
            + pmi_distance_2024_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic , family=quasipoisson,
            data = df)


b <- glm(citation_2024_01 ~  score_group + reference_ai_score_mean + Balance_author_journal 
            + Balance_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic,family=quasipoisson ,
            data = df)


c <- glm(citation_2024_01 ~  score_group + reference_ai_score_mean + Disparity_author_journal 
            + Disparity_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic,family=quasipoisson, 
            data = df)

d <- glm(citation_2024_01 ~  score_group + reference_ai_score_mean + Variety_author_journal 
            + Variety_reference_journal + ai_collaborator + top_ai + sum_infl_cit_autho_ln + year_work_ln 
            + num_unique_country_ln + count_out_ln + month_year + Dominant_Topic, family=quasipoisson,
            data = df)

stargazer( b,c,d,a,
           dep.var.labels=c("Nb. Citations",'','',''),
           omit = c("month_year", "Dominant_Topic", "Constant"),
           align=TRUE,
           type="text", 
           df = FALSE)
