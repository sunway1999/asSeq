\name{pileupBAM}
\alias{pileupBAM}
\title{
obtain pile up file from a bam file
}
\description{
This function is used to illustrate the RNAs-seq distribution. 
}
\usage{
pileupBAM(input, output, maxsize = 1e+06)
}
\arguments{
  \item{input}{
  an input bam file. This should be a small subset of a bam file that cover a 
  specific region of the genome. It can be generated by samtools view. 
}
  \item{output}{
  the output pile up file, which is of bed format. 
}
  \item{maxsize}{
  the maximum length of genomic region to be used for pile up.
}
}

\value{
  the results will be written into an output file. 
}

\author{ Vasyl Zhabotynsky}
\keyword{ utilities }
