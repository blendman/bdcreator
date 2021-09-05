;{ infos
; BD creator ( & storyboard creation, to use with cartoon or animatoon)
; by blendman, august 2021

;{ TODOlist BY version (date de création de la roadmap 5.8.2021) :
; V 0.03 : 
; ok - Bouger le canvas avec Space
; ok - Mode normal : définir line H,Y
; ok - definir : case w,h
; ok 0.04 - definir : case x,y
; ok - Bugfixe : sélectionner la ligne
; V 0.04 :
; ok 0.10 - Voir le Numéro de page
; ok 0.04 - voir et Changer le depth des cases
; ok 0.03 - Sélectionner une Case
; V 0.05
; ok 0.02.3 - Case avec fond blanc
; ok 0.04 - Menu : savedoc.
; V 0.06
; ok - Case : ajout infos cadre, position, texte
; ok 0.07 - Définir police du texte.
; V 0.07 :
; ok 0.05 - Case : Pouvoir ajouter une image
; ok 0.05 - Case\image : modifier x,y,w,h,scale, alpha
; ok 0.06 - Case : bank -> Pouvoir ajouter un personnage (issu du dossier par defaut). 
; ok 0.06 - Bank Canvas (folder characters -> clique et ça le place). 
; ok 0.06 - Personnage (image) : position, taille 
; - Image: brightness (pour l'assombrir en 1er plan).
; V 0.09
; ok 0.04 - Menu opendoc
; - Enlever des pages
; - Insérer une page avant/après la page actuelle
; V  0.10
; ok 0.05 - Case : pouvoir ajouter 1 ou plusieurs bubles + texte. Position.
; ok 0.03 - Menu newdoc
; V 0.11
; ok 0.05 - Case : Pouvoir ajouter un décor ou + (avec depth, position, scale, alpha).
; V 0.12
; ok 0.03 - Menu export image (jpg ou PNG, calque écrasé)
; V 0.13
; - Menu export (image PNG de chaque page) avec taille d’export (% of export)..; 
; v 0.14 :
; ok 0.03 - pouvoir dessiner sur la page
; v 0.15 :
; ok 0.04 - export page as template

; non :
; ?? - Changer le zoom de la Case (type de plan) et « pan ».


; ok :
; - add character
; - add background
; - add bubles and text.
; - add image
; - doc_open()
; - in normal mode (not automatic) : change the x/y/w/h of case selected 
; - in normal mode (not automatic) : change the y/h of line selected
; - doc_save()
; - export page template
; - export image (full image) 
; - add a menu File, Edit, view, page..
; - page : add, select
; - save : case image / text
; - case text : change font
; - add fleche de buble system
; - load : case image
; - load : case text
; - wec : miror image
; - WEC : object hide

; bugs : 
; ok - select line is bugged
; ok - select line & case is bugged if move viewx/y
; ok - on ne peut pas bouger la case en Y ni changer sa hauteur
; ok - buble : taille in H not ok
;}

; bugs : 
; - mode normal : si on ajoute une case, il faudrait qu'elle soit créé à droite, après la dernière case et avec la largeur disponible (pas w=0 et x=0)
; - image/w/h isn't used on maincanvas

; Not priority : 
; ?? - add a "edition mode" :  page, graphics, text
; ??? - case : set zoom
; - add a menu file : preference
; - page : delete, move < >
; - show the space (between line and case)
; wip - page add the number of page gadget (numero de page)

; Priority :
; - export in png layers.
; - keep text separated from buble (by default)
; - image repeated/seamless (for bg)
; - image saturation, brightness, contrast, color
; - wec : rotation image
; - when change W/h/X:Y of case, the others cases should be changed automatically
; - bug with rectangle text -> is changed in ellipse and we don't see the text
; - WEC : object gradient or BG color (color or gradient) ?
; - WEC : change image option : keep size/scale
; - WEC : set image center (en %) + file center.txt
; - WEC : onglet presets case (save case preset, add the preset in the case (add all elements)


; 5.9.2021 0.13 (17)
; // New
; - UnPreMultiplyAlpha(image) (not used for the moment)
; - add several macro (ckeck, check ifinf, if sup....)
; - Image_brightness(image, value)
; - wec : add gadget image brightness
; - wec : we can change image brightness
; // changes
; - some changes in UpdateMaincanvas_withimage() 
; - when create the image, I copy image()\img in image()\imgtemp, to keep the original (imgtemp)


; 4.9.2021 0.12 (16)
; // New
; - WEC add menu\edit\delete
; - WEC add shortcut objectdelete
; - add : case()\image()\hide
; - WEC : add gadget hide image.
; // changes
; - WEC : when clic not on an image : imageID = -1

; 31.8.2021 0.11 (15)
; // New
; - add case BGcolor (rgba(255,255,25(,255) by default)
; // Changes
; - Canvas_DrawThepage() : (1 procedure to draw all image on the page), use in canvasmain and for export.
; // Fixe
; - export : if fileexists->didn't export the image
; - export : if filename$ has extension : image not exported

;{ other versions
; 30.8.2021 0.10.3 (14)
; // changes
; - in gadget_AddItems(), check extension of files before to add it in the image array.
; // Fixe
; - bank image : if the file isn't an image -> crash


; 23.8.2021 0.10.1 (13)
; // Fixe
; - when open old file, the fontsize = 0 and fontname$ = "", so before to create the bubble -> Case_SetTextFont()
; - if Doc_New() with caseID >0 -> crash


; 21.8.2021 0.10 (12)
; // New
; - window main : gadgets : stroke by case (alpha, size, set)
; - wec : gadget default scale for image
; - wec : gadget image miror
; - bdcoptions : add bankcaseScale, depth (to set scale, depth by default when add new image to case)
; - structure sImg : add miror, rotation
; - doc_save() : add case\strokealpha,size,set
; - doc_save() : add image\miror, rotation, brightness
; - doc_open() : add image\miror, rotation, brightness
; - #properties : miror, rotation, brightness
; // changes
; - page\case : stroke alpha/size is by case
; - UpdateCanvasMain() : changes to use stroke alpha, size from case if set >=2
; - projet\strokesize : now we can have a strokesize= 0

; 19.8.2021 0.09 (11)
; // New
; - WinBuble_UpdateGadgets() (to update the buble when we select a buble)
; - WindowEditBubble : + gadgets : text width, size (height), choose font, position (x,y), string, cbbox to chose the arrow position, btn ok
; // changes
; - Window_EditCase : clic on "set btn"-> ope the WindowEditBubble to make the change.
; - Case_SetText() : add bulle arrow (all directions)
; - Case_SetText() : lots of change to use the new text parameters
; - doc_save() : save font and text new parameters (width,x,y,bublearrow)
; - doc_open() : save font and text new parameters (width,x,y,bublearrow)
; // fixes
; - after doc_open() then open window_editcase, the gadget item text isn't correct with the object text (buble)


; 18.8.2021 0.08 (10)
; // New
; - add bubble "arrow" (ellipse, just bottom-middle for the moment)
; - Doc_open() : case image
; - Doc_open() : case text
; // changes
; - Doc_Save() : write image line only if image exists or is used
; - Doc_Save() : write tex line only if buble exists or is used
; - Some changes in Case_SetText() to create the buble when Doc_open()
; - Some changes in Case_SetText() to create text and set all properties correctly at creation
; // fixes
; - bubble heigth wasn't ok


; 17.8.2021 0.07.5 (9)
; // New
; - Window_EditCase : show red box on selected image
; - Window_EditCase : clic on object (image or text) : select the object.
; - structure sImg : add   typ (image, text) & shaptyp (ellipse,rectangle)
; - Doc_save() : save case()\image() !
; - Doc_save() \image() : add typ, shaptyp
; - Case_Update() : add arguments : typ=0,shaptyp=0
; // Fixes
; - when change text, the scale and alpha of image shouldn't be reseted


; 17.8.2021 0.07 (9)
; // New
; - Window_EditCase : text set font (name, size)
; - Window_EditCase : text set font : save \fonttext$,fontsize,fontname$
; - structure sImg : add fonttext$,fontsize,fontname$
; - addkeyboardshortcut : ctrl+S, ctrl+O, ctrl+N
; - Doc_save()/Doc_open() : add options\modeauto, zoom, showmarge,showselect
; // Fixes
; - when create a new page, all parameters are =0
; - select page din't update nbline and nbcase gadgets
; - if add_page with window project_properties, the gadget select page isn't updated
; - if add_page with window project_properties, the gadget nbline and nbcasebyline isn't updated
; - select line & case is bugged if move viewx/y
; - we can't move selected case in Y and cant change its height
; - when open a file, if the page isn't made with automatic, automatic should not be used.
; - open a file, the gadget to select pages isn't updated


; 16.8.2021 0.06 (8)
; // New
; - Window_EditCase\bank : add scrollarea
; - Window_EditCase\bank : add canvas
; - Window_EditCase\bank : add cbbox folder
; - Window_EditCase\bank : add cbbox subfolder
; - Window_EditCase\bank : check cbbox subfolder
; - Window_EditCase\bank : check cbbox subfolder images
; - Window_EditCase\bank : update subfolder images and canvas if change folder
; - Window_EditCase\bank : btn+ -> add image on case
; // Fixes
; - case_settext() : if set text without text create, the gadget list isn't updated


; 12.8.2021 0.05.6 (7)
; // new
; - case_settext() : to change a text (buble).


; 9.8.2021 0.05.5 (6)
; // new
; - Window_EditCase : delete images
; - Window_EditCase : add text rectangle
; - Window_EditCase : add text_typ (ellipse, rectangle)
; - Window_EditCase : event canvas. We can move or scale the image with mouse.
; - options (save, load, reset)
; - options add default parameter for project (BDCOptions\project.sProject)
; - Window_EditCase() : add panelgadget (+ tab : bank,graphics)
; // fixes
; - fixe some bug with text

; 8.8.2021 0.05 (5)
; // new
; - load a comic font (free : komika hand)
; - Window_EditCase() : we can add a text ! 
; - Window_EditCase() : the text has an allipse (for the buble)! 
; - Window_EditCase() : btn add text
; - UpdateMaincanvas_withimage : verify if size of case has hcnaged, if yes, it update the image
; - UpdateCanvasMain : draw image
; - case\image : change image x,y,w,h,scale,alpha
; - tab case : clic btn "Edit"  : open a window to edit the case (add/delete images, move image, select)
; - tab case : btn "Edit" (to edit the "image" of the case)
; - Window_EditCase()
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
;}


#BDC_ProgramVersion = "0.13"
#BDC_ProgramName = "BD Creator"
Enumeration 
  
  #BDC_StatusbarMain = 0
  
  ;{ window
  #BDC_Win_Main = 0
  #BDC_Win_ProjectProperties
  #BDC_Win_EditCase
  #BDC_Win_EditBubble
  #BDC_ImageADjustement
  ;}
  
  ;{ menu
  #JSONFile = 0
  
  ; The menu for the windows
  #BDC_Menu_Main=0
  #BDC_Menu_Wec
  
  ;{ menu items main window
  #BDC_Menu_NewDoc=0
  #BDC_Menu_OpenDoc
  #BDC_Menu_SaveDoc
  #BDC_Menu_Projectproperties
  #BDC_Menu_ExportAsImage
  #BDC_Menu_ExportAllPagesAsImage
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
  
  ;{ other windows
  
  ;{ window editcase
  #BDC_Menu_WEC_CaseCopy
  #BDC_Menu_WEC_CasePaste
  #BDC_Menu_WEC_CaseNext
  #BDC_Menu_WEC_CasePrevious
  #BDC_Menu_WEC_ObjectDelete
  #BDC_Menu_WEC_ObjectCopy
  #BDC_Menu_WEC_ObjectPaste
  ;}
  
  ;}
  
  ;}
  
  ;{ gadgets
  
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
  ; #G_win_Story_StrokeForAllcases
  ; page
  #G_win_Story_PageTitle
  #G_win_Story_PageNumber
  #G_win_Story_NbLine
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
  
  ; By page (line, case)
  #G_win_Story_PageX
  #G_win_Story_PageY
  #G_win_Story_CaseAutomaticCalcul
  #G_win_Story_PageAddNumber
  
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
  
  #G_win_Story_CaseStrokeSize
  #G_win_Story_CaseStrokeColor
  #G_win_Story_CaseStrokeAlpha
  #G_win_Story_CaseStrokeSet ; project =0, page =1, line= 2, case=3
  
  #G_win_Story_BankImage
  #G_win_Story_BankFolder
  #G_win_Story_BankSubFolder
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
  
  ;{ other windows
  ;{ window Edit case
  ; Panel bank
  #G_win_EditCase_BankFolder
  #G_win_EditCase_BankSubFolder
  #G_win_EditCase_BankSA ; scorllarea
  #G_win_EditCase_Bankcanvas
  #G_win_EditCase_BankAdd
  #G_win_EditCase_BankScale
  ; Panel case
  #G_win_EditCase_Canvas
  #G_win_EditCase_Panel
  #G_win_EditCase_SA
  #G_win_EditCase_ImageList
  #G_win_EditCase_BtnTextAdd
  #G_win_EditCase_BtnTextSet
  #G_win_EditCase_BtnTextTyp ; buble ellipse, text square
  #G_win_EditCase_BtnTextOver ; over the case
  #G_win_EditCase_ObjetType ; 0=Image, 1 = text.
  #G_win_EditCase_BtnImageAdd
  #G_win_EditCase_BtnImageDel
  #G_win_EditCase_ImageX
  #G_win_EditCase_ImageY
  #G_win_EditCase_ImageW
  #G_win_EditCase_ImageH
  #G_win_EditCase_ImageMiror
  #G_win_EditCase_ImageRotation
  #G_win_EditCase_ImageRepeatX
  #G_win_EditCase_ImageRepeatY
  #G_win_EditCase_ImageBrightness
  #G_win_EditCase_ImageContrast
  #G_win_EditCase_ImageColor
  #G_win_EditCase_ImageScale
  #G_win_EditCase_ImageAlpha
  #G_win_EditCase_ImageDepth
  #G_win_EditCase_ImageHide
  ;}
  
  ;{ window Edit Bubble
  
  #G_win_EditBuble_TextString
  #G_win_EditBuble_TextWidth
  #G_win_EditBuble_TextSize
  #G_win_EditBuble_TextX
  #G_win_EditBuble_TextY
  #G_win_EditBuble_TextChooseFont
  #G_win_EditBuble_BubleArrowShapeTyp
  #G_win_EditBuble_BubleArrowPosition
  #G_win_EditBuble_BtnOk
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
  
  ;}
  
  ;{ Image
  #Img_PageDrawing=0
  #Img_Export
  ;}
  
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
  
  ;{ properties
  ; properties
  #BD_properties_Interline=0
  ; properties
  #Propertie_X = 0
  #Propertie_Y
  #Propertie_W
  #Propertie_H
  #Propertie_Depth
  #Propertie_Alpha
  #Propertie_Color
  #Propertie_Light
  #Propertie_Scale
  #Propertie_Hide
  #propertie_Brightness
  #propertie_Rotation
  #propertie_Miror
  #propertie_Contrast
  ;}
  
  ;{ case typ
  #CaseTyp_Img = 0
  #CaseTyp_Text
  ;} 
  
  ;{ Bubble Arrow typ
  ; should be same as gadget combobox : #G_win_EditBuble_BubleArrowPosition
  #BubbleArrowTyp_BottomMiddle = 0
  #BubbleArrowTyp_BottomLeft
  #BubbleArrowTyp_BottomRight
  #BubbleArrowTyp_TopMiddle
  #BubbleArrowTyp_TopLeft
  #BubbleArrowTyp_TopRight
  #BubbleArrowTyp_CenterLeft
  #BubbleArrowTyp_CenterRight
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
  imgtemp.i
  typ.a ; 0=image, 1=text
  shapetyp.a ; 0 = ellipse, 1= rectangle
  file$
  ; text bubble
  text$
  fontText$
  fontName$
  fontSize.w
  fontWidth.w
  BubleArrowTyp.a
  TextX.w
  TextY.w
  
  ; other parameters
  depth.w
  alpha.a
  x.w
  y.w
  w.w
  h.w
  scale.d
  miror.a
  rotation.w
  brightness.a
  Contrast.a
  R.a
  G.a
  b.a
  ; WEC (windiw edit case)
  hide.a
EndStructure
Dim wec_bankimage.sImg(0)

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
  StrokeSize.a
  StrokeColor.i
  StrokeAlpha.a
  StrokeSet.a
  ; BG
  Color.i
  ; Alpha.A
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
  ; show / hide
  ShowMarge.a
  ShowSelected.a
  ; path
  PathSave$
  pathOpen$
  PathExport$
  PathImage$
  ; default projet
  Project.sProject
  firstopening.a
  ; options Window Editcase
  CaseBankScale.w
  CaseBankDepth.w
  
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
;{ Macros
;{ array
Macro DeleteArrayElement(ar, el)
    
    For a=el To ArraySize(ar())-1
        ar(a) = ar(a+1)
    Next
    
    a = 0
    If ArraySize(ar())-1>=0
        a = ArraySize(ar())-1    
    EndIf
    ReDim ar(a)
    
EndMacro

Macro InsertArrayElement(ar, el)
  
  a = ArraySize(ar())+1    
  ReDim ar(a)
  
  For a=ArraySize(ar())-1 To el Step -1
    ar(a+1) = ar(a)
  Next
    
EndMacro
;}

; verification >255, <0, etc
Macro CheckZero(a,b)
  If a<=0
    a=b
  EndIf
EndMacro

Macro SetMax(a,b)
  If a > b
    a = b
  EndIf  
EndMacro

Macro CheckIfInf(a,b)
  If a < b
    a = b
  EndIf  
EndMacro
Macro CheckIfInf2(a,b)
  If a < b
    b = a
  EndIf  
EndMacro
Macro Check0(a)
  SetMax(a,255)
  CheckIfInf(a,0)
EndMacro

;}
;{ procedures
Declare Line_SetProperties(i,x,y,w,h)
Declare Line_SetNBCase(nbcase=2)
Declare Case_SetProperties(i,x,y,w,h)
Declare UpdateMaincanvas_withimage()
Declare UpdateCanvas_WinEditCase()
Declare Case_SetText(text$, update=0, usefontrequester=1)
Declare Window_EditBubble()


Procedure.s Lang(text$)
  ProcedureReturn text$
EndProcedure

;{ Images
Procedure Freeimage2(id)
  If IsImage(id) : FreeImage(id) : EndIf
EndProcedure
Procedure UnPreMultiplyAlpha(image)
  ; by Chi, english forum
  c = 255
  tmp = CopyImage(image,#PB_Any)
  
  If StartDrawing(ImageOutput(image))
    DrawingMode(#PB_2DDrawing_AllChannels)
    Box(0,0,OutputWidth(),OutputHeight(),RGBA(0,0,0,255))
    DrawAlphaImage(ImageID(tmp),0,0)
    
    DrawingMode(#PB_2DDrawing_AlphaClip)
    Box(0,0,OutputWidth(),OutputHeight(),RGBA(0,0,0,255))
   ; DrawingMode(#PB_2DDrawing_AlphaBlend)
    DrawAlphaImage(ImageID(tmp),0,0)
    
    For y=0 To ImageHeight(image)-1
      For x=0 To ImageWidth(image)-1
        color = Point(x, y)
        alpha = Alpha(color)
        
        alpha2 = Alpha(color)
        If alpha=0 : alpha=1 : EndIf
        If alpha2>0
          ;r = (255 * Red(color) + (alpha2 /2)) /alpha
          r = (c * Red(color) ) /alpha
          If r>255
            r=255
          EndIf
          ;g = (255 * Green(color) + (alpha2 /2)) /alpha
          g = (c * Green(color)) /alpha
          If g>255
            g=255
          EndIf
          ;b = (255 * Blue(color) + (alpha2 /2)) /alpha
          b = (c * Blue(color) ) /alpha
          If b>255
            b = 255
          EndIf
          Plot(x, y, RGBA( r, g, b, alpha2))
        Else
          Plot(x, y, RGBA(Red(color), Green(color), Blue(color), alpha2))
        EndIf
      Next
    Next
    StopDrawing()
  EndIf
  
  FreeImage2(tmp)
  
  ; MessageRequester("", "unpremul ok : "+Str(image))
  
  ProcedureReturn image
EndProcedure
ProcedureDLL.i Brightness(Color.i, value.f) 
  
  ; Eclaicir ou foncer une Color
  ; by LSI ?
  Protected Red.i, Green.i, Blue.i, Alpha.i
  
  Red = Color & $FF
  Green = Color >> 8 & $FF
  Blue = Color >> 16 & $FF
  Alpha = Color >> 24
  Red * value
  Green * value
  Blue * value
  
  If Red > 255 : Red = 255 : EndIf
  If Green > 255 : Green = 255 : EndIf
  If Blue > 255 : Blue = 255 : EndIf
  
  ProcedureReturn (Red | Green <<8 | Blue << 16 | Alpha << 24)
EndProcedure
Macro IE_GetImagePixelColor(img)
  
  w = ImageWidth(img)
  h = ImageHeight(img) 
  Dim pixel.i(w, h)
  Dim alph.a(w, h)
  
  ; we get the color // on chope la couleur
  If StartDrawing(ImageOutput(img))
    DrawingMode(#PB_2DDrawing_AllChannels)
    For y = 0 To h - 1
      For x = 0 To w - 1
        color = Point(x, y)
        alpha = Alpha(color)
        pixel(x, y) = color
        Alph(x, y) = alpha
      Next
    Next
    StopDrawing()
  EndIf
EndMacro
Macro IE_SetImageOutput(Image,a1=0)
  
  DrawOk = 0
  
  W = ImageWidth(Image)
  H = ImageHeight(Image)
  If StartDrawing(ImageOutput(Image))
    DrawOk = 1                     
  EndIf
  
  If DrawOk
    
    ;"Buffer" : le pointeur vers l'espace memoire.
    Buffer = DrawingBuffer()
    
    If Buffer <> 0
      ;Organisation du buffer :
      pixelFormat = DrawingBufferPixelFormat()
      ; pixelFormat va te donner une constante car sa peut varier ; Voir la documentation
      lineLength = DrawingBufferPitch();Longueur d'une ligne
      If pixelFormat = #PB_PixelFormat_32Bits_BGR | #PB_PixelFormat_ReversedY
        For i = a1 To W-(1+a1) ;Pour chaque ligne
          For j = a1 To H-(1+a1) ; Pour chaque colonne (donc pour chaque pixel) :
            
EndMacro
Macro IE_SetImageOutput1(mode=0)
            
          Next j
        Next i
      EndIf
      StopDrawing()
    EndIf
  EndIf
  
  If mode =0
    UpdateCanvas_WinEditCase()
  EndIf
  
EndMacro
Procedure IE_ColorBalance1(img, r1, g1, b1, mode= 0)
  
  r2.d = r1/126
  g2.d = g1/126
  b2.d = b1/126
  
  IE_SetImageOutput(img,0)
  
  ; On lit le pixels
  b = PeekA(Buffer + 4 * i + j * lineLength);Bleu
  g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
  r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
  
  ; on effectue l'opération 
  ;Rouge = Rouge * Echelle + Rouge2 * (1-Echelle)
  r = r * r2 + r1 *(1-r2) 
  Check0(r)
  g = g * g2 + g1 *(1-g2)
  Check0(g)
  b = b * b2 + b1 *(1-b2)     
  Check0(b)
  
  ; on poke le pixel
  PokeA(Buffer + 4 * i + j * lineLength,      b);Bleu
  PokeA(Buffer + 4 * i + j * lineLength + 1,  g);Vert
  PokeA(Buffer + 4 * i + j * lineLength + 2,  r);Rouge  
  
  IE_SetImageOutput1(mode)
  
  ProcedureReturn img  
EndProcedure
Procedure IE_ColorBalance(img, r1, g1, b1, mode= 0)
  
  IE_SetImageOutput(img)
  
  ; On lit le pixels
  b = PeekA(Buffer + 4 * i + j * lineLength);Bleu
  g = PeekA(Buffer + 4 * i + j * lineLength + 1);Vert
  r = PeekA(Buffer + 4 * i + j * lineLength + 2);Rouge 
  
  ; on effectue l'opération 
  If (r+g+b)/3 < 240
    r = r + r1
    SetMax(r,255)
    g = g + g1
    SetMax(g,255)
    b = b + b1
    SetMax(b,255)
  Else
    If (r+g)/2 <250
      r = r + r1
      SetMax(r,255)
      g = g + g1
      SetMax(g,255)
      ; b = b + b1
      ; SetMax(b,255)                
    ElseIf (r+b)/2 < 250
      r = r + r1
      SetMax(r,255)
      ; g = g + g1
      ; SetMax(g,255)                
      b = b + b1
      SetMax(rb,255)
    ElseIf (g+b)/2 < 250
      ; r = r + r1
      ; SetMax(r,255)                
      g = g + g1
      SetMax(g,255)
      b = b + b1
      SetMax(b,255)
    EndIf
  EndIf
  
  ; on poke le pixel
  PokeA(Buffer + 4 * i + j * lineLength,      b) ;Bleu
  PokeA(Buffer + 4 * i + j * lineLength + 1,  g) ;Vert
  PokeA(Buffer + 4 * i + j * lineLength + 2,  r) ;Rouge  
  
  IE_SetImageOutput1(mode)
  
  ProcedureReturn img  
EndProcedure

;}


;{ pages
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
;}

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
Procedure Canvas_DrawThePage(vx,vy,exportimage=0)
    
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

  ; the white page
  w = Project\Width 
  h = Project\Height 
  
  vd\PagecenterX = 0 ; (wc-w)/2 
  vd\PagecenterY = 0 ; (hc-h)/2 
  
  ; position of center of page (and for line, case...)    
  x =  vx + vd\PagecenterX 
  y =  vy + vd\PagecenterY 
  
  ; white Background
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
        
        x1 = x + margeL 
        y1 = y + margeTop 
        
        ; color Background for each case
        w2 = \Line(i)\caze(j)\w 
        h2 = \Line(i)\caze(j)\h 
        AddPathBox(x1+\Line(i)\caze(j)\x , y1+\Line(i)\caze(j)\y, w2, h2)
        color = \Line(i)\caze(j)\color
        VectorSourceColor(RGBA(Red(color),Green(color),Blue(color),255))
        FillPath() 
        
        Canvas_DrawImage(i,j,x1,y1)
        
        ; draw the stroke drawings
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
        st_a = project\StrokeAlpha
        st_s = project\StrokeSize
        c = project\StrokeColor
        If \Line(i)\caze(j)\StrokeSet >=2
          st_a = \Line(i)\caze(j)\StrokeAlpha
          st_s = \Line(i)\caze(j)\StrokeSize
        EndIf
        If st_a >0 And st_s >0
          MovePathCursor(0,0)
          AddPathBox(x1+\Line(i)\caze(j)\x , y1+\Line(i)\caze(j)\y, \Line(i)\caze(j)\w, \Line(i)\caze(j)\h )
          VectorSourceColor(RGBA(Red(c), Green(c), Blue(c), st_a))
          StrokePath((st_s * Project\Width)/2500,#PB_Path_RoundEnd|#PB_Path_RoundCorner)
        EndIf
        
        ; selection of the case
        If exportimage = 0 And BDCOptions\showSelected 
          If i = lineID And j = caseid
            AddPathBox(x1+\Line(i)\caze(j)\x, y1+\Line(i)\caze(j)\y, \Line(i)\caze(j)\w, \Line(i)\caze(j)\h)
            VectorSourceColor(RGBA(255,0,0,100))
            StrokePath(40)
          EndIf
        EndIf
      Next
    Next
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
    
    Canvas_DrawThePage(vx,vy)
    
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
  i = CaseID
  With project\page(PageId)\Line(LineID)
    SetGadgetState(#G_win_Story_CaseDepth, \caze(CaseId)\Depth)
    SetGadgetState(#G_win_Story_CaseX, \caze(CaseId)\x)
    SetGadgetState(#G_win_Story_CaseY, \caze(CaseId)\y)
    SetGadgetState(#G_win_Story_CaseW, \caze(CaseId)\w)
    SetGadgetState(#G_win_Story_CaseH, \caze(CaseId)\h)
    SetGadgetState(#G_win_Story_CaseID, CaseId)
    
    ;If \caze(i)\StrokeSet <2
      ;SetGadgetState(#G_win_Story_CaseStrokeAlpha, project\StrokeAlpha)
      ;SetGadgetState(#G_win_Story_CaseStrokeSize, project\StrokeSize)
    ;ElseIf \caze(i)\StrokeSet >=2
      SetGadgetState(#G_win_Story_CaseStrokeAlpha, \caze(CaseId)\StrokeAlpha)
      SetGadgetState(#G_win_Story_CaseStrokeSize, \caze(CaseId)\StrokeSize)
    ;EndIf
    SetGadgetState(#G_win_Story_CaseStrokeSet, \caze(CaseId)\StrokeSet)
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
          x = GetGadgetAttribute(gad, #PB_Canvas_MouseX) /z -vx ;- cx 
          y = GetGadgetAttribute(gad, #PB_Canvas_MouseY) /z -vy ;- cy 
          
          With project\page(PageId)
            For i=0 To ArraySize(\Line())
              If y>=margeTop+\Line(i)\y And y<=margeTop+\Line(i)\y +\Line(i)\h
                lineID = i
                For j=0 To ArraySize(\Line(i)\caze())
                  ; If x>=vx+margeL+\Line(i)\caze(j)\x And x<=vx+margeL+\Line(i)\caze(j)\x +\Line(i)\caze(j)\w
                  If x>=(margeL+\Line(i)\caze(j)\x) And x<=(margeL+\Line(i)\caze(j)\x +\Line(i)\caze(j)\w)
                    caseId = j
                    ;Break
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

;{ create page, line, case...
Procedure Page_update(nbcase=1,updatelineproperties=1,updatenb=0,updateline=0)
  
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
    
;     Debug "mode auto :"+Str(BDCOptions\ModeAutomatic)
;     Debug "nbcasebyline :"+Str(\page(k)\NbcaseByline)
;     Debug "nbline :"+Str(\page(k)\Nbline)
    
    If BDCOptions\ModeAutomatic = 1
      ;{ 
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
          \page(k)\Line(i)\caze(j)\Color = RGB(255,255,255)
        Next
        
      Next
      lineId = 0
      ;}
     
    Else
      
        ; set lineID properties
        If lineID >ArraySize(\page(k)\Line())
          lineID = ArraySize(\page(k)\Line())
        EndIf
        
        i = lineID
        x = \page(k)\Line(i)\x ; 0 ;margeL
        y = \page(k)\Line(i)\y ; i * (h1 + spacelineH); +MargeTop
        w1 = \page(k)\Line(i)\w;i * (h1 + spacelineH); +MargeTop
        h1 = \page(k)\Line(i)\h;i * (h1 + spacelineH); +MargeTop
        Line_SetProperties(i,x,y,w1,h1)
      If updateline  
        For j=0 To ArraySize(\page(k)\Line(i)\caze())
          \page(k)\Line(i)\caze(j)\h = h1
          \page(k)\Line(i)\caze(j)\y = y
          \page(k)\Line(i)\caze(j)\SizeBorder = 4
          \page(k)\Line(i)\caze(j)\Depth = j*10
          \page(k)\Line(i)\caze(j)\nbImage = -1
          \page(k)\Line(i)\caze(j)\Color = RGB(255,255,255)
        Next
      EndIf
      
      
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
    If updatenb=1
      SetGadgetState(#G_win_Story_NbCaseByLine, \NbcaseByline+1)
      SetGadgetState(#G_win_Story_NbLine, \Nbline+1)
    EndIf
    SetGadgetState(#G_win_Story_MargeBottom, \MargeBottom)
    SetGadgetState(#G_win_Story_MargeLeft, \MargeLeft)
    SetGadgetState(#G_win_Story_MargeRight, \MargeRight)
    SetGadgetState(#G_win_Story_MargeTop, \MargeTop)
    SetGadgetState(#G_win_Story_SpacebetweenCase, \SpacebetweenCase)
    SetGadgetState(#G_win_Story_SpacebetweenLine, \SpacebetweenLine)
    
    SetGadgetState(#G_win_Story_StrokeAlpha, project\StrokeAlpha)
    SetGadgetState(#G_win_Story_StrokeSize, project\StrokeSize)

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
      AddGadgetItem(#G_win_Story_PageSelect, -1,  lang("page ")+Str(i+1))
      SetGadgetState(#G_win_Story_PageSelect, i)
    EndWith
    Page_update(1,1,1)
    
  Else ; delete the page
    
  EndIf
  
EndProcedure
;}

;{ Gadgets
Procedure gadget_AddItems(gad,text$,state=0,folder$="",pattern$="*.*",foldertype = #PB_DirectoryEntry_Directory)
  Shared wec_bankimage(), wec_NbImage
  If text$= #Empty$
    Debug folder$
    If ExamineDirectory(0,folder$, pattern$)
      While NextDirectoryEntry(0)
        If DirectoryEntryType(0) = foldertype
          ;If DirectoryEntrySize(0) > 0
          If DirectoryEntryName(0)<> "." And DirectoryEntryName(0)<> ".."
            ext$ = LCase(GetExtensionPart(DirectoryEntryName(0)))
            ;Debug DirectoryEntryName(0)
            If (ext$ ="jpg" Or ext$ ="png" Or ext$ ="bmp") Or foldertype = #PB_DirectoryEntry_Directory
              wec_NbImage +1
              i = wec_NbImage
              ReDim wec_bankimage(i)
              With wec_bankimage(i)
                \file$ = folder$+DirectoryEntryName(0)
                \text$ = DirectoryEntryName(0)
                ; Debug \file$
              EndWith
            EndIf
          EndIf
        EndIf 
      Wend
      FinishDirectory(0)
    EndIf
    ClearGadgetItems(gad)
    For i=0 To ArraySize( wec_bankimage())
      AddGadgetItem(gad, -1,  wec_bankimage(i)\text$)
    Next
    
  Else
    
    nb = FindString(text$, ",")-1
    ClearGadgetItems(gad)
    For i=0 To nb
      t$ = StringField(text$,i+1,",")
      If t$ <> ""
        AddGadgetItem(gad,-1,lang(t$))
      EndIf
    Next 
  EndIf
  
  SetGadgetState(gad,state)
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
      AddGadget(#G_win_Story_NbLine,#Gad_spin,x,y,w1,h1,"",1,20,Lang("Set the number of lines for this page"),3,Lang("Nb of lines")) : y+h1+a
      AddGadget(#G_win_Story_NbCaseByLine,#Gad_spin,x,y,w1,h1,"",1,20,Lang("Set the number of cases by lines for this page (automatic mode)"),2,Lang("Nb of Cases"))
      y+h1+10
      
      ; Stroke
       If FrameGadget(#PB_Any, 2,y,wp-2,4*(h1+a)+20,lang("Page"))
         y+b
        AddGadget(#G_win_Story_StrokeSize,#Gad_spin,x,y,w1,h1,"",0,100,Lang("Set the stroke size for case borders"),0,Lang("Stroke Size")) : y+h1+a
        AddGadget(#G_win_Story_StrokeAlpha,#Gad_spin,x,y,w1,h1,"",0,255,Lang("Set the transparency for the stroke of the case borders"),0,Lang("Stroke Alpha")) : y+h1+8
       EndIf
      
      ; marges
;       If FrameGadget(#PB_Any, 2,y,wp-2,4*(h1+a)+20,lang("Marge"))
;         y+b
;         AddGadget(#G_win_Story_PageAddNumber,#Gad_Chkbox,x,y,w1,h1,"",0,0,lang("Add the number off the page"),0,Lang("Number")) : y+h1+10
;       EndIf
      
      If FrameGadget(#PB_Any, 2,y,wp-2,4*(h1+a)+20,lang("Marge"))
        y+b
        AddGadget(#G_win_Story_MargeTop,#Gad_spin,x,y,w1,h1,"",0,20000,lang("Set the Top Space for this page, or in automatic mode for all pages"),100,Lang("Top")) : y+h1+a
        AddGadget(#G_win_Story_MargeBottom,#Gad_spin,x,y,w1,h1,"",0,20000,lang("Set the Bottom Space for this page, or in automatic mode for all pages"),100,Lang("Bottom")) : y+h1+a
        AddGadget(#G_win_Story_MargeLeft,#Gad_spin,x,y,w1,h1,"",0,20000,lang("Set the Left Space for this page, or in automatic mode for all pages"),100,Lang("Left")) : y+h1+a
        AddGadget(#G_win_Story_MargeRight,#Gad_spin,x,y,w1,h1,"",0,20000,lang("Set the Right Space for this page, or in automatic mode for all pages"),100,Lang("Right")) 
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
      If FrameGadget(#PB_Any, 2,y,wp-2,10*(h1+a)+20,lang("Case"))
        y+b
        AddGadget(#G_win_Story_CaseStrokeSize,#Gad_spin,x,y,w1,h1,"",0,100,Lang("Set the stroke size for case borders (if stroke is set on case or line)"),8,Lang("Stroke Size")) : y+h1+a
        AddGadget(#G_win_Story_CaseStrokeAlpha,#Gad_spin,x,y,w1,h1,"",0,255,Lang("Set the transparency for the stroke of the case borders(if stroke is set on case or line)"),255,Lang("Stroke Alpha")) : y+h1+a
        AddGadget(#G_win_Story_CaseStrokeSet,#Gad_Cbbox,x,y,w1,h1,"",0,0,Lang("Set the stroke of the case borders"),0,Lang("Stroke")) : y+h1+8
        Gadget_AddItems(#G_win_Story_CaseStrokeSet,"Project,Page,Line,Case,") 

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
    
    ; AddGadgetItem(#G_win_Story_panel, -1, Lang("Text"))
    ; y=5
   
    CloseGadgetList()
  EndIf
  
  y = 5+tbh : x+wp+5
  If CanvasGadget(#G_win_Story_Canvas, x, y, winw - wp-15, hp,#PB_Canvas_Border|#PB_Canvas_Keyboard): EndIf
  ;}
  
EndProcedure
;}

;{ Menu
; options
Procedure BDC_SaveOptions()
    
    FileName.s = GetCurrentDirectory() + "PreferencesBDC.json"

    ; Sauvegarde des options
    CreateJSON(#JSONFile)
    InsertJSONStructure(JSONValue(#JSONFile), @BDCOptions, sBDCOptions)
    SaveJSON(#JSONFile, FileName, #PB_JSON_PrettyPrint)

EndProcedure
Procedure BDC_OptionsReset()
  With BDCOptions
    \Action = 0
    \Modeautomatic =1
    \PanelW = 250
    \PathExport$ = "save\"
    \pathOpen$ = "save\"
    \PathSave$ = "save\"
    \PathImage$ = "data\images\"
    \ShowMarge = 0
    \ShowSelected = 1
    \ToolbarH = 30
    \Zoom = 20
    \CaseBankScale = 100
    ; project by default
    \Project\dpi = 300
    \Project\Height_mm = 297
    \Project\Height = 3500
    \Project\Width = 2500
    \Project\Width_mm = 210
    \Project\SpacebetweenCase = 50
    \Project\SpacebetweenLine = 50
    \Project\MargeTop = 250
    \Project\MargeLeft = 150
    \Project\MargeRight = 150
    \Project\MargeBottom = 200
    \Project\Nbpage = 0
    ; stroke case
    \Project\StrokeAlpha = 255
    \Project\StrokeSize = 8
    \Project\StrokeColor = 0
  EndWith
EndProcedure
Procedure BDC_LoadOptions()
    
    BDC_OptionsReset()
    
    FileName$ = GetCurrentDirectory() + "PreferencesBDC.json"
    
    If FileSize(FileName$) < 0        
        BDC_SaveOptions()
    EndIf
        
    ; Lecture des options
    If LoadJSON(#JSONFile, FileName$, #PB_JSON_NoCase)
      ExtractJSONStructure(JSONValue(#JSONFile), @BDCOptions, sBDCOptions)
    EndIf
    
    ; then check for some variable
      With BDCOptions
;         If \firstopening=0
;           \firstopening=1
;           
;         EndIf
      CheckZero(\CaseBankScale,100)
      CheckZero(\PanelW,250)
      ; CheckZero(\Project\StrokeSize,8)
    EndWith
    
    
EndProcedure
; files
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
  PageId = 0
  LineId = 0
  CaseId = 0
  
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
    \StrokeSize = BDCOptions\Project\StrokeSize
    \StrokeColor = BDCOptions\Project\StrokeSize
    \StrokeAlpha = BDCOptions\Project\StrokeAlpha
    SetGadgetState(#G_win_Story_StrokeSize,\StrokeSize)
    SetGadgetState(#G_win_Story_StrokeAlpha,\StrokeAlpha)
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
  Page_update(1,1,1)
  ; LineCase_GetProperties()
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
      e$=";"
      virg$ = "{{virgule}}"

      Doc_New()
      ClearGadgetItems(#G_win_Story_PageSelect)
      Modeautomatic = BDCOptions\Modeautomatic
      BDCOptions\Modeautomatic = 0
      
      While Eof(0) = 0          
        line$ = ReadString(0) 
        index$ = StringField(line$, 1, d$)
        
        u=2
        Select index$
          Case "gen"
            version$ = StringField(line$, u, d$) : u+1
            Date$ = StringField(line$, u, d$) : u+1
            
          Case "options"  
            Modeautomatic = Val(StringField(line$, u, d$)) : u+1
            BDCOptions\Zoom = Val(StringField(line$, u, d$)) : u+1
            BDCOptions\ShowMarge = Val(StringField(line$, u, d$)) : u+1
            BDCOptions\ShowSelected = Val(StringField(line$, u, d$)) : u+1
            
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
            AddGadgetItem(#G_win_Story_PageSelect, -1,  lang("page ")+Str(id+1))

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
            ;{ line
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
             ;}
             
           Case "case"
             ;{ case
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
              \StrokeSet = Val(StringField(line$, u, d$)) : u+1
              \StrokeAlpha = Val(StringField(line$, u, d$)) : u+1
              \StrokeSize = Val(StringField(line$, u, d$)) : u+1
              \StrokeColor = Val(StringField(line$, u, d$)) : u+1
            EndWith
            ;}
            
          Case "image"
            ;{ image
            Pageid = Val(StringField(line$, u, d$)) : u+1
            Lineid = Val(StringField(line$, u, d$)) : u+1
            Caseid = Val(StringField(line$, u, d$)) : u+1
            ImageId = Val(StringField(line$, u, d$)) : u+1
            If  imageId > ArraySize(project\page(pageID)\Line(lineId)\caze(Caseid)\image())
              ReDim project\page(pageID)\Line(LineId)\caze(Caseid)\image(imageId)
              project\page(pageID)\Line(LineId)\caze(Caseid)\nbImage = ArraySize(project\page(pageID)\Line(lineId)\caze(Caseid)\image())
            EndIf
            With project\page(pageID)\Line(Lineid)\caze(caseId)\image(imageId)
              \x = Val(StringField(line$, u, d$)) : u+1
              \y = Val(StringField(line$, u, d$)) : u+1
              \w = Val(StringField(line$, u, d$)) : u+1
              \h = Val(StringField(line$, u, d$)) : u+1
              \typ = Val(StringField(line$, u, d$)) : u+1
              \shapetyp = Val(StringField(line$, u, d$)) : u+1
              \Depth = Val(StringField(line$, u, d$)) : u+1
              \alpha = Val(StringField(line$, u, d$)) : u+1
              \scale = Val(StringField(line$, u, d$)) : u+1
              \file$ = ReplaceString(StringField(line$, u, d$),virg$, ",") : u+1
              \text$ = ReplaceString(StringField(line$, u, d$),virg$, ",") : u+1
              \fontName$ = StringField(line$, u, d$) : u+1
              \fontSize = Val(StringField(line$, u, d$)) : u+1
              \fontText$ = ReplaceString(StringField(line$, u, d$),virg$, ",") : u+1
              \fontWidth = Val(StringField(line$, u, d$)) : u+1
              \TextX = Val(StringField(line$, u, d$)) : u+1
              \TextY = Val(StringField(line$, u, d$)) : u+1
              \BubleArrowTyp = Val(StringField(line$, u, d$)) : u+1
              \miror = Val(StringField(line$, u, d$)) : u+1
              \rotation = Val(StringField(line$, u, d$)) : u+1
              \brightness = Val(StringField(line$, u, d$)) : u+1
              
              ; then update the case
              If \file$ <> #Empty$ Or \text$ <> #Empty$ Or \fontName$ <> #Empty$
                If \typ = #CaseTyp_Img
                  If FileSize(\file$) >0 
                    project\page(pageID)\Line(Lineid)\caze(caseId)\image(ImageId)\img = LoadImage(#PB_Any, \file$)
                  EndIf
                ElseIf \typ =#CaseTyp_Text
                  project\page(pageID)\Line(Lineid)\caze(caseId)\image(ImageId)\img = Case_SetText(\text$, 1)
                EndIf
                UpdateMaincanvas_withimage()
              EndIf
            EndWith
            ;}
            
        EndSelect
        
      Wend
      CloseFile(0)
      
      ; update 
      Pageid = 0
      Lineid = 0
      CaseID = 0
      ImageId = 0
      Page_Update()
      LineCase_GetProperties()
      BDCOptions\Modeautomatic = Modeautomatic
      SetGadgetState(#G_win_Story_ModeAutomatic,BDCOptions\Modeautomatic)
      SetGadgetState(#G_win_Story_PageSelect,0)
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
          virg$ = "{{virgule}}"

          WriteStringN(0, "// Created with "+#BDC_ProgramName+#BDC_ProgramVersion)
          
          ; info program
          WriteStringN(0, "gen,"+#BDC_ProgramVersion+d$+FormatDate("%dd%mm%yyyy_%hh%ii%ss", Date())+d$)
          
          ; options
          txt$ = "options,"+Str(BDCOptions\Modeautomatic)+d$+Str(BDCOptions\Zoom)+d$+Str(BDCOptions\ShowMarge)+d$+Str(BDCOptions\ShowSelected)+d$
          WriteStringN(0, txt$)
          
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
                  txt$ + Str(\StrokeSet)+d$+Str(\StrokeAlpha)+d$+Str(\StrokeSize)+d$+Str(\StrokeColor)+d$
                  WriteStringN(0, txt$) 
                EndWith
                
                ; save image and text
                For l=0 To ArraySize(project\page(i)\Line(j)\caze(k)\image())
                  With project\page(i)\Line(j)\caze(k)\image(l)
                    If \typ = #CaseTyp_Img
                      \fontName$ = ""
                      \fontSize = 0
                    ElseIf \typ = #CaseTyp_Text
                      \file$ = ""
                      ; \text$ = ""
                    EndIf
                    If \file$ <> #Empty$ Or \text$ <> #Empty$ Or \fontName$ <> ""
                      txt$ = "image,"+Str(i)+d$+Str(j)+d$+Str(k)+d$+Str(l)+d$
                      txt$ + Str(\x)+d$+Str(\y)+d$+Str(\w)+d$+Str(\h)+d$
                      txt$ + Str(\typ)+d$+Str(\shapetyp)+d$+Str(\Depth)+d$+Str(\alpha)+d$+Str(\scale)+d$
                      txt$ + ReplaceString(\file$, ",",virg$)+d$+ReplaceString(\text$,",",virg$)+d$
                      txt$ + \fontName$+d$+Str(\fontSize)+d$+ReplaceString(\fontText$,",",virg$)+d$
                      txt$ + Str(\fontWidth)+d$+Str(\TextX)+d$+Str(\TextY)+d$+Str(\BubleArrowTyp)+d$
                      txt$ + Str(\miror)+d$+Str(\rotation)+d$+Str(\brightness)+d$
                      WriteStringN(0, txt$) 
                    EndIf
                  EndWith
                Next 
                
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
  
  If filename$ <> #Empty$
    
    If GetFileExists(filename$) = 0
      
      ext$ = LCase(GetExtensionPart(filename$))
      If ext$ = ""
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
      Else
        Select ext$
          Case "png"
             format = #PB_ImagePlugin_PNG    
           Case "jpg"
             format = #PB_ImagePlugin_JPEG   
           Case "bmp"
             format = #PB_ImagePlugin_BMP   
        EndSelect
      EndIf
      
      If CreateImage(#Img_Export, Project\Width, project\Height, 32, #PB_Image_Transparent)
       
        id = #Img_Export
        If StartVectorDrawing(ImageVectorOutput(id)) 
         
          If useold = 0
            Canvas_DrawThePage(0,0,1)
          Else
            ;{ old technic for export
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
            ;}
          EndIf
          StopVectorDrawing()
        EndIf
        
        If SaveImage(id, filename$, format, 8) 
        EndIf
        FreeImage(id)
      EndIf
      
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
Procedure.a GetImageIdIsOk()
  If imageId >-1 And imageID<= ArraySize(Project\page(pageid)\Line(lineId)\caze(caseId)\image())
    ProcedureReturn 1
  Else
    ProcedureReturn 0
  EndIf
EndProcedure


; Window Adjustement
Procedure Window_ImageAdujstement(mode=0)
  If GetImageIdIsOk() = 1
    If OpenWindow(#BDC_ImageADjustement,0,0,winw,winh,lang("Image Adjustement"),#PB_Window_ScreenCentered|#PB_Window_SystemMenu)
      
      img = Project\page(pageid)\Line(lineId)\caze(caseId)\image(imageID)\img
      IE_GetImagePixelColor(img)
      ; mode = 0 : color balance
      ; mode=1 : brightness
      Select mode
      EndSelect 
      
    EndIf
  EndIf
EndProcedure



; window Edit case
Procedure WEC_updateShortcut(create=1)
  ;   To add or delete shortcuts
  If create =1
    AddKeyboardShortcut(#BDC_Win_EditCase, #PB_Shortcut_Delete,#BDC_Menu_WEC_ObjectDelete)
  Else
  EndIf
  
EndProcedure

Procedure Image_transform(img,transform=0)
  
  If transform = 0 ; mirorW
    w = ImageWidth(img)
    h = ImageHeight(img) 
    Dim pixel.i(w, h)
    Dim alph.a(w, h)
    ; we get the color // on chope la couleur
    If StartDrawing(ImageOutput(img))
      DrawingMode(#PB_2DDrawing_AllChannels)
      For y = 0 To h - 1
        For x = 0 To w - 1
          color = Point(x, y)
          alpha = Alpha(color)
          pixel(x, y) = color
          Alph(x, y) = alpha
        Next
      Next
      StopDrawing()
    EndIf
    
    NewImg = CreateImage(#PB_Any, w, h, 32, #PB_Image_Transparent)

     If NewImg
      
      If StartDrawing(ImageOutput(NewImg))
        DrawingMode(#PB_2DDrawing_AlphaBlend)
        For x = w - 1 To 0 Step -1
          StripeImg = GrabImage(Img, #PB_Any, x, 0, 1, h)
          If StripeImg
            DrawAlphaImage(ImageID(StripeImg), w - x - 1, 0) 
            FreeImage(StripeImg)
          EndIf
        Next x
        
        StopDrawing()
        
      EndIf
      
     ; FreeImage(img)
    EndIf
    FreeArray(pixel())
    FreeArray(alph())
    
    ProcedureReturn NewImg

  Else  
    
  EndIf
  
EndProcedure
Procedure UpdateMaincanvas_withimage()
  With project\page(pageID)\Line(LineId)\caze(CaseID)
    
    If \imageFinal\img =0
      \imageFinal\img = CreateImage(#PB_Any, \w,\h,32,#PB_Image_Transparent)
    Else
      w = ImageWidth(\imageFinal\img)
      h = ImageHeight(\imageFinal\img)
      If \w <> w Or \h <> h
        FreeImage2(\imageFinal\img)
        \imageFinal\img = CreateImage(#PB_Any, \w,\h,32,#PB_Image_Transparent)
      EndIf
    EndIf
    
    ; check if we have mirored image
    For n=0 To ArraySize(\image())
      If IsImage(\image(n)\img)
        If \image(n)\miror
          \image(n)\img = Image_transform(\image(n)\imgtemp,0)
        EndIf
      EndIf
    Next
    
    ; the draw
    If StartDrawing(ImageOutput(\imageFinal\img))
      ; erase images
      DrawingMode(#PB_2DDrawing_AllChannels)
      Box(0,0,OutputWidth(), OutputHeight(), RGBA(0,0,0,0))
      
      ; draw the images of the case
      DrawingMode(#PB_2DDrawing_AlphaBlend)
      For n=0 To ArraySize(\image())
        If IsImage(\image(n)\img)
          img =  \image(n)\img
;           If \image(n)\miror
;             img =  \image(n)\imgtemp
;           EndIf
          
          If \image(n)\scale <> 100
            img1 = img
            s.d = \image(n)\scale * 0.01
            img = CopyImage(img1, #PB_Any)
            ResizeImage(img, ImageWidth(img1) * s, ImageHeight(img1) * s)
          Else
            ; img = \image(n)\img
          EndIf
          DrawAlphaImage(ImageID(img),\image(n)\x,\image(n)\y,\image(n)\alpha)
          
          If \image(n)\scale <> 100
            Freeimage2(img)
          EndIf
;            If \image(n)\miror
;             FreeImage(\image(n)\imgtemp)
;           EndIf
        EndIf
      Next 
      StopDrawing()
    EndIf
  EndWith
  UpdateCanvasMain()
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
    
    ; white Background
    AddPathBox(0,0,w,h)
    VectorSourceColor(RGBA(255,255,255,255))
    FillPath()
    
    ScaleCoordinates(vs,vs)
    
    With project\page(pageId)\Line(LineId)\caze(CaseId)
      ; draw image of the case
      For i=0 To ArraySize(\image())
        If \image(i)\hide = 0
          img = \image(i)\img
          If IsImage(img)
          ResetCoordinates()
          ScaleCoordinates(vs,vs)
          ; set variables
          s.d = \image(i)\scale * 0.01
          x = vx+\image(i)\x
          y = vy+\image(i)\y
          w2 = \image(i)\w * s
          h2 = \image(i)\h * s
          ; draw image
         MovePathCursor(x, y)
          If \image(i)\miror
            x=vx+\image(i)\x+w2
            MovePathCursor(x, y)
            ScaleCoordinates(-1,1)
          EndIf
          DrawVectorImage(ImageID(img),\image(i)\alpha,w2,h2)
          If \image(i)\miror
            ResetCoordinates()
            ScaleCoordinates(vs,vs)
            x=vx+\image(i)\x
          EndIf
          If i = imageId
            AddPathBox(x,y,w2,h2)
            VectorSourceColor(RGBA(255,0,0,255))
            StrokePath(2)
          EndIf
         
        EndIf
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
  If imageID <= ArraySize( project\page(pageId)\Line(LineId)\caze(CaseId)\image()) And imageID >=0
    With project\page(pageId)\Line(LineId)\caze(CaseId)\image(ImageId)
      SetGadgetState(#G_win_EditCase_ImageX, \x)
      SetGadgetState(#G_win_EditCase_ImageY, \y)
      SetGadgetState(#G_win_EditCase_ImageAlpha, \alpha)
      SetGadgetState(#G_win_EditCase_ImageDepth, \depth)
      SetGadgetState(#G_win_EditCase_ImageH, \h)
      SetGadgetState(#G_win_EditCase_ImageScale, \scale)
      SetGadgetState(#G_win_EditCase_ImageW, \w)
      SetGadgetState(#G_win_EditCase_ImageMiror, \miror)
      SetGadgetState(#G_win_EditCase_ImageRotation, \rotation)
      SetGadgetState(#G_win_EditCase_ImageBrightness, \brightness)
      SetGadgetState(#G_win_EditCase_ImageContrast, \Contrast)
    EndWith
  EndIf
EndProcedure
Procedure Window_EditCase_UpdateList()
  ImageID = 0
  ClearGadgetItems(#G_win_EditCase_ImageList)
  With project\page(pageID)\Line(LineId)\caze(CaseID)
    If \nbImage>-1
      For i=0 To ArraySize(\image())
        file$ = \image(i)\file$
        If \image(i)\typ = #CaseTyp_Text
          file$ = \image(i)\fontText$
        EndIf
        AddGadgetItem(#G_win_EditCase_ImageList,i, GetFilePart(file$,#PB_FileSystem_NoExtension))
      Next
    EndIf
  EndWith
EndProcedure

Procedure WEC_ImageAdjust()
  
  If GetImageIdIsOk() = 1
    With Project\page(pageid)\Line(lineId)\caze(caseId)\image(ImageID)
      
      If \brightness Or \Contrast>1
        
        tempImgPaper = CopyImage(\imgtemp, #PB_Any)
        
        Echelle.d = (400+\Contrast)/400
        EchelleB.d = \brightness/100 ; 0.2
        
        If StartDrawing(ImageOutput(tempImgPaper))
          For i= 0 To OutputWidth()-1
            For j=0 To OutputHeight()-1
              col = Point(i,j)
              r = (Red(col) * Echelle  + 127 * (1 - Echelle)) * EchelleB
              g = (Green(col)* Echelle  + 127 * (1 - Echelle))* EchelleB
              b = (Blue(col)* Echelle  + 127 * (1 - Echelle)) * EchelleB
              Check0(r)
              Check0(g)
              Check0(b)
              Plot(i,j,RGB(r,g,b))
            Next
          Next
          StopDrawing()
        EndIf
        
        freeimage2(\img)
        \img = tempImgPaper
        UpdateCanvas_WinEditCase()
      EndIf
    EndWith
  EndIf
  
EndProcedure
Procedure Case_Update(img,text$,file$,set=0,scale=-1,alpha=255,typ=0,shapetyp=0,depth=-57267,miror=0,rot=0, Brightness=100)
  Shared wec_fontname$, wec_fontsize
  If scale=-1
    scale = BDCOptions\CaseBankScale
  EndIf
  If depth = -57267
    depth = BDCOptions\CaseBankDepth
  EndIf
  
  With project\page(pageID)\Line(LineId)\caze(CaseID)
    If set = 0
      \nbImage+1
      n= \nbImage
      ReDim \image(n)
      ; update gadget win_editcase
      AddGadgetItem(#G_win_EditCase_ImageList,n, GetFilePart(file$,#PB_FileSystem_NoExtension))

    Else
      n = imageId
      ; update gadget win_editcase
      If IsGadget(#G_win_EditCase_ImageList)
        If CountGadgetItems(#G_win_EditCase_ImageList)<n Or  CountGadgetItems(#G_win_EditCase_ImageList)=0
          AddGadgetItem(#G_win_EditCase_ImageList,-1, GetFilePart(file$,#PB_FileSystem_NoExtension))
        Else
          SetGadgetItemText(#G_win_EditCase_ImageList,n, GetFilePart(file$,#PB_FileSystem_NoExtension))
        EndIf
      EndIf
    EndIf
    
    If IsGadget(#G_win_EditCase_ImageList)
      \image(n)\depth = depth
      \image(n)\img = img
      \image(n)\imgtemp = CopyImage(img, #PB_Any)
      
      \image(n)\typ = typ
      \image(n)\shapetyp = shapetyp
      If typ = #CaseTyp_Text
        \image(n)\fontText$ = text$
        \image(n)\fontName$ = wec_fontname$
        \image(n)\fontSize = wec_fontsize
      EndIf
      \image(n)\text$ = text$
      \image(n)\file$ = file$
      \image(n)\w = ImageWidth(img)
      \image(n)\h = ImageHeight(img)
      \image(n)\scale = scale
      \image(n)\alpha = alpha
      \image(n)\miror = miror
      \image(n)\rotation = rot
      \image(n)\brightness = brightness
      
      ImageId = n
      
      ; update canvas of window_editcase
      UpdateCanvas_WinEditCase()
      Window_EditCase_SetGadgetState()
      
      ; update main canvas
      UpdateMainCanvas_WithImage()
    EndIf
  
  EndWith
  
  UpdateCanvasMain()
EndProcedure
Procedure Case_SetTextFont(update=0)
  Shared wec_fontname$, wec_fontsize
  
  font0 = FontRequester(wec_fontname$,wec_fontsize,#PB_FontRequester_Effects)
  wec_fontname$ = SelectedFontName()
  wec_fontSize = SelectedFontSize()
  If update=1
    With project\page(pageID)\Line(LineId)\caze(CaseID)\image(imageId)
      \fontName$= wec_fontname$
      \fontSize = wec_fontSize
    EndWith
    SetGadgetText(#G_win_EditBuble_TextChooseFont,wec_fontname$)
    
  EndIf
  ProcedureReturn Font0
EndProcedure
Procedure Case_SetText(text$, update=0, usefontrequester=1)
  Shared wec_fontname$, wec_fontsize
  
  If text$ <> #Empty$
    
    w = project\page(pageID)\Line(LineId)\caze(CaseID)\w
    h = project\page(pageID)\Line(LineId)\caze(CaseID)\h
    ; variable to insert the text in the ellipse or rectangle
    d = 2
    b=40
    
    ; get the shape typ for phylacter (buble) (0 = ellipse, 1= rectangle)
    If IsGadget(#G_win_EditCase_BtnTextTyp) And usefontrequester=1
      shapeTyp = GetGadgetState(#G_win_EditCase_BtnTextTyp)
      ; set font
      If wec_fontSize = 0
        wec_fontSize = 50
      EndIf
      font0 = Case_SetTextFont()
      w5 = w/d
      w6 = w/d
      arrowtyp = #BubbleArrowTyp_BottomMiddle
      x=0
      y=0
    Else
     
      With project\page(pageID)\Line(LineId)\caze(CaseID)\image(imageId)
        shapeTyp = \shapetyp
        wec_fontname$ = \fontName$
        wec_fontSize = \fontSize
         If wec_fontname$ = "" Or wec_fontSize=0
          Case_SetTextFont()
        EndIf
        w5 = \fontWidth
        If w5<=0
          w5 = 500
          \fontWidth = w5
        EndIf
        w6 = \w -b*2
        arrowtyp = \BubleArrowTyp
        x = \TextX
        y = \Texty
      EndWith
      update =1
    EndIf
    
    ; Debug w5
    
    ; create font
    LoadFont(0,  wec_fontname$ ,wec_fontSize)
    s.d = (2500/project\Width) * wec_fontSize
    
    ; free image
    If update >=1
      FreeImage2(project\page(pageID)\Line(LineId)\caze(CaseID)\image(imageId)\img)
    EndIf
    
    ; create image with text to calcule the text height
    img = CreateImage(#PB_Any, w,h,32,#PB_Image_Transparent)
    If StartVectorDrawing(ImageVectorOutput(img))
      If shapeTyp = 0
        VectorFont(FontID(0), 1.4*s)
      Else
        VectorFont(FontID(0), 1*s)
      EndIf
      MovePathCursor(0, 0)
      DrawVectorParagraph(text$,w5,h,#PB_VectorParagraph_Center)
      w1 = VectorTextWidth(text$,#PB_VectorText_Visible)
      h1 = VectorParagraphHeight(text$,w5,h)
      ;Debug Str(h1)+"/"+Str(h)
      StopVectorDrawing()
    EndIf
    ;       w2 = w/d
    
    ; then create final image (bubble+text):)
    FreeImage(img)
    
    w1= w6
    h3 = 40
    If shapeTyp = 0
      h1=h/2 +b*2
      w1+b*2
    Else
      h1 = h1+b*2
      w1+b*2
    EndIf
    ; Debug Str(h1)+"/"+Str(h)
    file$ = text$
    w=w6+b*2
    h=h1
    
    
   
    w3 = 60
    img = CreateImage(#PB_Any,w,h1,32,#PB_Image_Transparent)
    If StartVectorDrawing(ImageVectorOutput(img))
      
      ; for the arrow of the buble
       u = 0
      xa1 = w1/2-w3
      ya1 = h1/2
      xa3 = w1/2+w3
      ya3 = h1/2
      Select arrowtyp
        Case #BubbleArrowTyp_BottomMiddle
          xa2 = w1/2
          ya2 = h1
        Case #BubbleArrowTyp_BottomLeft 
          xa2 = 0
          ya2 = h1
        Case #BubbleArrowTyp_BottomRight
          xa2 = w1
          ya2 = h1
        Case #BubbleArrowTyp_CenterRight
          xa2 = w1
          ya2 = h1/2
          ya1 = h1/2-w3
          ya3 = h1/2+w3
       Case #BubbleArrowTyp_CenterLeft
          xa2 = 0
          ya2 = h1/2
          ya1 = h1/2-w3
          ya3 = h1/2+w3
        Case #BubbleArrowTyp_TopLeft
          xa2 = 0
          ya2 = 0
        Case #BubbleArrowTyp_TopMiddle
          xa2 = w1/2
          ya2 = 0
        Case #BubbleArrowTyp_TopRight
          xa2 = w1
          ya2 = 0
      EndSelect
      
      
      ; Create the buble
      If shapeTyp = 0
        h0 = h1/d-h3*2
        w0 = w1-h3*2
        AddPathEllipse(w1/2,h1/d,w0/d,h0)
      ElseIf shapeTyp = 1
        h0 = h1-h3*2
        w0 = w1-h3*2
        AddPathBox(h3,h3,w1,h0)
      EndIf
      VectorSourceColor(RGBA(255,255,255,255))
      FillPath()
      
      ; pointe de la buble
     
      MovePathCursor(xa1+u,ya1+u)
      AddPathLine(xa2+u,ya2+u)
      AddPathLine(xa3+u,ya3+u)
      VectorSourceColor(RGBA(255,255,255,255))
      FillPath()
      
      ; text
      VectorFont(FontID(0), 1 * s)
      VectorSourceColor(RGBA(0,0,0,255))
;       x+h3
;       y+h3
      If shapeTyp = 0
        MovePathCursor(x,Y+h1*0.16)
      ElseIf shapeTyp = 1
        MovePathCursor(x,y+(b/4)*s)
      EndIf
      DrawVectorParagraph(text$,w5,h,#PB_VectorParagraph_Center)
      StopVectorDrawing()
    EndIf
    
    If update=1
      With project\page(pageID)\Line(LineId)\caze(CaseID)\image(imageId)
        scale = \scale
        alpha = \alpha
        shapeTyp = \shapetyp
      EndWith
      Case_Update(img,text$,file$,1,scale,alpha,1,shapeTyp)
    ElseIf update = 2
      Case_Update(img,text$,file$,1,100,255,1,shapeTyp)
    EndIf
    

    With project\page(pageID)\Line(LineId)\caze(CaseID)\image(imageId)
      \typ = #CaseTyp_Text
      \fontName$ = wec_fontname$
      \fontSize = wec_fontsize
      \fontText$ = text$
      \text$ = text$
      \fontWidth = w5
      \img = img
    EndWith
    
  EndIf
  
  ProcedureReturn img
EndProcedure
Procedure Case_AddObject(typ=0, mode=0)
  Shared wec_vx, wec_vy, wec_zoom
  Shared wec_bankimage(), wec_bankimageid
  Shared wec_fontname$, wec_fontsize

  ; typ = 0 : add image
  ; typ = 1 : add text
  ; typ = 2: delete image
  ; mode = 0 : open an image
  ; mode = 1 : load the image witht the filename$ in the wec_bankimage() array
   vs.d = wec_zoom * 0.01

  If typ= #CaseTyp_Text
    ;{ Add text
    text$ = InputRequester(lang("text"), lang("Add a text"),"")
    If text$<> ""
      With project\page(pageID)\Line(LineId)\caze(CaseID)
        \nbImage+1
        n= \nbImage
        ReDim \image(n)
        \image(n)\alpha = 255
        \image(n)\scale = 100
        \image(n)\typ = #CaseTyp_Text
      EndWith
      imageId = n
      ; update gadget win_editcase
      AddGadgetItem(#G_win_EditCase_ImageList,n, GetFilePart(text$,#PB_FileSystem_NoExtension))
      ; create text
      Case_SetText(text$,1)
      Window_EDitBubble()
      ; file$ = text$
    EndIf
    ;}
  ElseIf typ = #CaseTyp_Img
    ;{ add image
    set = 0
    If mode = 0 Or mode = 2
      file$= OpenFileRequester(lang("add an image"),BDCOptions\PathImage$,"image|*.png;*.jpg",0)
      If mode = 2
        set =1
      EndIf
      
    Else
      file$ = wec_bankimage(wec_bankimageid)\file$
    EndIf
    
    If file$ <> "" And FileSize(file$) >0
      ;BDCOptions\PathImage$ = GetPathPart(file$)
      ;Debug BDCOptions\PathImage$
      img = LoadImage(#PB_Any, file$)
      If img > 0 
        Case_Update(img,text$,file$,set)
      EndIf
    EndIf
    ;}
    
  ElseIf typ = 2
    ;{ delete object (image/text)
    If imageId>-1 And imageID <= ArraySize(project\page(pageID)\Line(LineId)\caze(CaseID)\image())
    If ArraySize(project\page(pageID)\Line(LineId)\caze(CaseID)\image())>0
      DeleteArrayElement( project\page(pageID)\Line(LineId)\caze(CaseID)\image, imageId)
       project\page(pageID)\Line(LineId)\caze(CaseID)\nbImage-1
     Else
       With project\page(pageID)\Line(LineId)\caze(CaseID)
         \nbImage=-1
         FreeImage2(\image(0)\img)
         \image(0)\x = 0
         \image(0)\y = 0
       EndWith
       
    EndIf
    
    Window_EditCase_UpdateList()
    UpdateCanvas_WinEditCase()
    Window_EditCase_SetGadgetState()
    UpdateMainCanvas_WithImage()
    UpdateCanvasMain()
    EndIf
    ;}
  EndIf
  
EndProcedure

Procedure WinBuble_UpdateGadgets()
   With Project\page(pageid)\Line(LineId)\caze(CaseID)\image(ImageID) 
     SetGadgetText(#G_win_EditBuble_TextString, \fontText$)
     SetGadgetState(#G_win_EditBuble_TextWidth, \fontWidth)
     SetGadgetState(#G_win_EditBuble_TextSize, \fontSize)
     SetGadgetState(#G_win_EditBuble_TextX, \TextX)
     SetGadgetState(#G_win_EditBuble_TextY, \TextY)
     SetGadgetText(#G_win_EditBuble_TextChooseFont, \fontName$)
     SetGadgetState(#G_win_EditBuble_BubleArrowPosition, \BubleArrowTyp)
   EndWith
   
EndProcedure
Procedure Window_EDitBubble()
  
  winw = 400
  winH = 500 ; WindowHeight(#BDC_Win_Main)
  If OpenWindow(#BDC_Win_EditBubble, 0, 0, winW, winH, Lang("Edit Bubble"), #PB_Window_SystemMenu | #PB_Window_ScreenCentered|#PB_Window_SizeGadget, 
                WindowID(#BDC_Win_EditCase))
    WindowBounds(#BDC_Win_EditBubble,400,500, WinW,winH+100)
    ; add gadgets
    x=5 : y=5 : wp=250 : h=200 : h1=30 : w1=wp-110 : h0=winh-y*2 : a=2
    With Project\page(pageid)\Line(LineId)\caze(CaseID)\image(ImageID) 
      AddGadget(#G_win_EditBuble_TextString, #Gad_String,x,y,w1,h1,\fontText$,0,0,lang("Change the strings of the text"),-65257,lang("Text")) : y+h1+a
      AddGadget(#G_win_EditBuble_TextWidth, #Gad_spin,x,y,w1,h1,"",0,10000,lang("Change the width of the text"),\fontWidth,lang("Width")) : y+h1+a
      AddGadget(#G_win_EditBuble_TextSize, #Gad_spin,x,y,w1,h1,"",0,10000,lang("Change the Size (height) of the text"),\fontSize,lang("Size")) : y+h1+a
      AddGadget(#G_win_EditBuble_TextX, #Gad_spin,x,y,w1,h1,"",-100000,100000,lang("Change the X position of the text"),\TextX,lang("X")) : y+h1+a
      AddGadget(#G_win_EditBuble_TextY, #Gad_spin,x,y,w1,h1,"",-100000,100000,lang("Change the Y position of the text"),\TextY,lang("Y")) : y+h1+a
      AddGadget(#G_win_EditBuble_TextChooseFont, #Gad_btn,x,y,w1,h1,\fontName$,0,0,lang("Change the font of the text"),0,lang("Font")) : y+h1+a
      
      AddGadget(#G_win_EditBuble_BubleArrowPosition, #Gad_Cbbox,x,y,w1,h1,"",0,0,lang("Set the arrow position for the bubble"),0,lang("Arrow")) : y+h1+30
      ; should be the same as Bubble Arrow typ 
      Gadget_AddItems(#G_win_EditBuble_BubleArrowPosition,"BottomMidlle,BottomLeft,BottomRight,TopMiddle,TopLeft,TopRight,CenterLeft,CenterRight,",\BubleArrowTyp) 
      
      AddGadget(#G_win_EditBuble_BtnOk, #Gad_btn,x,y,w1,h1,lang("Ok"),0,0,lang("Set the changes For the text"))

      ;     #G_win_EditBuble_BubleArrowShapeTyp
    EndWith
  
  EndIf

EndProcedure

Procedure Update_WinEdit_ImageProperties(propertie, n)
 
  With project\page(pageID)\Line(lineID)\caze(CaseId)
    If GetImageIdIsOk()
      Select propertie
        Case #Propertie_Depth
          ;{ depth
          \image(ImageID)\depth = n 
          name$ = \image(ImageID)\file$
          SortStructuredArray(\image(),#PB_Sort_Ascending, OffsetOf(sImg\depth), TypeOf(sImg\depth))
          ClearGadgetItems(#G_win_EditCase_ImageList)
          For i=0 To ArraySize(\image())
            file$ = \image(i)\file$
            AddGadgetItem(#G_win_EditCase_ImageList,i, GetFilePart(file$,#PB_FileSystem_NoExtension))
            If name$ = \image(i)\file$
              imageID = i
            EndIf
          Next
          ;}
        Case #Propertie_Scale
          \image(ImageID)\scale = n
        Case #Propertie_X
          \image(ImageID)\x = n
        Case #Propertie_Y
          \image(ImageID)\y = n 
        Case #Propertie_W
          \image(ImageID)\w = n 
        Case #Propertie_H
          \image(ImageID)\h = n 
        Case #propertie_Miror
          \image(ImageID)\miror = n  
        Case #propertie_Rotation
          \image(ImageID)\rotation = n      
        Case #propertie_Brightness
          If n <> \image(ImageID)\brightness 
            \image(ImageID)\brightness = n 
            WEC_ImageAdjust()
          EndIf
        Case #propertie_Contrast
          If n <> \image(ImageID)\Contrast 
            \image(ImageID)\Contrast = n 
            WEC_ImageAdjust()
          EndIf
        Case #Propertie_Alpha
          \image(ImageID)\alpha = n 
        Case #Propertie_Hide
          \image(ImageID)\hide = n 
          
      EndSelect
      
      UpdateCanvas_WinEditCase()
    EndIf
  EndWith
 
EndProcedure
Procedure Event_WinEditcaseCanvas()
  Static wec_clic, wec_start.spoint, wec_Shift, wec_ctrl, wec_Space, wec_startscale
  Shared wec_vx, wec_vy, wec_zoom
  ; wec = window edit case
  ; BDC = BD creator
  
  z.d = wec_zoom * 0.01
  gad = #G_win_EditCase_Canvas
  
  ; key down
  If EventType() = #PB_EventType_KeyDown ; Or EventType() = #PB_EventType_Focus          
    If GetGadgetAttribute(gad, #PB_Canvas_Modifiers) & #PB_Canvas_Shift                            
      wec_Shift = 1                          
    EndIf  
    If GetGadgetAttribute(gad, #PB_Canvas_Modifiers) & #PB_Canvas_Control                         
      wec_ctrl = 1                          
    EndIf                        
    If GetGadgetAttribute(gad, #PB_Canvas_Key) & #PB_Shortcut_Space                         
      wec_Space = 1                            
    EndIf
  EndIf
  
  If EventType() = #PB_EventType_LeftButtonDown Or 
     (EventType() = #PB_EventType_MouseMove And                         
      GetGadgetAttribute(gad, #PB_Canvas_Buttons) & #PB_Canvas_LeftButton)
    
    If EventType() = #PB_EventType_LeftButtonDown
      x = GetGadgetAttribute(gad, #PB_Canvas_MouseX)/z 
      y = GetGadgetAttribute(gad, #PB_Canvas_MouseY)/z
      If wec_clic=0
        wec_clic =1
        
        With project\page(pageId)\Line(LineId)\caze(CaseID)
          
          ; select the image under the clic mouseleft
          oldImageId = imageId
          imageId = -1
          For k=0 To ArraySize(\image())
            s.d=\image(k)\scale*0.01
            If x>=wec_vx+\image(k)\x And x<=wec_vx+\image(k)\x+(s * \image(k)\w) And y>=wec_vy+\image(k)\y And y<=wec_vy+\image(k)\y+(s * \image(k)\h)
              imageId = k
              Window_EditCase_SetGadgetState()
              If IsWindow(#BDC_Win_EditBubble)
                WinBuble_UpdateGadgets()
              EndIf
              
            EndIf
          Next
          
            If oldImageId <> ImageID  
              oldImageId = ImageID
              UpdateCanvas_WinEditCase()
            EndIf
          If imageId>-1 And image <= ArraySize(\image()) 
            wec_start\x = x - \image(ImageID)\x
            wec_start\y = y - \image(ImageID)\y
            wec_startscale = \image(ImageID)\scale
          EndIf
         EndWith
      EndIf
;       ; select the object (image or text)
;       With project\page(pageId)\Line(LineId)\caze(CaseID)
;         For i=0 To 
;         Next
;       EndWith
      
    ElseIf EventType() = #PB_EventType_MouseMove
      If wec_clic
        ; move the selected object
         x = GetGadgetAttribute(gad, #PB_Canvas_MouseX)/z 
         y = GetGadgetAttribute(gad, #PB_Canvas_MouseY)/z
         ; Debug Str(x)+"/"+Str(y)
        
         With project\page(pageId)\Line(LineId)\caze(CaseID)
           If wec_ctrl=0
             \image(ImageID)\x = x - wec_start\x
             \image(ImageID)\y = y - wec_start\y
             SetGadgetState(#G_win_EditCase_ImageX,  \image(ImageID)\x)
             SetGadgetState(#G_win_EditCase_ImageY,  \image(ImageID)\y)
           Else
            \image(ImageID)\scale = (x - wec_start\x)/(\image(ImageID)\w*0.01) + wec_startscale
             ;\image(ImageID)\h = y - wec_start\y
             If \image(ImageID)\scale<=0
               \image(ImageID)\scale = 1
             EndIf
             
              SetGadgetState(#G_win_EditCase_ImageX,  \image(ImageID)\x)
           EndIf
           UpdateCanvas_WinEditCase()
         EndWith
         
      EndIf
      
    EndIf
    
    
  EndIf
  
  If EventType() = #PB_EventType_LeftButtonUp
    WEC_clic = 0
  ElseIf EventType() = #PB_EventType_KeyUp 
    ;{ key up
    If GetGadgetAttribute(gad, #PB_Canvas_Key) = #PB_Shortcut_Space 
      wec_space= 0                           
    EndIf                        
    If GetGadgetAttribute(gad, #PB_Canvas_Key)= 16 ; shift 
      wec_shift= 0                           
    EndIf  
    If GetGadgetAttribute(gad, #PB_Canvas_Key)= 17 ; ctrl 
     wec_ctrl= 0                           
    EndIf 
    ;}
  EndIf

  
EndProcedure
Procedure WEC_updateBankCanvas()
  Shared wec_bankimage(), wec_folder$, wec_bankimageid, wec_sizebankimage, wec_nbcase_bankimg
  s = 63
  wec_sizebankimage = s
  If StartDrawing(CanvasOutput(#G_win_EditCase_Bankcanvas))
    c = 150
    Box(0,0,OutputWidth(), OutputHeight(), RGBA(c,c,c,255))
    
    DrawingMode(#PB_2DDrawing_AlphaBlend)
    ; draw image
    b = OutputWidth()/(s+1)
    wec_nbcase_bankimg = b
    For i=0 To ArraySize(wec_bankimage())
      ok=0
      If wec_bankimage(i)\img = 0
        ; Debug "image :"+ wec_bankimage(i)\file$
        If wec_bankimage(i)\file$<> "" And FileSize(wec_bankimage(i)\file$)>0
          img = LoadImage(#PB_Any, wec_bankimage(i)\file$)
          If IsImage(img)
           wec_bankimage(i)\img = img
            ok = 1
          EndIf
        EndIf
      Else
        img = wec_bankimage(i)\img
        If img <> 0
          ok = 1
        EndIf
        
      EndIf
      If ok = 1
        ResizeImage(img,s,s)
        x = Mod(i,b) * 64
        y = (i/b) * 64
        ; draw a box
        c=180
        Box(x,y,s,s, RGBA(c,c,c,255))
        ; draw the image
        DrawAlphaImage(ImageID(img),x,y)
      EndIf
    Next
    DrawingMode(#PB_2DDrawing_Outlined)
    Box(Mod(wec_bankimageid,b)*(s+1),(wec_bankimageid/b)*(s+1),s,s, RGBA(255,0,0,255))
    
    StopDrawing()
  EndIf
  

EndProcedure
Procedure WEC_eventBankCanvas()
  Shared wec_bankimageid, wec_sizebankimage, wec_nbcase_bankimg
  Static clic
  s = wec_sizebankimage
  b = wec_nbcase_bankimg
  
  gad = #G_win_EditCase_Bankcanvas
  If EventType() = #PB_EventType_LeftButtonDown
   x = Round(GetGadgetAttribute(gad, #PB_Canvas_MouseX) /(s+1), #PB_Round_Down)
   y = Round(GetGadgetAttribute(gad, #PB_Canvas_MouseY) /(s+1), #PB_Round_Down)
   wec_bankimageid = x + y * wec_nbcase_bankimg
   WEC_updateBankCanvas()
  ElseIf EventType() = #PB_EventType_MouseMove
  EndIf
  
EndProcedure
Procedure WEC_updateBankImage()
  Shared wec_bankimage(), wec_NbImage,wec_bankimageid
  ResetStructure(wec_bankimage(),sImg)
  ReDim wec_bankimage(0)
  wec_NbImage =-1
  pos = GetGadgetState(#G_win_EditCase_BankFolder)
  folder$ = BDCOptions\PathImage$+GetGadgetItemText(#G_win_EditCase_BankFolder, pos)+"\"
  ; Debug folder$
  Gadget_AddItems(#G_win_EditCase_BankSubFolder,"",0,folder$,"*.*",#PB_DirectoryEntry_File) 
  wec_bankimageid = 0
EndProcedure
Procedure Window_EditCase()
  
  Shared wec_vx, wec_vy, wec_zoom
  Shared wec_bankimage(), wec_NbImage, wec_bankimageid
  ; wec_vx = window edit case view X
  ; wec_vy = window edit case view Y
  ; wec_zoom = window edit case view zoom (ScaleCoordinates()
  
  ; define variable by default
  wec_NbImage =-1
  wec_vx = 100
  wec_vy = 50
  wec_zoom = 40
  wec_bankimageid = 0
  
  winw = WindowWidth(#BDC_Win_Main) - 100
  winH = 600 ; WindowHeight(#BDC_Win_Main)
  If OpenWindow(#BDC_Win_EditCase, 0, 0, winW, winH, Lang("Edit case"), #PB_Window_SystemMenu | #PB_Window_ScreenCentered|#PB_Window_SizeGadget, 
                WindowID(#BDC_Win_Main))
    ; set the window properties
    c= 150
    SetWindowColor(#BDC_Win_EditCase, RGB(c,c,c))
    WindowBounds(#BDC_Win_EditCase,400,500, WinW,winH+100)
    
    ;{ menu
    
    CreateMenu(#BDC_Menu_Wec, WindowID(#BDC_Win_EditCase))
    MenuTitle(lang("Edit"))
    MenuItem(#BDC_Menu_WEC_ObjectDelete, lang("Delete")+Chr(9)+"Del")
;     MenuBar()
;     MenuItem(#BDC_Menu_WEC_ObjectCopy, lang("Copy"))
;     MenuItem(#BDC_Menu_WEC_ObjectPaste, lang("Paste"))
    
    WEC_UpdateShortcut()
    ;}
    
    ;{ add gadgets
    x=5 : y=5 : wp=250 : h=200 : h1=30 : w1=wp-110 : h0=winh-y*2-10 : a=2
    If PanelGadget(#G_win_EditCase_Panel,x,y,wp,h0)
      wp-10
      
      ;{ tab "bank"
      AddGadgetItem(#G_win_EditCase_Panel,-1,lang("Bank"))
      ;{ gadgets for bank tab
      AddGadget(#G_win_EditCase_BankFolder, #Gad_Cbbox,x,y,w1,h1,"",0,0,lang("Set the folder for image")) : y+h1+a
      Gadget_AddItems(#G_win_EditCase_BankFolder,"",0, BDCOptions\PathImage$) 
      AddGadget(#G_win_EditCase_BankSubFolder, #Gad_Cbbox,x,y,w1,h1,"",0,0,lang("Set the folder for image")) : x+W1+5
      WEC_updatebankimage()
      AddGadget(#G_win_EditCase_BankAdd, #Gad_Btn,x,y,h1,h1,Lang("+"),0,0,lang("add the selected image on the case")) : y+h1+5
      
      x= 5
      ; add options gagdets for each image : scale, alpha, x, y 
      AddGadget(#G_win_EditCase_BankScale, #Gad_spin,x,y,w1,h1,"",0,10000,lang("Define the default scale of the image"),
                BDCOptions\CaseBankScale,lang("Scale")) : y+h1+a

      x=5
      If ScrollAreaGadget(#G_win_EditCase_BankSA,x,y,wp,h0,wp-25,h0+200)
        If CanvasGadget(#G_win_EditCase_Bankcanvas,0,0,wp-30,h0)
          WEC_updateBankCanvas()
        EndIf
        CloseGadgetList()
      EndIf
      ;}
      ;}
      
      ;{ tab options (not used)
;       AddGadgetItem(#G_win_EditCase_Panel,-1,lang("Options"))
;       x=5 : y=5
;       ; options for default image or text creation (ex : scale, alpha, x,y ...)
      ;}
      
      ;{ tab "case"
      AddGadgetItem(#G_win_EditCase_Panel,-1,lang("Case"))
      x=5 : y=5
      If ScrollAreaGadget(#PB_Any,x,y,wp,h0,wp-25,h0+250)
        cont = ContainerGadget(#PB_Any,0,0,wp,h0+1200)
        If cont>0
          c= 200
          SetGadgetColor(cont, #PB_Gadget_BackColor, RGB(c,c,c))
          x=2 : y=2
          AddGadget(#G_win_EditCase_ImageList, #Gad_ListV,x,y,wp-35,h,"",0,0,lang("Select the image to modofy")) : y+h+10
          ;AddGadget(#G_win_EditCase_ObjetType, #Gad_Cbbox,x,y,w1,h1,Lang("Type"),0,0,lang("Set the type for object"),0,lang("Type")) : y+h1+5
          ;Gadget_AddItems(#G_win_EditCase_ObjetType,"Image,Text,") 
          
          AddGadget(#G_win_EditCase_BtnTextAdd, #Gad_Btn,x,y,w1,h1,Lang("Add"),0,0,lang("add a text on the case"),0,lang("Text")) : y+h1+a
          AddGadget(#G_win_EditCase_BtnTextSet, #Gad_Btn,x,y,w1,h1,Lang("Set"),0,0,lang("add a text on the case"),0,lang("Text")) : y+h1+5
          AddGadget(#G_win_EditCase_BtnTextTyp, #Gad_Cbbox,x,y,w1,h1,"",0,0,lang("Set the type  text on the Case"),0,lang("Type")) : y+h1+5
          Gadget_AddItems(#G_win_EditCase_BtnTextTyp,"Ellipse,Rectangle,") 

          AddGadget(#G_win_EditCase_BtnImageAdd, #Gad_Btn,x,y,w1,h1,LAng("Add"),0,0,lang("add an image on the case"),0,lang("Image")) : y+h1+a
          AddGadget(#G_win_EditCase_BtnImageDel, #Gad_Btn,x,y,w1,h1,LAng("Del"),0,0,lang("Delete the selected image from the case"),0,lang("Image")) : y+h1+5
          
          AddGadget(#G_win_EditCase_ImageDepth, #Gad_spin,x,y,w1,h1,"",0,10000,lang("Change the depth poition of the image"),0,lang("Depth")) : y+h1+a
          AddGadget(#G_win_EditCase_ImageScale, #Gad_spin,x,y,w1,h1,"",0,10000,lang("Change the Scale poition of the image"),0,lang("Scale")) : y+h1+a
          AddGadget(#G_win_EditCase_ImageMiror, #Gad_Chkbox,x,y,w1,h1,LAng("Miror"),0,0,lang("Change the miror of the image"),0,lang("Miror")) : y+h1+a
          AddGadget(#G_win_EditCase_ImageRotation, #Gad_spin,x,y,w1,h1,LAng("Rot"),-360,360,lang("Change the rotation of the image"),0,lang("Rot")) : y+h1+a
          AddGadget(#G_win_EditCase_ImageHide, #Gad_Chkbox,x,y,w1,h1,LAng("Hide"),0,0,lang("Hide/show the image"),0,lang("Hide")) : y+h1+5
          
          AddGadget(#G_win_EditCase_ImageBrightness, #Gad_spin,x,y,w1,h1,LAng("Brightness"),0,200,lang("Brightness of the image"),0,lang("Brightness")) : y+h1+a
          AddGadget(#G_win_EditCase_ImageContrast, #Gad_spin,x,y,w1,h1,LAng("Contrast"),0,255,lang("Contrast of the image"),0,lang("Contrast")) : y+h1+a
          
          AddGadget(#G_win_EditCase_ImageX, #Gad_spin,x,y,w1,h1,LAng("X"),-100000,100000,lang("Change the X position of the image"),0,lang("X")) : y+h1+a
          AddGadget(#G_win_EditCase_ImageY, #Gad_spin,x,y,w1,h1,LAng("Y"),-100000,100000,lang("Change the Y position of the image"),0,lang("Y")) : y+h1+a
          AddGadget(#G_win_EditCase_ImageW, #Gad_spin,x,y,w1,h1,LAng("Width"),1,100000,lang("Change the width of the image"),0,lang("w")) : y+h1+a
          AddGadget(#G_win_EditCase_ImageH, #Gad_spin,x,y,w1,h1,LAng("Height"),1,100000,lang("Change the height of the image"),0,lang("H")) : y+h1+a
          AddGadget(#G_win_EditCase_ImageAlpha, #Gad_spin,x,y,w1,h1,"",0,255,lang("Change the opacity of the image"),0,lang("Alpha")) : y+h1+a
          CloseGadgetList()
        EndIf
        CloseGadgetList()
      EndIf
      ;}
      
      
      CloseGadgetList()
    EndIf
  
    ; add the canvas for the window edit case, to see the case with image, text...
    w = winw -wp-15 -50
    x=15+wp+5 : y=5
    If CanvasGadget(#G_win_EditCase_Canvas,x,y,w,h0,#PB_Canvas_Keyboard)
    EndIf
    ; upsate canvas and gagdets
    Window_EditCase_UpdateList()
    
    UpdateCanvas_WinEditCase()
    Window_EditCase_SetGadgetState()
    ;}
    
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
  BDC_LoadOptions()
  
  ;{ statusbar
  If CreateStatusBar(#BDC_StatusbarMain,WindowID(#BDC_Win_Main))
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
  AddKeyboardShortcut(#BDC_Win_Main,#PB_Shortcut_Control | #PB_Shortcut_S, #BDC_Menu_SaveDoc)
  AddKeyboardShortcut(#BDC_Win_Main,#PB_Shortcut_Control | #PB_Shortcut_O, #BDC_Menu_OpenDoc)
  AddKeyboardShortcut(#BDC_Win_Main,#PB_Shortcut_Control | #PB_Shortcut_N, #BDC_Menu_NewDoc)
  
  CreateTheGadgets()
  
;   font$ = GetCurrentDirectory()+"data\VTCLettererProRegular.ttf"
;   font$ = GetCurrentDirectory()+"data\KOMIKAH_.ttf"
;   font0$ =  "VTC Letterer Pro"
;   font0$ = "komika hand"
;   ;Debug font$
;   If FileSize(font$)>0  And RegisterFontFile(font$)>0
;     ;Debug "ok register"
;     If LoadFont(0, font0$, 50)
;       ;Debug "ok font ok"
;     Else
;       If LoadFont(0, "komika hand", 50) : EndIf
;     EndIf
;   Else
;     If LoadFont(0, "komika hand", 50) : EndIf
;   EndIf

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
            
          Case #BDC_Win_Main ; main
            Select EventGadget
              
              Case #G_win_Story_ImageAdd
                Window_EditCase() 
                
              Case #G_win_Story_Editmode
                vd\EditMode = GetGadgetState(#G_win_Story_Editmode)
                
              Case #G_win_Story_CaseStrokeSet, #G_win_Story_CaseStrokeAlpha, #G_win_Story_CaseStrokeSize
                With Project\page(pageID)\Line(lineId)\caze(CaseId)
                 \StrokeSet = GetGadgetState(#G_win_Story_CaseStrokeSet)
                 \StrokeAlpha = GetGadgetState(#G_win_Story_CaseStrokeAlpha)
                 \StrokeSize = GetGadgetState(#G_win_Story_CaseStrokeSize)
                EndWith
                UpdateCanvasMain()
                
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
                Page_update(1,1,1)
                UpdateCanvasMain()
                
              Case #G_win_Story_NbLine
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
                If s >=0 And s<=100
                  project\StrokeSize = s
                  ok=1
                EndIf
                If ok
                  UpdateCanvasMain()
                EndIf
                ;}
                
            EndSelect
            
          Case #BDC_Win_EditBubble
            If Project\page(pageid)\Line(LineId)\caze(CaseID)\nbImage>=0
              With Project\page(pageid)\Line(LineId)\caze(CaseID)\image(ImageID)
                Select EventGadget
                  Case #G_win_EditBuble_TextSize,#G_win_EditBuble_TextY, #G_win_EditBuble_TextX, #G_win_EditBuble_TextString,#G_win_EditBuble_TextWidth,#G_win_EditBuble_BubleArrowPosition
                    \fontSize = GetGadgetState(#G_win_EditBuble_TextSize)
                    \fontText$ = GetGadgetText(#G_win_EditBuble_TextString)
                    \fontWidth = GetGadgetState(#G_win_EditBuble_TextWidth)
                    \TextX = GetGadgetState(#G_win_EditBuble_TextX)
                    \TextY = GetGadgetState(#G_win_EditBuble_TextY)
                    \BubleArrowTyp = GetGadgetState(#G_win_EditBuble_BubleArrowPosition)
                    Case_SetText(\fontText$, 0, 0)
                    
                  Case #G_win_EditBuble_TextChooseFont
                    Case_SetTextFont(1)
                    Case_SetText(\fontText$, 0, 0)
                    
                  Case #G_win_EditBuble_BtnOk
                    Case_SetText(\fontText$, 0, 0)
                    
                EndSelect
              EndWith
            EndIf
          
          Case #BDC_Win_EditCase
            Select EventGadget
                ;{ bank 
              Case #G_win_EditCase_BankScale
                BDCOptions\CaseBankScale = GetGadgetState(#G_win_EditCase_BankScale)
                
              Case #G_win_EditCase_BankAdd
                Case_AddObject(0,1)
                
              Case #G_win_EditCase_BankFolder
                WEC_updateBankImage()
                WEC_updateBankCanvas()

              Case #G_win_EditCase_Bankcanvas
                WEC_eventBankCanvas()
                ;}
                
              Case #G_win_EditCase_BtnTextSet
                ; Debug Project\page(pageid)\Line(LineId)\caze(CaseID)\image(ImageID)\fontText$
                
                If Project\page(pageid)\Line(LineId)\caze(CaseID)\nbImage>=0
                  If imageID >-1
                    ; text$ = InputRequester(lang("text"), lang("Add a text"),Project\page(pageid)\Line(LineId)\caze(CaseID)\image(ImageID)\fontText$)
                    If Project\page(pageid)\Line(LineId)\caze(CaseID)\image(imageID)\typ =  #CaseTyp_Text
                      Window_EditBubble()
                      ; Case_SetText(text$, 1)
                    Else
                      ; change the image
                      Case_AddObject(#CaseTyp_Img, 2)
                    EndIf
                  EndIf
                Else
                  Case_AddObject(1)
                EndIf
                   
              Case #G_win_EditCase_Canvas
                Event_WinEditcaseCanvas()
                
              Case #G_win_EditCase_ImageList
                imageId = GetGadgetState(#G_win_EditCase_ImageList)
                Window_EditCase_SetGadgetState()
                
              Case #G_win_EditCase_BtnTextAdd
                Case_AddObject(1)
                
              Case #G_win_EditCase_ImageMiror
                Update_WinEdit_ImageProperties(#propertie_Miror, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageRotation
                Update_WinEdit_ImageProperties(#propertie_Rotation, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageBrightness
                Update_WinEdit_ImageProperties(#propertie_Brightness, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageContrast
                Update_WinEdit_ImageProperties(#propertie_Contrast, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageColor
                Update_WinEdit_ImageProperties(#Propertie_Color, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageX
                Update_WinEdit_ImageProperties(#propertie_X, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageY
                Update_WinEdit_ImageProperties(#Propertie_Y, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageW
                Update_WinEdit_ImageProperties(#Propertie_W, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageH
                Update_WinEdit_ImageProperties(#Propertie_H, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageAlpha
                Update_WinEdit_ImageProperties(#Propertie_Alpha, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageDepth
                Update_WinEdit_ImageProperties(#Propertie_Depth, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageScale
                Update_WinEdit_ImageProperties(#Propertie_Scale, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_ImageHide
                Update_WinEdit_ImageProperties(#Propertie_Hide, GetGadgetState(EventGadget))
                
              Case #G_win_EditCase_BtnImageDel
                Case_AddObject(2)
                
              Case #G_win_EditCase_BtnImageAdd
                Case_AddObject()
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
                      ; add pages
                      For i=0 To nb-1
                        Page_Add()
                      Next
                      ClearGadgetItems(#G_win_Story_PageSelect)
                      For i=0 To ArraySize(project\page())
                        AddGadgetItem(#G_win_Story_PageSelect, i, lang("Page")+Str(i+1))
                      Next
                      SetGadgetState(#G_win_Story_PageSelect, 0)
                      pageId = 0
                      Page_update(1,1,1)
                    Else
                      
                    EndIf
                  Else
                  EndIf
                EndIf
                
                
            EndSelect
            
        EndSelect
        
      Case #PB_Event_Menu
        
        Select EventWindow()
          Case #BDC_Win_Main
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
            
          Case #BDC_Win_EditCase
            Select eventmenu
              Case #BDC_Menu_WEC_ObjectDelete
                If GetActiveGadget() = #G_win_EditCase_Canvas And imageiD >-1 And imageid<=ArraySize(Project\page(pageid)\Line(LineId)\caze(CaseID)\image())
                   Case_AddObject(2)
                EndIf
                
            EndSelect
        EndSelect
    
      Case #PB_Event_CloseWindow
        If GetActiveWindow() = #BDC_Win_Main
          quit = 1
        Else
          If EventWindow() = #BDC_Win_EditCase
            UpdateMaincanvas_withimage()
          EndIf
          CloseWindow(GetActiveWindow() )
        EndIf
        
    EndSelect
    
  Until Quit >= 1
  
EndIf

;}


; IDE Options = PureBasic 5.73 LTS (Windows - x86)
; CursorPosition = 113
; FirstLine = 22
; Folding = BuBKAAAV-8gBA988LAAAAAAeTIY+-A+-PAAQAgAAAgAAYc+CQd0v9Debsb-BAAAx-AuB+bAgv3sjDHAAoDo--
; EnableXP
; Executable = _release\bdcreator.exe
; DisableDebugger
; Warnings = Display
; EnablePurifier