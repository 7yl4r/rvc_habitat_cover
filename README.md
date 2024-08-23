* download data into `data/01_raw` from [NOAA](https://grunt.sefsc.noaa.gov/rvc_analysis20/samples/index).
  * note: a loop of `wget` requests can be made to reduce human clickwork here.
    * url example: `https://grunt.sefsc.noaa.gov/rvc_analysis20/samples?utf8=%E2%9C%93&region=DRY+TORT&year=2016&format=csv&commit=Download`
    * url fmt_str: `https://grunt.sefsc.noaa.gov/rvc_analysis20/samples?utf8=%E2%9C%93&region=${AOI}&year=${YEAR}&format=csv&commit=Download`
    * use bash file `dl_data.sh` at your own risk
* `quarto render`
* `.csv` files will be created in `data/02_reduced` for each region