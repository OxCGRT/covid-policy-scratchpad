# Methodology behind calculation of Risk of Openness Index (RoOI)

#### Risk of Openness Index (RoOI) derived from the Oxford COVID-19 Government Response Tracker (OxCGRT)

_**Methodology version 1.0**_  
_**6th September, 2020**_

The index draws itself from a combination of OxCGRT indicators and data on COVID-19 testing and cases from verified sources. RoOI is a composed of four sub-indices, 
each of which provide the alignment of a relevant policy to the WHO recommendations. 

## Calculation

### Sub-indices

The four sub-indices are `cases controlled`, `test and trace`, `manage imported cases` and `community`. For more details about the relevance of the sub-indices to the WHO 
recommendations, refer to the working paper. 

The sub-indices are calculated as: 

1. `cases controlled`  

<img src="https://latex.codecogs.com/gif.latex?casescontrolled&space;=&space;\frac{50&space;-\Delta&space;cases_{t}}{50}" title="casescontrolled = \frac{50 -\Delta cases_{t}}{50}" />  

Here _Δcases_ is the rolling average of new daily cases from the last 7 days.

##### **`NA` Handling** 

Discontinuity in case data is resolved by a linear interpolation. `cases controlled` is automatically set to 0 if _Δcases_ ≥ 50. 
  
  
2. `test and trace`

<img src="https://latex.codecogs.com/gif.latex?testing&space;and&space;tracing&space;=&space;0.25(\frac{H2}{3})&space;&plus;&space;0.25(\frac{H3}{2})&space;&plus;&space;0.5(\frac{ln(tests)&space;-&space;ln(tests_{global\_min})}{ln(tests_{global\_max})&space;-&space;ln(tests_{global\_min})})" title="testing and tracing = 0.25(\frac{H2}{3}) + 0.25(\frac{H3}{2}) + 0.5(\frac{ln(tests) - ln(tests_{global\_min})}{ln(tests_{global\_max}) - ln(tests_{global\_min})})" />

Where:
*	H2 is the latest value of the testing policy indicator (H2) in OxCGRT database
*	H3 is the latest value of the contact tracing policy indicator (H3) in the OxCGRT database
*	<img src="https://latex.codecogs.com/gif.latex?ln(tests)" title="ln(tests)" /> is the natural logarithm of the number of tests-per-case conducted by that country
*	<img src="https://latex.codecogs.com/gif.latex?ln(tests_{global\_max/min})" title="ln(tests_{global\_max/min})" /> is the natural logarithm of the number tests-per-case conducted by the country that has conducted the most/least tests-per-case

##### **`NA` Handling**

If the Our World in Data team has not included a country in their testing database, the portion of the metric based on testing data is set to the global average* of `test and trace`.
If the Our World in Data team tried to include a country in their testing database but could not find publicly available numbers, the portion of the metric based on testing data is set to 0.

_*global average prior to imputation_

3. `manage imported cases`

<img src="https://latex.codecogs.com/gif.latex?manage\:imported\:cases&space;=&space;\left\{\begin{matrix}&space;0&space;&&space;if&space;&&space;C8&space;=&space;0&space;\\&space;0.25&space;&&space;if&space;&&space;C8&space;=&space;1\\&space;0.5&space;&&space;if&space;&&space;C8&space;=&space;2\\&space;1&space;&&space;if&space;&&space;C8&space;=&space;\{3,4\}&space;\end{matrix}\right." title="manage\:imported\:cases = \left\{\begin{matrix} 0 & if & C8 = 0 \\ 0.25 & if & C8 = 1\\ 0.5 & if & C8 = 2\\ 1 & if & C8 = \{3,4\} \end{matrix}\right." />

##### **`NA` Handling**
In certain cases, there may be gaps in OxCGRT indicator data. We perform a simple 'carryforward' operation to fill such gaps.

4. `community`  

<img src="https://latex.codecogs.com/gif.latex?community&space;=&space;0.5(casescontrolled)&space;&plus;&space;(1-0.5(casescontrolled))(\frac{120-mob}{100})" title="community = 0.5(casescontrolled) + (1-0.5(casescontrolled))(\frac{120-mob}{100})" />

Where
* _casescontrolled_ is the metric between 0 and 1 calculated in the first item above.
* _mob_ is the level of mobility as a percentage of pre-COVID baseline levels reported by Apple (average of all three reported mobility types) or Google (average of “retail and recreation”, “transit stations”, and “workplaces” mobility types).

##### **`NA` Handling**

**If a country does not have a national public information campaign (that is, the OxCGRT database reports H1≠2), then the entire metric is set to 0.**  
  
If a country has both Apple and Google mobility data, then _mob_ is set to whichever reports the greatest reduction in mobility.
If a country has neither Apple nor Google mobility, then this metric is left blank.

If _mob_ < 20 (that is: a reduction to less than 20% of pre-COVID levels), it is set to 20.  
If _mob_ > 120 (that is: mobility has increased to 120% of pre-COVD levels), it is set to 120.

### Unadjusted Index 
The unadjusted *Risk of Openness Index* for the country is calculated as:
 <br/><br/>
 <img src="https://latex.codecogs.com/gif.latex?RoOI_{unadjusted}&space;=&space;Mean(casescontrolled,&space;testingandtracing,manageimportedcases,community)" title="RoOI_{unadjusted} = Mean(casescontrolled, testingandtracing,manageimportedcases,community)" />  


### Endemic Factor

The endemic factor is calculated as:

<img src="https://latex.codecogs.com/gif.latex?EndemicFactor&space;=&space;\left\{\begin{matrix}&space;0&space;&&space;if&space;&&space;newcases\_per\_million&space;<&space;50\\&space;1&space;&&space;if&space;&&space;newcases\_per\_million&space;>&space;200\\&space;\frac{(newcases\_per\_million-50)}{150}&space;&&space;if&space;&&space;50&space;<&space;newcases\_per\_million&space;<&space;200&space;\end{matrix}\right." title="EndemicFactor = \left\{\begin{matrix} 0 & if & newcases-per-million < 50\\ 1 & if & newcases-per-million > 200\\ \frac{newcases-50}{150} & if & 50 < newcases-per-million < 200 \end{matrix}\right." />
 
### Final RoOI Index

The final *Risk of Openness Index* is calculated as:  

<img src="https://latex.codecogs.com/gif.latex?RoOI_{final}&space;=&space;EndemicFactor&space;&plus;&space;(1-EndemicFactor)(1-RoOI_{unadjusted})" title="RoOI_{final} = EndemicFactor + (1-EndemicFactor)(1-RoOI_{unadjusted})" /> 


For interpretation and explanation of the logic for any of these calculation, refer to the working paper. 

## Index Methodology Changelog 

* 06/09/2020 - Update RoOI index calculation including sub-indices, endemic factor, unadjusted and final RoOI Index.



