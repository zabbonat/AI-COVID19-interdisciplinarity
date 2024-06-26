# Publication
Official repository for **Interdisciplinary Research in Artificial Intelligence: Lessons from COVID-19**

- Keywords: Team Science, Interdisciplinarity, Artificial Intelligence, COVID-19

# Project Description
This project contains a sample of data from CORD-19 concerning AI and COVID-19 with additional information obtained through OpenAlex  


## Interdisciplinarity metrics
|      |  |               |
|------|------------------|----------------------------------------------------------------------------------------------------------------------|
| Team | *AI Team Expertise* | *AI team metric* is the fraction of the previous AI publications for each author, averaged over the entire time |
|      | *PMI (Team)* | *General team metric* is the average "recent" disciplinary dispersion (journal distances) of team authors    |
|      | *Balance (Team)* | *Balance* measures the evenness of the distribution of categories in the team    |
|      | *Disparity (Team)* |*Disparity* quantifies the degree of difference or diversity between elements within a set of the n most recent publications per author in the team   |
|      | *Variety (Team)* | *Variety* is the number of different disciplines (or journals) of the n most recent publications per author in the team   |
| Knowledge | *Share of AI References* | *AI knowledge metric* is the fraction of references using AI keywords |
|           |*PMI (References)* | *General knowledge metric* is the average distance among all the journals cited in the references |
|      | *Balance (References)* | *Balance*  measures the evenness of the distribution of categories within a set of references     |
|      | *Disparity (References)* | *Disparity* quantifies the degree of difference or diversity between elements within a set of references    |
|      | *Variety (References)* | *Variety* is the number of different disciplines (or journals) cited |





## Indicators of "success"
|  |  |
|-----------------|------------------------|
| $N_{citations}$ | The number of citations |
| $M_{attention}(i)$ | The Altmetric score |
| $I(i)$ | The interdisciplinary spread |

Note: $i$ represents a research publication. 


# Repository structure

- `/DATA` contains the data used for the econometric model 
    - `data_main.csv` - csv file
    -  `Reference&Citations.rar` - .rar file containing data_reference.csv & data_citation.csv
    -  `data_main_senza_preprint.csv` - csv file with `data_main.csv` data but without preprints
- `/CODE` contains the code used for the econometric model and to build indexes and metrics
    - `Metrics.ipynb ` - Jupyter Notebok which contains the process for building the metrics and indexes
    - `rEconometrics_mainFindings.R` - R file which contains the econometric models
    - `rEconometrics_robustnessCheck.R` - R file which contains the robustness checks





