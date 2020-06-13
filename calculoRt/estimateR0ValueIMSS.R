#estimateR0Value
#compute the value of R0 over time

my.max <- function(x) {
  if (!all(is.na(x))){
    res = max(x, na.rm=T)
  }
  else {
    res= Sys.Date() #"2020-06-03"
  }
  return(res)
}

estimateR0ValueIMSS <- function (positives, positives.before, nombre, limits) {
  
  #obtain the number of cases by date over a range of consecutive dates
  
  #create a sequence of dates from 2020.02.28 to the maximum date.
  positivos = dim(positives)[1]
  Rt.mu = NA
  Rt.sd = 0
  fecha = "2020-02-28" #first known case
  
  
  if (positivos > 0) {
    #this is the more recent date
    #2020.06.10, the date in a municipio in Chiapas has a date in before larger than in positives
    max.date.check = 
      max(my.max(positives.before$FECHA_INICIO_CUADRO_CLINICO), 
          my.max(as.Date(positives$FECHA_INICIO_CUADRO_CLINICO)))
    
    
    dates = seq(from = as.Date("2020-02-28"), 
                to = max.date.check, by= "day")
    
    
    lim.date = max.date.check
    #within the sequence, this will be its position
    lim.date.pos = which(dates == lim.date)
    #lim.date.pos = length(positives.before$FECHA_SINTOMAS)
    #reserve space to hold the number of cases by date
    num.cases = matrix(0,ncol = 1, nrow = length(dates))
    i = 1
    #keep checking for a change of date
    keep.checking = TRUE
    for (date in dates) {
      #filter in the cases for this date
      cases = positives[positives$FECHA_INICIO_CUADRO_CLINICO == date,]
      #count how many registers there are for this date
      num.cases[i] = dim(cases)[1]
      
      if (keep.checking) {
        if (date <= max.date.check){
          cases.before = positives.before[positives.before$FECHA_INICIO_CUADRO_CLINICO == date,]
          #count how many registers there are for this date
          num.cases.before = dim(cases.before)[1]
          if (!(num.cases[i] == num.cases.before)){
            lim.date = date
            lim.date.pos = i;
            keep.checking = FALSE
          }
          
        }
      }
      
      i = i + 1
    }
    
    acumulado = cumsum(num.cases)
    pos = which(acumulado > 12)
    #suppose Rt is not a number
    
    if (length(pos) > 0) {
      #create a data frame to feed the routine
      incid = data.frame(dates = dates, I=num.cases)
      
      #compute R
      
      #parameters for the Gamma prior distribution
      #2020, The serial interval of COVID-19 from publicly reported confirmed cases
      mu = 3.96
      sigma = 4.75
      #2020, Serial interval of novel coronavirus (COVID-19) infections
      mu = 3.96
      sigma = 4.75
      res_parametric_si <- suppressWarnings(suppressMessages(estimate_R(incid, 
                                                                        method="parametric_si",
                                                                        config = make_config(list(
                                                                          mean_si = mu, 
                                                                          std_si = sigma)))))
      
      mean.values = res_parametric_si$R$`Mean(R)`
      
      sd.values = res_parametric_si$R$`Std(R)`
      lim.sup = mean.values + sd.values
      lim.inf = mean.values - sd.values
      
      good.dates = dates[8:length(dates)]
      
      
      data.sure = data.frame(dias = good.dates[1:(lim.date.pos-7)], 
                             R =  mean.values[1:(lim.date.pos-7)],
                             sd =  sd.values[1:(lim.date.pos-7)],
                             lower = lim.inf[1:(lim.date.pos-7)],
                             upper = lim.sup[1:(lim.date.pos-7)])
      
      
      data.unsure = data.frame(dias = 
                                 good.dates[(lim.date.pos-7):length(good.dates)], 
                               R =  mean.values[(lim.date.pos-7):length(mean.values)],
                               sd =  sd.values[(lim.date.pos-7):length(mean.values)],
                               lower = lim.inf[(lim.date.pos-7):length(mean.values)],
                               upper = lim.sup[(lim.date.pos-7):length(mean.values)])
      
      
      
      Rt.mu = data.sure$R[length(data.sure$R)]
      Rt.sd = data.sure$sd[length(data.sure$R)]
      fecha = data.sure$dias[length(data.sure$dias)]
      
      
      p<-suppressWarnings(ggplot() + 
                            geom_line(data=data.sure, 
                                      aes(x=dias, 
                                          y=R, 
                                          color= "blue", linetype = "dashed"))+
                            geom_line(data=data.unsure, 
                                      aes(x=dias,  
                                          y=R, 
                                          color= "blue", linetype = "solid"))+  
                            geom_ribbon(data=data.sure, 
                                        aes(x=dias,
                                            y=R, 
                                            ymin=lower, ymax=upper),
                                        linetype=2, alpha=0.1)+
                            geom_ribbon(data=data.unsure, 
                                        aes(x=dias,
                                            y=R, 
                                            ymin=lower, ymax=upper), 
                                        linetype=3, alpha=0.1)+
                            geom_vline(xintercept = lim.date,
                                       linetype = "dashed", 
                                       color = "red", size=0.5) + 
                            geom_hline(yintercept = 1,
                                       linetype = "solid", 
                                       color = "blue", size=0.5) +
                            theme (legend.position = "none",
                                   axis.text.x = element_text(angle = 20, hjust = 1)) +
                            ggtitle(nombre))
      
      if (limits == 1) {
        if (is.na(my.max(pos))) {
          p <- p +   ylim(0,3)
          
        }
        else {
          initial = as.Date(as.character(dates[min(pos)]))
          final = as.Date(as.character(dates[my.max(pos)]))
          p <- p + ylim(0,3) + xlim(initial,final)
        }
        
        
      }
      
      
      suppressMessages(suppressWarnings(plot(p)))
      
    }
  }
  estimate = data.frame(Rt = Rt.mu, sd = Rt.sd, fecha = fecha, positivos = positivos)
  return(estimate)
}