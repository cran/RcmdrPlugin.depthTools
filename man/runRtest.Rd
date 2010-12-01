\name{runRtest}
\alias{runRtest}
\title{Rank Test Based on the Modified Band Depth }
\description{ 
  \code{runRtest} performs the rank test based on the MBD to decide whether two samples come from a single parent distribution. 
}

\details{Given a population P from which a sample of \code{n} vectors is drawn, and another population P' from which a second sample of \code{m} vectors is obtained, assume there is a third reference sample (from the same population as the largest sample), whose size is also larger than \code{n} and \code{m}. The user selects the data sets containing the samples from both populations to be tested and the number of elements \code{n} and \code{m} to be included in each sample. \code{runRtest} identifies the largest sample as the one to be split into test and reference samples and verifies whether there are enough observations to run the test. Then, the proportions R and R' of elements from the reference sample whose depths are less or equal than those from the other samples, relative to the reference one, respectively, are computed and ordered from smallest to highest, giving them a rank from 1 to \code{n+m}. The statistic sum of the ranks of values R' (from the second population) has the distribution of a sum of m elements randomly drawn from 1 to \code{n+m} without replacement. The output is a list containing the p-value of the rank test and the test statistic value.}

\author{ Sara Lopez-Pintado \email{sl2929@columbia.edu} and 

Aurora Torrente \email{etorrent@est-econ.uc3m.es}}
\references{
Lopez-Pintado, S. \emph{et al.} (2010). Robust depth-based tools for the analysis of gene expression data. \emph{Biostatistics}, 11 (2), 254-264.
}

\seealso{computeTmean}

\keyword{ multivariate }
