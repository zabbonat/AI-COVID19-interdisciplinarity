# Publication
Official repository for **AI and COVID-19: A case of failed interdisciplinarity**

- Keywords: Team Science, Interdisciplinarity, Artificial Intelligence, COVID-19

# Project Description
This project contains a sample of data from CORD-19 concerning AI and COVID-19 with additional information obtained through other databases (semantic scholar, openAlex)  

# Repository structure

- `/DATA` contains the data used for the econometric model 
    - `data.csv` - csv file


 \begin{columns}
     \begin{column}{0.6\textwidth}
\begin{table}
\scriptsize
    \begin{tabular}{  l  l   p{5.5cm} }
    \toprule
    Team & $\mu_{AI}^{team}$ & \textit{AI team metric} is the fraction of the previous AI publications for each author, averaged over the entire time \\ [0.3cm] 
     & $\mu_{GEN}^{team}$ & \textit{General team metric} is the average "recent" disciplinary dispersion (journal distances) of team authors \\ [0.3cm]
    Knowledge & $\mu_{AI}^{kn}$ & \textit{AI knowledge metric} is the fraction of references using AI keywords  \\ [0.3cm]
     & $\mu_{GEN}^{kn}$ & \textit{General knowledge metric} is the average distance among all the journals cited in the references  \\ \bottomrule
    \end{tabular}
    \caption{Interdisciplinarity metrics}
\end{table}
    
