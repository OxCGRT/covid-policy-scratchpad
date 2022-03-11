# Differentiated vaccination policy methodology

***Differentiated methodology version 1.0 <br/>11 March 2022***

This methodology document is an addition to the core [index methodology](https://github.com/OxCGRT/covid-policy-tracker/blob/master/documentation/index_methodology.md) for the Oxford Covid-19 Government Response Tracker, and explains the key differences and considerations relevant to the experimental differentiated vaccination policy coding csv ([GitHub repo](https://github.com/OxCGRT/covid-policy-tracker), [university website](https://www.bsg.ox.ac.uk/covidtracker)). 

The Oxford Covid-19 Government Response Tracker ([GitHub repo](https://github.com/OxCGRT/covid-policy-tracker), [university website](https://www.bsg.ox.ac.uk/covidtracker)) tracks individual policy measures across 21 indicators, with 3 retired fiscal indicators and a miscellaneous notes field. We also calculate several indices to give an overall impression of government activity, and this page describes how these indices are calculated. Changes to this methodology are recorded in the [changelog](#index-methodology-changelog) below.

This experimental differentiated vaccination policy csv reports four different versions of each index:

|  | Government Response Index | Containment and Health Index | Stringency Index | 
| --- | --- | --- | --- | 
| Non-Vaccinated | GRI_Nonvax | CHI_Nonvax | SI_Nonvax | 
| Vaccinated | GRI_Vax | CHI_Vax | SI_Vax | 
| Average | GRI_Avg | CHI_Avg | SI_Avg | 
| Population-weighted average | GRI_WeightAvg | CHI_WeightAvg | SI_WeightAvg | 


The **non-vaccinated** value is the index value calculated based on policies that apply to non-vaccinated people. The **vaccinated** value is the index calculated from the policies that apply to vaccinated people. Where an certain indicator or policy area does not have a vaccine-differentiated approach, then the same value (the policy applying to everyone) is used in both indices. The **average** is the sum of the non-vaccinated and vaccinated divided by two. 

**The population-weighted average**  weights the index value using the non-vaccinated/vaccinated values based on the proportion of the population that are vaccinated with a complete initial protocol using the data from Our World in Data vaccination dataset's 'fullyvaccinatedperhundred' (with gaps filled) repository available here: https://ourworldindata.org/covid-vaccinations. This value is also published in the csv in a column labelled "Vaccinated (%)" column next to the cases/deaths columns.

**The population-weighted average** uses the following logic:

  - If no data available before or equal to date -> 0% vaccination is assumed
  - If no "fully_vaccinated_per_hundred" for a specific date -> pull forward the value from the last day it was present

There is also a new "M" (Majority) column for each of the ten indicators with differentiated policies. If >50% of the population are fully vaccinated, it contains the vaccinated value. If <50% or there is no vaccinated value, it contains the non-vaccinated/everyone value. This "M" column ensures a continuous series of data for these ten indicators.

The OxCGRT cannot guarantee the validity of data sourced externally.


Indices with 4 versions- Indicators C1,C2,C3,C4,C5,C6,C7,C8,H6, and H8 have differentiated policies

| Index name | _k_ | **C1** | **C2** | **C3** | **C4** | **C5** | **C6** | **C7** | **C8** | E1 | E2 | E3 | E4 | H1 | H2 | H3 | H4 | H5 | **H6** | H7 | **H8** | M1 |
| --- | ---: | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |--- |--- |--- |
| **Government response index** <br/>–Non vaccinated<br>–Vaccinated<br>–Average<br>–Population-weighted average | 16 | `x` | `x` | `x` | `x` | `x` | `x` | `x` | `x` | `x` | `x` | | | `x` | `x` | `x` | | | `x` | `x` | `x` | | | |
| **Containment and health index** <br/>–Non vaccinated<br>–Vaccinated<br>–Average<br>–Population-weighted average | 14 | `x` | `x` | `x` | `x` | `x` | `x` | `x` | `x` | | | | | `x` | `x` | `x` | | |`x` | `x` | `x` | | | |
| **Stringency index** <br/>–Non vaccinated<br>–Vaccinated<br>–Average<br>–Population-weighted average | 9 | `x` | `x` | `x` | `x` | `x` | `x` | `x` | `x` | | | | | `x` | | | | | | |


***Calculating sub-index scores for each indicator***
The methodology is exactly the same for this as in our existing methodology: https://github.com/OxCGRT/covid-policy-tracker/blob/master/documentation/index_methodology.md. For the 10 indicators with differentiated coding, 3 separate columns are published, for 'Everyone' (if no differentiation in place), and for the ‘Non-vaccinated, and the ‘Vaccinated’ values.

***Legacy stringency index***
This is NOT present in the differentiated vaccination coding csv. The legacy SI is however published in the main csvs [link].



