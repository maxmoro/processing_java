data= read.csv("../data/org.csv")
files=dir(pattern='jpg')
for(f in c(1:length(files))){
  message(f)
  file.copy(files[f],paste0('../data/',data$`�..id`[f],'.jpg'),overwrite=TRUE)
}
