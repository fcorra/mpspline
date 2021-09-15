# mpsplines
## An R Package to Estimate Global Area Splines form aqp SoilProfileCollection

As I mention in the DESCRIPTION file, The Global Soil Information Facilities (GSIF) 
package is not longer available at CRAN as PROJ8 does not have the proj\_api.h header.
However, we needed a function to calculate the equal-area splines in our work
for FAO. Therefore, we adapted the function mpsplines, wrapping it inside its
own package to work with it without the burden of PROJ8. **All thanks should go to
GSIF authors**, Tomislav Hengl, Gerard Heuvelink, and Brendan Malone.

*Why didn't we work with an archived version of GSIF?*

Because we wanted that all parts of our workflow to work with current versions of R.
