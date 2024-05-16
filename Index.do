<<dd_version: 2>>     
<<dd_include: header.txt>>




# **Collaborative Project**

$\small For$  $\small ongoing$  $\small sharing$  $\small project$

1. **Project Objective**

- Collaborate with investigators to ask critical questions in public health field

2. **Phase 1 Plan**

- Data source:

     National Health and Nutrition Examination Survey (NHANES) [1999-2000 Survey Data](https://wwwn.cdc.gov/Nchs/Nhanes/1999-2000/DEMO.XPT)

     NHANES Mortality [Follow-up Data](https://ftp.cdc.gov/pub/HEALTH_STATISTICS/NCHS/datalinkage/linked_mortality/NHANES_1999_2000_MORT_2019_PUBLIC.dat)
- Code development:
  Download original Script from [here](https://ftp.cdc.gov/pub/HEALTH_STATISTICS/NCHS/datalinkage/linked_mortality/Stata_ReadInProgramAllSurveys.do). Modify the .do file and upload.
  Execute the following Stata code to merge the survey data with the mortality data, ensuring alignment on the unique sequence numbers:
  ```stata
  //use your own username/project repo instead of the class repo below
  global repo "https://github.com/sleetlin1983/Project/raw/main/"
  do ${repo}followup.do
  save followup, replace
  import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/1999-2000/DEMO.XPT", clear
  merge 1:1 seqn using followup
  lookfor follow
  ```
3. **Key Parameters**
- Here’s a first iteration of a script that answers they project main goal. Save it as [project.do](https://raw.githubusercontent.com/sleetlin1983/Project/main/Project.do) and upload it to you repo.
```stata
global repo "https://github.com/sleetlin1983/Project/raw/main/"
do ${repo}followup.do
save followup, replace 
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/1999-2000/DEMO.XPT", clear
merge 1:1 seqn using followup
lookfor follow
lookfor mortstat permth_int eligstat 
keep if eligstat==1
capture g years=permth_int/12
codebook mortstat
stset years, fail(mortstat)
sts graph, fail
save demo_mortality, replace 
import sasxport5 "https://wwwn.cdc.gov/Nchs/Nhanes/1999-2000/HUQ.XPT", clear 
merge 1:1 seqn using demo_mortality, nogen
sts graph, by(huq010) fail
stcox i.huq010
```
4. **Inferences**
Please review [documentation](https://wwwn.cdc.gov/Nchs/Nhanes/1999-2000/HUQ.htm)for the file HUQ.XPT, which includes the variable huq010

   **Non-Parametric Model**
   - Click [here](https://raw.githubusercontent.com/sleetlin1983/Project/main/Nonparametric.do) to access the code script
   - Click [here](https://github.com/sleetlin1983/Project/blob/main/nonpara.png) for the results
     
   **Semi-parametric Model**
   - Click [here](https://raw.githubusercontent.com/sleetlin1983/Project/main/Nonparametric.do) to access the code script
   - Click [here](https://github.com/sleetlin1983/Project/blob/main/semipara_unadj.png) for the results
   