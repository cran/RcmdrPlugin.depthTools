\name{plotCentralCurves}
\alias{plotCentralCurves}
\title{Plot of the p Percent Most Central Curves of a Dataset }
\description{The function \code{plotCentralCurves} distinctly plots the p % most central observations in the dataset and the remaining most external ones, according to the modified band depth, MBD.
}

\details{The rows of active data set, corresponding to genes, are ordered from center outwards, according to MBD. Then the [np/100] most central observations, where [x] is the largest integer smaller than x, and the remaining most external ones are plotted distinctly. The user can select the proportion of central curves points that are enhanced.
}
\author{ Sara Lopez-Pintado \email{sl2929@columbia.edu} and 
Aurora Torrente \email{etorrent@est-econ.uc3m.es}}
\seealso{computeMBD, computeTmean, computeScaleCurve}

\keyword{ multivariate, depth }
