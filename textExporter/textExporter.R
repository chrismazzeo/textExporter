args = commandArgs(trailingOnly=TRUE)

runString = "Rscript exportText.r excelFilePath outputDir  exportOptions(Flutter, iOS, Android, All)\n
  Excel structure:\n
  IDs   English  Spanish  French ...\n
  HELLO  hello     hola    salut\n"
if (length(args) == 0 || length(args) == 1 & args[1] == "?"){
  cat("Instructions: 1. Install R\n")
  cat (runString)
}else if (length(args)<3) {
  print(runString)
} else{
  input  = args[1]
  ouputDir = args[2]
  option = args[3]
   

  
  list.of.packages <- c("openxlsx")
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  
  require(openxlsx)
  df = read.xlsx(input)
  languages = colnames(df)[2:dim(df)[2]]
  
  tempString = NA
  tempString2 = NA
  for (language in 1:length(languages)){
    min = dim(df)[1] -1
    if (option == "Flutter"){
        if (min > 0) {
           tempString = paste0('"',df[1:min,1],'" : "',df[1:min,language],'",\n')
           tempString2= paste0('"',df[(min+1),1],'" : "',df[(min+1),language],'"\n')
           
           
           
        }else{
          
          tempString = paste0('"',df[,1],'" = "',df[,language],'"')
        }
    }
    setwd(ouputDir)
    sink(paste0("string_",languages[language],".json"),type = "output")
      cat("{\n")
      cat(tempString)
      if(!is.na(tempString2)){
        cat(tempString2)
      }
      cat("}")
      sink()
  }
  
}