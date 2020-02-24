# Group 5 - Allegation Influence & Disciplinary Rationale

We wanted to stray away from the other common project theses in order to approach a connection that would provide more unique results. To accomplish this, we focused on the relationships between allegations, crimes, and signs of compelling emotion. Being a police officer requires maintaining discipline and composure in exceptionally stressful and potentially life-threatening situations. Police officers consistently deal with disobedience, frustration, and an ever-present worry for their safety. On the other hand, the motivation that pushes someone to file a complaint against an officer has the potential to be emotionally driven. While this doesn't mean all complaints are, there should be a unique threshold, or point until action, that a person must meet before they willingly carry out the process of filing a complaint. As emotion cannot yet be accurately quantified, we instead focused on separating and predicting how certain, more emotion-inducing, stimuli can have affected officers and complainants.

*Project team:*
- Jack Richard
- Ikhlas Attarwala
- Quincia Hu


### Roadmap Entry

You can find our [Roadmap entry here!](http://roadmap.cpdp.co/analyses/p/predicting-influence-of-allegation-and-chance-of-disciplinary-action-for-a-given)


### Checkpoints

##### 1. Relational Analytics
* `05_Group/Checkpoints/CP_1/src` - Contains all query scripts in SQL  
* `05_Group/Checkpoints/CP_1/output` - Contains all queried outputs in README.MD file  
  * Q1: What is the salary range of officers with more than a single complaint?  
  * Q2: What is the distribution of allegations over the various police districts?  
  * Q3: What officer ranks receive the most number of allegations?  
  * Q4: How many different types of allegations are there against police officers?

##### 2. Data Integration (& Cleaning)
* `05_Group/Checkpoints/CP_2/src` - Contains writeup from Trifacta  
* `05_Group/Checkpoints/CP_2/output` - Contains all outputs from Trifacta  
  * Q1: Are there are significant number of complaints with near-equivalent entries of date and location in the crime database?  
  * Q2: Given connections between crime and complaints in a location at a given time, what classifications of crimes lead to a greater number of filed complaints?  
  * Q3: Is there a stronger likelihood that a complaint will be filed in areas that historically show more domestic crimes?  
  * Q4: What is the ratio of complaints to crimes per police district?

##### 3. Workflow Analytics
* `05_Group/Checkpoints/CP_3/src` - Contains inputs from .ipynb file for Jupiter Notebook (using Spark)  
* `05_Group/Checkpoints/CP_3/output` - Contains outputs in CSV and HTML format  
  * Q1: Is there a specific district that consistently sees a higher percentage of complaints and crimes?  
  * Q2: Is there a relationship between the area type and clusters of officers?  
  * Q3: What is the correlation coefficient of the relationship between police officer salary and the number of complaints received? What about the relationship between police officer rank and number of complaints received?  
  * Q4: What is an officer's track record of complaints over a period of time?

##### 4. Machine Learning
* `05_Group/Checkpoints/CP_4/src` - Contains inputs from .ipynb file for Jupiter Notebook (using Spark)  
* `05_Group/Checkpoints/CP_4/output` - Contains outputs in HTML format  
  * Q1: How reasonable is a complaint, given the history of the officer and the area it was filed in?  
  * Q2: For a given district, can we predict the number of complaints during an upcoming time period?

##### 5. Modeling with Neural Networks
* `05_Group/Checkpoints/CP_5/src` - Contains inputs from .ipynb file for Jupiter Notebook (using TensorFlow)  
* `05_Group/Checkpoints/CP_5/output` - Contains outputs in CSV and HTML format  
  * Q1: Build a prediction model centered around `SubjectInjured`  

##### 6. Visualization
* `05_Group/Checkpoints/CP_6/src` - Contains inputs from .twb file for Tableau Workbook  
* `05_Group/Checkpoints/CP_6/output` - Contains visuals  
  * Q1: Historically, what areas have the highest rate of crime, and what areas exhibit the most complaints?  
  * Q2: How many unique officers have received complaints in each district or area of interest?  
  * Q3: How did the crime rate and allegation rate change over the years?
