# Publication
Official repository for **Questioning the impact of AI and interdisciplinarity in science: Lessons from COVID-19**

- Keywords: Team Science, Interdisciplinarity, Artificial Intelligence, COVID-19

# Project Description
This project contains a sample of data from CORD-19 concerning AI and COVID-19 with additional information obtained through other databases (Semantic scholar, OpenAlex)  


## Interdisciplinarity metrics
|      |  |               |
|------|------------------|----------------------------------------------------------------------------------------------------------------------|
| Team | $\mu_{AI}^{team}$ | *AI team metric* is the fraction of the previous AI publications for each author, averaged over the entire time |
|      | $\mu_{GEN}^{team}$ | *General team metric* is the average "recent" disciplinary dispersion (journal distances) of team authors    |
|      | $Balance^{team}$ | *General team metric* is the average "recent" disciplinary dispersion (journal distances) of team authors    |
|      | $Disparity^{team}$ | *General team metric* is the average "recent" disciplinary dispersion (journal distances) of team authors    |
|      | $Variety^{team}$ | *General team metric* is the average "recent" disciplinary dispersion (journal distances) of team authors    |

| Knowledge | $\mu_{AI}^{kn}$ | *AI knowledge metric* is the fraction of references using AI keywords |
|           | $\mu_{GEN}^{kn}$ | *General knowledge metric* is the average distance among all the journals cited in the references |
|      | $Balance^{kn}$ | *General team metric* is the average "recent" disciplinary dispersion (journal distances) of team authors    |
|      | $Disparity^{kn}$ | *General team metric* is the average "recent" disciplinary dispersion (journal distances) of team authors    |
|      | $Variety^{kn}$ | *General team metric* is the average "recent" disciplinary dispersion (journal distances) of team authors    |





## Indicators of "success"
|  |  |
|-----------------|------------------------|
| $N_{citations}$ | The number of citations |
| $M_{attention}(i)$ | The Altmetric score |
| $I(i)$ | The interdisciplinary spread |

Note: $i$ represents a research publication. 


# Repository structure

- `/DATA` contains the data used for the econometric model 
    - `data.csv` - csv file
- `/CODE` contains the code used for the econometric model and to build indexes and metrics
    - `ai-corona-interdisciplinarity.py ` - Python file that could be open also as a jupyter notebook and which contains the process for building the metrics and indexes
    - `rEconometrics.R` - R file which contains the three built econometric models





