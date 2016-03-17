#' script for validating dframe
#'
#' This function allows you go through various steps to cleanse the dframe
#' @keywords validate, verified
#' @export
#' @examples
#' validate()


validasi = function() 
{
    #prolog
    print("Selamat datang di script validasi data")
    print("Silahkan pilih yang ingin anda lakukan :")
    print("1. pilih data untuk divalidasi")
    print("0. keluar")
    
    #choose file to work with
    choice = readline("Masukan kode angka yang tertera : ")
    
    if (choice == "1")
    {
        dframe = fread(file.choose(), data.table = F)
        print(summary(dframe))
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
        print("5. trim whitespaces")
        print("6. to lower case")
        print("9. lihat data")
        print("10. lihat rangkuman data")
        #print("10. hilangkan kolom kosong")
        #print("10. hilangkan baris kosong")
        #print("10. seragamkan penulisan kelurahan")
        #print("10. seragamkan penulisan kecamatan")
        #print("10. seragamkan penulisan provinsi")
        #print("10. pisahkan kelurahan, kecamatan, dan wilayah kota dari kolom alamat")
        #print("10. pisahkan RT, RW dari kolom alamat")
        print("0. simpan data")
        choice = readline("Masukan kode angka yang tertera : ")
        
        
        #remove thousand separator
        if (choice == "1")
        {
            print(colnames(dframe))
            col = readline("Masukan nama kolom : ")
            dframe = removeSeparator_df(dframe, col)
            print(head(dframe[,col]))
            
        }
        else if(choice == "2")
        {
            #drop column
            print("Nama kolom yang ada pada dframe ini :")
            print(colnames(dframe))
            choice = readline("Masukan nama kolom yang ingin anda hapus : ")
            print(summary(dframe[,choice]))
            
            dframe = dropColumn(dframe, choice)
            
        }
        else if(choice == "3")
        {
            #change typeof
            print("Nama dan tipe dframe setiap kolom pada dframe ini :")
            print(lapply(dframe,typeof))
            colname = readline("Masukan nama kolom yang ingin ubah tipenya : ")
            print(typeof(dframe[,colname]))
            print("Ubah menjadi tipe berikut : ")
            print("1. Text")
            print("2. Numerik")
            print("3. Tanggal")
            type = readline("Masukan tipe baru: ")
            if (type == "3") 
            {
                print("Silahkan pilih format penulisan tanggal yang ada sebelumnya : ")
                print("1. 29/02/2016")
                print("2. 02/29/2016")
                print("3. 2016/02/29")
                print("4. 29-02-2016")
                print("5. 02-29-2016")
                print("6. 2016-02-29")
                choice = readline("Silahkan pilih format penulisan tanggal yang ada sebelumnya : ")
                if (choice == "1")
                {
                    dframe = setAsDate(date.format="%d/%m/%Y", dframe, colname)
                }
                else if (choice == "2")
                {
                    dframe = setAsDate(date.format="%m/%d/%Y", dframe, colname)
                }
                else if (choice == "3")
                {
                    dframe = setAsDate(date.format="%Y/%m/%d", dframe, colname)
                }
                else if (choice == "4")
                {
                    dframe = setAsDate(date.format="%d-%m-%Y", dframe, colname)
                }
                else if (choice == "5")
                {
                    dframe = setAsDate(date.format="%m-%d-%Y", dframe, colname)
                }
                else if (choice == "6")
                {
                    dframe = setAsDate(date.format="%Y-%m-%d", dframe, colname)
                }
            } 
            else
            {
                dframe = changeType(dframe, colname, type)
            }
        }
        else if(choice == "4")
        {
            #set null values
            dframe[dframe == ""] = NA
            dframe[dframe == "-"] = NA
            print("nilai kosong berhasil dibersihkan")
        }
        else if(choice == "9")
        {
            View(dframe)
        }
        else if(choice == "10")
        {
            lapply(dframe, summary)
        }
        else if(choice == "0")
        {
            write.csv(dframe,
                      file=readline("Masukan nama file (berikan ekstensi .csv diakhir nama) :"),
                      row.names=F,
                      sep=',', 
                      col.names=TRUE)
            print(paste("data tersimpan di ", getwd()))
            
            return(dframe)
        }
        
    }
}

dropColumn = function(dframe,colname)
{
    dframe[,colname] = NULL
    print(paste("Kolom ", colname, " dihapus"))
    return(dframe)
}

changeType = function(dframe, colname, type)
{
    if (type == "1")
    {
        dframe[,colname] = as.factor(dframe[,colname])
        print(paste("Tipe dframe kolom ", colname, " diubah menjadi ", "text"))
    }
    else
    {
        dframe[,colname] = as.numeric(dframe[,colname])
        print(paste("Tipe dframe kolom ", colname, " diubah menjadi ", "numerik"))
    }
    
    return(dframe)
}

#load multiple csv
loadMultipleFiles = function(file_names = dir(), columnNames)
{
    #library(dplyr)
    #library(dframe.table)
    dfs = lapply(file_names, fread)
    dfs = lapply(dfs, setColumnNames, columnNames)
    dframe = bind_rows(dfs)
    
    return(dframe)
}

#change colnames
setColumnNames = function(dframe,columnnames)
{
    colnames(dframe) = columnnames
    return(dframe)
}

#set column values as date
setAsDate = function(date.format="%d/%m/%Y", dframe, colName)
{
    #lapply returns a list of Dates, but we need to unlist it and set it to dframe[,colName]. but unlist kills the date format
    #(based on docs and http://stackoverflow.com/questions/15659783/why-does-unlist-kill-dates-in-r). Also see this 
    #http://stackoverflow.com/questions/35591022/how-to-unlist-result-of-lapply-involving-functionx-as-dateas-posixctx-origi?lq=1
    res = lapply(dframe[,colName], as.Date, date.format)
    dframe[,colName] = do.call("c", res) 
    return(dframe)
}
    
