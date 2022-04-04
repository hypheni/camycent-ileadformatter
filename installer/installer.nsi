; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "iLFormater"
!define PRODUCT_VERSION "1.2"
!define PRODUCT_PUBLISHER "Camycent Technologies"
!define PRODUCT_WEB_SITE "ilead.camycent.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\iLFormater.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "img-wizard-top.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "img-wizard-side.bmp"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "license.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\iLFormater.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME}"
OutFile ".\iLFormater-setup.exe"
InstallDir "$PROGRAMFILES\iLFormater"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show
CRCCheck on
BrandingText "Camycent Technologies"

Section "MainSection" SEC01
	SetOverwrite on
  
	;;vc++ redist install
	ReserveFile ".\vcredist_x86.exe"
	SetOutPath "$TEMP"
	File ".\vcredist_x86.exe"
	Sleep 1000
	ExecWait '"$TEMP\vcredist_x86.exe" /q'
	;;vc++ redist install
  
	SetOutPath "$INSTDIR"
	File "..\bin\release\mysqlcppconn.dll"
	File "..\bin\release\libmysql.dll"
	File "..\bin\release\iLFormater.exe"
	File "..\bin\release\iLUpdater.exe"
	CreateDirectory "$SMPROGRAMS\iLFormater"
	CreateShortCut "$SMPROGRAMS\iLFormater\iLFormater.lnk" "$INSTDIR\iLFormater.exe"
	CreateShortCut "$DESKTOP\iLFormater.lnk" "$INSTDIR\iLFormater.exe"
	
	WriteRegStr HKCU "Software\iLFormater" "AutoUpdate" "FALSE"
	WriteRegStr HKCU "Software\iLFormater" "UpdateStatus" "0"
	
	Delete "$TEMP\vcredist_x86.exe"
  
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\iLFormater\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\iLFormater.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\iLFormater.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr HKCU "Software\iLFormater" "apppath" "$INSTDIR"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\mysqlcppconn.dll"
  Delete "$INSTDIR\iLFormater.exe"
  Delete "$INSTDIR\libmysql.dll"

  Delete "$SMPROGRAMS\iLFormater\Uninstall.lnk"
  Delete "$DESKTOP\iLFormater.lnk"
  Delete "$SMPROGRAMS\iLFormater\iLFormater.lnk"

  RMDir "$SMPROGRAMS\iLFormater"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd