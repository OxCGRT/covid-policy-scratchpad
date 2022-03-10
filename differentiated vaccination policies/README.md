# Differentiated vaccination policies

***OxCGRT 11 March 2022***

This folder contains our experimental demo csv with differentiated coding based on vaccination status. The dataset begins on 1 January 2022. Information on differentiated policies on vaccinated and unvaccinated people is still being collected for 2021. 

This dataset is incomplete, however will be integrated into our main dataset once we are finished building it. This dataset is incomplete, however will be integrated into our main dataset once we are finished building it. If you build scripts relying upon it please be aware it is temporary, and will change format and location in the coming months. Sign up to our technical mailing list here for details of this csv structure, and release notes: http://eepurl.com/hiMsdL.

10 indicators have differentiated policies available – C1-C8, H6 and H8. If there is no differentiation, values are reported in an `everyone` variable. If there are differentiated policies based on vaccination status, then the `everyone` variable remains empty, and instead values are reported as  `non-vaccinated` and `vaccinated` variables. 

For the Government Response Index, Containment and Health Index, and Stringency Index, there are four versions: `Non-vaccinated Index`, `Vaccinated Index`, `Average Index`, and `Population-weighted average` (based on the proportion of the population vaccinated). If there is no differentiation in a policy, then the same `everyone` value is used for all indices. The `Average Index` is calculated from the ‘Non vaccinated’ + ‘Vaccinated’, divided by two. Population weighted average weights the index value using the proportion of the population that are vaccinated with a complete initial vaccination protocol using the data from Our World in Data: https://ourworldindata.org/covid-vaccinations.

Access the codebook and methodology for the differentiated vaccination policy data here.

This csv does not publish the legacy Stringency Index like the main Github repo. 

As per our main repo, the data are regularly reviewed, and are subject to change. We therefore recommend downloading the most recent data and stating the date of download if using the data in research or publications.


If you have feedback on this csv please submit an entry to this form: https://forms.office.com/Pages/ResponsePage.aspx?id=G96VzPWXk0-0uv5ouFLPkVSWvw_jDgZKm4LZGz53kfBUME9NOUtYRkxLVldLUVFERTRTMEJSRkZITCQlQCN0PWcu
