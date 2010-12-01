\name{computeScaleCurve}
\alias{computeScaleCurve}
\title{ Computation and Representation of the Scale Curve }
\description{ 
  \code{computeScaleCurve} computes the scale curve of a given group, based on the MBD, at a given value p as the area of the band delimited by the [np] most central observations, where [np] is the largest integer smaller than np.
}

\value{
computeScaleCurve plots the scale curve of the active data set, which can contain a single group or several. In the latter case, a vector of labels can be provided to compute the scale curve for each group. The Y-coordinates used in the plot, i.e., the scale curve values at each point p can be stored as a vector, if only one group is present, or as a list, if there are several groups.
}

\details{The scale curve measures the increase in the area of the band determined by the fraction p most central curves, where p moves from 0 to 1, thus providing a measure of the sample dispersion. If the data set is represented in parallel coordinates, then the area is computed using the trapezoid formula.}

\author{ Sara Lopez-Pintado \email{sl2929@columbia.edu} and 

Aurora Torrente \email{etorrent@est-econ.uc3m.es}}
\references{
Lopez-Pintado, S. \emph{et al.} (2010). Robust depth-based tools for the analysis of gene expression data. \emph{Biostatistics}, 11 (2), 254-264.
}
\seealso{computeMBD}
\keyword{ multivariate }
