\name{runDS}
\alias{runDS}
\title{Distance to the Trimmed Mean Classification Method }
\description{Implementation of the classification technique based on assigning each observation to the group that minimizes the distance of the observation to the trimmed mean of the group.
}

\details{The user can choose the learning and test sets, as well as the labels corresponding to the learning set. The DS method proceeds by first computing the \code{alpha} trimmed mean corresponding to each group from the learning set, then computing the distance from a new observation to each trimmed mean. The new sample will then be assigned to the group that minimizes such distance. At the moment, only the Euclidean distance is implemented. The predicted labels can be stored as a vector.
}
\author{ Sara Lopez-Pintado \email{sl2929@columbia.edu} and 

Aurora Torrente \email{etorrent@est-econ.uc3m.es}}
\references{
Lopez-Pintado, S. \emph{et al.} (2010). Robust depth-based tools for the analysis of gene expression data. \emph{Biostatistics}, 11 (2), 254-264.
}
\seealso{computeTmean, runTAD}

\keyword{ multivariate }
