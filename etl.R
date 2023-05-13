# This R script is for loading and transformat data
library(ggplot2)
library(tsibbledata)
get_default_df <- function(){
  # get the datafram to analysis purpose.
  # by default using the diamonds dataset from ggplot2 
  #ggplot2::diamonds
  tsibbledata::aus_retail
}

default_df <- get_default_df()

get_df <- function(){
  get_default_df() 
}

get_std_df <- function(var_y, var_x1=NULL, var_x2=NULL, var_ts=NULL,keep_ts=FALSE){
  
  std_df <- get_df() 
  
  if (class(std_df)[1] == 'tbl_ts' & !keep_ts){
    std_df <- as_tibble(std_df)
  }
  # # print(class(std_df)) 
  std_df |>
    rename(var_y  = all_of(var_y), 
           var_x1 = all_of(var_x1),
           var_x2 = all_of(var_x2))
  
  # if (!is.null(var_ts)) {
  #   std_df <- std_df |>
  #     rename( 
  #       var_ts = all_of(var_ts)
  #       )
  # }
  # todo 1.  note object:object eror might be no data ouput which happed when you add code broke pipeline output
}

get_var_names <- function(only_numeric=FALSE, df=default_df){
  # get all variable names from data.frame
  # parameter: 
  #   only_numeric(TRUE) to filter the numeric column only
  #               (FALSE) get all variables names  
  if (is.null(df)) {
    df <- get_df()
  }
  if (!only_numeric) {
    var_names <- df |> names()
    
  }else {
    var_names <- df |> select(where(is.numeric)) |> names()
  }
}

get_y_names <- function(df=default_df){
  # get target variables name list
  # only use the numeric type variable as target variable to analysis purpose
   get_var_names(df, only_numeric = TRUE)
}

get_var_tbl <- function(var_name=NULL, df=default_df){
  df |> select({{var_name }}) 
}

get_var_summary <- function(var_name=NULL, df=default_df){
  if (is.null(var_name)) {
    warning('expect var_name input')
  }
  else if (class(df)[1] == 'tbl_ts'){
    df<- as_tibble(df)
  }
  df |> 
    summarise(mean = mean(get(var_name)),
              sd =   sd(get(var_name)),
              n  =    n(),
              missing_rate = sum(is.na(get( var_name)))/n()
              ) |>
    round(3)
}

