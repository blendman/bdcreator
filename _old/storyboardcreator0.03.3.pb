;{ infos
; BD creator ( & storyboard creation, to use with cartoon or animatoon)
; by blendman, august 2021

; BY version (date de création de la roadmap 5.8.2021) :
; V 0.03 : 
; ok - Bouger le canvas avec Space
; ok - Mode normal : définir line H,Y
; ok - definir : case w,h
; wip - definir : case x,y
; ok - Bugfixe : sélectionner la ligne
; V 0.04 :
; - Voir le Numéro de page
; ok 0.03.3 - voir et Changer le depth des cases
; ok 0.03 - Sélectionner une Case
; V 0.05
; - ok 0.02.3 Case avec fond blanc
; - Menu : savedoc.
; V 0.06
; - Case : ajout infos cadre, position, texte
; - Définir police du texte.
; V 0.07 :
; - Case : Pouvoir ajouter un personnage (issu du dossier par defaut). Canvas personnage, on clique et ça le place. 
; - Personnage : position, taille et « lumière ».
; V 0.09
; - Menu opendoc
; - Enlever des pages
; - Insérer une page avant/après la page actuelle
; V  0.10
; - Case : pouvoir ajouter 1 ou plusieurs bulles + texte. Position.
; ok 0.03 - Menu newdoc
; V 0.11
; - Case : Pouvoir ajouter un décor ou + (avec depth, position, scale, alpha).
; V 0.12
; ok 0.03 - Menu export image (jpg ou PNG, calque écrasé)
; V 0.13
; - Changer le zoom de la Case (type de plan) et « pan ».
; - Menu export (image PNG de chaque page) avec taille d’export..; 



; Priority :
; - add a menu : file save, open, export page gabarit, preference
; - page : delete, move < >
; - add a "edition mode" :  page, graphics, text
; wip - in normal mode (not automatic) : change the size of case selected (or line)
; - add characters
; - add background
; - case : set zoom
; - add bulles and text.
; - export in png layers.
; ok :
; - export image (full image) 
; - add a menu File, Edit, view, page..
; - page : add, select

; bugs : 
; ok - select line is bugged
; - select line& case is bugged if move viewx/y
; - on ne peut pas bouger la case en Y ni changer sa hauteur
; - mode normal : si on ajoute une case, il faudrait qu'elle soit créé à droite, après la dernière case et avec la largeur disponible (pas w=0 et x=0)


; 7.8.2021 0.03.3
; // new
; - Mode normal : we can change the number of case by line
; - Mode normal : define caseID X/Y
; - panel create : add gadget case depth
; - we can change the depth of a case (-> use sortstructuredarray after the changes)
; - creation page : if case()\depth=0 -> case()\depth = i
; // fixes
; - when select a line in page and change page, crash if line> arraysize(page()\line())
; - gadget marge aren't updated if doc_new().
; - gadget spacebetween (line/case) aren't updated with page_update() (& new_doc()).
; - gadgetitem selectpage is'nt clear if Doc_new() and page_update



; 6.8.2021 0.03
; // new
; - Editmode paint : we can paint on the case selected
; - Mode normal : Define caseID W/H
; - menu : view : zoom (10, 15, 20, 50, 100%)
; - add tollbar: gadget editmode (2 mode : page, paint)
; - Menu export image (jpg, PNG)
; - Mode normal : define LineID H 
; - Add VD\shift, ctrl, space, alt. 
; - Maincanvas : add eventttype() key down and up (shift, ctrl, space, alt) 
; - move canvas with space
; - Cases have white background
; - Doc_new() if yes to message
; - EventcanvasMAin() : clic on case select caseID
; - panel "create" : add gadget for lineY/H, caseX/Y/W/H
; - we can select a case
; - select a case/Line -> Getline/case properties and update gadgets
; // Changes
; - doc_new() : ResetStructure()
; - add framegadget in panel
; - updatecanvasmain() : show border for selected case (instead of line)
; // fixes
; - select the line


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

#BDC_ProgramVersion = "0.03.2"
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
  ; page
  #BDC_Menu_ViewOrigin
  #BDC_Menu_ViewCenter
  #BDC_Menu_ViewZoom10
  #BDC_Menu_ViewZoom15
  #BDC_Menu_ViewZoom20
  #BDC_Menu_ViewZoom30
  #BDC_Menu_ViewZoom50
  #BDC_Menu_ViewZoom70
  #BDC_Menu_ViewZoom100
  #BDC_Menu_ViewZoom200
  #BDC_Menu_PageAdd
  #BDC_Menu_PageAddBefore
  #BDC_Menu_PageAddAfter
  #BDC_Menu_PageDelete
  ;}
  
  ;{ gadget
  #G_win_Story_Canvas = 0
  #G_win_Story_ContToolBar
  #G_win_Story_Editmode
  ; 
  #G_win_Story_panel
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
  
  ; By page
  #G_win_Story_PageX
  #G_win_Story_PageY
  
  #G_win_Story_LineID
  #G_win_Story_LineY
  #G_win_Story_LineH
  #G_win_Story_CaseID
  #G_win_Story_CaseX
  #G_win_Story_CaseY
  #G_win_Story_CaseW
  #G_win_Story_CaseH
  #G_win_Story_CaseDepth
  #G_win_Story_CaseHideBorder
  #G_win_Story_CaseUseMargeL
  #G_win_Story_CaseUseMargeR
  #G_win_Story_CaseUseMargeTop
  #G_win_Story_CaseUseMargeBottom
  
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
  
  ; Image
  #Img_PageDrawing=0
  #Img_Export
  
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
  
  ;{ action
  #BDC_actionCreatePage
  #BDC_actionPaint
  ;}
  
EndEnumeration

If UsePNGImageDecoder() And UsePNGImageEncoder() And UseJPEGImageDecoder() And UseJPEGImageEncoder() : EndIf

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
  image.i
  NotRectangle.a
  ; If Case isn't rectangle
  ;x2.w
  ;y2.w
  NoBorder.a
  Depth.a ; the depth for the case
  NotuseMargeTop.a
  NotuseMargeL.a
  NotuseMargeR.a
  NotuseMargeBottom.a
  
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
Global Project.sProject, nbPage = -1, PageId, LineId, CaseID, ImageID

Structure sProgram
  viewx.w
  viewy.w
  PagecenterX.w
  PageCenterY.w
  ; key down
  Shift.a
  Ctrl.a
  Alt.a
  Space.a
  ClicLb.a
  spaceX.w
  spaceY.w
  EditMode.a
EndStructure
Global VD.sProgram

Structure sOptions
  Action.a
  modeautomatic.a
  panelW.w
  ToolbarH.a
  Zoom.w
EndStructure
Global VDOptions.sOptions


Structure sPoint
  x.i
  y.i
EndStructure
Structure sStroke
  Array dot.sPoint(0)
EndStructure
Global Dim stroke.sStroke(0), NbStroke=-1
;}

;{ procedures
Declare Line_SetProperties(i,x,y,w,h)
Declare Line_SetNBCase(nbcase=2)
Declare Case_SetProperties(i,x,y,w,h)

Procedure.s Lang(text$)
  ProcedureReturn text$
EndProcedure
Procedure Freeimage2(id)
  If IsImage(id) : FreeImage(id) : EndIf
EndProcedure
; pages
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
    
    ResetCoordinates()
    ; the grey background
    AddPathBox(0,0, wc, hc)
    VectorSourceColor(RGBA(c,c,c,255))
    FillPath()
    
    
    ScaleCoordinates(z,z)
    
    
    ; the white page
    w = Project\Width 
    h = Project\Height 
    
    vd\PagecenterX = 0 ; (wc-w)/2 
    vd\PagecenterY = 0 ; (hc-h)/2 
    
    ; position of center of page (and for line, case...)    
    x =  vx + vd\PagecenterX 
    y =  vy + vd\PagecenterY 
    ;vd\viewx = x
    ;vd\viewy = y
    
    AddPathBox(x,y,w,h)
    c = 255
    VectorSourceColor(RGBA(c,c,c,255))
    FillPath()
    
    ; and the lines and cases
    With Project\page(pageId)
      h_l1 = Project\SpacebetweenLine 
      w_c1 = Project\SpacebetweenCase 
      For i=0 To ArraySize(\Line())
        For j= 0 To ArraySize(\Line(i)\caze())
          
          
          ;AddPathBox(x+\Line(i)\caze(j)\x + j*w_c1, y+\Line(i)\caze(j)\y + i*hl1, \Line(i)\caze(j)\w * z, \Line(i)\caze(j)\h * z)
          x1 = x + margeL 
          y1 = y + margeTop 
           
          ;White Background for each case
          w2 = \Line(i)\caze(j)\w 
          h2 = \Line(i)\caze(j)\h 
          AddPathBox(x1+\Line(i)\caze(j)\x , y1+\Line(i)\caze(j)\y, w2, h2)
          VectorSourceColor(RGBA(255,255,255,255))
          FillPath() 
          
;           img = \Line(i)\caze(j)\image
;           If IsImage(img)
;             MovePathCursor(x1,y1) 
;             DrawVectorImage(ImageID(img)) ;,255,w2,h2)
;           EndIf
          For k=0 To ArraySize(Stroke())
            MovePathCursor(stroke(k)\dot(0)\x+ vx,stroke(k)\dot(0)\y+ vy)
            For f=1 To ArraySize(stroke(k)\dot())
              xa = stroke(k)\dot(f)\x + vx
              ya = stroke(k)\dot(f)\y + vy
              AddPathLine(xa,ya)
              ; MovePathCursor(xa, ya)
            Next
            VectorSourceColor(RGBA(0,0,0,255))
            StrokePath(4,#PB_Path_RoundEnd)
          Next
          
          MovePathCursor(0,0)
          ; black stroke for each case
          AddPathBox(x1+\Line(i)\caze(j)\x , y1+\Line(i)\caze(j)\y , \Line(i)\caze(j)\w , \Line(i)\caze(j)\h )
          VectorSourceColor(RGBA(0,0,0,255))
          StrokePath(3)
          If i = lineID And j = caseid
            AddPathBox(x1+\Line(i)\caze(j)\x, y1+\Line(i)\caze(j)\y, \Line(i)\caze(j)\w, \Line(i)\caze(j)\h)
            VectorSourceColor(RGBA(255,0,0,100))
            StrokePath(40)
          EndIf
        Next
      Next
    EndWith
    
    
;     MovePathCursor(x,y)
;     DrawVectorImage(ImageID(#Img_PageDrawing),255,w,h)
    
    StopVectorDrawing()
  EndIf
  
EndProcedure
Procedure LineCase_GetProperties()
  With project\page(PageId)\Line(LineID)
    SetGadgetState(#G_win_Story_CaseDepth, \caze(CaseId)\Depth)
    SetGadgetState(#G_win_Story_CaseX, \caze(CaseId)\x)
    SetGadgetState(#G_win_Story_CaseY, \caze(CaseId)\y)
    SetGadgetState(#G_win_Story_CaseW, \caze(CaseId)\w)
    SetGadgetState(#G_win_Story_CaseH, \caze(CaseId)\h)
    SetGadgetState(#G_win_Story_LineY, \y)
    SetGadgetState(#G_win_Story_LineH, \h)
    SetGadgetState(#G_win_Story_LineID, lineId)
  EndWith
EndProcedure

; Canvas main
Procedure Canvas_SetZoom(zoom=-1)
  If zoom>=1
    VDOptions\Zoom = zoom
  EndIf
  UpdateCanvasMain()
  StatusBarText(0, 0, "Zoom"+" "+Str(VdOptions\Zoom)+"%")
EndProcedure
Procedure EventCanvasMain(gad=#G_win_Story_Canvas)
  Static down, x, y, startx, starty,start
  
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
  cx = vd\PagecenterX
  cy = vd\PageCenterY
  
  ; key down
  If EventType() = #PB_EventType_KeyDown ; Or EventType() = #PB_EventType_Focus          
    If GetGadgetAttribute(gad, #PB_Canvas_Modifiers) & #PB_Canvas_Shift                            
      vd\Shift = 1                          
    EndIf  
    If GetGadgetAttribute(gad, #PB_Canvas_Modifiers) & #PB_Canvas_Control                         
      vd\ctrl = 1                          
    EndIf                        
    If GetGadgetAttribute(gad, #PB_Canvas_Key) & #PB_Shortcut_Space                         
      Vd\Space = 1                            
    EndIf
  EndIf
  
  If EventType() = #PB_EventType_LeftButtonDown Or 
     (EventType() = #PB_EventType_MouseMove And                         
      GetGadgetAttribute(gad, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton) 
    
    If Vd\space = 1  ; on appuie sur espace 
      x = GetGadgetAttribute(gad, #PB_Canvas_MouseX) /Z
      y = GetGadgetAttribute(gad, #PB_Canvas_MouseY) /Z
      If Vd\ClicLb = 0                                   
        Vd\cliclb = 1
        Vd\spaceX = X - VD\ViewX
        Vd\spaceY = Y - VD\ViewY
      EndIf 
      VD\viewX = x - Vd\spaceX
      VD\viewY = y - Vd\spaceY
      
    Else
      
      If EventType() = #PB_EventType_LeftButtonDown
        down = 1
        If VD\EditMode = 0
          ; SetActiveGadget(#G_win_Story_Canvas)
          x = GetGadgetAttribute(gad, #PB_Canvas_MouseX) /z ;- cx 
          y = GetGadgetAttribute(gad, #PB_Canvas_MouseY) /z ;- cy 
          
          With project\page(PageId)
            For i=0 To ArraySize(\Line())
              If y>=vy/z+margeTop+\Line(i)\y And y<=vy/z+margeTop+\Line(i)\y +\Line(i)\h
                lineID = i
                For j=0 To ArraySize(\Line(i)\caze())
                  ; If x>=vx+margeL+\Line(i)\caze(j)\x And x<=vx+margeL+\Line(i)\caze(j)\x +\Line(i)\caze(j)\w
                  If x>=vx/z+(margeL+\Line(i)\caze(j)\x) And x<=vx/z+(margeL+\Line(i)\caze(j)\x +\Line(i)\caze(j)\w)
                    caseId = j
                    Break
                  EndIf
                Next
                LineCase_GetProperties()
                ;Debug Str(\Line(i)\y)+"/"+Str(\Line(i)\y +\Line(i)\h)
                Break
              EndIf
            Next
            
            ; StatusBarText(0, 2, Str(X)+"/"+Str(vx)+"/"+Str(vx/z)+"/"+Str(vx+margeL+\Line(LineID)\caze(CaseID)\x))
            
          EndWith
          UpdateCanvasMain()
        Else
          If StartVectorDrawing(CanvasVectorOutput(gad))
            x1 = GetGadgetAttribute(gad, #PB_Canvas_MouseX)
            y1 = GetGadgetAttribute(gad, #PB_Canvas_MouseY) 
            x = ConvertCoordinateX(x1, y1, #PB_Coordinate_Device, #PB_Coordinate_User)/z -vx ;-margeL
            y = ConvertCoordinateY(x1, y1, #PB_Coordinate_Device, #PB_Coordinate_User)/z -vy ;- margeTop
            startx = x
            starty = y
            
            NbStroke +1
            ReDim Stroke.sStroke(NbStroke)
            Stroke(NbStroke)\dot(0)\x = x
            Stroke(NbStroke)\dot(0)\y = y
            StopVectorDrawing()
            
          EndIf
        EndIf
        
      ElseIf EventType() = #PB_EventType_MouseMove 
        If VD\EditMode = 1
          If down
            If StartVectorDrawing(CanvasVectorOutput(gad))
              x1 = GetGadgetAttribute(gad, #PB_Canvas_MouseX) 
              y1 = GetGadgetAttribute(gad, #PB_Canvas_MouseY) 
              
              x = ConvertCoordinateX(x1, y1, #PB_Coordinate_Device, #PB_Coordinate_User)/Z  -vx ;-margeL
              y = ConvertCoordinateY(x1, y1, #PB_Coordinate_Device, #PB_Coordinate_User)/z  -vy ;-margeTop
              
              j = nbstroke
              n = ArraySize(Stroke(j)\dot())+1
              ReDim Stroke(j)\dot(n)
              Stroke(j)\dot(n)\x = x
              Stroke(j)\dot(n)\y = y
              
;               MovePathCursor(startx,starty)
;               AddPathLine(x,y)
;               VectorSourceColor(RGBA(0,0,0,255))
;               StrokePath(4,#PB_Path_RoundEnd)
;               startx = x
;               starty = y
              StopVectorDrawing()
              update=2
            EndIf
            
          EndIf
        EndIf
        
      EndIf
      
    EndIf
    
  EndIf
  
  If Vd\cliclb = 1 Or update >= 1 ; Or vd\ClicSelect =1
    
    If Vd\space = 1 Or update>1
      UpdateCanvasMain()
    Else
      ;Drawcanvas(x,y,1) 
    EndIf
    update = 0
  EndIf
  
  If EventType() = #PB_EventType_LeftButtonUp
    down = 0
    Vd\cliclb = 0
    start=0
  ElseIf EventType() = #PB_EventType_MouseWheel
    ;{ zoom
    delta = GetGadgetAttribute(gad, #PB_Canvas_WheelDelta)
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
    Canvas_SetZoom()
    ;}
  ElseIf EventType() = #PB_EventType_KeyUp 
    ;{ key up
    
    ; Debug "key "+GetGadgetAttribute(gad, #PB_Canvas_Key)
    ; enter 13
    ; altgr 18
    ; tab 9
    If GetGadgetAttribute(gad, #PB_Canvas_Key) = #PB_Shortcut_Space 
      Vd\space= 0                           
      ;     vd\keypressed = 0                           
    EndIf                        
    If GetGadgetAttribute(gad, #PB_Canvas_Key)= 16 ; shift 
      Vd\shift= 0                           
      ;     vd\keypressed = 0                          
    EndIf  
    If GetGadgetAttribute(gad, #PB_Canvas_Key)= 17 ; ctrl 
      Vd\ctrl= 0                           
      ;     vd\keypressed = 0                          
    EndIf 
    ;}
  EndIf
  
EndProcedure

; create page, line, case...
Procedure Page_update(nbcase=1,updatelineproperties=1)
  
  With Project
    k = pageId
    ; define the properties
    w = \Width 
    h = \Height
    ;     If VDOptions\ModeAutomatic = 1
    ;       margeL = \MargeLeft
    ;       margeR = \MargeRight
    ;       MargeTop = \MargeTop 
    ;       margeBottom = \MargeBottom
    ;       
    ;       ; space between lines and cases
    ;       spacelineH = \SpacebetweenLine
    ;       spaceCaseW = \SpacebetweenCase
    ;     Else
    margeL = \page(pageId)\MargeLeft
    margeR = \page(pageId)\MargeRight
    MargeTop = \page(pageId)\MargeTop 
    margeBottom = \page(pageId)\MargeBottom
    
    ; space between lines and cases
    spacelineH = \page(pageId)\SpacebetweenLine
    spaceCaseW = \page(pageId)\SpacebetweenCase
    ;     EndIf
    
    
    
    
    
    ; define other paramters
    nbline = \page(k)\Nbline
    n1 = nbline+1
    h1 = (h-margeBottom-MargeTop)/n1 - (spacelineH*nbline)/n1 ; * nbline
    w1 = w-margeL-margeR
    
    If VDOptions\ModeAutomatic = 1
      nbcase = \page(k)\NbcaseByline ; ArraySize(\page(k)\Line(0)\caze())
      
      For i=0 To ArraySize( \page(k)\Line())
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
      ; set lineID properties
      If lineID >ArraySize(\page(k)\Line())
        lineID = ArraySize(\page(k)\Line())
      EndIf
      
      i = lineID
      x = \page(k)\Line(i)\x ;0 ;margeL
      y = \page(k)\Line(i)\y ;i * (h1 + spacelineH); +MargeTop
      w1 = \page(k)\Line(i)\w;i * (h1 + spacelineH); +MargeTop
      h1 = \page(k)\Line(i)\h;i * (h1 + spacelineH); +MargeTop
      Line_SetProperties(i,x,y,w1,h1)
      For j=0 To ArraySize(\page(k)\Line(i)\caze())
        \page(k)\Line(i)\caze(j)\h = h1
        \page(k)\Line(i)\caze(j)\y = y
      Next
      
      
      
      ;         ; set case  properties
      ;         ; Line_SetNBCase(nbcase)
      ;         nbcase = ArraySize(\page(k)\Line(i)\caze())
      ;         n = nbcase +1
      ;         w2 = (w1 - (spaceCaseW * nbcase))/n
      ;         For j=0 To nbcase
      ;           x1 = x + j * (spaceCaseW + w2)
      ;           ; Case_SetProperties(j,x1,y,w2,h1)
      ;         Next
      ;         
      ;       Next
      ;       lineId = 0
    EndIf
    
  EndWith
  
  
  ; set gadget parameters
  With project\page(PageId)
    SetGadgetState(#G_win_Story_MargeBottom, \MargeBottom)
    SetGadgetState(#G_win_Story_MargeLeft, \MargeLeft)
    SetGadgetState(#G_win_Story_MargeRight, \MargeRight)
    SetGadgetState(#G_win_Story_MargeTop, \MargeTop)
    SetGadgetState(#G_win_Story_SpacebetweenCase, \SpacebetweenCase)
    SetGadgetState(#G_win_Story_SpacebetweenLine, \SpacebetweenLine)
  EndWith
  
  If updatelineproperties
    LineCase_GetProperties()
  EndIf
  
  ; update the canvas
  UpdateCanvasMain()
EndProcedure
Procedure Case_SetProperties(i,x,y,w,h)
  With project\page(pageId)\Line(lineId)
    \caze(i)\x = x
    \caze(i)\y = y
    \caze(i)\w = w
    \caze(i)\h = h
    If \caze(i)\Depth = 0
      \caze(i)\Depth = i
    EndIf
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

; GAdgets
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
Procedure CreateTheGadgets()
  
  ;{ add gadgets
  winH = WindowHeight(#BDC_Win_Storyboard)
  winW = WindowWidth(#BDC_Win_Storyboard)
  tbh = 30
  VDOptions\ToolbarH = tbh
  x = 5 : y=5 : wp = 230 : hp= winH-y-5-StatusBarHeight(#BDC_StatusbarMain)-MenuHeight()-tbh: w1 = wp-(2*wp)/5-30 : 
  h1 = 30 : a=2
  b = 18
  VDOptions\panelW = wp
  
  ; toolbar 
  If ContainerGadget(#G_win_Story_ContToolBar,0,0,winw,tbh)
    c=150
    SetGadgetColor(#G_win_Story_ContToolBar,#PB_Gadget_BackColor ,RGB(c,c,c))
    AddGadget(#G_win_Story_Editmode,#Gad_Cbbox,x,2,150,tbh-4,"",0,0,lang("Choose the EditMode"),0)
    line$ = "Create Page,Paint"
    For i=0 To 1
      AddGadgetItem(#G_win_Story_Editmode,i,StringField(line$, i+1,","))
    Next
    SetGadgetState(#G_win_Story_Editmode,0)
    CloseGadgetList()
  EndIf
  
  If PanelGadget(#G_win_Story_panel, x,y+tbh,wp,hp)
    AddGadgetItem(#G_win_Story_panel, -1, Lang("Create"))
    If ScrollAreaGadget(#G_win_Story_SA,2,2,wp-10,hp-35,wp-40,hp+200)
      
      ; general
      If FrameGadget(#PB_Any, 2,y,wp-2,4*(h1+a)+20,lang("general"))
        y+b
        AddGadget(#G_win_Story_ModeAutomatic,#Gad_Chkbox,x,y,w1,h1,Lang("Automatic"),1,20,Lang("Use automatic mode for automatic changes for all pages, and create automatic things like cases"),1,Lang("Mode")) : y+h1+a
        AddGadget(#G_win_Story_PageSelect,#Gad_Cbbox,x,y,w1,h1,"",1,20,Lang("Select the page"),3,Lang("Page :")) : y+h1+a
      EndIf
      AddGadget(#G_win_Story_LineNb,#Gad_spin,x,y,w1,h1,"",1,20,Lang("Set the number of lines for this page"),3,Lang("Nb of lines")) : y+h1+a
      AddGadget(#G_win_Story_NbCaseByLine,#Gad_spin,x,y,w1,h1,"",1,20,Lang("Set the number of cases by lines for this page (automatic mode)"),2,Lang("Nb of Cases"))
      y+h1+10
      
      ; marges
      If FrameGadget(#PB_Any, 2,y,wp-2,4*(h1+a)+20,lang("Border"))
        y+b
        AddGadget(#G_win_Story_MargeTop,#Gad_spin,x,y,w1,h1,"",0,20000,"Set the Top Space for this page, or in automatic mode for all pages",100,Lang("Top")) : y+h1+a
        AddGadget(#G_win_Story_MargeBottom,#Gad_spin,x,y,w1,h1,"",0,20000,"Set the Bottom Space for this page, or in automatic mode for all pages",100,Lang("Bottom")) : y+h1+a
        AddGadget(#G_win_Story_MargeLeft,#Gad_spin,x,y,w1,h1,"",0,20000,"Set the Left Space for this page, or in automatic mode for all pages",100,Lang("Left")) : y+h1+a
        AddGadget(#G_win_Story_MargeRight,#Gad_spin,x,y,w1,h1,"",0,20000,"Set the Right Space for this page, or in automatic mode for all pages",100,Lang("Right")) 
        y+h1+10
      EndIf
      
      If FrameGadget(#PB_Any, 2,y,wp-2,2*(h1+a)+20,lang("Space"))
        y+b
        AddGadget(#G_win_Story_SpacebetweenLine,#Gad_spin,x,y,w1,h1,"",0,2000,Lang("Set the Space between lines (in automatic mode for all pages, else only for this page)"),50,Lang("Lines")) : y+h1+a
        AddGadget(#G_win_Story_SpacebetweenCase,#Gad_spin,x,y,w1,h1,"",0,2000,Lang("Set the Space between cases (in automatic mode for all pages, else only for this page)"),50,Lang("Cases"))
        y+h1+15
      EndIf
      
      If FrameGadget(#PB_Any, 2,y,wp-2,3*(h1+a)+20,lang("Line"))
        y+b
        AddGadget(#G_win_Story_LineID,#Gad_spin,x,y,w1,h1,"",0,100,Lang("Select the line you want to change"),0,Lang("Select line")) : y+h1+a
        AddGadget(#G_win_Story_LineY,#Gad_spin,x,y,w1,h1,"",-10000,10000,Lang("Set the Y for the selected line (automatic mode should be unselected)"),0,Lang("Line Y")) : y+h1+a
        AddGadget(#G_win_Story_LineH,#Gad_spin,x,y,w1,h1,"",0,10000,Lang("Set the height for the selected line (automatic mode should be unselected)"),0,Lang("Line H")) 
        y+h1+5
      EndIf 
      If FrameGadget(#PB_Any, 2,y,wp-2,4*(h1+a)+20,lang("Case"))
        y+b
        AddGadget(#G_win_Story_CaseDepth,#Gad_spin,x,y,w1,h1,"",0,100000,Lang("Set the Depth for the selected case (the more the depth is high, the more the case is over the other cases)"),0,Lang("Depth")) : y+h1+a
        AddGadget(#G_win_Story_CaseX,#Gad_spin,x,y,w1,h1,"",0,10000,Lang("Set the X for the selected case (Not in automatic mode)"),0,Lang("Case X")) : y+h1+a
        AddGadget(#G_win_Story_CaseY,#Gad_spin,x,y,w1,h1,"",0,10000,Lang("Set the Y for the selected case (Not in automatic mode)"),0,Lang("Case Y")) : y+h1+a
        AddGadget(#G_win_Story_CaseW,#Gad_spin,x,y,w1,h1,"",0,10000,Lang("Set the width for the selected case (Not in automatic mode)"),0,Lang("Case W")) : y+h1+a
        AddGadget(#G_win_Story_CaseH,#Gad_spin,x,y,w1,h1,"",0,10000,Lang("Set the height for the selected case (Not in automatic mode)"),0,Lang("Case H"))
        y+h1+10
      EndIf 
      
      
      CloseGadgetList()
    EndIf
    CloseGadgetList()
  EndIf
  
  y = 5+tbh : x+wp+5
  If CanvasGadget(#G_win_Story_Canvas, x, y, winw - wp-15, hp,#PB_Canvas_Border|#PB_Canvas_Keyboard): EndIf
  ;}
  
EndProcedure

; Menu
Procedure Doc_New(name$="New project",w=2500,h=3500,spacelineH=50,spaceCaseW=50,nbpage=0,margeL=150,margeR=150,MargeTop=250,margeBottom=200)
  
  ResetStructure(@project, sProject)
  ClearGadgetItems(#G_win_Story_PageSelect)
  
;   FreeImage2(#Img_PageDrawing)
;   If CreateImage(#Img_PageDrawing,10,10,32,#PB_Image_Transparent) : EndIf
;   ImageID = #Img_PageDrawing
  
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
  ;vd\viewx = (GadgetWidth(#G_win_Story_Canvas)-(Project\Width * VDOptions\Zoom*0.01))/2
  ;vd\viewy = (GadgetHeight(#G_win_Story_Canvas)-(Project\Height * VDOptions\Zoom*0.01))/2
  
  ; update 
  Page_update()
  LineCase_GetProperties()
  With Project\page(0)\Line(0)\caze(0)
    If  \image = 0
      \image = CreateImage(#PB_Any, \w, \h,32,#PB_Image_Transparent)
      ImageID = \image  
    EndIf
  EndWith
  
  
  
EndProcedure
Procedure Doc_Open()
EndProcedure
Procedure Doc_Save()
EndProcedure
Procedure Doc_ExportImage()
  
  filename$ = SaveFileRequester(lang("save image"),GetCurrentDirectory(),"Png|*.png|JPG|*jpg|BMP|*bmp",0)
  
  If filename$<> #Empty$
    
    If GetExtensionPart(filename$) = ""
      Select SelectedFilePattern()
        Case 0 
          ext$ =".png"
          format = #PB_ImagePlugin_PNG     
        Case 1
          ext$=".jpg"
          format = #PB_ImagePlugin_JPEG    
        Case 2
          ext$ =".bmp"
          format = #PB_ImagePlugin_BMP   
      EndSelect
      filename$+ext$
    EndIf
    
    If CreateImage(#Img_Export, Project\Width, project\Height, 32, #PB_Image_Transparent)
      id = #Img_Export
      If StartVectorDrawing(ImageVectorOutput(id)) 
        x = 0
        y = 0
        w = Project\Width 
        h = Project\Height 
        
        ; white bg
        AddPathBox(x,y,w,h)
        c = 255
        VectorSourceColor(RGBA(c,c,c,255))
        FillPath()
        
        ; draw the cases and its content
        With Project\page(pageId)
          margeL = \MargeLeft
          margeTop = \MargeTop
          h_l1 = Project\SpacebetweenLine * z
          w_c1 = Project\SpacebetweenCase * z 
          For i=0 To ArraySize(\Line())
            For j= 0 To ArraySize(\Line(i)\caze())
              
              x1 = x + margeL 
              y1 = y + margeTop 
              
              ;White Background for each case
              AddPathBox(x1+\Line(i)\caze(j)\x, y1+\Line(i)\caze(j)\y, \Line(i)\caze(j)\w , \Line(i)\caze(j)\h)
              VectorSourceColor(RGBA(255,255,255,255))
              FillPath() 
              
              
              ; draw the elements
              ; characters and background
              
              ; draw border for each case
              AddPathBox(x1+\Line(i)\caze(j)\x, y1+\Line(i)\caze(j)\y , \Line(i)\caze(j)\w, \Line(i)\caze(j)\h)
              VectorSourceColor(RGBA(0,0,0,255))
              StrokePath(3)
              
              
            Next
          Next
        EndWith
        
        StopVectorDrawing()
      EndIf
      
      If SaveImage(id, filename$,format,8) :EndIf
      FreeImage(id)
    EndIf
    
  EndIf
  
EndProcedure


; other window
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
  VDOptions\Zoom = 100
  ; statusbar
  CreateStatusBar(#BDC_StatusbarMain,WindowID(#BDC_Win_Storyboard))
  AddStatusBarField(100)
  AddStatusBarField(100)
  AddStatusBarField(500)
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
    OpenSubMenu(lang("Zoom"))
    MenuItem(#BDC_Menu_ViewZoom10, lang("Zoom")+" 10%")
    MenuItem(#BDC_Menu_ViewZoom15, lang("Zoom")+" 15%")
    MenuItem(#BDC_Menu_ViewZoom20, lang("Zoom")+" 20%")
    MenuItem(#BDC_Menu_ViewZoom30, lang("Zoom")+" 30%")
    MenuItem(#BDC_Menu_ViewZoom50, lang("Zoom")+" 50%")
    MenuItem(#BDC_Menu_ViewZoom70, lang("Zoom")+" 70%")
    MenuItem(#BDC_Menu_ViewZoom100, lang("Zoom")+" 100%")
    MenuItem(#BDC_Menu_ViewZoom200, lang("Zoom")+" 200%")
    CloseSubMenu()
        
    MenuTitle(Lang("Page"))
    MenuItem(#BDC_Menu_PageAdd, lang("Add page"))
    MenuItem(#BDC_Menu_PageDelete, lang("Delete the page"))
    MenuTitle(Lang("Help"))
  EndIf
  
  CreateTheGadgets()
  
  ; test project
  Doc_New()
  
  ;}
  
  Repeat
    Event = WaitWindowEvent()
    EventGadget =  EventGadget()
    EventMenu =  EventMenu()
    
    Select Event 
        
      Case #PB_Event_Gadget
        Select EventWindow()
            
          Case #BDC_Win_Storyboard ; main
            Select EventGadget
                
              Case #G_win_Story_Editmode
                vd\EditMode = GetGadgetState(#G_win_Story_Editmode)
                
              Case #G_win_Story_LineID
                id = GetGadgetState(#G_win_Story_LineID)
                If id <0 Or id > ArraySize(project\page(pageID)\Line())
                  SetGadgetState(#G_win_Story_LineID, lineId)
                Else
                  lineid = id
                  UpdateCanvasMain()
                EndIf
                
              Case #G_win_Story_CaseDepth
                Project\page(pageID)\Line(lineId)\caze(CaseId)\Depth = GetGadgetState(#G_win_Story_CaseDepth)
                SortStructuredArray(Project\page(pageID)\Line(lineId)\caze(),#PB_Sort_Ascending ,OffsetOf(sCase\Depth),TypeOf(sCase\Depth))
                Page_update(0,0)

              Case #G_win_Story_CaseH, #G_win_Story_CaseW, #G_win_Story_CaseX, #G_win_Story_CaseY 
                With Project\page(pageID)
                  \Line(lineId)\caze(CaseId)\x = GetGadgetState(#G_win_Story_CaseX)
                  \Line(lineId)\caze(CaseId)\y = GetGadgetState(#G_win_Story_CaseY)
                  \Line(lineId)\caze(CaseId)\W = GetGadgetState(#G_win_Story_CaseW)
                  \Line(lineId)\caze(CaseId)\h = GetGadgetState(#G_win_Story_CaseH)
                EndWith
                Page_update(0,0)
                
              Case #G_win_Story_LineH, #G_win_Story_LineY
                With Project\page(pageID)
                  \Line(LineId)\h = GetGadgetState(#G_win_Story_LineH)
                  \Line(LineId)\y = GetGadgetState(#G_win_Story_LineY)
                EndWith
                Page_update(0,0)
                
              Case #G_win_Story_MargeTop, #G_win_Story_MargeBottom, #G_win_Story_MargeLeft, #G_win_Story_MargeRight,#G_win_Story_SpacebetweenLine,#G_win_Story_SpacebetweenCase
                If VDOptions\ModeAutomatic =1
                  Project\MargeLeft = GetGadgetState(#G_win_Story_MargeLeft)
                  Project\MargeRight = GetGadgetState(#G_win_Story_MargeRight)
                  Project\MargeBottom = GetGadgetState(#G_win_Story_MargeBottom)
                  Project\MargeTop = GetGadgetState(#G_win_Story_MargeTop)
                  Project\SpacebetweenLine = GetGadgetState(#G_win_Story_SpacebetweenLine)
                  Project\SpacebetweenCase = GetGadgetState(#G_win_Story_SpacebetweenCase)
                EndIf   
                With Project\page(pageID)
                  \MargeLeft = GetGadgetState(#G_win_Story_MargeLeft)
                  \MargeRight = GetGadgetState(#G_win_Story_MargeRight)
                  \MargeBottom = GetGadgetState(#G_win_Story_MargeBottom)
                  \MargeTop = GetGadgetState(#G_win_Story_MargeTop)
                  \SpacebetweenLine = GetGadgetState(#G_win_Story_SpacebetweenLine)
                  \SpacebetweenCase = GetGadgetState(#G_win_Story_SpacebetweenCase)
                EndWith
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
                    ReDim Project\page(PageId)\Line(LineId)\caze(nb)
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
                EventCanvasMain()
                
            EndSelect
            
          Case #BDC_Win_ProjectProperties
            Select EventGadget
                
              Case #G_win_BDCprop_title
                name$ = GetGadgetText(#G_win_BDCprop_title)
                If name$ <> #Empty$
                  project\Name$ = name$
                EndIf
                
              Case #G_win_BDCprop_NbPage
                ;Debug "ok gadget change nb page"
                nb = GetGadgetState(EventGadget)
                If nb>=1 
                  If nb<=1000
                    If nb > ArraySize(project\page())
                      ; Debug "ok 2 !!!"
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
            ;{ File
          Case #BDC_Menu_OpenDoc
            Doc_Open()
            
          Case #BDC_Menu_SaveDoc
            Doc_save()
            
          Case #BDC_Menu_NewDoc
            If MessageRequester(lang("Info"),lang("Are you sur to create a new project? All previous work will be lost."),#PB_MessageRequester_YesNo) = #PB_MessageRequester_Yes
              Doc_New()
            EndIf
            
          Case #BDC_Menu_ExportAsImage
            Doc_ExportImage()
            
          Case #BDC_Menu_Projectproperties
            Window_ProjectProperties()
            
          Case #BDC_Menu_quit
            quit = 1 
            ;}
            
            ;{ View
          Case #BDC_Menu_ViewZoom10
            Canvas_SetZoom(10) 
            
          Case #BDC_Menu_ViewZoom15
            Canvas_SetZoom(15)
            
          Case #BDC_Menu_ViewZoom20
            Canvas_SetZoom(20)
            
          Case #BDC_Menu_ViewZoom30
            Canvas_SetZoom(30) 
            
          Case #BDC_Menu_ViewZoom50
            Canvas_SetZoom(50) 
            
          Case #BDC_Menu_ViewZoom70
            Canvas_SetZoom(70)
            
          Case #BDC_Menu_ViewZoom100
            Canvas_SetZoom(100) 
            
          Case #BDC_Menu_ViewZoom200
            Canvas_SetZoom(200)
            ;}
            
            ;{ Page
          Case #BDC_Menu_PageAdd
            Page_Add()
            
          Case #BDC_Menu_PageDelete
            Page_Add(0)
            ;}
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


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 60
; FirstLine = 39
; Folding = RSAJA9XB5DeLw-vgBQ4+AZYHA1ybOP3
; EnableXP
; DisableDebugger
; Warnings = Display
; EnablePurifier