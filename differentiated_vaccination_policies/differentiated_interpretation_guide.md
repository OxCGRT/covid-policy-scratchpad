# OxCGRT Differentiated Vaccination Policy Coding Interpretation Guide
***Version 1.0 <br/>Date: 11 March 2022***

This interpretation guide is an addition to the core [coding interpretation guide](https://github.com/OxCGRT/covid-policy-tracker/blob/master/documentation/interpretation_guide.md) for the Oxford Covid-19 Government Response Tracker, and explains the key differences and considerations relevant to the experimental differentiated vaccination policy coding csv ([GitHub repo](https://github.com/OxCGRT/covid-policy-tracker), [university website](https://www.bsg.ox.ac.uk/covidtracker)). 

Updates to this coding interpretation are recorded in the [changelog](#differentiated_interpretation_guide-changelog) below.

## General differentiated vaccination policy coding guidance

- For each indicator, we record the most stringent policy in place anywhere in the country/region/territory.
- For indicators that could have differentiation based on vaccination status: 
  - If there is no policy differentiation related to vaccination status, we just record one policy which applies to everyone
  - If there are different policies for people based on vaccination status, we record:
      - ‘Non-vaccinated’ - the policy for people without a vaccination
      - ‘Vaccinated’- the policy for people with a vaccination

- If our data reports a single policy for everyone, where there was previously differentiation, this may represent either the end of policy differentiation, or it could represent a targeted lockdown in a single place applying to both non-vaccinated and vaccinated people, while the rest of the country maintains policy differentiation by vaccination status at a lower level of stringency
- We record a differentiated policy when someone is able to access different freedoms within a jurisdiction based on their vaccination status (e.g. access to events). 
- We do not record how this is enforced, or make judgements about whether the rules are being implemented effectively. 
- There does not need to be a vaccine “pass”  in place for us to record a differentiated policy. Some jurisdictions have vaccine passes of different kinds (eg. paper, digital certificate, sign-in app) but some countries do not actively enforce their vaccine requirements. We simply record the level of restrictions granted through being vaccinated in that place. If countries distinguish between one, two, three or more vaccinations and there are different vaccination related freedoms granted based on the number of doses, we code the freedoms given for the highest number of doses.
- We accept each jurisdictions’ decision on which vaccine brand, or number of doses makes vaccinated people eligible for less restrictive policies, following an ‘as defined locally’ logic
- We record in the notes if vaccination freedoms are granted for less than the full course of doses for each vaccine brand
- If vaccinated people are also required to present a negative PCR test, we code this as a closure (2 or 3) to vaccinated people, to reflect the stringency of this measure. We record policies in both the non-vaccinated, and vaccinated columns here, to reflect the existence of two different policies for each group.

### C1 - School Closures

- We record C1 as a closure if students are required to be vaccinated
- If teachers/education staff are required to be vaccinated we do not code C1 as a closure, but record this as a mandatory vaccination in V4

###  C2- Workplace closing

- Here we only code a closure if attendees are required to provide proof of vaccination to enter, not staff
- If staff are required to be vaccinated we code this as an occupational vaccine mandate in V4

### C3- Cancel Public Events

- Here we only code a closure if attendees are required to provide proof of vaccination to enter, not staff
- If staff are required to be vaccinated we code this as an occupational vaccine mandate in V4

### C4- Restrictions on gatherings

- We record C4 as a closure if there are restrictions on gathering size based on vaccination status

### C5- Public Transportation

- Here we only code a closure if passengers are required to provide proof of vaccination to enter, not staff
- If staff are required to be vaccinated we code this as a requirement to be vaccinated due to occupation in V4

### C6- Stay at home requirements

- We record C6 as a closure if non-vaccinated people are required to stay at home

### C8-  International Travel Controls

- If visitors can get a PCR test to avoid quarantine we record this as a 1- screening. If quarantine is mandatory, and visitors cannot do a test to avoid this, we code a 2. 
- If vaccinated people do not have to quarantine- we code this as a 1, and if non vaccinated can ‘test out’ of quarantine, we also code this as a 1. This is the one exception to the logic described elsewhere. If non-vaccinated people must present evidence of a test to arrive in a country, this is therefore a 1. If they must present a test and also quarantine, this is coded as a 2.
- If non-vaccinated people cannot enter from any country at all, we code this as a 4, total closure to non-vaccinated 
- If non-vaccinated people are banned from some countries, we code this as a 3
- If non-vaccinated nationals are allowed to enter the country, we do not consider this in the coding. This is in line with the interpretation guidance which states that we do not consider the repatriation of nationals when considering border closures. 
- If vaccination status is still used to approve vaccinated people's arrival and exempt them from quarantine, this is still a form of screening, and is coded as a 1. We only code this as a 0 if vaccination status is not factored in and there is no kind of screening in place at all (equivalent to pre-covid times), and non-vaccinated and vaccinated people are subject to the same policies.

### H8-  Protection of elderly people

- We code a closure for non-vaccinated if visitors are required to be vaccinated or present a Covid-19 pass.
- If staff are required to be vaccinated we code this as an occupational vaccine mandate in V4

## Indicator specific examples- vaccine focus

| ID | Name | Non-vaccinated | Explanation | Vaccinated | Explanation |
| --- | --- | --- | --- | --- | --- |
| C1 | `C1_School closing` | 0 | Teachers required to have a vaccine | 0 | No significant changes compared to pre-COVID times for vaccinated attendees |
| C1 | `C1_School closing` | 2 or 3 | Students required to have a vaccine | 0 | No significant changes compared to pre-COVID times for vaccinated attendees |
| C2 | `C2_Workplace closures` | 2 | Vaccines required to enter nightclubs. No exceptions | 0 | Vaccinated people can enter nightclubs |
| C3 | `C3_Public events` | 2 | Vaccines required to enter large concerts and sporting events. No exceptions | 0 | Vaccinated people can attend with no restrictions |
| C4 | `C4_Restrictions on gatherings` | 4 | Non vaccinated people can only meet in groups of up to 9 | 0 | Vaccinated people have no restrictions on group size |
| C5 | `C5_Public transport` | 2 | Vaccination required to travel on any train. Non vaccinated turned away | 0 | Vaccinated people can travel on trains and all public transport without restriction, with proof of vaccination status |
| C6 | `C6_Stay at home requirements` | 2 | Austria requires non vaccinated people to stay at home | 0 | Vaccinated people do not have to stay at home |
| C7 | `C7_Restrictions on internal movement` | 2 | People must provide evidence of vaccination to travel within country to different regions | 0 | Vaccinated people can move freely between regions |
| C8 | `C8_International travel controls` | 4 | Non-vaccinated people cannot enter the country  | 3 | Vaccinated people can enter, but some bans on entry to all remain from specific countries |
| H6 | `H6_Facial Coverings` | 4 | Non-vaccinated people must wear masks at all times  | 0 | Vaccinated people do not have to wear masks |
| H8 | `H6_Facial Coverings` | 3 | All visitors must be vaccinated to enter elderly care homes  | 1 | Vaccinated visitors can enter elderly care homes, subject to significant operational changes compared to pre COVID-19 times |

## Indicator specific examples- PCR test focus

| ID | Name | Non-vaccinated | Explanation | Vaccinated | Explanation |
| --- | --- | --- | --- | --- | --- |
| C1 | `C1_School closing` | 2 | Students can enter schools with a COVID-19 pass showing negative PCR test or evidence of prior infection | 0 | Students can enter schools with a COVID-19 pass showing vaccination status. No significant operational changes besides this |
| C2 | `C2_Workplace closures` | 2 | Patrons must present a negative test OR a vaccine to enter nightclubs | 0 | Vaccinated people can enter nightclubs |
| C4 | `C4_Restrictions on gatherings` | 4 | Non-vaccinated must have a negative PCR test to attend a funeral of more than 10 people | 0 | Vaccinated people don’t have any restrictions on gatherings |
| C5 | `C5_Public transport` | 2 | Non-vaccinated need a COVID-19 pass with negative PCR test to travel on buses | 1 | Vaccinated people can get on buses without testing requirements, subject to reduced capacity |
| C7 | `C7_Restrictions on internal movement` | 2 | Non-vaccinated must present a negative PCR test to travel to different regions.  | 0 | Vaccinated don’t need to present PCR test to travel to different regions |


## Differentiated Interpretation guide changelog
- 08 March 2022: v1.0 created the differentiated interpretation guide
