args = commandArgs(trailingOnly=TRUE)

 
file = args[length(args)]
count =(length(args)-1)
for (i in 1:count){
  if (i%%2 !=0){
    command = paste0("protoc --",args[i] ,"_out=" ,args[i+1], " ",file)
    print(command)
  }
}
