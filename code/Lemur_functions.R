## Set of functions needed for lemur tooth & tree analysis

#Function that combines momocs objects
c.Coo <- function(..., recursive=FALSE){
  args <- list(...)
  res <- args[[1]] 
  res$coo <- do.call(c, lapply(args, function(x) c(x$coo)))
  res$ldk <- do.call(c, lapply(args, function(x) c(x$ldk)))
  # res$fac <- do.call(c, lapply(args, function(x) c(x$fac)))
  
  res$fac <- do.call(rbind, lapply(args, function(x) x$fac))
  res
}


#This is stupid but momocs and dplyr both have filter functions and this ugly code will let those work at the same time
filter_.default <- function(.data, ..., .dots) {
  fargs <- formals(Momocs::filter)
  dnames <- names(.dots)
  pos.args <- lapply(.dots[nchar(dnames) == 0], identity)
  named.args <- lapply(.dots[dnames %in% names(fargs)], identity)
  call.args <- lapply(c(pos.args, named.args), lazyeval::lazy_eval)
  do.call(Momocs::filter, c(list(.data), call.args))
}


#Function to get the mean/PC axis for objects molx, LRx, LLx, URx ,ULx across species
getMean<-function(targets,PC_object,axis_column=2)
{
  means<-matrix(nrow=length(targets))
  for (i in 1:length(targets))
  {
    get<-targets[i] 
    print(get)
    taxon<-PC_object[which(PC_object$Species_name%in%get),] 
    means[i,]<-mean(taxon[,axis_column])
    print(means[i,])
  }
  row.names(means)<-targets
  return(means)
}


# Function to make a tree ultrametric
## the main driver code (n = number of tips):
force.ultrametric<-function(tree,method=c("nnls","extend")){
  method<-method[1]
  if(method=="nnls") tree<-nnls.tree(cophenetic(tree),tree,
                                     rooted=TRUE,trace=0)
  else if(method=="extend"){
    h<-diag(vcv(tree))
    d<-max(h)-h
    ii<-sapply(1:Ntip(tree),function(x,y) which(y==x),
               y=tree$edge[,2])
    tree$edge.length[ii]<-tree$edge.length[ii]+d
  } else 
    cat("method not recognized: returning input tree\n\n")
  tree
}

