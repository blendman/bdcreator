;{ infos
; BD creator ( & storyboard creation, to use with cartoon or animatoon)
; by blendman, august 2021

; Priority :
; - add a menu : file save, open, export image, export page gabarit, preference
; - page : delete, move < >
; - add a "edition mode" :  page, graphics, text
; - in normal mode (not automatic) : change the size of case selected (or line)
; - add characters
; - add background
; - case : set zoom
; - add bulles and text.
; - export in png full image, or layers.
; ok :
; - add a menu File, Edit, view, page..
; - page : add, select

; bugs : 
; - select line is bugged


; 5.8.2021 0.02
; // new
; - Add menu (file, edit, view, help)
; - Add menu file : New, open, save, export, quit.
; - Add menu Page : Add (ok), delete (not ok).
; - add lang() system
; - Page : add, select
; - windowprojectproperties : define title and number of pages for projet

; 4.8.2021 0.01
; // new
; - window main
; - panel left gadgets : number of lines, nb of cases (if automaticMode=1), checkbox for automaticmode
; - panel left gadgets : space (marge) top, bottom, left, right.
; - panel left gadgets : spacebetween line And Case (automaticMode).
; - main canvas
; - Createproject() : with project parameters (nb page, title, marge, space between line and case...)
; - UpdateCanvasMain() : create the storyboard (page & cases for the moment)
;}

#BDC_ProgramVersion = "0.02"
#BDC_ProgramName = "BD Creator"

Enumeration 
  
  #BDC_StatusbarMain = 0
  ;{ window
  #BDC_Win_Storyboard = 0
  #BDC_Win_ProjectProperties
  ;}
  
  ;{ menu
  #BDC_Menu_Main=0
  #BDC_Menu_NewDoc=0
  #BDC_Menu_OpenDoc
  #BDC_Menu_SaveDoc
  #BDC_Menu_Projectproperties
  #BDC_Menu_ExportAsImage
  #BDC_Menu_ExportAsLayer
  #BDC_Menu_ExportPageTemplate
  #BDC_Menu_Quit
  #BDC_Menu_PageAdd
  #BDC_Menu_PageDelete
  ;}
  
  ;{ gadget
  #G_win_Story_panel=0
  #G_win_Story_SA ; scrollarea
  #G_win_Story_ModelesPage
  #G_win_Story_PageTitle
  #G_win_Story_PageNumber
  #G_win_Story_LineNb
  #G_win_Story_SpacebetweenLine
  #G_win_Story_SpacebetweenCase
  #G_win_Story_NbCaseByLine
  #G_win_Story_ModeAutomatic
  #G_win_Story_PageMode
  #G_win_Story_PageSelect
  
  #G_win_Story_MargeTop
  #G_win_Story_MargeBottom
  #G_win_Story_MargeLeft
  #G_win_Story_MargeRight
  
  #G_win_Story_Canvas
  #G_win_Story_Last ; last gadget for the main window
  
  ; other window
  ; WIndow project properties
  #G_win_BDCprop_title
  #G_win_BDCprop_NbPage
  #G_win_BDCprop_Width ; in cm
  #G_win_BDCprop_Height; in cm
  #G_win_BDCprop_DPI
  #G_win_BDCprop_Wpixel
  #G_win_BDCprop_Hpixel
  
  ;}
  
  ; properties
  #BD_properties_Interline=0
  
  ;{ gadget type (for procedure addgadgets()
  #Gad_spin=0
  #Gad_String
  #Gad_Btn
  #Gad_BtnImg
  #Gad_Chkbox
  #Gad_Cbbox
  #Gad_ListV
  ;}
  
EndEnumeration

;{ structures
Structure sBase
  Tile$
  Width.w
  Height.w
  
EndStructure

Structure sCase
  w.w
  h.w
  x.w
  y.w
  NotRectangle.a
  ; If Case isn't rectangle
  x2.w
  y2.w
  Border.a
EndStructure
Structure sLine
  Array caze.sCase(0)
  NbCase.a
  x.w
  y.w
  w.w
  h.w
EndStructure

Structure sPage Extends sBase
  numero.w ; numero de page
  Array line.sline(0)
  Nbline.a
  NbcaseByline.a
  MargeLeft.w
  MargeRight.w
  MargeTop.w
  MargeBottom.w
  SpacebetweenLine.w
  SpacebetweenCase.w
EndStructure

Structure sProject Extends sBase
  Name$
  Date$
  Info$
  ; the pages
  nbpage.w
  Array page.sPage(0)
  ; the parameters
  SpacebetweenLine.w
  SpacebetweenCase.w
  
  MargeLeft.w
  MargeRight.w
  MargeTop.w
  MargeBottom.w
EndStructure
Global Project.sProject, nbPage = -1, PageId, LineId, CaseID

Structure sProgram
  viewx.w
  viewy.w
EndStructure
Global VD.sProgram

Structure sOptions
  modeautomatic.a
  panelW.w
  Zoom.w
EndStructure
Global VDOptions.sOptions
;}

;{ procedures
Declare Line_SetProperties(i,x,y,w,h)
Declare Line_SetNBCase(nbcase=2)
Declare Case_SetProperties(i,x,y,w,h)

Procedure.s Lang(text$)
  ProcedureReturn text$
EndProcedure
Procedure VerifyCaseLine()
  
  With Project\page(pageId)
    For i=0 To ArraySize(\Line())
      For j= 0 To ArraySize(\Line(i)\caze())
        If \Line(i)\caze(j)\w<=0
          \Line(i)\caze(j)\w = Project\Width /(ArraySize(\Line(i)\caze())+1)
        EndIf
        If \Line(i)\caze(j)\h<=0
          \Line(i)\caze(j)\h = Project\Height /(ArraySize(\Line())+1)
        EndIf
      Next
    Next
  EndWith
  
EndProcedure
Procedure UpdateCanvasMain(gad=#G_win_Story_Canvas,outputid=0)
  
  z.d = VDOptions\Zoom * 0.01
  c=140
  
  wc = GadgetWidth(gad)
  hc = GadgetHeight(gad)
  
  If VDOptions\modeautomatic= 1
    With Project
      margeL = \MargeLeft
      margeTop = \MargeTop
    EndWith
  Else
    With Project\page(pageId)
      margeL = \MargeLeft
      margeTop = \MargeTop
    EndWith
  EndIf
  
  vx = vd\viewx
  vy = vd\viewy
  
  If StartVectorDrawing(CanvasVectorOutput(gad))
    
    ; the grey background
    AddPathBox(0,0, wc, hc)
    VectorSourceColor(RGBA(c,c,c,255))
    FillPath()
    
    ; the white page
    w = Project\Width * z
    h = Project\Height * z
    
    
    x =  (wc-w)/2 
    y =  (hc-h)/2 
    vd\viewx = x
    vd\viewy = y
    
    AddPathBox(x,y,w,h)
    VectorSourceColor(RGBA(255,255,255,255))
    FillPath()
    
    x1 = x+margeL * z
    y1 = y+margeTop * z
    
    ; and the lines and cases
    With Project\page(pageId)
      h_l1 = Project\SpacebetweenLine * z
      w_c1 = Project\SpacebetweenCase * z 
      For i=0 To ArraySize(\Line())
        For j= 0 To ArraySize(\Line(i)\caze())
          ;AddPathBox(x+\Line(i)\caze(j)\x + j*w_c1, y+\Line(i)\caze(j)\y + i*hl1, \Line(i)\caze(j)\w * z, \Line(i)\caze(j)\h * z)
          AddPathBox(x1+\Line(i)\caze(j)\x * z, y1+\Line(i)\caze(j)\y * z, \Line(i)\caze(j)\w * z, \Line(i)\caze(j)\h * z)
          VectorSourceColor(RGBA(0,0,0,255))
          StrokePath(3 * z)
        Next
        If i = lineID
          AddPathBox(x1+\Line(i)\x * z, y1+\Line(i)\y * z, \Line(i)\w * z, \Line(i)\h * z)
          VectorSourceColor(RGBA(255,0,0,100))
          StrokePath(40 * z)
        EndIf
        
      Next
    EndWith
    StopVectorDrawing()
  EndIf
  
EndProcedure

Procedure EventCanvas()
  Static down
  z.d = VDOptions\Zoom *0.01
  
  If VDOptions\modeautomatic= 1
    With Project
      margeL = \MargeLeft
      margeTop = \MargeTop
    EndWith
  Else
    With Project\page(pageId)
      margeL = \MargeLeft
      margeTop = \MargeTop
    EndWith
  EndIf
  
  vx = vd\viewx
  vy = vd\viewy
  
  If EventType() = #PB_EventType_LeftButtonDown
    ; SetActiveGadget(#G_win_Story_Canvas)
    down = 1
    x = GetGadgetAttribute(#G_win_Story_Canvas, #PB_Canvas_MouseX) / z
    y = GetGadgetAttribute(#G_win_Story_Canvas, #PB_Canvas_MouseY) / z
    ;Debug Str(y)
    With project\page(PAgeId)
      For i=0 To ArraySize(\Line())
        If y>= vy+margeTop+\Line(i)\y And y<= vy+margeTop+\Line(i)\y +\Line(i)\h
          lineID = i
          ;Debug lineID
          ;Debug Str(\Line(i)\y)+"/"+Str(\Line(i)\y +\Line(i)\h)
          Break
        EndIf
      Next
    EndWith
    UpdateCanvasMain()
    
  ElseIf EventType() = #PB_EventType_LeftButtonUp
    down = 0
  ElseIf EventType() = #PB_EventType_MouseMove
    
  ElseIf EventType() = #PB_EventType_MouseWheel
    ;{ zoom
    delta = GetGadgetAttribute(#G_win_Story_Canvas, #PB_Canvas_WheelDelta)
    If delta =1
      If VdOptions\Zoom<30
        VdOptions\Zoom + 1
      ElseIf VdOptions\Zoom<100
        VdOptions\Zoom + 10
      Else
        VdOptions\Zoom + 20
      EndIf
    ElseIf delta = -1
      If VdOptions\Zoom > 100
        VdOptions\Zoom -20
      ElseIf VdOptions\Zoom > 30
        VdOptions\Zoom -10
      ElseIf VdOptions\Zoom > 1
        VdOptions\Zoom -1
      EndIf
    EndIf
    UpdateCanvasMain()
    StatusBarText(0, 0, "Zoom"+" "+Str(VdOptions\Zoom)+"%")
    ;}
  EndIf
  
EndProcedure

; create page, line, case...
Procedure Page_update(nbcase = 1)
  
  With Project
    
    ; define the properties
    w = \Width 
    h = \Height
    If VDOptions\ModeAutomatic = 1
      margeL = \MargeLeft
      margeR = \MargeRight
      MargeTop = \MargeTop 
      margeBottom = \MargeBottom
      
      ; space between lines and cases
      spacelineH = \SpacebetweenLine
      spaceCaseW = \SpacebetweenCase
    Else
      margeL = \page(pageId)\MargeLeft
      margeR = \page(pageId)\MargeRight
      MargeTop = \page(pageId)\MargeTop 
      margeBottom = \page(pageId)\MargeBottom
      
      ; space between lines and cases
      spacelineH = \page(pageId)\SpacebetweenLine
      spaceCaseW = \page(pageId)\SpacebetweenCase
    EndIf
    
    ; define other paramters
    nbline = \page(PageId)\Nbline
    n1 = nbline+1
    h1 = (h-margeBottom-MargeTop)/n1 - (spacelineH*nbline)/n1 ; * nbline
    w1 = w-margeL-margeR
    
    If VDOptions\ModeAutomatic = 1
      nbcase = \page(PageId)\NbcaseByline ; ArraySize(\page(PageId)\Line(0)\caze())
      
      For i=0 To ArraySize( \page(pageId)\Line())
        ; set line properties
        lineId = i
        x = 0; margeL
        y = i * (h1 + spacelineH) ; +MargeTop
        Line_SetProperties(i,x,y,w1,h1)
        
        ; set case  properties
        Line_SetNBCase(nbcase)
        
        n = nbcase +1
        w2 = (w1 - (spaceCaseW * nbcase))/n
        For j=0 To nbcase
          x1 = x + j * (spaceCaseW + w2)
          Case_SetProperties(j,x1,y,w2,h1)
        Next
        
      Next
      lineId = 0
    Else
      For i=0 To ArraySize( \page(pageId)\Line())
        ; set line properties
        lineId = i
        x = 0 ;margeL
        y = i * (h1 + spacelineH); +MargeTop
        Line_SetProperties(i,x,y,w1,h1)
        
        ; set case  properties
        ; Line_SetNBCase(nbcase)
        nbcase = ArraySize(\page(PageId)\Line(i)\caze())
        n = nbcase +1
        w2 = (w1 - (spaceCaseW * nbcase))/n
        For j=0 To nbcase
          x1 = x + j * (spaceCaseW + w2)
          Case_SetProperties(j,x1,y,w2,h1)
        Next
        
      Next
      lineId = 0
    EndIf
    
  EndWith
  
  ; update the canvas
  UpdateCanvasMain()
EndProcedure
Procedure Case_SetProperties(i,x,y,w,h)
  With project\page(pageId)\Line(lineId)
    \caze(i)\x = x
    \caze(i)\y = y
    \caze(i)\w = w
    \caze(i)\h = h
  EndWith
EndProcedure
Procedure Line_SetNBCase(nbcase=2)
  With project\page(pageId)\Line(LineId)
    ReDim \caze(nbCase)
  EndWith
EndProcedure
Procedure Line_SetProperties(i,x,y,w,h)
  With project\page(pageId)
    \Line(i)\x = x
    \Line(i)\y = y
    \Line(i)\w = w
    \Line(i)\h = h
  EndWith
EndProcedure
Procedure Page_SetNBline(Nbline=2)
  With project\page(pageId)
    \Nbline = Nbline
    ReDim \Line(\Nbline)
  EndWith
EndProcedure
Procedure Page_Add(add=1, nbpage=-1)
  
  If add= 1
    With project
      If nbpage = -1
        \nbpage +1
      Else
        \nbpage = nbpage
      EndIf
      
      ReDim \page(\nbpage)
      pageId = ArraySize(\page())
      i = pageId
      \page(i)\MargeBottom = \margeBottom
      \page(i)\MargeTop = \MargeTop
      \page(i)\MargeRight = \MargeRight
      \page(i)\MargeLeft = \MargeLeft
      \page(i)\SpacebetweenCase = \SpacebetweenCase
      \page(i)\SpacebetweenLine = \SpacebetweenLine 
      
      ; add a gadgetitem for the new page
      AddGadgetItem(#G_win_Story_PageSelect, i,  lang("page ")+Str(i+1))
      SetGadgetState(#G_win_Story_PageSelect, i)
    EndWith
    Page_update()
    
  Else ; delete the page
    
  EndIf
  
EndProcedure

Procedure SetGadgetColor2(gadget,color=-1)
  If color=-1
    b = 120
    c = RGB(b,b,b)
  Else
    c = RGB(color,color,color)
  EndIf
  
  SetGadgetColor(gadget, #PB_Gadget_BackColor, c)
EndProcedure
Procedure AddGadget(id,typ,x,y,w,h,txt$="",min.d=0,max.d=0,tip$="",val.d=-65257,name$=#Empty$)
  
  ; pour ajouter plus facilement un gadget
  w_1 = VDoptions\PanelW/3 ; VdOptions\PanelW/3
  If name$ <> #Empty$ 
    w1 = w_1
    g = TextGadget(#PB_Any,x,y,w1,h,name$) 
    If G
      SetGadgetColor2(g)
    EndIf 
    If typ = #Gad_String And txt$ = #Empty$
      txt$ = StrD(val,3)
    EndIf
    
  ElseIf txt$ <>#Empty$  And typ <= #Gad_String 
    w1 = w_1
    g = TextGadget(#PB_Any,x,y,w1,h,txt$) 
    If G
      SetGadgetColor2(g)
    EndIf 
  EndIf
  
  Select typ
    Case #Gad_spin
      If SpinGadget(id, x+w1,y,w,h,min,max,#PB_Spin_Numeric) : EndIf
      
    Case #Gad_String
      If min =1
        If StringGadget(id, x+w1,y,w,h,txt$,#PB_String_Numeric) : EndIf
      ElseIf val = #PB_String_ReadOnly Or min = 2
        If StringGadget(id, x+w1,y,w,h,txt$,#PB_String_ReadOnly) : EndIf  
      Else
        ;Debug txt$
        If StringGadget(id, x+w1,y,w,h,txt$) : EndIf                
      EndIf
      
    Case #Gad_Btn
      If min = 1
        If ButtonGadget(id,x+w1,y,w,h,txt$,#PB_Button_Toggle)  : EndIf    
      Else
        If ButtonGadget(id,x+w1,y,w,h,txt$)  : EndIf    
      EndIf
      
    Case #Gad_BtnImg
      If min = 1
        If ButtonImageGadget(id,x+w1,y,w,h,ImageID(max),#PB_Button_Toggle)  : EndIf    
      Else
        If ButtonImageGadget(id,x+w1,y,w,h,ImageID(max))  : EndIf    
      EndIf
      
    Case #Gad_Chkbox
      If CheckBoxGadget(id,x+w1+2,y,w,h,txt$) : EndIf    
      
    Case #Gad_Cbbox
      If ComboBoxGadget(id,x+w1,y,w,h) : EndIf    
      
    Case #Gad_ListV
      If ListViewGadget(id,x+w1,y,w,h) : EndIf    
      
  EndSelect
  
  If tip$ <> #Empty$      
    If IsGadget(id)
      GadgetToolTip(id,tip$)
    EndIf
  EndIf
  
  If val <> -65257
    If typ = #Gad_String
      If txt$ = #Empty$
        SetGadgetText(id,StrD(val))
      EndIf
    Else
      SetGadgetState(id,val)
    EndIf
  EndIf
  
EndProcedure

Procedure Createproject(name$="New project",w=2500,h=3500,spacelineH=50,spaceCaseW=50,nbpage=0,margeL=100,margeR=100,MargeTop=100,margeBottom=100)
  
  With Project
    ; create the project
    \Name$ = name$
    \Width = w
    \Height = h
    
    ; the border (marge)
    \MargeLeft = margeL
    \MargeRight = margeR
    \MargeTop = MargeTop
    \MargeBottom = margeBottom
    
    ; space between lines and cases
    \SpacebetweenLine = spacelineH
    \SpacebetweenCase = spaceCaseW
    
    ; set the number of pages
    Page_Add(1,nbpage)
    
    ; set nb of line for the current pageID to 2
    nbline = 2
    Page_SetNbline(nbline)
    
    ; and set 2 cases by line
    nbcase =1 ; by default : 2 cases by line
    \page(pageId)\NbcaseByline = nbcase
    
  EndWith
  
  ; center the view
  vd\viewx = (GadgetWidth(#G_win_Story_Canvas)-(Project\Width * VDOptions\Zoom*0.01))/2
  vd\viewy = (GadgetHeight(#G_win_Story_Canvas)-(Project\Height * VDOptions\Zoom*0.01))/2
  
  ; update 
  Page_update()
  
EndProcedure

Procedure Window_ProjectProperties()
  
  winw = 800
  winH = 500
  If OpenWindow(#BDC_Win_ProjectProperties, 0, 0, winW, winH, LAng("Project Properties"), 
                #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
    
    x = 5 : y=5 : w = winw -100 : h = 30
    AddGadget(#G_win_BDCprop_title, #Gad_String,x,y,w,h,Project\Name$,0,0,lang("Define the title for the project"),0,lang("Title")) : y+h+5
    AddGadget(#G_win_BDCprop_NbPage, #Gad_spin,x,y,w,h,"",1,1000,lang("Define the number of pages"),ArraySize(project\page())+1,lang("Nb of pages")) : y+h+5
  EndIf
  
EndProcedure
;}

;{ open main window
If ExamineDesktops()
  winH = DesktopHeight(0)
  winW = DesktopWidth(0)
EndIf
If OpenWindow(#BDC_Win_Storyboard, 0, 0, winW, winH, "BD creator (Storyboard & comics creation) "+#BDC_ProgramVersion, #PB_Window_SystemMenu | #PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget|#PB_Window_Maximize)
  
  ;{ statusbar, menu, gadgets...
  WindowBounds(#BDC_Win_Storyboard,600,600,5000,5000)
  
  VDOptions\ModeAutomatic = 1
  VDOptions\Zoom = 17
  ; statusbar
  CreateStatusBar(#BDC_StatusbarMain,WindowID(#BDC_Win_Storyboard))
  AddStatusBarField(100)
  AddStatusBarField(100)
  AddStatusBarField(100)
  StatusBarText(0, 0, Lang("Zoom")+" "+Str(VdOptions\Zoom)+"%")
  
  ; menu
  If CreateMenu(#BDC_Menu_Main, WindowID(#BDC_Win_Storyboard))
    MenuTitle(Lang("File"))
    MenuItem(#BDC_Menu_NewDoc, lang("New")+Chr(9)+"Ctrl+N")
    MenuItem(#BDC_Menu_OpenDoc, lang("Open")+Chr(9)+"Ctrl+O")
    MenuItem(#BDC_Menu_SaveDoc, lang("Save")+Chr(9)+"Ctrl+S")
    MenuBar()
    MenuItem(#BDC_Menu_ExportAsImage, lang("Export all pages as image"))
    ;     MenuItem(#BDC_Menu_ExportAsLayer, lang("Export page as layer"))
    ;     MenuItem(#BDC_Menu_ExportPageTemplate, lang("Export page as template"))
    MenuBar()
    MenuItem(#BDC_Menu_Projectproperties, lang("Project properties")) 
    MenuBar()
    MenuItem(#BDC_Menu_Quit, lang("Quit"))
    MenuTitle(Lang("Edit"))
    MenuTitle(Lang("View"))
    MenuTitle(Lang("Page"))
    MenuItem(#BDC_Menu_PageAdd, lang("Add page"))
    MenuItem(#BDC_Menu_PageDelete, lang("Delete the page"))
    MenuTitle(Lang("Help"))
  EndIf
  
  ;{ add gadgets
  x = 5 : y=5 : wp = 230 : hp= winH-75-StatusBarHeight(#BDC_StatusbarMain)-MenuHeight() : w1 = wp-(2*wp)/5-30 : h1 = 30 : a=2
  VDOptions\panelW = wp
  
  If PanelGadget(#G_win_Story_panel, x,y,wp,hp)
    AddGadgetItem(#G_win_Story_panel, -1, Lang("Create"))
    If ScrollAreaGadget(#G_win_Story_SA,2,2,wp-10,hp-35,wp-40,hp+200)
      
      AddGadget(#G_win_Story_ModeAutomatic,#Gad_Chkbox,x,y,w1,h1,Lang("Automatic"),1,20,Lang("Use automatic mode for automatic changes for all pages, and create automatic things like cases"),1,Lang("Mode")) : y+h1+a
      
      
      AddGadget(#G_win_Story_PageSelect,#Gad_Cbbox,x,y,w1,h1,"",1,20,Lang("Select the page"),3,Lang("Page :")) : y+h1+a
      
      
      AddGadget(#G_win_Story_LineNb,#Gad_spin,x,y,w1,h1,"",1,20,Lang("Set the number of lines for this page"),3,Lang("Nb of lines")) : y+h1+a
      AddGadget(#G_win_Story_NbCaseByLine,#Gad_spin,x,y,w1,h1,"",1,20,Lang("Set the number of cases by lines for this page (automatic mode)"),2,Lang("Nb of Cases"))
      y+h1+10
      
      ; marges
      AddGadget(#G_win_Story_MargeTop,#Gad_spin,x,y,w1,h1,"",0,20000,"Set the Top Space for this page, or in automatic mode for all pages",100,Lang("Top")) : y+h1+a
      AddGadget(#G_win_Story_MargeBottom,#Gad_spin,x,y,w1,h1,"",0,20000,"Set the Bottom Space for this page, or in automatic mode for all pages",100,Lang("Bottom")) : y+h1+a
      AddGadget(#G_win_Story_MargeLeft,#Gad_spin,x,y,w1,h1,"",0,20000,"Set the Left Space for this page, or in automatic mode for all pages",100,Lang("Left")) : y+h1+a
      AddGadget(#G_win_Story_MargeRight,#Gad_spin,x,y,w1,h1,"",0,20000,"Set the Right Space for this page, or in automatic mode for all pages",100,Lang("Right")) 
      y+h1+10
      
      AddGadget(#G_win_Story_SpacebetweenLine,#Gad_spin,x,y,w1,h1,"",0,2000,Lang("Set the Space between lines (in automatic mode for all pages, else only for this page)"),50,Lang("Lines Space")) : y+h1+a
      AddGadget(#G_win_Story_SpacebetweenCase,#Gad_spin,x,y,w1,h1,"",0,2000,Lang("Set the Space between cases (in automatic mode for all pages, else only for this page)"),50,Lang("Cases Space"))
      y+h1+10
      
      CloseGadgetList()
    EndIf
    CloseGadgetList()
  EndIf
  
  y = 5 : x+wp+5
  If CanvasGadget(#G_win_Story_Canvas, x, y, winw - wp-15, hp,#PB_Canvas_Border|#PB_Canvas_Keyboard): EndIf
  ;}
  
  ; test project
  CreateProject()
  
  ;}
  
  Repeat
    Event = WaitWindowEvent()
    EventGadget =  EventGadget()
    EventMenu =  EventMenu()
    
    Select Event 
        
      Case #PB_Event_Gadget
        Select EventWindow()
            
          Case #BDC_Win_Storyboard
            Select  EventGadget
                
              Case #G_win_Story_MargeTop, #G_win_Story_MargeBottom, #G_win_Story_MargeLeft, #G_win_Story_MargeRight,#G_win_Story_SpacebetweenLine,#G_win_Story_SpacebetweenCase
                If VDOptions\ModeAutomatic =1
                  Project\MargeLeft = GetGadgetState(#G_win_Story_MargeLeft)
                  Project\MargeRight = GetGadgetState(#G_win_Story_MargeRight)
                  Project\MargeBottom = GetGadgetState(#G_win_Story_MargeBottom)
                  Project\MargeTop = GetGadgetState(#G_win_Story_MargeTop)
                  Project\SpacebetweenLine = GetGadgetState(#G_win_Story_SpacebetweenLine)
                  Project\SpacebetweenCase = GetGadgetState(#G_win_Story_SpacebetweenCase)
                Else
                  With Project\page(pageID)
                    \MargeLeft = GetGadgetState(#G_win_Story_MargeLeft)
                    \MargeRight = GetGadgetState(#G_win_Story_MargeRight)
                    \MargeBottom = GetGadgetState(#G_win_Story_MargeBottom)
                    \MargeTop = GetGadgetState(#G_win_Story_MargeTop)
                    \SpacebetweenLine = GetGadgetState(#G_win_Story_SpacebetweenLine)
                    \SpacebetweenCase = GetGadgetState(#G_win_Story_SpacebetweenCase)
                  EndWith
                EndIf
                Page_update()
                
              Case #G_win_Story_ModeAutomatic
                VDoptions\modeautomatic = GetGadgetState(EventGadget)
                Page_update()
                
              Case #G_win_Story_NbCaseByLine
                nb = GetGadgetState(EventGadget)-1
                If nb>=0 
                  If VDOptions\ModeAutomatic =1
                    Project\page(PageId)\NbcaseByline = nb
                  Else
                    Project\page(PageId)\Line(LineId)\NbCase = nb
                  EndIf
                  Page_update()
                EndIf
                
              Case #G_win_Story_PageSelect
                PageId = GetGadgetState(EventGadget)
                Page_update()
                UpdateCanvasMain()
                
              Case #G_win_Story_LineNb
                nb = GetGadgetState(EventGadget)-1
                If nb>=0 
                  Project\page(pageId)\Nbline = nb
                  ReDim Project\page(pageId)\Line(nb)
                  Page_SetNBline(nb)
                  Page_update()
                EndIf
                
              Case #G_win_Story_Canvas
                eventcanvas()
                
            EndSelect
            
          Case #BDC_Win_ProjectProperties
            
            Select EventGadget
                
              Case #G_win_BDCprop_title
                name$ = GetGadgetText(#G_win_BDCprop_title)
                If name$ <> #Empty$
                  project\Name$ = name$
                EndIf
                
              Case #G_win_BDCprop_NbPage
                Debug "ok gadget change nb page"
                nb = GetGadgetState(EventGadget)
                If nb>=1 
                  If nb<=1000
                    If nb > ArraySize(project\page())
                      Debug "ok 2 !!!"
                      ReDim project\page(nb-1)
                      ClearGadgetItems(#G_win_Story_PageSelect)
                      For i=0 To ArraySize(project\page())
                        AddGadgetItem(#G_win_Story_PageSelect, i, lang("Page")+Str(i+1))
                      Next
                    Else
                      
                    EndIf
                  Else
                  EndIf
                EndIf
                
                
            EndSelect
            
        EndSelect
        
      Case #PB_Event_Menu
        Select EventMenu
          Case #BDC_Menu_NewDoc
            
          Case #BDC_Menu_Projectproperties
            Window_ProjectProperties()
            
          Case #BDC_Menu_quit
            quit = 1 
            
          Case #BDC_Menu_PageAdd
            Page_Add()
            
          Case #BDC_Menu_PageDelete
            Page_Add(0)
            
        EndSelect
        
      Case #PB_Event_CloseWindow
        If GetActiveWindow() = #BDC_Win_Storyboard
          quit = 1
        Else
          CloseWindow(GetActiveWindow())
        EndIf
        
    EndSelect
    
  Until Quit >= 1
  
EndIf

;}


; IDE Options = PureBasic 5.61 (Windows - x86)
; CursorPosition = 630
; FirstLine = 33
; Folding = AAEAAAAAAAAgu0BcBPQP-
; EnableXP