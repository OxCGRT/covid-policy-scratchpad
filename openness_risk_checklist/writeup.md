# Openness Risk Index 
#### Derived from the Oxford COVID-19 Government Response Tracker 

Since the outbreak of the COVID-19 pandemic, countries have used a wide array of closure and containment policies such as school and workplace closings, travel restrictions, and stay-at-home orders to try to break the chain of infection. They have also rapidly deployed test-trace-isolate procedures to seek to detect and isolate transmission as soon as possible. As the disease has spread around the world, these policies have waxed and waned in many jurisdictions. For example, some have rolled back ‘lockdown’ measures following a reduction in community transmission. Others are seeing a a rise and fall of containment measures as small outbreaks occur. And others still are seeing large surges and responding with agreesive containment policies.  As governments seek to calibrate policy to risk, how and when do they know it is safe to opennen up, and when must they instead close down?

The Oxford COVID-19 Government Response Tracker (OxCGRT) provides a cross-national overview of the risk and response of different countries as they tighten and relax physical distancing measures. The Openness Risk Index (ORI) is based on the recommendations set out by the World Health Organisation’s (WHO) of the measures that should be put in place before Covid-19 response policies can be safely relaxed. Considering that many countries have already started to lift measures, the ORI is a reviewed version of our previous ‘Lockdown rollback checklist’.

While the OxCGRT data cannot say precisely the risk faced by each country, it does provide for a rough comparison across nations. Even this “high level” view reveals that many countries are still facing considerable risks as they ease the stringency of policies.

## Methodology 

Computing risk of opening up isn't straightforward - there's a lot of heterogeniety between countries each of which face different sorts of risk. In April 2020, the WHO [outlined six categories](https://apps.who.int/iris/bitstream/handle/10665/331773/WHO-2019-nCoV-Adjusting_PH_measures-2020.1-eng.pdf) of measures governments need to have in place to diminish the risks of easing measures. For more detail on these, read [here](https://apps.who.int/iris/bitstream/handle/10665/331773/WHO-2019-nCoV-Adjusting_PH_measures-2020.1-eng.pdf). 

OxCGRT currently provides information relevant to three of these recommendations related to: 
* Health capacities and controlling the outbreak 
* Managing the risk of exporting and imported cases
* Community engagement and behaviour change

We combine this with:
* epidemiological data from the European Centre for Disease Control on cases and deaths, provided by [Our World in Data](https://ourworldindata.org/coronavirus), which address recommendation 1
* data collected by Our World in Data on the number of tests conducted in each country, which further addresses recommendation 2
* data from [Apple](https://www.apple.com/covid19/mobility) and [Google](https://www.google.com/covid19/mobility/) on travel and mobility, which further address recommendation 6

From this information, we construct an Openness Risk Index, defined below, which roughly describes the risk of not having closure and containment measures in place, in light of four of the six WHO recommendations. The data is made available in a time series, which makes it possible to see how risk has evolved over time, as the pandemic evolved.

### Brief Overview of the Index Calculation

| WHO Recommendation | Data Sources | Index Calculation | Formula |
|--------------------|:------------:|:-----------------:|:-------:|
| Transmission Controlled|<p>_No OxCGRT indicators_ <br /> <br /> Daily cases and Deaths <br /> (from European CDC via Our World in Data) </p>|  `cases controlled` <br />A metric between 0 and 1 based on new cases confirmed each day|  |
| Test / trace / isolate| <p> OxCGRT: H2 (testing policy) <br /> OxCGRT: H3 (contact tracing policy)<br /> <br />  Testing data from Our World in Data </p>| `test and trace` <br /> A metric between 0 and 1, half based on testing and contact tracing policy, and half based on the number of tests-per-case a country has conducted (does not measure isolation)|
| Manage risk of exporting and importing cases | OxCGRT: C8 (international travel restrictions) | `manage imported cases` <br /> A metric between 0 and 1 based on the stringency of the country’s restrictions on travel arrivals (does not measure risk of exporting cases)|
|Communities understanding and behaviour change|OxCGRT: H1 (public information campaigns) <br /><br />  Travel and mobility data from Apple and Google <br /><br />  Daily cases and deaths <br />(from European CDC via Our World in Data) |`community` <br />A metric between 0 and 1 based on whether a country has a public information campaign and the level of mobility reduction, weighted for current transmission risk.|

### Visualising the Openness Risk Index

![Detailed scatter latest](./graphs/new-score/detail_scatterSIroll_latest.png)

<!---[Scatter SI vs Rollback](/graphs/summary_scatterSIroll2020-06-28.png)--->

![Detailed scatter latest](./graphs/new-score/summary_scatterSIroll_latest.png)

## Line plots of Stringency Index and Openness Risk

![Lineplots of key countries](./graphs/new-score/lineplot_latest.png)

![Lineplots .gif](./temp/lineplot_fps2.gif)

## Heatmaps of rollback scores of countries over time 
#### East Asia and Pacific 
![Tile map East Asia Pacific](./graphs/new-score/tilemap_latest_East_Asia_Pacific.png)

#### Europe and Central Asia
![Tile map Europe Central Asia](./graphs/new-score/tilemap_latest_Europe_Central_Asia.png)

#### Latin America and Carribean
![Tile map LatAm Carribean](./graphs/new-score/tilemap_latest_Latin_America_Caribbean.png)

#### Middle East and North Africa
![Tile map MENA](./graphs/new-score/tilemap_latest_Middle_East_North_Africa.png)

#### North America
![Tile map N.America](./graphs/new-score/tilemap_latest_North_America.png)

#### South Asia
![Tile map South Asia](./graphs/new-score/tilemap_latest_South_Asia.png)

#### Sub-Saharan Africa
![Tile map Subsaharan Africa](./graphs/new-score/tilemap_latest_sub_Saharan_Africa.png)

### Tile maps of rollback scores of countries (latest)

![Chloropleth maps of rollback](./graphs/new-score/dailytilemap_latest.png)

### Chloropleth maps of rollback scores of countries over time

![Chloropleth maps of rollback](./graphs/new-score/chloropleth_latest.png)

