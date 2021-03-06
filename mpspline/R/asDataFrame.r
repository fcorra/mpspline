.as.data.frame.SoilProfileCollection <- 
  function(x, 
           row.names = NULL, 
           optional = FALSE, ...)
  {
  
    ## derive layer sequence:
    s1 <- unlist(by(x@horizons[,x@depthcols[1]], x@horizons[,paste(x@idcol)], order))
    s2 <- unlist(by(x@horizons[,x@depthcols[2]], x@horizons[,paste(x@idcol)], order))
    HONU <- ifelse(s1==s2 & !x@horizons[,x@depthcols[1]]==x@horizons[,x@depthcols[2]], s1, NA) 
    
    ## Put all horizon in the same row:
    HOR.list <- as.list(rep(NA, summary(HONU)[[6]]))  ## highest number of layers
    for(j in 1:length(HOR.list)){
      HOR.list[[j]] <- subset(x@horizons, HONU==j)
      sel <- !{names(HOR.list[[j]]) %in% paste(x@idcol)}
      ## rename variables using a sufix e.g. "_A", "_B" etc:
      names(HOR.list[[j]])[sel] <- paste(names(HOR.list[[j]])[sel], "_", LETTERS[j], sep="")
    }
    
    ## Merge all tables (per horizon):
    HOR.list.m <- as.list(rep(NA, length(HOR.list)))
    for(j in 1:length(HOR.list)){
      sid <- data.frame(x@site[,paste(x@idcol)])
      names(sid) <- paste(x@idcol)
      HOR.list.m[[j]] <- merge(sid, HOR.list[[j]], all.x=TRUE, by=paste(x@idcol))
    }   
    
    ## Merge all horizon tables to one single table:
    tmp <- do.call(cbind, HOR.list.m)
    
    sel <- which(names(tmp) %in% paste(x@idcol))[-1] ## delete copies of IDs:
    tmp2 <- cbind(sp::coordinates(x@sp), x@site)
    fdb <- merge(tmp2, tmp[,-sel], all.x=TRUE, by=paste(x@idcol), ...)
    if(optional==TRUE){
      row.names(fdb) <- row.names
    }
    
    return(fdb)
    
  }

setMethod(
  'as.data.frame', 
  signature(x = "SoilProfileCollection"), 
  .as.data.frame.SoilProfileCollection)
