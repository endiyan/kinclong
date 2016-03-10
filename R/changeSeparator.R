#remove thousands separator xxx.xxx,xx
removeSeparator = function(file, 
                           separator=",",
                           colname)
{
    
    #sample data
    #file="Downloads//BELANJA-URUSAN-PER-SKPD-2014-PER-REKENING.csv"
    #separator=";"
    #colname="ANGGARAN"
    
    #load as data frame
    data = read.csv(file,
                    stringsAsFactors=F,
                    sep=separator)
    df = as.data.frame(data)
    
    #remove separator
    df[[colname]] = lapply(df[,colname], function(x) gsub("[^a-zA-Z0-9_][0-9]{0,2}$", "", x)) #something with lapply wrong here
    df[[colname]] = lapply(df[,colname], function(x) gsub("[,.]", "", x))
    df[[colname]] = as.numeric(df[,colname])

    #write.csv(df, file="out.csv", row.names=F)
    return(df)
}
    

removeSeparator_df = function(df,
                              colname)
{
    #remove separator
    df[[colname]] = lapply(df[,colname], function(x) gsub("[^a-zA-Z0-9_][0-9]{0,2}$", "", x)) #something with lapply wrong here
    df[[colname]] = lapply(df[,colname], function(x) gsub("[,.]", "", x))
    df[[colname]] = as.numeric(df[,colname])
    
    return(df)
}






