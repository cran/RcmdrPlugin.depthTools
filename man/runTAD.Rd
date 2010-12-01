\name{runTAD}
\alias{runTAD}
\title{Weighted Trimmed Mean Distance Classification Method }
\description{Implementation of the classification technique based on assigning each observation to the group that minimizes the trimmed average distance of the given observation to the deepest points of each group in the learning set, weighted by the depth of these points in their own group. 
}

\details{The user can choose the learning and test sets, as well as the labels corresponding to the learning set. The TAD method classifies a given observation \code{x} into one of \code{g} groups, of sizes \code{n1,...,ng}, but taking into account only the \code{m=min\{n1,...,ng\}} deepest elements of each group in the learning set. Additionally, this number can be reduced in a proportion \code{alpha}. The distance of \code{x} to these \code{m} elements is averaged and weighted with the depth of each element with respect to its own group. The predicted labels can be stored as a vector.
}

\author{ Sara Lopez-Pintado \email{sl2929@columbia.edu} and 

Aurora Torrente \email{etorrent@est-econ.uc3m.es}}
\references{
Lopez-Pintado, S. \emph{et al.} (2010). Robust depth-based tools for the analysis of gene expression data. \emph{Biostatistics}, 11 (2), 254-264.
}
\seealso{computeTmean, runDS}

\keyword{ multivariate }
