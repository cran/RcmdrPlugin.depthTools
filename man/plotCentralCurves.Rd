\name{plotCentralCurves}
\alias{plotCentralCurves}
\title{Plot of the p Percent Most Central Curves of a Dataset }
\description{The function \code{plotCentralCurves} distinctly plots the p % most central observations in the dataset and the remaining most external ones, according to the modified band depth, MBD.
}

\details{The rows of active data set, corresponding to genes, are ordered from center outwards, according to MBD. Then the [np/100] most central observations, where [x] is the largest integer smaller than x, and the remaining most external ones are plotted distinctly. The user can select the proportion of central curves points that are enhanced, and also assign a color palette to the most central ones to facilitate the understanding of the data structure.
}
\author{ Sara Lopez-Pintado \email{sl2929@columbia.edu} and 
Aurora Torrente \email{etorrent@est-econ.uc3m.es}
}
\seealso{computeMBD, computeTmean, computeScaleCurve
}
\examples{
data(prostate, package="depthTools")
prostate <- as.data.frame(prostate)
centralPlot(prostate, p = 0.5, col.c = '#ff0000',  col.e = '#C0C0C0' , lty=c(1,3) , 
   gradient = FALSE, gradient.ramp = c('#ff0000', '#ffd700'))
}

\keyword{ multivariate depth }
