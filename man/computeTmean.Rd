\name{computeTmean}
\alias{computeTmean}
\title{ Modified Band Depth-Based Alpha Trimmed Mean }
\description{ 
  \code{computeTmean} computes the mean of the deepest observations within the sample, their depths given by the Modified Band Depth, trimming out the proportion \code{alpha} of the outest observations. 
}

\details{The rows of active data set, corresponding to genes, are ordered from center outward, that is, starting with the deepest one(s) and ending with the less deep one(s), according to MBD. The alpha-trimmed mean is computed by first removing the proportion \code{alpha} of less deep points, and then computing the component-wise average of the remaining observations. 
The user can select the proportion of external points that are trimmed out and decide whether plotting the data set in parallel coordinates along with the trimmed mean. In addition, the plot can show the usual mean and the data points used to compute the trimmed mean.}
\author{ Sara Lopez-Pintado \email{sl2929@columbia.edu} and 

Aurora Torrente \email{etorrent@est-econ.uc3m.es}}

\seealso{computeMBD}

\keyword{ multivariate }
