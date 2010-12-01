# Graphical interface associated to depthTools package

# last modified: 01 December 2010 by A. Torrente

# load the Rcmdr if it is not already loaded

.First.lib <- function(libname, pkgname){
    if (!interactive()) return()
    Rcmdr <- options()$Rcmdr
    plugins <- Rcmdr$plugins
    if ((!pkgname %in% plugins) && !getRcmdr("autoRestart")) {
        Rcmdr$plugins <- c(plugins, pkgname)
        options(Rcmdr=Rcmdr)
        closeCommander(ask=FALSE, ask.save=TRUE)
        Commander()
        }
    }

#######################################################################################################################################

computeMBD <-function()
{
  require(tcltk)
 
  ############     OUTPUT SELECTION
  # function to select elements to output
  Output.funct<-defmacro(label, firstLabel, expr=
  {
    env<-environment()
    # variable declaration
    Rdepths <- FALSE
    Rordering <- TRUE

    .OutputLabel<-tclVar(paste(firstLabel, "", sep=" "))
    OnOutput<-function()
    {
      OutputWin<-tktoplevel()
      tkwm.title(OutputWin,gettextRcmdr("Output options"))
      tkwm.geometry(OutputWin, "-170+1")

         # function onOKsub to retrieve selected outputs in R
         onOK.output<-function()
         {
           tkconfigure(Output.but, fg="blue")
    
           if (tclvalue(depthsValue)=="1") assign("Rdepths", TRUE, envir=env)
           else assign("Rdepths", FALSE,envir=env)

           if (tclvalue(orderingValue)=="1") assign("Rordering", TRUE,envir=env)
           else assign("Rordering", FALSE,envir=env)

           tkdestroy(OutputWin)
         }  ## end FUNCTION *onOK.output*
    
      depths.lab <- tklabel(OutputWin, text=gettextRcmdr("  MBD for each sample (rows)   "))
        depths.check <- tkcheckbutton(OutputWin)
        if(Rdepths) depthsValue <- tclVar("1")
        else depthsValue <- tclVar("0")
        tkconfigure(depths.check,variable=depthsValue)

      ordering.lab <- tklabel(OutputWin, text=gettextRcmdr("  Ordering (from center outwards)  "))
        ordering.check <- tkcheckbutton(OutputWin)
        if(Rordering) orderingValue <- tclVar("1")
        else orderingValue <- tclVar("0")
        tkconfigure(ordering.check,variable=orderingValue)
 
      OutputOK.but<-tkbutton(OutputWin,text="    OK    ",command=onOK.output)
      tkgrid(tklabel(OutputWin, text = " "))
      tkgrid(depths.lab,depths.check,sticky="w")    
      tkgrid(ordering.lab,ordering.check,sticky="w")    
      tkgrid(tklabel(OutputWin, text = " "))
      tkgrid(OutputOK.but)
      tkgrid(tklabel(OutputWin, text = " "))
   }  ## end FUNCTION *OnOutput*
    
    OutputFrame<-tkframe(OutFrame)
    Output.but<-tkbutton(OutputFrame, textvariable=.OutputLabel, command=OnOutput, borderwidth=3)
    tkgrid(Output.but, sticky="ew")
  })  ## end MACRO *output.funct*


  ##########       GRAPHICAL OPTIONS
  # function to set up graphical parameters  

  PLOT.MBD<-defmacro(label, firstLabel, expr=
  {
    env<-environment()
    .PlotLabel<-tclVar(paste(firstLabel, "", sep=" "))

    # variable declaration
        
    RTitle<-""
    RXLabel<-""
    RYLabel<-"Gene Expression"
    # RXlim<-NULL
    RYlim<-NULL
    RCd <- Rcold <- "#ff0000"
    RCRef <- RcolRef <- "#0000ff"

    OnPlot<-function()
    {
      GraphicalWin<-tktoplevel()
      tkwm.title(GraphicalWin,gettextRcmdr("Graphical options"))
      tkwm.geometry(GraphicalWin, "-100+50")
 
      # function onOKsub
      onOKsub<-function() {
        tclvalue(.PlotLabel)<-paste(label, gettextRcmdr(""), sep=" ")
        tkconfigure(Plot.but, fg="blue")
 
        if (tclvalue(Main)==" ") assign("RTitle", " ", envir=env)
        else assign("RTitle", tclvalue(Main), envir=env)

        if (tclvalue(Xaxis)==" ") assign("RXLabel", " ", envir=env)
        else assign("RXLabel", tclvalue(Xaxis), envir=env)

        if (tclvalue(Yaxis)==" ") assign("RYLabel", " ", envir=env)
        else assign("RYLabel", tclvalue(Yaxis), envir=env)

        # if(tclvalue(XlimMin)=="" | tclvalue(XlimMax)=="") assign("RXlim", NULL, envir=env)
        #  else assign("RXlim", c(as.numeric(tclvalue(XlimMin)), as.numeric(tclvalue(XlimMax))), envir=env)

        if(tclvalue(YlimMin)=="" | tclvalue(YlimMax)=="") assign("RYlim", NULL, envir=env)
        else assign("RYlim", c(as.numeric(tclvalue(YlimMin)), as.numeric(tclvalue(YlimMax))), envir=env)

        assign("RCd", Rcold, envir=env)                                      
        assign("RCRef", RcolRef, envir=env)                                

        tkdestroy(GraphicalWin)
        }  ## end FUNCTION onOKsub

      # Graphical options interface
      GraphicalFrame<-tkframe(GraphicalWin, borderwidth=5, relief="groove")
      
      RTitleFrame<-tkframe(GraphicalFrame,borderwidth=2)
       if (RTitle=="") Main <- tclVar("")
       else Main<-tclVar(RTitle)
       Main.entry <-tkentry(RTitleFrame,width="40",textvariable=Main)
       tkgrid(tklabel(RTitleFrame,text=gettextRcmdr("Title of the graph")),Main.entry)

      RXLabelFrame<-tkframe(GraphicalFrame,borderwidth=2)
       if (RXLabel=="") Xaxis <- tclVar("")
       else Xaxis<-tclVar(RXLabel)
       Xaxis.entry <-tkentry(RXLabelFrame,width="40",textvariable=Xaxis)
       tkgrid(tklabel(RXLabelFrame,text=gettextRcmdr("X axis label")),Xaxis.entry)

      RYLabelFrame<-tkframe(GraphicalFrame,borderwidth=2)
       if (RYLabel=="") Yaxis <- tclVar("")
       else Yaxis<-tclVar(RYLabel)
       Yaxis.entry <-tkentry(RYLabelFrame,width="40",textvariable=Yaxis)
       tkgrid(tklabel(RYLabelFrame,text=gettextRcmdr("Y axis label")),Yaxis.entry)
                      
      RlimFrame<-tkframe(GraphicalFrame,borderwidth=2)
      #   if(is.null(RXlim)) XlimMin<-tclVar("")
      #   else XlimMin<-tclVar(paste(RXlim[1]))
      #   XlimMin.entry <-tkentry(RlimFrame,width="5",textvariable=XlimMin)
      #   if (is.null(RXlim)) XlimMax<- tclVar("")
      #   else XlimMax<-tclVar(paste(RXlim[1]))
      #   XlimMax.entry <-tkentry(RlimFrame,width="5",textvariable=XlimMax)
      #   tkgrid(tklabel(RlimFrame,text=gettextRcmdr("x limits of the graph:")),XlimMin.entry, XlimMax.entry)
      
      if(is.null(RYlim)) YlimMin<- tclVar("")
      else YlimMin<-tclVar(paste(RYlim[1]))
      YlimMin.entry <-tkentry(RlimFrame,width="5",textvariable=YlimMin)
      if (is.null(RYlim)) YlimMax<- tclVar("")
      else YlimMax<-tclVar(paste(RYlim[2]))
      YlimMax.entry <-tkentry(RlimFrame,width="5",textvariable=YlimMax)
      tkgrid(tklabel(RlimFrame,text=gettextRcmdr("y limits of the graph:")),YlimMin.entry,YlimMax.entry)

      RcoldFrame<-tkframe(GraphicalFrame,borderwidth=2)  
      RcolRefFrame<-tkframe(GraphicalFrame,borderwidth=2)  
      Rcold.value<-RCd
      RcolRef.value<-RCRef                                                        
      canvas1 <- tkcanvas(RcoldFrame,width="15",height="15",bg=Rcold.value)
      canvas2 <- tkcanvas(RcolRefFrame,width="15",height="15", bg=RcolRef.value)
      ChangeColor1 <- function() {
        Rcold.value<-tclvalue(tcl("tk_chooseColor",initialcolor=Rcold.value,title=gettextRcmdr("Choose a color")))  
        if (nchar(Rcold.value)>0) {
           tkconfigure(canvas1,bg=Rcold.value)  
           assign("Rcold",Rcold.value,envir=env)                                                                      
           } ## end IF
        }  ## end FUNCTION ChangeColor1
      ChangeColor2 <- function() {
        RcolRef.value<-tclvalue(tcl("tk_chooseColor",initialcolor=RcolRef.value,title=gettextRcmdr("Choose a color")))  
        if (nchar(RcolRef.value)>0) {
          tkconfigure(canvas2,bg=RcolRef.value)  
          assign("RcolRef",RcolRef.value,envir=env)                                                                      
          }   ### end IF
        } ## end FUNCTION ChangeColor2
      ChangeColor1.button <- tkbutton(RcoldFrame,text=gettextRcmdr("Change Color"),command=ChangeColor1)         
      ChangeColor2.button <- tkbutton(RcolRefFrame,text=gettextRcmdr("Change Color"),command=ChangeColor2)              
      tkgrid(tklabel(RcoldFrame,text=gettextRcmdr("Color of the deepest element:    ")),canvas1,ChangeColor1.button)
      tkgrid(tklabel(RcolRefFrame,text=gettextRcmdr("Color of the Reference sample:   ")),canvas2,ChangeColor2.button)
 
      # design of GraphicalFrame
      SubOK.but<-tkbutton(GraphicalFrame,text="    OK    ",command=onOKsub)
      tkgrid(tklabel(GraphicalFrame, text=" "))
      tkgrid(RTitleFrame)
      tkgrid(tklabel(GraphicalFrame, text=" "))
      tkgrid(RXLabelFrame)
      tkgrid(RYLabelFrame)
      tkgrid(tklabel(GraphicalFrame, text=" "))
      tkgrid(RlimFrame)
      tkgrid(tklabel(GraphicalFrame, text=" "))
      tkgrid(RcoldFrame)
      tkgrid(RcolRefFrame)
      tkgrid(SubOK.but)
      tkgrid(tklabel(GraphicalFrame, text=" "))
      tkgrid(GraphicalFrame, sticky="ns")
    }  ## end FUNCTION OnPlot

    PlotFrame<-tkframe(OutFrame)
    Plot.but<-tkbutton(PlotFrame, textvariable=.PlotLabel, command=OnPlot, borderwidth=3)
    tkgrid(Plot.but, sticky="ew")
  }) ## end MACRO PLOT.MBD

  ###########################     Window 'top'   #################################
  initializeDialog(title=gettextRcmdr("Modified Band Depth"))
  dataSets <- listDataSets()
  dataSets <- dataSets[-which(dataSets==.activeDataSet)]
  dataSetsBox <- variableListBox(top, c("(the same data set)",dataSets), title=gettextRcmdr(" "), initialSelection=NULL)
  checkBoxes(frame="optionsFrame", boxes=c("plotDepth"), initialValues=1, labels=gettextRcmdr(c("Plot depths")))

  ######  function associated with button OK. Run and distroy the graphical interface
  onOK <- function(){
     if (tclvalue(plotDepthVariable)=="1"){
       plotting <- ", plotting=TRUE"
       if (RTitle!="") {plotting <- paste(plotting,", main = '",RTitle,"'",sep="")} 
       if ((is.null(RXLabel)|(RXLabel==""))==FALSE) {plotting <- paste(plotting, ", xlab = '",RXLabel,"'",sep="")}
       if ((is.null(RYLabel)|(RYLabel==""))==FALSE) {plotting <- paste(plotting, ", ylab = '",RYLabel,"'",sep="")}
       if (is.null(RYlim)==FALSE) {plotting <- paste(plotting, ", ylim = c(",RYlim[1],",",RYlim[2],")",sep="")}
       plotting<-paste(plotting,", cold = '", RCd,"'", sep="")
     }  ## end IF (do the plot)
     else {
       plotting <- ", plotting=FALSE"
     }  ## end ELSE (do not plot)
     if ( (Rdepths==FALSE) & (Rordering==FALSE) ) {getOutput <- ""; outputComp <- ""}
     else {
         getOutput <- "xD <- " 
         if (Rdepths & (Rordering==FALSE) ){outputComp <- "$depth"}
         else {
              if ( (Rdepths==FALSE) & Rordering) {outputComp <- "$ordering"}
              else {outputComp <- ""}
              }  ## end ELSE
         }  ## end ELSE
      ### select the reference sample
     .refData <- getSelection(dataSetsBox)  ## name          #refData <- get(.refData)        ## data
     if (length(.refData)==0){
         errorCondition(recall=computeMBD, message="You must select the reference sample.")
         return()
         }
     if (.refData!="(the same data set)") {
        plotting <-paste( ", xRef = ", .refData, plotting,", colRef = '", RCRef,"'", sep="")
        }
     else {plotting <- paste(plotting,", col = '", RCRef,"'",sep="")}
     closeDialog()

     ### compute the MBD according to the user's selections
     command <- paste(getOutput,"MBD(",.activeDataSet, plotting,")",outputComp,sep="") 
     doItAndPrint(command)
     tkfocus(CommanderWindow())
     }  ## end function onOK

  # construction of OutFrame (graphical options + selection of outputs)
  OutFrame<- tkframe(top, borderwidth=2)
  PLOT.MBD(label=gettextRcmdr("Graphical options"), firstLabel=gettextRcmdr("Graphical options"))
  Output.funct(label=gettextRcmdr("Outputs"), firstLabel=gettextRcmdr("Outputs"))
  tkgrid(tklabel(OutFrame, text=""))
  tkgrid.configure(PlotFrame)
  tkgrid.configure(OutputFrame)
  OKCancelHelp(helpSubject="MBD")

  # construction of 'top'
  tkgrid(tklabel(top, text=gettextRcmdr(" Computation of MBD with respect to... (pick one):  "),fg="blue"))
  tkgrid(getFrame(dataSetsBox))           #  reference datasets
  tkgrid(tklabel(top,text=""))    
  tkgrid(optionsFrame)                    #  whether or not plotting depths
  tkgrid(OutFrame)                        #  graphical options + selection of outputs
  tkgrid(tklabel(top,text=""))    
  tkgrid(buttonsFrame, sticky="w" )       #  ok, cancel, help buttons
}  

################################################################################################################################

computeScaleCurve <- function()
{
  require(tcltk)
  
  ###########################     Window 'top'   #################################
  top<-tktoplevel(borderwidth=10)
  tkwm.title(top,gettextRcmdr("Scale curve"))
  tkwm.geometry(top, "-50+50")

  dataSets <- listDataSets() 
  dataSets <- dataSets[-which(dataSets==.activeDataSet)]
  labelsBox <- variableListBox(top, c("(none)",dataSets), title=gettextRcmdr("Group labels (if several groups)"), initialSelection=NULL)

  checkBoxes(frame="outputFrame",boxes=c("output"), initialValues=1, labels=gettextRcmdr(c("      Store scale-curve values  ")))
 
  ######  function associated with button OK. Run and distroy the graphical interface
  onOK <- function(){
       save <- if (tclvalue(outputVariable) == "0") ""
            else paste("sc.",.activeDataSet," <- ",sep="")
       .labels <- getSelection(labelsBox)
       if (length(.labels)==0) {y<-""}
       else {if (.labels=="(none)") {y<-""}
             else {y<-paste(",y=",.labels,sep="")}
            }
       closeDialog()

       ### compute the scale curve
       command <- paste(save,"scalecurve(x=",.activeDataSet,y,")",sep="") 
       doItAndPrint(command)
       }  ## end function onOK

    # configure the layout of *top*
    OKCancelHelp(helpSubject="scalecurve")
    tkgrid(getFrame(labelsBox))                       
    tkgrid(tklabel(top,text=""))
    tkgrid(outputFrame) 
    tkgrid(tklabel(top,text=""))
    tkgrid(buttonsFrame, sticky="w")      #  ok, cancel, help buttons
}

#################################################33#######################################################################################

runRtest <- function()
{
  require(tcltk)
  
  ###########################     Window 'top'   #################################
  top<-tktoplevel(borderwidth=10)
  tkwm.title(top,gettextRcmdr("Rank test for equality of populations"))
  tkwm.geometry(top, "-50+50")

  dataSets <- listDataSets() 
  sample1Box <- variableListBox(top, dataSets, title=gettextRcmdr("Sample 1 (pick one)"), initialSelection=NULL)
  sample2Box <- variableListBox(top, dataSets, title=gettextRcmdr("Sample 2 (pick one)"), initialSelection=NULL)  
  size1Var <- tclVar("1")
  size2Var <- tclVar("1")
  size1Entry <- tkentry(top, width="6", textvariable=size1Var)
  size2Entry <- tkentry(top, width="6", textvariable=size2Var)
 
  ######  function associated with button OK. Run and distroy the graphical interface
  onOK <- function(){
       .sample1 <- getSelection(sample1Box)
       if (length(.sample1)==0){
          errorCondition(recall=runRtest, message="You must select sample 1.")
          return()
          }
       X1 <- as.matrix(get(.sample1))
       if (ncol(X1)==1) {X1<-matrix(X1,1,nrow(X1))}
       .sample2 <- getSelection(sample2Box)
       if (length(.sample2)==0){
          errorCondition(recall=runRtest, message="You must select also sample 2.")
          return()
          }
       X2 <- as.matrix(get(.sample2))
       if (ncol(X2)==1) {X2<-matrix(X2,1,nrow(X2))}
       size1 <- as.numeric(tclvalue(size1Var))
       size2 <- as.numeric(tclvalue(size2Var))
       if (is.na(size1) || size1 < 0 || size1 > nrow(X1) || as.integer(size1)-size1!=0){
            errorCondition(recall=runRtest, message=paste("n must be a positive integer between 1 and ",nrow(X1),".",sep=""))
            return()
            }
       if (is.na(size2) || size2 < 0 || size2 > nrow(X2) || as.integer(size2)-size2!=0){
            errorCondition(recall=runRtest, message=paste("m must be a positive integer between 1 and ",nrow(X2),".",sep=""))
            return()
            }
       closeDialog()

       ### run the Rank test
       command <- paste("R.test(",.sample1,",",.sample2,",n=",size1,",m=",size2,")",sep="") 
       doItAndPrint(command)
       }  ## end function onOK

    # configure the layout of *top*
    OKCancelHelp(helpSubject="R.test")
    tkgrid(getFrame(sample1Box))                       # sample from population 1
    tkgrid(getFrame(sample2Box))                       # sample from population 2
    tkgrid(tklabel(top,text=""))
    tkgrid(tklabel(top, text="Size of subsample from the first population, n "), size1Entry, sticky="e")
    tkgrid(tklabel(top, text="Size of subsample from the second population, m "), size2Entry, sticky="e")
    tkgrid(tklabel(top,text=""))             
    tkgrid(buttonsFrame, sticky="w", columnspan=2)      #  ok, cancel, help buttons
    tkgrid.configure(size1Entry, sticky="w")
    tkgrid.configure(size2Entry, sticky="w")
    dialogSuffix(rows=4, columns=2, focus=size1Entry)
    dialogSuffix(rows=4, columns=2, focus=size2Entry)
}  

#####################################################################################################################################################




runDS <- function()
{
  require(tcltk)
  
  ###########################     Window 'top'   #################################
  top<-tktoplevel(borderwidth=10)
  tkwm.title(top,gettextRcmdr("DS classification method"))
  tkwm.geometry(top, "-50+50")

  dataSets <- listDataSets() 
  learningXBox <- variableListBox(top, dataSets, title=gettextRcmdr("Learning set (pick one)"), initialSelection=NULL)
  learningYBox <- variableListBox(top, dataSets, title=gettextRcmdr("Labels in learning set (pick one)"),  initialSelection=NULL)  
  trainingXBox <- variableListBox(top, dataSets, title=gettextRcmdr("Test set (pick one)"), initialSelection=NULL)
  alphaVar <- tclVar("20")
  alphaEntry <- tkentry(top, width="4", textvariable=alphaVar)
  checkBoxes(frame="outputFrame",boxes=c("output"), initialValues=1, labels=gettextRcmdr(c("      Store label predictions  ")))

 
  ######  function associated with button OK. Run and distroy the graphical interface
  onOK <- function(){
       .xl <- getSelection(learningXBox)
       if (length(.xl)==0){
          errorCondition(recall=runDS, message="You must select the learning set.")
          return()
          }
       X1 <- as.matrix(get(.xl))
       if (ncol(X1)==1) {X1<-matrix(X1,1,nrow(X1))}

       .yl <- getSelection(learningYBox)
       if (length(.yl)==0){
          errorCondition(recall=runDS, message="You must select the labels of the learning set.")
          return()
          }
       Y1 <- as.matrix(get(.yl))
       if (nrow(X1)!=nrow(Y1)){
          errorCondition(recall=runDS, message="The dimension of the learning set mismatches the length of the vector of labels.")
          return()
          }

       .xt <- getSelection(trainingXBox)
       if (length(.xt)==0){
       errorCondition(recall=runDS, message="You must select the test set.")
       return()
          }
       X2 <- as.matrix(get(.xt))
       if (ncol(X2)==1) {X2<-matrix(X2,1,nrow(X2))}
  
       alpha <- as.numeric(tclvalue(alphaVar))/100
       if (is.na(alpha) || alpha < 0 || alpha > 1){
          errorCondition(recall=runDS, message="alpha must be a number between 0 and 100.")
          return()
          }
       save <- if (tclvalue(outputVariable) == "0") ""
               else paste("pred.DS.",.xt," <- ",sep="")
       closeDialog()

       ### run DS

       command <- paste(save,"classDS(",.xl,",",.yl,",",.xt,",alpha=",alpha,")",sep="") 
       doItAndPrint(command)
       }  ## end function onOK

    # configure the layout of *top*
    OKCancelHelp(helpSubject="classDS")
    tkgrid(getFrame(learningXBox))
    tkgrid(tklabel(top,text=""))
    tkgrid(getFrame(learningYBox))                       
    tkgrid(tklabel(top,text=""))
    tkgrid(tklabel(top,text=""))
    tkgrid(getFrame(trainingXBox))    
    tkgrid(tklabel(top,text=""))
    tkgrid(tklabel(top, text="   % of external points to be trimmed out:"), alphaEntry)
    tkgrid(tklabel(top,text=""))
    tkgrid(outputFrame) 
    tkgrid(tklabel(top,text=""))             
    tkgrid(buttonsFrame)      #  ok, cancel, help buttons
 #   tkgrid.configure(alphaEntry, sticky="w")
}  


#####################################################################################################################################################




runTAD <- function()
{
  require(tcltk)
  
  ###########################     Window 'top'   #################################
  top<-tktoplevel(borderwidth=10)
  tkwm.title(top,gettextRcmdr("TAD classification method"))
  tkwm.geometry(top, "-50+50")

  dataSets <- listDataSets() 
  learningXBox <- variableListBox(top, dataSets, title=gettextRcmdr("Learning set (pick one)"), initialSelection=NULL)
  learningYBox <- variableListBox(top, dataSets, title=gettextRcmdr("Labels in learning set (pick one)"),  initialSelection=NULL)  
  trainingXBox <- variableListBox(top, dataSets, title=gettextRcmdr("Training set (pick one)"), initialSelection=NULL)
  alphaVar <- tclVar("20")
  alphaEntry <- tkentry(top, width="4", textvariable=alphaVar)
  checkBoxes(frame="outputFrame",boxes=c("output"), initialValues=1, labels=gettextRcmdr(c("      Store label predictions  ")))

 
  ######  function associated with button OK. Run and distroy the graphical interface
  onOK <- function(){
       .xl <- getSelection(learningXBox)
       if (length(.xl)==0){
          errorCondition(recall=runTAD, message="You must select the learning set.")
          return()
          }
       X1 <- as.matrix(get(.xl))
       if (ncol(X1)==1) {X1<-matrix(X1,1,nrow(X1))}

       .yl <- getSelection(learningYBox)
       if (length(.yl)==0){
          errorCondition(recall=runTAD, message="You must select the labels of the learning set.")
          return()
          }
       Y1 <- as.matrix(get(.yl))
       if (nrow(X1)!=nrow(Y1)){
          errorCondition(recall=runTAD, message="The dimension of the learning set mismatches the length of the vector of labels.")
          return()
          }

       .xt <- getSelection(trainingXBox)
       if (length(.xt)==0){
       errorCondition(recall=runTAD, message="You must select the training set.")
       return()
          }
       X2 <- as.matrix(get(.xt))
       if (ncol(X2)==1) {X2<-matrix(X2,1,nrow(X2))}
  
       alpha <- as.numeric(tclvalue(alphaVar))/100
       if (is.na(alpha) || alpha < 0 || alpha > 1){
          errorCondition(recall=runTAD, message="alpha must be a number between 0 and 100.")
          return()
          }
       save <- if (tclvalue(outputVariable) == "0") ""
               else paste("pred.TAD.",.xt," <- ",sep="")       
       closeDialog()

       ### run TAD
       command <- paste(save,"classTAD(",.xl,",",.yl,",",.xt,",alpha=",alpha,")",sep="") 
       doItAndPrint(command)
       }  ## end function onOK

    # configure the layout of *top*
    OKCancelHelp(helpSubject="classTAD")
    tkgrid(getFrame(learningXBox))
    tkgrid(tklabel(top,text=""))
    tkgrid(getFrame(learningYBox))                       
    tkgrid(tklabel(top,text=""))
    tkgrid(tklabel(top,text=""))
    tkgrid(getFrame(trainingXBox))    
    tkgrid(tklabel(top,text=""))
    tkgrid(tklabel(top, text="   % of external points to be trimmed out:  "), alphaEntry)
    tkgrid(tklabel(top,text=""))
    tkgrid(outputFrame)    
    tkgrid(tklabel(top,text=""))  
    tkgrid(buttonsFrame)      #  ok, cancel, help buttons
}  





################################################################################################################################

computeTmean <- function(){
    require(depthTools)
    .activeDataSet <- as.matrix(ActiveDataSet())
    initializeDialog(title=gettextRcmdr("Trimmed Mean"))
    alphaVar <- tclVar("20")
    alphaEntry <- tkentry(top, width="4", textvariable=alphaVar)
    plotVariable <- tclVar("1")
    plotFrame <- tkframe(top)
    plotCheckBox<-tkcheckbutton(plotFrame,variable=plotVariable)
    plotMeanVariable <- tclVar("1")
    plotMeanFrame <- tkframe(top)
    plotMeanCheckBox<-tkcheckbutton(plotMeanFrame,variable=plotMeanVariable)
    env<-environment()
    RcolFrame<-tkframe(top,borderwidth=2)  
    RcolRefFrame<-tkframe(top,borderwidth=2)                                                          
    RcolMean.value <- RMeanC <- "#ff00ff"
    RcolRef.value <- RRefC <- "#0000ff"
    canvas1 <- tkcanvas(RcolFrame,width="20",height="20",bg=RcolMean.value)
    canvas2 <- tkcanvas(RcolRefFrame,width="20",height="20", bg=RcolRef.value)
    ChangeColor1 <- function()                                                                              
    {
      RcolMean.value<-tclvalue(tcl("tk_chooseColor",initialcolor=RcolMean.value,title=gettextRcmdr("Choose a color")))  
      if (nchar(RcolMean.value)>0)
      {
        tkconfigure(canvas1,bg=RcolMean.value)  
        assign("RMeanC",RcolMean.value,envir=env)                                                                      
      }
    }  ## end FUNCTION ChangeColor1
   ChangeColor2 <- function()                                                                              
    {
      RcolRef.value<-tclvalue(tcl("tk_chooseColor",initialcolor=RcolRef.value,title=gettextRcmdr("Choose a color")))  
      if (nchar(RcolRef.value)>0)
      {
        tkconfigure(canvas2,bg=RcolRef.value)  
        assign("RRefC",RcolRef.value,envir=env)                                                                      
      }
    } ## end FUNCTION ChangeColor2

    ChangeColor1.button <- tkbutton(RcolFrame,text=gettextRcmdr("Change Color"),command=ChangeColor1)              
    tkgrid(tklabel(RcolFrame, text=gettextRcmdr("   ")),canvas1,ChangeColor1.button)   
    ChangeColor2.button <- tkbutton(RcolRefFrame,text=gettextRcmdr("Change Color"),command=ChangeColor2)              
    tkgrid(tklabel(RcolRefFrame, text=gettextRcmdr("   ")),canvas2,ChangeColor2.button)   

    plotTsampleVariable <- tclVar("0")
    plotTsampleFrame <- tkframe(top)
    plotTsampleCheckBox<-tkcheckbutton(plotTsampleFrame,variable=plotTsampleVariable)

    onOK <- function(){
        closeDialog()
        alpha <- as.numeric(tclvalue(alphaVar))/100
        plotValue <- "1"==tclvalue(plotVariable)
        plotTsampleValue <- "1"==tclvalue(plotTsampleVariable)
        plotMeanValue <- "1"==tclvalue(plotMeanVariable)
        if (is.na(alpha) || alpha < 0 || alpha > 1){
            errorCondition(recall=computeTmean, message="alpha must be a number between 0 and 100.")
            return()
            }
        command <- (paste("tm<-tmean(",.activeDataSet,", alpha = ", alpha, ")", sep=""))
        doItAndPrint(command)
        if (plotValue){
            command <- paste(par(mar=c(8,5,5,5)))
            justDoIt
            command <- (paste("matplot(t(",.activeDataSet,"), type='l',lty=3,col='gray',xlab='',ylab='')",sep=""))
            logger(command)
            justDoIt(command)
            if (plotTsampleValue){
                command <- (paste("x <- as.matrix(tm$tm.x); matlines(t(x), lty=3, col='",RRefC,"', lwd=0.5)",sep=""))
                justDoIt(command)
                command <- paste("par(xpd=TRUE); legend('bottom',inset=-0.3, legend=c('trimmed mean','reference sample'),col=c(1,'",RRefC,"'), lty=c(1,3), lwd=c(1.5,1)) ; par(xpd=FALSE)", sep="")
                justDoIt(command)
                }
            else {
                command <- paste("par(xpd=TRUE); legend('bottom',inset=-0.3,legend=c('trimmed mean'),col=1,lty=1,lwd=1.5) ; par(xpd=FALSE)",sep="")
                justDoIt(command)
                }
            if (plotMeanValue) {
                command <- (paste ("m <- as.matrix(apply(",.activeDataSet,",2,mean)); lines(m,lty=2,col='",RMeanC,"',lwd=1.5)",sep="") )
                justDoIt(command)
                }
            command <- (paste("t <- as.matrix(tm$tm); lines(t,lty=1,col=1,lwd=1.5)",sep=""))
            justDoIt(command)
            }  ## end IF plotValue
        tkfocus(CommanderWindow())
        }
    OKCancelHelp(helpSubject="tmean")
    tkgrid(tklabel(top, text="% of external points to be trimmed out "), alphaEntry, sticky="e")
    tkgrid(labelRcmdr(plotFrame, text=gettextRcmdr("Plot sample and trimmed mean"), justify="left"),
        plotCheckBox, sticky="e")
    tkgrid(plotFrame, stick="e")
    tkgrid(tklabel(top,text=""))
    tkgrid(labelRcmdr(plotMeanFrame, text=gettextRcmdr("Plot sample mean"), justify="left"),
        plotMeanCheckBox, sticky="e")
    tkgrid(plotMeanFrame, RcolFrame,sticky="e")
    tkgrid(tklabel(top,text=""))
    tkgrid(labelRcmdr(plotTsampleFrame, text=gettextRcmdr("Plot trimmed sample"), justify="left"),
        plotTsampleCheckBox, sticky="e")
    tkgrid(plotTsampleFrame, RcolRefFrame,stick="e")
    tkgrid(tklabel(top,text=""))
    tkgrid(buttonsFrame, sticky="w", columnspan=2)
    tkgrid.configure(alphaEntry, sticky="w")
    dialogSuffix(rows=4, columns=2, focus=alphaEntry)
    }

#################################################################################################################################3#################



#    plotMeanCheckBox<-tkcheckbutton(plotMeanFrame,variable=plotMeanVariable,state="disabled")