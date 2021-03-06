\name{trecase}
\alias{trecase}
\title{
  Total Read Count and Allele Specific Expression (trecase) model
}
\description{
  eQTL mapping using both Total Read Count (TReC) 
  and Allele Specific Expression (ASE).
}
\usage{
trecase(Y, Y1, Y2, X, Z, output.tag, p.cut, offset=NULL, 
      min.AS.reads=5, min.AS.sample=5, min.n.het=5, local.only=TRUE,  
      local.distance=200000, eChr=NULL, ePos=NULL, mChr=NULL, mPos=NULL, 
      converge=5e-5, convergeGLM=1e-8, scoreTestP=0.05, transTestP=0.05,
      trace=1, maxit=100)
}
\arguments{
  \item{Y}{ matrix of gene expression. 
    Each row corresponds to one sample and each column corresponds to one gene. 
  }
  
  \item{Y1}{ matrix of gene expression from one allele (haplotype). 
    Each row corresponds to one sample and each column corresponds to one gene. 
  }
  
  \item{Y2}{ matrix of gene expression from the other allele (haplotype). 
    Each row corresponds to one sample and each column corresponds to one gene. 
    Must be the same dimension as Y1.
  }

  \item{X}{ matrix of cofounding covariates. 
    Each row corresponds to one sample and each column corresponds to 
    one gene. Usually this include log(total reads per sample) 
    and PCs obtained from log transformed expression matrix.
  }
  
  \item{Z}{ matrix of phased genotype data, Each row corresponds to one sample 
    and each column corresponds to one SNP. Must take value of 0 (AA), 1 (AB), 
    3 (BA) or 4(BB), where A and B are two alleles of the SNP. AB and BA are 
    different since AB means the 1st/2nd haplotype harbors the A/B allele, 
    respectively, while BA means the 1st/2nd haplotype harbors the B/A allele, 
    respectively. 
  }
  
  \item{output.tag}{
    tag of output file. The actual output files will be tag_eqtl.txt and 
    tag_freq.txt.
  }
  
  \item{p.cut}{ p-value cut-off, only the associations with p-value smaller 
  	than p.cut are saved. 
  }
    
  \item{offset}{
    A vector of offset of each sample in the model log(mu) = offset + Xb.
  }
  
  \item{min.AS.reads, min.AS.sample}{ one gene will be considered for 
  allele-specific association analysis only if at least min.AS.sample samples
  have at least min.AS.reads allele-specific reads.
  }
  
  \item{min.n.het}{ an allele-specific eQTL will be evaluated only if the 
  at least min.n.het samples have heterozygous genotype at the query SNP. 
  }
  
  \item{local.only}{ whether examine local-eQTL only. }
  
  \item{local.distance}{ if the distance between a gene and a marker
   is smaller than local.distance, we call it a local eQTL. }
   
  \item{eChr}{ chromosomes of gene expression traits, must be
   a vector of integers, which means sex chromosomes (X, Y) need
   to be coded as numbers }
   
  \item{ePos}{ positions of gene expression traits, must be
   a vector of integers}
   
  \item{mChr}{ chromosomes of markers, must be a vector of integers,
   which means sex chromosomes (X, Y) need to be coded as numbers }
   
  \item{mPos}{ positions of markers, must be a vector of integers}
  
  \item{converge}{ convergence tolerance. The algorithm converges if 
  	changes of all the parameters are smaller than value. }
   
  \item{convergeGLM}{ convergence tolerance to be passed to function glmNB.}

  \item{scoreTestP}{ p-value cutoff for score test of the over-dispersion in 
  Poisson model. For each association regression, we first fit a Poisson 
  model, and move to negative binomial if the score test p-value smaller 
  than scoreTestP}

  \item{transTestP}{ p-value cutoff for the hypothesis testing of trans effect. 
    If p-value is smaller than transTestP, the eQTL is treated as trans-eQTL, 
    otherwise it is treated as cis-eQTL}

  \item{trace}{ If trace=0, do not output tracing information.  
  if trace = 1, output brief tracing information, and 
  if trace > 1. output detailed tracing information. }

  \item{maxit}{ maximum number of iterations of iterative 
  parameter estimate. It is also passed to glmNB to control 
  maximum iteration of IRLS. }
}
\details{
  Joint model of both total expression and allele-specific expression will 
  only be attempted if there are enough allele-specific reads in enough 
  samples, which are specified in parameters min.AS.reads, and min.AS.sample. 
}
\value{
 The function return 1 if no error occurs.
 The results are written into two output files: 
 one file (output.tag_eqtl.txt) stores the eQTL mapping result that
 pass the p-value threshold p.cut, including gene ID,
 marker ID, Negative Binomial over-dispersion for TReC part of the model, 
 Beta Binomial over-dispersion for ASE model, 
 Chi-square statistic and p-value for
 TReC model, ASE model, and Joint (TReCASE) model. 
 The column of pvalFinal equals to the TReC pvalue if 
 the eQTL is trans-eQTL by hypothesis testing, and 
 equals to the TReCASE p-value otherwise
 
 The other file (output.tag_freq.txt) includes a frequency table 
 of all the p-values for TReC model, ASE model and Joint model.
 
 A vector of 'yFailBaselineModel' will be returned from the function call. 
 This vector is only for debug purpose. 
 Each element indicating whether baseline model (without using any genetic 
 marker) is failed. It equals to 1 or 2 if only TReC model or only 
 ASE model is failed. It equals 0 if none of these two models fail 
 and 2 if both models are failed.   
}

\examples{
 data(KLK1)
 attach(KLK1)
 trecase(Y, Y1, Y2, X, Z, output.tag="testIt.txt", p.cut=0.05,
 	eChr=eChr, ePos=ePos, mChr=mChr, mPos=mPos)
}

\author{ Wei Sun weisun@email.unc.edu }
\keyword{ methods }

