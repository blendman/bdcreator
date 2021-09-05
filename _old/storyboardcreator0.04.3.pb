;{ infos
; BD creator ( & storyboard creation, to use with cartoon or animatoon)
; by blendman, august 2021

; BY version (date de création de la roadmap 5.8.2021) :
; V 0.03 : 
; ok - Bouger le canvas avec Space
; ok - Mode normal : définir line H,Y
; ok - definir : case w,h
; ok 0.04 - definir : case x,y
; ok - Bugfixe : sélectionner la ligne
; V 0.04 :
; - Voir le Numéro de page
; ok 0.04 - voir et Changer le depth des cases
; ok 0.03 - Sélectionner une Case
; V 0.05
; ok 0.02.3 - Case avec fond blanc
; ok 0.04 - Menu : savedoc.
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
; v 0.14 :
; ok 0.03 - pouvoir dessiner sur la page
; v 0.15 :
; ok 0.04 - export page as template


; Priority :
; - add a menu file : preference
; - page : delete, move < >
; - add a "edition mode" :  page, graphics, text
; - add image
; ? - add character
; ? - add background
; - case : set zoom
; - add bulles and text.
; - export in png layers.
; - show the space (between line and case)

; ok :
; - doc_open()
; - in normal mode (not automatic) : change the x/y/w/h of case selected 
; - in normal mode (not automatic) : change the y/h of line selected
; - doc_save()
; - export page template
; - export image (full image) 
; - add a menu File, Edit, view, page..
; - page : add, select

; bugs : 
; ok - select line is bugged
; - select line & case is bugged if move viewx/y
; - on ne peut pas bouger la case en Y ni changer sa hauteur
; - mode normal : si on ajoute une case, il faudrait qu'elle soit créé à droite, après la dernière case et avec la largeur disponible (pas w=0 et x=0)


; 8.8.2021 0.04.3 (5)
; // new
; wip - tab case : clic btn "Edit"  : open a window to edit the case (add/delete images, move image, select)
; - tab case : btn "Edit" (to edit the "image" of the case)
; - UpdateCanvasMain : draw utilities (the marge) 
; - menu view\show : case selected, marge


; 7.8.2021 0.04 (4)
; // new
; - Doc_open() : open infos : gen, project, pages, lines, cases
; - create : add gadget select case.
; - add tabcase (empty), text (empty)
; - ChangePixelToCm() : to convert pixels to mm or cm to pixels
; - Doc_ExportPageAsTemplate()
; - Doc_save()
; - panel : add gagdet stroke size, alpha
; - project : add stroke color/alpha/size (dependaning of the resolution)
; - Mode normal : we can change the number of case by line
; - Mode normal : define caseID X/Y
; - panel create : add gadget case depth (and update if change case)
; - we can change the depth of a case (-> use sortstructuredarray after the changes)
; - creation page : if case()\depth=0 -> case()\depth = i
; // fixes
; - when select a line in page and change page, crash if lineID > arraysize(page()\line())
; - gadget marge aren't updated if doc_new().
; - gadget spacebetween (line/case) aren't updated with page_update() (& new_doc()).
; - gadgetitem selectpage is'nt clear if Doc_new() and page_update


; 6.8.2021 0.03 (3)
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


; 5.8.2021 0.02 (2)
; // new
; - Add menu (file, edit, view, help)
; - Add menu file : New, open, save, export, quit.
; - Add menu Page : Add (ok), delete (not ok).
; - add lang() system
; - Page : add, select
; - windowprojectproperties : define title and number of pages for projet

; 4.8.2021 0.01 (1)
; // new
; - window main
; - panel left gadgets : number of lines, nb of cases (if automaticMode=1), checkbox for automaticmode
; - panel left gadgets : space (marge) top, bottom, left, right.
; - panel left gadgets : spacebetween line And Case (automaticMode).
; - main canvas
; - Createproject() : with project parameters (nb page, title, marge, space between line and case...)
; - UpdateCanvasMain() : create the storyboard (page & cases for the moment)
;}

#BDC_ProgramVersion = "0.04.3"
#BDC_ProgramName = "BD Creator"
Enumeration 
  
  #BDC_StatusbarMain = 0
  
  ;{ window
  #BDC_Win_Main = 0
  #BDC_Win_ProjectProperties
  #BDC_Win_EditCase
  ;}
  
  ;{ menu
  #JSONFile = 0
  
  #BDC_Menu_Main=0
  
  ; menu imtems main window
  #BDC_Menu_NewDoc=0
  #BDC_Menu_OpenDoc
  #BDC_Menu_SaveDoc
  #BDC_Menu_Projectproperties
  #BDC_Menu_ExportAsImage
  #BDC_Menu_ExportAsLayer
  #BDC_Menu_ExportPageAsTemplate
  #BDC_Menu_Quit
  ; view
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
  #BDC_Menu_ViewShowCaseSelected
  #BDC_Menu_ViewShowMarge
  #BDC_Menu_ViewShowSpace
  ; page
  #BDC_Menu_PageAdd
  #BDC_Menu_PageAddBefore
  #BDC_Menu_PageAddAfter
  #BDC_Menu_PageDelete
  ;}
  
  ;{ gadget
  
  ;{ window main
  #G_win_Story_Canvas = 0
  #G_win_Story_ContToolBar
  #G_win_Story_Editmode
  ; 
  #G_win_Story_panel
  #G_win_Story_SA ; scrollarea
  #G_win_Story_ModelesPage
  ; stroke for case
  #G_win_Story_StrokeSize
  #G_win_Story_StrokeColor
  #G_win_Story_StrokeAlpha
  ; page
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
  
  #G_win_Story_BankImage
  #G_win_Story_BankFolder
  #G_win_Story_BAnkSubFolder
  #G_win_Story_ImageAdd
  #G_win_Story_ImageDel
  #G_win_Story_ImageX
  #G_win_Story_ImageY
  #G_win_Story_ImageScale
  
  #G_win_Story_AddText
  #G_win_Story_TextSet
  #G_win_Story_TextFont
  
  #G_win_Story_Last ; last gadget for the main window
                    ;}
  
  ; other window
  ;{ window Edit case
  #G_win_EditCase_Canvas
  #G_win_EditCase_SA
  #G_win_EditCase_ImageList
  #G_win_EditCase_BtnImageAdd
  #G_win_EditCase_BtnImageDel
  #G_win_EditCase_ImageX
  #G_win_EditCase_ImageY
  #G_win_EditCase_ImageW
  #G_win_EditCase_ImageH
  #G_win_EditCase_ImageScale
  #G_win_EditCase_ImageAlpha
  #G_win_EditCase_ImageDepth
  ;}
  
  ;{ WIndow project properties
  #G_win_BDCprop_title
  #G_win_BDCprop_NbPage
  #G_win_BDCprop_Width ; in cm
  #G_win_BDCprop_Height; in cm
  #G_win_BDCprop_DPI
  #G_win_BDCprop_Wpixel
  #G_win_BDCprop_Hpixel
  ;}
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
  ;Tile$
  Width.w
  Height.w
EndStructure


Structure sImg
  img.i
  file$
  depth.w
  alpha.a
  x.w
  y.w
  w.w
  h.w
  scale.d
EndStructure
Structure sCase
  w.w
  h.w
  x.w
  y.w
  Array image.sImg(0)
  nbImage.w
  imageFinal.sImg
  
  NotRectangle.a
  SizeBorder.w
  ; If Case isn't rectangle
  ; x2.w
  ; y2.w
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
  Number.w ; numero de page
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
  ; info taille et dpi
  dpi.w
  Width_mm.w
  Height_mm.w
  ; info for the stroke
  StrokeSize.a
  StrokeColor.i
  StrokeAlpha.a
  ; the pages
  Nbpage.w
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

Structure sBDCOptions
  Action.a
  Modeautomatic.a
  PanelW.w
  ToolbarH.a
  Zoom.w
  
  ShowMarge.a
  ShowSelected.a
  ; path
  PathSave$
  pathOpen$
  PathExport$
  PathImage$
EndStructure
Global BDCOptions.sBDCOptions

Structure sPoint
  x.i
  y.i
EndStructure
Structure sStroke
  Array dot.sPoint(0)
  Size.w
EndStructure
Global Dim stroke.sStroke(0), NbStroke=-1
Stroke(0)\Size = 4

Global PixelToMm.d = 25.4 
Global cmToPixel.d = 39.37 

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
Procedure ChangePixelToCm(w, nbdpi, mode=0)
  If mode = 0 ; pixel to mm
    ; w in mm
    nb = ((nbdpi * w)/ Pixeltomm)
  Else
    ; change pixel To cm
    ;w = nb of pixels
    nb = (100*w)/(cmtopixel*nbdpi)
  EndIf
  ProcedureReturn nb
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


Procedure Canvas_DrawImage(i,j,x1,y1)
  ; images
  With project\page(PageId)
    img = \Line(i)\caze(j)\imageFinal\img
    If IsImage(img)
      MovePathCursor(x1 + \Line(i)\caze(j)\x + \Line(i)\caze(j)\imageFinal\x ,y1 + \Line(i)\caze(j)\y+ \Line(i)\caze(j)\imageFinal\y) 
      DrawVectorImage(ImageID(img)) ;,255,w2,h2)
    EndIf
  EndWith
        
EndProcedure
Procedure UpdateCanvasMain(gad=#G_win_Story_Canvas,outputid=0)
  
  z.d = BDCOptions\Zoom * 0.01
  c=140
  
  wc = GadgetWidth(gad)
  hc = GadgetHeight(gad)
  
  r.d = Project\dpi /300
  
  If BDCOptions\modeautomatic= 1
    With Project
      margeL = \MargeLeft
      margeR = \MargeRight
      margeTop = \MargeTop
      margeB = \MargeBottom
    EndWith
  Else
    With Project\page(pageId)
      margeL = \MargeLeft
      margeR = \MargeRight
      margeTop = \MargeTop
      margeB = \MargeBottom
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
          
          Canvas_DrawImage(i,j,x1,y1)
          
          ; drawing
          For k=0 To ArraySize(Stroke())
            MovePathCursor(stroke(k)\dot(0)\x+ vx,stroke(k)\dot(0)\y+ vy)
            For f=1 To ArraySize(stroke(k)\dot())
              xa = stroke(k)\dot(f)\x + vx
              ya = stroke(k)\dot(f)\y + vy
              AddPathLine(xa,ya)
              ; MovePathCursor(xa, ya)
            Next
            VectorSourceColor(RGBA(0,0,0,255))
            StrokePath(stroke(k)\Size) ;,#PB_Path_RoundEnd)
          Next
          
          ; black stroke for each case
          MovePathCursor(0,0)
          AddPathBox(x1+\Line(i)\caze(j)\x , y1+\Line(i)\caze(j)\y, \Line(i)\caze(j)\w, \Line(i)\caze(j)\h )
          c = project\StrokeColor
          VectorSourceColor(RGBA(Red(c), Green(c), Blue(c), project\StrokeAlpha))
          StrokePath(project\StrokeSize * Project\Width/2500,#PB_Path_RoundEnd|#PB_Path_RoundCorner   )
          
          ; selection of the case
          If BDCOptions\showSelected 
            If i = lineID And j = caseid
              AddPathBox(x1+\Line(i)\caze(j)\x, y1+\Line(i)\caze(j)\y, \Line(i)\caze(j)\w, \Line(i)\caze(j)\h)
              VectorSourceColor(RGBA(255,0,0,100))
              StrokePath(40)
            EndIf
          EndIf
        Next
      Next
    EndWith
    
    ; draw utilities
    If BDCOptions\showMarge
      MovePathCursor(x+margeL,y+margeTop)
      ;AddPathLine(margeL ,margeTop )
      AddPathLine(x+Project\Width -margeR ,y+margeTop )
      AddPathLine(x+Project\Width -margeR ,y+project\Height -margeB)
      AddPathLine(x+margeL,y+project\Height-margeB )
      ClosePath()
      VectorSourceColor(RGBA(0,0,255,100))
      StrokePath(10)
    EndIf
  
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
    BDCOptions\Zoom = zoom
  EndIf
  UpdateCanvasMain()
  StatusBarText(0, 0, "Zoom"+" "+Str(BDCOptions\Zoom)+"%")
EndProcedure
Procedure EventCanvasMain(gad=#G_win_Story_Canvas)
  Static down, x, y, startx, starty,start
  
  z.d = BDCOptions\Zoom *0.01
  
  If BDCOptions\modeautomatic= 1
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
      ;{ space
      x = GetGadgetAttribute(gad, #PB_Canvas_MouseX) /Z
      y = GetGadgetAttribute(gad, #PB_Canvas_MouseY) /Z
      If Vd\ClicLb = 0                                   
        Vd\cliclb = 1
        Vd\spaceX = X - VD\ViewX
        Vd\spaceY = Y - VD\ViewY
      EndIf 
      VD\viewX = x - Vd\spaceX
      VD\viewY = y - Vd\spaceY
      ;}
      
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
            Stroke(NbStroke)\Size = 4 * Project\Width/2500
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
      If BDCOptions\Zoom<30
        BDCOptions\Zoom + 1
      ElseIf BDCOptions\Zoom<100
        BDCOptions\Zoom + 10
      Else
        BDCOptions\Zoom + 20
      EndIf
    ElseIf delta = -1
      If BDCOptions\Zoom > 100
        BDCOptions\Zoom -20
      ElseIf BDCOptions\Zoom > 30
        BDCOptions\Zoom -10
      ElseIf BDCOptions\Zoom > 1
        BDCOptions\Zoom -1
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
    dpi = \dpi
    ;     If BDCOptions\ModeAutomatic = 1
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
    
    If BDCOptions\ModeAutomatic = 1
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
          \page(k)\Line(i)\caze(j)\SizeBorder = 4
          \page(k)\Line(i)\caze(j)\Depth = j*10
          \page(k)\Line(i)\caze(j)\nbImage = -1
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
        \page(k)\Line(i)\caze(j)\SizeBorder = 4
        \page(k)\Line(i)\caze(j)\Depth = j*10
        \page(k)\Line(i)\caze(j)\nbImage = -1
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
;     If \caze(i)\SizeBorder = 0
;       \caze(i)\SizeBorder = 4
;     EndIf
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



  
; Gadgets
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
  w_1 = BDCOptions\PanelW/3 ; BDCOptions\PanelW/3
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
  winH = WindowHeight(#BDC_Win_Main)
  winW = WindowWidth(#BDC_Win_Main)
  tbh = 30
  BDCOptions\ToolbarH = tbh
  x = 5 : y=5 : wp = 230 : hp= winH-y-5-StatusBarHeight(#BDC_StatusbarMain)-MenuHeight()-tbh: w1 = wp-(2*wp)/5-30 : 
  h1 = 30 : a=2
  b = 18
  BDCOptions\panelW = wp
  
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
    ;{
    AddGadget(#G_win_Story_ModelesPage,#Gad_Cbbox,x,y,w1,h1,"",0,0,Lang("Use a template for the current page"),1,Lang("Template")) : y+h1+a
    ;}
    
    AddGadgetItem(#G_win_Story_panel, -1, Lang("Page"))
    y=5 
    If ScrollAreaGadget(#G_win_Story_SA,2,2,wp-10,hp-35,wp-40,hp+500)
      
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
      If FrameGadget(#PB_Any, 2,y,wp-2,4*(h1+a)+20,lang("Marge"))
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
      If FrameGadget(#PB_Any, 2,y,wp-2,7*(h1+a)+20,lang("Case"))
        y+b
        AddGadget(#G_win_Story_StrokeSize,#Gad_spin,x,y,w1,h1,"",0,100,Lang("Set the stroke size for case borders"),0,Lang("Stroke Size")) : y+h1+a
        AddGadget(#G_win_Story_StrokeAlpha,#Gad_spin,x,y,w1,h1,"",0,255,Lang("Set the transparency for the stroke of the case borders"),0,Lang("Stroke Alpha")) : y+h1+8
        AddGadget(#G_win_Story_CaseID,#Gad_spin,x,y,w1,h1,"",0,100,Lang("Select the case to modify"),0,Lang("select")) : y+h1+a
        AddGadget(#G_win_Story_CaseDepth,#Gad_spin,x,y,w1,h1,"",0,100000,Lang("Set the Depth for the selected case (the more the depth is high, the more the case is over the other cases)"),0,Lang("Depth")) : y+h1+a
        AddGadget(#G_win_Story_CaseX,#Gad_spin,x,y,w1,h1,"",-10000,10000,Lang("Set the X for the selected case (Not in automatic mode)"),0,Lang("Case X")) : y+h1+a
        AddGadget(#G_win_Story_CaseY,#Gad_spin,x,y,w1,h1,"",-10000,10000,Lang("Set the Y for the selected case (Not in automatic mode)"),0,Lang("Case Y")) : y+h1+a
        AddGadget(#G_win_Story_CaseW,#Gad_spin,x,y,w1,h1,"",0,10000,Lang("Set the width for the selected case (Not in automatic mode)"),0,Lang("Case W")) : y+h1+a
        AddGadget(#G_win_Story_CaseH,#Gad_spin,x,y,w1,h1,"",0,10000,Lang("Set the height for the selected case (Not in automatic mode)"),0,Lang("Case H"))
        y+h1+10
      EndIf 
      
      
      CloseGadgetList()
    EndIf
    
    
    AddGadgetItem(#G_win_Story_panel, -1, Lang("Case"))
    y=5
     ;{
    AddGadget(#G_win_Story_ImageAdd,#Gad_Btn,x,y,w1,h1,Lang("Edit"),0,0,Lang("Add an image to the case"),1,Lang("Image")) : y+h1+a
    ;}
    AddGadgetItem(#G_win_Story_panel, -1, Lang("Text"))
    y=5
   
    CloseGadgetList()
  EndIf
  
  y = 5+tbh : x+wp+5
  If CanvasGadget(#G_win_Story_Canvas, x, y, winw - wp-15, hp,#PB_Canvas_Border|#PB_Canvas_Keyboard): EndIf
  ;}
  
EndProcedure

;{ Menu
Procedure GetFileExists(filename$)
  
  If FileSize(filename$)<=0
    ProcedureReturn 0
  Else
    If MessageRequester(lang("Info"), lang("The file already exists. Do you want ot overwrite it ?"), #PB_MessageRequester_YesNo) = #PB_MessageRequester_No
      ProcedureReturn 1
    Else
      ProcedureReturn 0
    EndIf
  EndIf
  
EndProcedure
Procedure Doc_New(name$="New project",dpi=300,wmm=210,hmm=297,w=2500,h=3500,spacelineH=50,spaceCaseW=50,nbpage=0,margeL=150,margeR=150,MargeTop=250,margeBottom=200)
  
  ResetStructure(@project, sProject)
  ClearGadgetItems(#G_win_Story_PageSelect)
  
;   FreeImage2(#Img_PageDrawing)
;   If CreateImage(#Img_PageDrawing,10,10,32,#PB_Image_Transparent) : EndIf
;   ImageID = #Img_PageDrawing
  
  With Project
    ; create the project
    \Name$ = name$
    \Date$ = FormatDate("%dd%mm%yyyy_%hh%ii%ss", Date())
    ; size
    \Width = w
    \Height = h
    \dpi = dpi
    \Height_mm = hmm
    \Width_mm = wmm
    ; stroke
    \StrokeSize = 5
    \StrokeColor = 0
    \StrokeAlpha = 255
    SetGadgetState(#G_win_Story_StrokeSize,5)
    SetGadgetState(#G_win_Story_StrokeAlpha,255)
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
  ;vd\viewx = (GadgetWidth(#G_win_Story_Canvas)-(Project\Width * BDCOptions\Zoom*0.01))/2
  ;vd\viewy = (GadgetHeight(#G_win_Story_Canvas)-(Project\Height * BDCOptions\Zoom*0.01))/2
  
  ; update 
  Page_update()
  LineCase_GetProperties()
;   With Project\page(0)\Line(0)\caze(0)
;     If \image = 0
;       \image = CreateImage(#PB_Any, \w, \h,32,#PB_Image_Transparent)
;       ImageID = \image  
;     EndIf
;   EndWith
  
EndProcedure
Procedure Doc_Open()
  
  Filename$ = OpenFileRequester(lang("Open a document"), GetCurrentDirectory(), "BDC|*.bdc|BDP|*bdp|Txt|*txt",0)
  
  If Filename$ <> #Empty$
    
    If ReadFile(0, Filename$)
      d$ = ","
      
      Doc_New()
      
      While Eof(0) = 0          
        line$ = ReadString(0) 
        index$ = StringField(line$, 1, d$)
        
        u=2
        Select index$
          Case "gen"
            version$ = StringField(line$, u, d$) : u+1
            Date$ = StringField(line$, u, d$) : u+1
            
          Case "project"
            With project
              \Name$ = StringField(line$, u, d$) : u+1
              \Info$ = StringField(line$, u, d$) : u+1
              \Date$ = StringField(line$, u, d$) : u+1
              ; marges
              \MargeTop = Val(StringField(line$, u, d$)) : u+1
              \MargeBottom = Val(StringField(line$, u, d$)) : u+1
              \MargeLeft = Val(StringField(line$, u, d$)) : u+1
              \MargeRight = Val(StringField(line$, u, d$)) : u+1
              ; nb pages
              \Nbpage = Val(StringField(line$, u, d$)) : u+1
              Nbpage = Val(StringField(line$, u, d$)) : u+1
              ReDim \page(Nbpage)
              ; space
              \SpacebetweenLine = Val(StringField(line$, u, d$)) : u+1
              \SpacebetweenCase = Val(StringField(line$, u, d$)) : u+1
              ; stroke
              \StrokeSize = Val(StringField(line$, u, d$)) : u+1
              \StrokeAlpha = Val(StringField(line$, u, d$)) : u+1
              \StrokeColor = Val(StringField(line$, u, d$)) : u+1
            EndWith
            
          Case "page"
            id = Val(StringField(line$, u, d$)) : u+1
            If id > ArraySize(project\page())
              ReDim project\page(id)
            EndIf
            pageID = id
            With project\page(id)
              ; marge
              \MargeTop = Val(StringField(line$, u, d$)) : u+1
              \MargeBottom = Val(StringField(line$, u, d$)) : u+1
              \MargeLeft = Val(StringField(line$, u, d$)) : u+1
              \MargeRight = Val(StringField(line$, u, d$)) : u+1
              ; size
              \Width = Val(StringField(line$, u, d$)) : u+1
              \Height = Val(StringField(line$, u, d$)) : u+1
              \Number = Val(StringField(line$, u, d$)) : u+1
              ; space
              \SpacebetweenLine = Val(StringField(line$, u, d$)) : u+1
              \SpacebetweenCase = Val(StringField(line$, u, d$)) : u+1
              ; lines
              \Nbline = Val(StringField(line$, u, d$)) : u+1
              Nbline = Val(StringField(line$, u, d$)) : u+1 ; verification
              If ArraySize(\Line())< Nbline
                ReDim \Line(nbline)
              EndIf
              \NbcaseByline = Val(StringField(line$, u, d$)) : u+1
            EndWith
            
          Case "line"
             Pageid = Val(StringField(line$, u, d$)) : u+1
             id = Val(StringField(line$, u, d$)) : u+1
             If id > ArraySize(project\page(pageID)\Line())
               ReDim project\page(pageID)\Line(id)
             EndIf   
             lineID = id
             With project\page(pageID)\Line(id)
               \NbCase = Val(StringField(line$, u, d$)) : u+1
               NbCase = Val(StringField(line$, u, d$)) : u+1
               If ArraySize(\caze())<NbCase
                 ReDim \caze(nbcase)
               EndIf
               ; parameters
               \x = Val(StringField(line$, u, d$)) : u+1
               \y = Val(StringField(line$, u, d$)) : u+1
               \w = Val(StringField(line$, u, d$)) : u+1
               \h = Val(StringField(line$, u, d$)) : u+1
             EndWith
            
          Case "case"
            Pageid = Val(StringField(line$, u, d$)) : u+1
            Lineid = Val(StringField(line$, u, d$)) : u+1
            Caseid = Val(StringField(line$, u, d$)) : u+1
            If Caseid > ArraySize(project\page(pageID)\Line(lineId)\caze())
              ReDim project\page(pageID)\Line(LineId)\caze(Caseid)
            EndIf   
            With project\page(pageID)\Line(Lineid)\caze(caseId)
              \x = Val(StringField(line$, u, d$)) : u+1
              \y = Val(StringField(line$, u, d$)) : u+1
              \w = Val(StringField(line$, u, d$)) : u+1
              \h = Val(StringField(line$, u, d$)) : u+1
              \Depth = Val(StringField(line$, u, d$)) : u+1
              \SizeBorder = Val(StringField(line$, u, d$)) : u+1
              \NoBorder = Val(StringField(line$, u, d$)) : u+1
              \NotuseMargeTop = Val(StringField(line$, u, d$)) : u+1
              \NotuseMargeBottom = Val(StringField(line$, u, d$)) : u+1
              \NotuseMargeL = Val(StringField(line$, u, d$)) : u+1
              \NotuseMargeR = Val(StringField(line$, u, d$)) : u+1
            EndWith
             
        EndSelect
        
      Wend
      CloseFile(0)
      
      ; update 
      Page_update()
      LineCase_GetProperties()
    EndIf
    
  EndIf
  
EndProcedure
Procedure Doc_Save(filename$=#Empty$, saveas=0)
  
  If filename$ =#Empty$ Or saveas = 1
    filename$ = SaveFileRequester(lang("Save"), GetCurrentDirectory(),"BDC|*.bdc",0)
  EndIf
  
  If filename$ <> #Empty$
    If GetExtensionPart(filename$) <> "bdc"
      filename$+".bdc"
    EndIf
    
;     If FileSize(filename$)<=0
;       ok = 1
;     Else
;       If MessageRequester(lang("Info"), lang("The file already exists. Do you want ot overwrite it ?"), #PB_MessageRequester_YesNo) = #PB_MessageRequester_No
;         Doc_Save(filename$, saveas)
;         ProcedureReturn 0
;       Else
;         ok = 1
;       EndIf
;     EndIf
    
    ok = 1-GetFileExists(filename$)
    
    If ok = 1
        If CreateFile(0, filename$)
          d$ =","
          e$=";"
          
          WriteStringN(0, "// Created with "+#BDC_ProgramName+#BDC_ProgramVersion)
          
          ; info program
          WriteStringN(0, "gen,"+#BDC_ProgramVersion+d$+FormatDate("%dd%mm%yyyy_%hh%ii%ss", Date())+d$)
          
          ; save info project
          With project
            txt$ ="project,"+\Name$+d$+\Info$+d$+\Date$+d$+Str(\MargeTop)+d$+Str(\MargeBottom)+d$+Str(\MargeLeft)+d$+Str(\MargeRight)
            txt$ + d$+Str(\Nbpage)+d$+Str(ArraySize(\page()))+d$+Str(\SpacebetweenLine)+d$+Str(\SpacebetweenCase)
            txt$ + d$+Str(\StrokeSize)+d$+Str(\StrokeAlpha)+d$+Str(\StrokeColor)+d$ 
            
            WriteStringN(0, txt$) 
          EndWith
          
          ; save page
          For i=0 To ArraySize(project\page())
            
            With project\page(i)
              txt$ = "page,"+Str(i)+d$+Str(\MargeTop)+d$+Str(\MargeBottom)+d$+Str(\MargeLeft)+d$+Str(\MargeRight)+d$
              txt$ + Str(\Width)+d$+Str(\Height)+d$+Str(\Number)+d$
              txt$ + Str(\SpacebetweenLine)+d$+ Str(\SpacebetweenCase)+d$
              txt$ + Str(\Nbline)+d$+Str(ArraySize(\Line()))+d$+Str(\NbcaseByline)+d$
              WriteStringN(0, txt$) 
            EndWith
            
            ; save all lines and cases
            For j=0 To ArraySize(project\page(i)\Line())
              With project\page(i)\Line(j)
                txt$ = "line,"+Str(i)+d$+Str(j)+d$+Str(\NbCase)+d$+Str(ArraySize(\caze()))+d$
                txt$ + Str(\x)+d$+Str(\y)+d$+Str(\w)+d$+Str(\h)+d$
                WriteStringN(0, txt$) 
              EndWith
              
              ; save the cases
              For k=0 To ArraySize(project\page(i)\Line(j)\caze())
                With project\page(i)\Line(j)\caze(k)
                  txt$ = "case,"+Str(i)+d$+Str(j)+d$+Str(k)+d$
                  txt$ + Str(\x)+d$+Str(\y)+d$+Str(\w)+d$+Str(\h)+d$
                  txt$ + Str(\Depth)+d$+Str(\SizeBorder)+d$+Str(\NoBorder)+d$
                  txt$ + Str(\NotuseMargeTop)+d$+Str(\NotuseMargeBottom)+d$+Str(\NotuseMargeL)+d$+Str(\NotuseMargeR)+d$
                  WriteStringN(0, txt$) 
                EndWith
              Next
              
            Next
            
          Next
          
          CloseFile(0)
        Else
          
        EndIf
    EndIf
      
 EndIf
  
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
          ; h_l1 = Project\SpacebetweenLine * z
          ; w_c1 = Project\SpacebetweenCase * z 
          For i=0 To ArraySize(\Line())
            For j= 0 To ArraySize(\Line(i)\caze())
              
              x1 = x + margeL 
              y1 = y + margeTop 
              
              ; White Background for each case
              AddPathBox(x1+\Line(i)\caze(j)\x, y1+\Line(i)\caze(j)\y, \Line(i)\caze(j)\w , \Line(i)\caze(j)\h)
              VectorSourceColor(RGBA(255,255,255,255))
              FillPath() 
              
              
              ; draw the elements
              ; characters and background
              Canvas_DrawImage(i,j, x1,y1)
          
              
              
              ; drawing by hand
              For k=0 To ArraySize(Stroke())
                MovePathCursor(stroke(k)\dot(0)\x+ vx,stroke(k)\dot(0)\y+ vy)
                For f=1 To ArraySize(stroke(k)\dot())
                  xa = stroke(k)\dot(f)\x + vx
                  ya = stroke(k)\dot(f)\y + vy
                  AddPathLine(xa,ya)
                  ; MovePathCursor(xa, ya)
                Next
                VectorSourceColor(RGBA(0,0,0,255))
                StrokePath(stroke(k)\Size) ;,#PB_Path_RoundEnd)
              Next
          
              ; black stroke for each case
              MovePathCursor(0,0)
              AddPathBox(x1+\Line(i)\caze(j)\x , y1+\Line(i)\caze(j)\y, \Line(i)\caze(j)\w, \Line(i)\caze(j)\h )
              c = project\StrokeColor
              VectorSourceColor(RGBA(Red(c), Green(c), Blue(c), project\StrokeAlpha))
              StrokePath(project\StrokeSize * Project\Width/2500)
              
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
Procedure Doc_ExportPageAstemplate()
  
  filename$ = SaveFileRequester(lang("Save page template"), GetCurrentDirectory(),"BDP|*.bdp",0)
  
  If filename$ <> #Empty$
    If GetExtensionPart(filename$) <> "bdc"
      filename$+".bdc"
    EndIf
    ok = 1-GetFileExists(filename$)
    
    If ok = 1
      If CreateFile(0, filename$)
        d$ =","
        e$=";"
        
        WriteStringN(0, "// Template for BDCreateor, Created with "+#BDC_ProgramName+#BDC_ProgramVersion)
        
        ; info program
        WriteStringN(0, "gen,"+#BDC_ProgramVersion+d$+FormatDate("%dd%mm%yyyy_%hh%ii%ss", Date())+d$)
        
        i = PageId
        With project\page(i)
          txt$ = "page,"+Str(i)+d$+Str(\MargeTop)+d$+Str(\MargeBottom)+d$+Str(\MargeLeft)+d$+Str(\MargeRight)+d$
          txt$ + Str(\Width)+d$+Str(\Height)+d$+Str(\Number)+d$
          txt$ + Str(\SpacebetweenLine)+d$+ Str(\SpacebetweenCase)+d$
          txt$ + Str(\Nbline)+d$+Str(ArraySize(\Line()))+d$+Str(\NbcaseByline)+d$
          WriteStringN(0, txt$) 
        EndWith
        
        ; save all lines and cases
        For j=0 To ArraySize(project\page(i)\Line())
          With project\page(i)\Line(j)
            txt$ = "line,"+Str(i)+d$+Str(j)+d$+Str(\NbCase)+d$+Str(ArraySize(\caze()))+d$
            txt$ + Str(\x)+d$+Str(\y)+d$+Str(\w)+d$+Str(\h)+d$
            WriteStringN(0, txt$) 
          EndWith
          
          ; save the cases
          For k=0 To ArraySize(project\page(i)\Line(j)\caze())
            With project\page(i)\Line(j)\caze(k)
              txt$ = "case,"+Str(i)+d$+Str(j)+d$+Str(k)+d$
              txt$ + Str(\x)+d$+Str(\y)+d$+Str(\w)+d$+Str(\h)+d$
              txt$ + Str(\Depth)+d$+Str(\SizeBorder)+d$+Str(\NoBorder)+d$
              txt$ + Str(\NotuseMargeTop)+d$+Str(\NotuseMargeBottom)+d$+Str(\NotuseMargeL)+d$+Str(\NotuseMargeR)+d$
              WriteStringN(0, txt$) 
            EndWith
          Next
          
        Next
        
        CloseFile(0)
      EndIf
    EndIf
  EndIf

EndProcedure
;}

;{ other window
; window Edit case
Procedure UpdateMaincanvas_withimage()
  With project\page(pageID)\Line(LineId)\caze(CaseID)
    
    If \imageFinal\img =0
      \imageFinal\img = CreateImage(#PB_Any, \w,\h,32,#PB_Image_Transparent)
    EndIf
    If StartDrawing(ImageOutput(\imageFinal\img))
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      For n=0 To ArraySize(\image())
        img = \image(n)\img
        If IsImage(img)
          DrawAlphaImage(ImageID(img),\image(n)\x,\image(n)\y)
        EndIf
      Next 
      StopDrawing()
    EndIf
  EndWith
EndProcedure
Procedure UpdateCanvas_WinEditCase()
  Shared wec_vx, wec_vy, wec_zoom
  ; wec_vx = window edit case view X
  ; wec_vy = window edit case view Y
  ; wec_zoom = window edit case view zoom (ScaleCoordinates()
  
  ; update the canvas of the window edit_case
  
  w = GadgetWidth(#G_win_EditCase_Canvas)
  h = GadgetWidth(#G_win_EditCase_Canvas)
  ; the view position
  vx = wec_vx
  vy = wec_vy
  vs.d = wec_zoom * 0.01 ; scale of the view
  ; size of the case
  With project\page(pageId)\Line(LineId)\caze(CaseId)
    w1 = \w
    h1 = \h
  EndWith
  
  ; update
  If StartVectorDrawing(CanvasVectorOutput(#G_win_EditCase_Canvas))
    
    ScaleCoordinates(vs,vs)
    
    ; white Background
    AddPathBox(0,0,w,h)
    VectorSourceColor(RGBA(255,255,255,255))
    FillPath()
    
    With project\page(pageId)\Line(LineId)\caze(CaseId)
      ; draw image of the case
      For i=0 To ArraySize(\image())
        If IsImage(\image(i)\img)
          MovePathCursor(vx+\image(i)\x, vy+\image(i)\y)
          s.d = \image(i)\scale
          DrawVectorImage(ImageID(\image(i)\img),\image(i)\alpha,\image(i)\w * s,\image(i)\h *s)
        EndIf
      Next
    EndWith
    
    AddPathBox(vx,vy,w1,h1)
    VectorSourceColor(RGBA(0,0,0,255))
    StrokePath(10)
    
    StopVectorDrawing()
  EndIf
  
EndProcedure
Procedure Window_EditCase_SetGadgetState()
  With project\page(pageId)\Line(LineId)\caze(CaseId)\image(ImageId)
    SetGadgetState(#G_win_EditCase_ImageX, \x)
    SetGadgetState(#G_win_EditCase_ImageY, \y)
    SetGadgetState(#G_win_EditCase_ImageAlpha, \alpha)
    SetGadgetState(#G_win_EditCase_ImageDepth, \depth)
    SetGadgetState(#G_win_EditCase_ImageH, \h)
    SetGadgetState(#G_win_EditCase_ImageScale, \scale)
    SetGadgetState(#G_win_EditCase_ImageW, \w)
  EndWith
EndProcedure
Procedure Case_AddImage()
  file$= OpenFileRequester(lang("add an image"),GetCurrentDirectory(),"image|*.png;*.jpg",0)
  If file$ <> "" And FileSize(file$) >0
    img = LoadImage(#PB_Any, file$)
    If img > 0
      With project\page(pageID)\Line(LineId)\caze(CaseID)
        \nbImage+1
        n= \nbImage
        ReDim \image(n)
        \image(n)\img = img
        \image(n)\file$ = file$
        \image(n)\w = ImageWidth(img)
        \image(n)\h = ImageHeight(img)
        \image(n)\scale = 1
        \image(n)\ALpha = 255
        ImageId = n
        ; update gadget win_editcase
        AddGadgetItem(#G_win_EditCase_ImageList,n, GetFilePart(file$,#PB_FileSystem_NoExtension))
        
        ; update canvas of window_editcase
        UpdateCanvas_WinEditCase()
        Window_EditCase_SetGadgetState()
        
        ; update main canvas
        UpdateMainCanvas_WithImage()
        
      EndWith
      
      UpdateCanvasMain()
    EndIf
  EndIf
EndProcedure
Procedure Window_EditCase()
  
  Shared wec_vx, wec_vy, wec_zoom
  ; wec_vx = window edit case view X
  ; wec_vy = window edit case view Y
  ; wec_zoom = window edit case view zoom (ScaleCoordinates()
  
  ; define variable by default
  wec_vx = 100
  wec_vy = 50
  wec_zoom = 40
  
  
  winw = WindowWidth(#BDC_Win_Main) - 100
  winH = 600 ; WindowHeight(#BDC_Win_Main)
  If OpenWindow(#BDC_Win_EditCase, 0, 0, winW, winH, Lang("Edit case"), #PB_Window_SystemMenu | #PB_Window_ScreenCentered|#PB_Window_SizeGadget, WindowID(#BDC_Win_Main))
    ; set the window properties
    c= 150
    SetWindowColor(#BDC_Win_EditCase, RGB(c,c,c))
    WindowBounds(#BDC_Win_EditCase, 400,500, WinW,winH+100)
    
    ; add gadgets
    x = 5 : y=5 : wp = 250 : w = winw -wp-15 : h = 200 : h1=30 : w1=wp-110 : h0=winh-y*2 : a = 2
    If ScrollAreaGadget(#PB_Any,x,y,wp,h0,wp-25,h0+200)
      cont = ContainerGadget(#PB_Any,0,0,wp,h0+1000)
      If cont>0
        c= 200
        SetGadgetColor(cont, #PB_Gadget_BackColor, RGB(c,c,c))
        x=2 : y=2
        AddGadget(#G_win_EditCase_ImageList, #Gad_ListV,x,y,wp-35,h,"",0,0,lang("Select the image to modofy")) : y+h+a
        AddGadget(#G_win_EditCase_BtnImageAdd, #Gad_Btn,x,y,w1,h1,LAng("Add"),0,0,lang("add an image on the case"),0,lang("Image")) : y+h1+a
        AddGadget(#G_win_EditCase_BtnImageDel, #Gad_Btn,x,y,w1,h1,LAng("Del"),0,0,lang("Delete the selected image from the case"),0,lang("Image")) : y+h1+5
        
        AddGadget(#G_win_EditCase_ImageX, #Gad_spin,x,y,w1,h1,LAng("X"),-100000,100000,lang("Change the X position of the image"),0,lang("X")) : y+h1+a
        AddGadget(#G_win_EditCase_ImageY, #Gad_spin,x,y,w1,h1,LAng("Y"),-100000,100000,lang("Change the Y position of the image"),0,lang("Y")) : y+h1+a
        AddGadget(#G_win_EditCase_ImageW, #Gad_spin,x,y,w1,h1,LAng("Width"),1,100000,lang("Change the width of the image"),0,lang("w")) : y+h1+a
        AddGadget(#G_win_EditCase_ImageH, #Gad_spin,x,y,w1,h1,LAng("Height"),1,100000,lang("Change the height of the image"),0,lang("H")) : y+h1+a
        AddGadget(#G_win_EditCase_ImageAlpha, #Gad_spin,x,y,w1,h1,"",0,255,lang("Change the opacity of the image"),0,lang("Alpha")) : y+h1+a
        AddGadget(#G_win_EditCase_ImageDepth, #Gad_spin,x,y,w1,h1,"",0,10000,lang("Change the depth poition of the image"),0,lang("Depth")) : y+h1+a
        AddGadget(#G_win_EditCase_ImageScale, #Gad_spin,x,y,w1,h1,"",0,10000,lang("Change the Scale poition of the image"),0,lang("Scale")) : y+h1+a
        CloseGadgetList()
      EndIf
      CloseGadgetList()
    EndIf
    
    ; add the canvas for the window edit case, to see the case with image, text...
    x=5+wp+5 : y=5
    If CanvasGadget(#G_win_EditCase_Canvas,x,y,w,h0)
    EndIf
    UpdateCanvas_WinEditCase()
    
  EndIf
EndProcedure

; window project properties
Procedure Window_ProjectProperties()
  
  winw = 800
  winH = 500
  If OpenWindow(#BDC_Win_ProjectProperties, 0, 0, winW, winH, LAng("Project Properties"), 
                #PB_Window_SystemMenu | #PB_Window_ScreenCentered, WindowID(#BDC_Win_Main))
    
    x = 5 : y=5 : w = winw -100 : h = 30
    AddGadget(#G_win_BDCprop_title, #Gad_String,x,y,w,h,Project\Name$,0,0,lang("Define the title for the project"),0,lang("Title")) : y+h+5
    AddGadget(#G_win_BDCprop_NbPage, #Gad_spin,x,y,w,h,"",1,1000,lang("Define the number of pages"),ArraySize(project\page())+1,lang("Nb of pages")) : y+h+5
  EndIf
  
EndProcedure
;}

;}


;{ open main window
If ExamineDesktops()
  winH = DesktopHeight(0)
  winW = DesktopWidth(0)
EndIf
If OpenWindow(#BDC_Win_Main, 0, 0, winW, winH, "BD creator (Storyboard & comics creation) "+#BDC_ProgramVersion, #PB_Window_SystemMenu | #PB_Window_ScreenCentered|#PB_Window_SizeGadget|#PB_Window_MaximizeGadget|#PB_Window_MinimizeGadget|#PB_Window_Maximize)
  
  ;{ statusbar, menu, gadgets...
  WindowBounds(#BDC_Win_Main,600,600,5000,5000)
 
  ;{ statusbar
  If  CreateStatusBar(#BDC_StatusbarMain,WindowID(#BDC_Win_Main))
    AddStatusBarField(100)
    AddStatusBarField(100)
    AddStatusBarField(500)
    StatusBarText(0, 0, Lang("Zoom")+" "+Str(BDCOptions\Zoom)+"%")
  EndIf
  ;}
  
  ; menu
  If CreateMenu(#BDC_Menu_Main, WindowID(#BDC_Win_Main))
    MenuTitle(Lang("File"))
    MenuItem(#BDC_Menu_NewDoc, lang("New")+Chr(9)+"Ctrl+N")
    MenuItem(#BDC_Menu_OpenDoc, lang("Open")+Chr(9)+"Ctrl+O")
    MenuItem(#BDC_Menu_SaveDoc, lang("Save")+Chr(9)+"Ctrl+S")
    MenuBar()
    MenuItem(#BDC_Menu_ExportAsImage, lang("Export all pages as image"))
    ;     MenuItem(#BDC_Menu_ExportAsLayer, lang("Export page as layer"))
    MenuBar()
    MenuItem(#BDC_Menu_ExportPageAsTemplate, lang("Export page as template"))
    MenuBar()
    MenuItem(#BDC_Menu_Projectproperties, lang("Project properties")) 
    MenuBar()
    MenuItem(#BDC_Menu_Quit, lang("Quit"))
    MenuTitle(Lang("Edit"))
    
    MenuTitle(Lang("View"))
    MenuItem(#BDC_Menu_ViewShowCaseSelected, lang("Show Case Selected"))
    MenuItem(#BDC_Menu_ViewShowMarge, lang("Show Marges"))
    MenuBar()
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
  
  ; add a project
  Doc_New()
  ;}
  
  Repeat
    Event = WaitWindowEvent()
    EventGadget =  EventGadget()
    EventMenu =  EventMenu()
    
    Select Event 
        
      Case #PB_Event_Gadget
        Select EventWindow()
            
          Case #BDC_Win_Main ; main
            Select EventGadget
              
              Case #G_win_Story_ImageAdd
                Window_EditCase() 
                
              Case #G_win_Story_Editmode
                vd\EditMode = GetGadgetState(#G_win_Story_Editmode)
                
              Case #G_win_Story_CaseID
                id = GetGadgetState(#G_win_Story_CaseID)
                If id <0 Or id > ArraySize(project\page(pageID)\Line(LineId)\caze())
                  SetGadgetState(#G_win_Story_CaseID, CaseID)
                Else
                  CaseID = id
                  UpdateCanvasMain()
                EndIf
                
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
                If BDCOptions\ModeAutomatic =1
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
                BDCOptions\modeautomatic = GetGadgetState(EventGadget)
                Page_update()
                
              Case #G_win_Story_NbCaseByLine
                nb = GetGadgetState(EventGadget)-1
                If nb>=0 
                  If BDCOptions\ModeAutomatic =1
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
                
              Case #G_win_Story_StrokeSize, #G_win_Story_StrokeAlpha
                ;{ stroke for case borders
                s = GetGadgetState(#G_win_Story_StrokeSize)
                a = GetGadgetState(#G_win_Story_StrokeAlpha)
                ok=0
                If a>=0 And a<=255
                  Project\StrokeAlpha = a
                 ok =1
                EndIf
                If s >0 And s<=100
                  project\StrokeSize = s
                  ok=1
                EndIf
                If ok
                  UpdateCanvasMain()
                EndIf
                ;}
                
            EndSelect
            
          Case #BDC_Win_EditCase
            Select EventGadget
              Case #G_win_EditCase_ImageList
                imageId = GetGadgetState(#G_win_EditCase_ImageList)
                Window_EditCase_SetGadgetState()
                
              Case #G_win_EditCase_BtnImageAdd
                Case_AddImage()
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
            
          Case #BDC_Menu_ExportPageAsTemplate
            Doc_ExportPageAstemplate()
            
          Case #BDC_Menu_ExportAsImage
            Doc_ExportImage()
            
          Case #BDC_Menu_Projectproperties
            Window_ProjectProperties()
            
          Case #BDC_Menu_quit
            quit = 1 
            ;}
            ;{ View
          Case #BDC_Menu_ViewShowMarge
            BDCOptions\showMarge = 1-BDCOptions\showMarge
            SetMenuItemState(#BDC_Menu_Main, #BDC_Menu_ViewShowMarge,BDCOptions\showMarge)
            UpdateCanvasMain()
            
          Case #BDC_Menu_ViewShowCaseSelected
            BDCOptions\showSelected = 1-BDCOptions\showSelected
            SetMenuItemState(#BDC_Menu_Main, #BDC_Menu_ViewShowCaseSelected,BDCOptions\showSelected)
            UpdateCanvasMain()
            
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
        If GetActiveWindow() = #BDC_Win_Main
          quit = 1
        Else
          CloseWindow(GetActiveWindow())
        EndIf
        
    EndSelect
    
  Until Quit >= 1
  
EndIf

;}


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 148
; Folding = AwASKg-48DMDe-w-tgRQ4+gZhbd0jP2+nW988-02jdPe8
; EnableXP
; Warnings = Display
; EnablePurifier