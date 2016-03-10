#' script for validating data
#'
#' This function allows you go through various steps to cleanse the data
#' @keywords validate, verified
#' @export
#' @examples
#' validate()


validasi = function() 
{
    #prolog
    print("Selamat datang di script validasi data.")
    print("Silahkan pilih yang ingin anda lakukan :")
    print("1. pilih data untuk divalidasi")
    print("0. keluar")
    
    #choose file to work with
    choice = readline("Masukan kode angka yang tertera : ")
    
    if (choice == "1")
    {
        sourcefile = file.choose()
        separator = readline("Masukan character separator:")
        
        #load data as dataframe
        data = read.csv(sourcefile,
                        stringsAsFactors=F,
                        sep=separator)
        
        df = as.data.frame(data)
        
        print(summary(data))
    }
    else
    {
        return()
    }
    
    while(TRUE)
    {
        print("Silahkan pilih yang ingin anda lakukan selanjutnya:")
        print("1. hapus separator ribuan")
        print("2. hilangkan kolom")
        print("3. ubah type data")
        print("4. bersihkan nilai kosong")
        print("9. lihat data")
        print("10. lihat rangkuman data")
        print("0. keluar")
        choice = readline("Masukan kode angka yang tertera : ")
        
        
        #remove thousand separator
        if (choice == "1")
        {
            print(colnames(df))
            col = readline("Masukan nama kolom : ")
            df = removeSeparator_df(df, col)
            print(head(df[,col]))
            
        }
        else if(choice == "2")
        {
            #drop column
            print("Nama kolom yang ada pada data ini :")
            print(colnames(df))
            choice = readline("Masukan nama kolom yang ingin anda hapus : ")
            print(summary(df[,choice]))
            df[,choice] = NULL
            
        }
        else if(choice == "")
        {
            #change typof
            print("Nama dan tipe data setiap kolom pada data ini :")
            print(lapply(df,typeof))
            choice = readline("Masukan nama kolom yang ingin ubah tipenya : ")
            print(typeof(df[,choice]))
            newDataType = readline("Ubah menjadi text atau numerik : ")
            
            print(summary(df[,choice]))
            df[,choice] = NULL
            
        }
        else if(choice == "4")
        {
            #set null values
            df[df == ""] = NA
            df[df == "-"] = NA
        }
        else if(choice == "9")
        {
            View(df)
        }
        else if(choice == "0")
        {
            return(df)
        }
        
    }
    
    
kosong = function(){}
    
}

