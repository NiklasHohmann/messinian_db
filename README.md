# messinian_db

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10782803.svg)](https://doi.org/10.5281/zenodo.10782803)

Supplementary code for _"A revised marine fossil record of the Mediterranean before and after the Messinian Salinity Crisis"_ (Agiadi et al 2024, [DOI: 10.5194/essd-2024-75](https://doi.org/10.5194/essd-2024-75)). Generates summary statistics, figures, and maps.

Project webpage: [REMARE project](https://sites.google.com/view/kagiadi/projects/remare)

## Authors

__Niklas Hohmann__  (maintainer, contributor)  
Utrecht University  
email: n.h.hohmann [at] uu.nl  
Web page: [www.uu.nl/staff/NHohmann](https://www.uu.nl/staff/NHHohmann)  
ORCID: [0000-0003-1559-1838](https://orcid.org/0000-0003-1559-1838)

__Daniel García-Castellanos__ (contributor)  
Geociencias Barcelona  
email: danielgc [at] geo3bcn.csic.es  
Web page: [digital.csic.es/cris/rp/rp07103](https://digital.csic.es/cris/rp/rp07103)  
ORCID: [0000-0001-8454-8572](https://orcid.org/0000-0001-8454-8572)

__Konstantina Agiadi__ (principal investigator, contributor)  
University of Vienna  
email: konstantina.agiadi [at] univie.ac.at  
Web page: [sites.google.com/view/kagiadi](https://sites.google.com/view/kagiadi)  
ORCID: [0000-0001-8073-559X](https://orcid.org/0000-0001-8073-559X)  

## License

Apache 2.0, see LICENSE file for full text.

## Requirements

Base R (version >= 4.0) and the RStudio IDE.

## Reproduction

In the RStudio IDE, open the file _messinian_db.Rproj_. This opens the RProject of the same name, and should automatically install the `renv` package (if not already installed). First, run

```R
renv::restore()
```

to install all required packages and their dependencies. Then run

```R
source("code/download_data.R")
````

to download the latest version of the database from Zenodo. Then, run

```R
source("code/make_table_and_plots.R")
```

in the console to produce the summary statistics of the database (stored in the variable `table`). You can view the values by running

```R
table
```

in the console, and inspect the figures in `figs/`. Details on producing the map are given in the file `code/make_maps.R`.

## Repository structure  

* _code_ : folder with R code
  * _make_table_and_plots.R_ : script to generate table 1 and figures
  * _make_maps.R_ : script to generate the maps
  * _download_data.R_ : script to download data from Zenodo
* _data_ : folder for raw data. Initially empty, will be filled with downloaded data after the script in `code/download_data` is run.
* _figs_ : folder for figures. Initially empty
* _renv_ : folder used by the `renv` package
* _.gitignore_ : untracked files
* _.Rprofile_ : session info
* _messinian_db.Rproj_ : RProject file
* _README_ : README file
* _renv.lock_ : lock file for `renv` package

## References

This repository downloads and uses data from

* Agiadi, K., Hohmann, N., Gliozzi, E., Thivaiou, D., Francesca, B., Taviani, M., Bianucci, G., Collareta, A., Londeix, L., Faranda, C., Bulian, F., Koskeridou, E., Lozar, F., Mancini, A. M., Dominici, S., Moissette, P., Bajo Campos, I., Borghi, E., Iliopoulos, G., … Garcia-Castellanos, D. (2024). Revised marine fossil record of the Mediterranean before and after the Messinian Salinity Crisis [Data set]. Zenodo. https://doi.org/10.5281/zenodo.13358435


## Funding

This work was supported by the Austrian Science Fund (FWF) project “Late Miocene Mediterranean Marine Ecosystem Crisis” (2022–2026), Project no. V 986, [DOI 10.55776/V986](https://www.doi.org/10.55776/V986) (PI: K.Agiadi). 
