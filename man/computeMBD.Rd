\name{computeMBD}
\alias{computeMBD}
\title{ Computation of the Modified Band Depth in R-commander }
\description{ 
  \code{computeMBD} computes the Modified Band Depth of a sample, the active data set, either with respect to the same data set or a different one. 
}


\details{The MBD of the active data set (a matrix or data-frame) is computed with respect to the chosen reference data set. The rows of the matrices correspond to genes, and the columns to experimental conditions. The user can decide wether plotting a graph to enhance the deepest point against the rest of samples, or to show the MBD values according to some color palette, representing the genes in parallel coordinates. Alternatively, given percentages of most central curves can be used to display bands of curves, instead of the individual curves. The appearance of the plot can be adjusted with the Graphical options button. In addition, the outputs to be stored, i.e., the depth value of each data point and its position from centre outwards, can be selected with the corresponding button.
}

\author{ Sara Lopez-Pintado \email{sl2929@columbia.edu} and 

Aurora Torrente \email{etorrent@est-econ.uc3m.es}}


\keyword{ multivariate }
