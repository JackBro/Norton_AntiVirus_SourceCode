# Set include paths 
  
!define NOVELLSDK C:\Novell\NDK\nwsdk
!define COMPILER_DIR C:\Progra~1\Metrowerks\CodeWarrior
!define PROJECT_DIR \AVClients\netware_client\src\scanmgr

!define SYS_INCLUDES -I- -I$(NOVELLSDK)\include\ -I$(NOVELLSDK)\include\nlm -I$(NOVELLSDK)\include\nlm\nit -I$(NOVELLSDK)\include\nlm\sys -I$(COMPILER_DIR)\Win32-~1\Headers\Win32S~1

# Set compiler and linker options

!ifdef %DEBUG
!define OUTDIR .\Debug
!define DEBUG_FLAGS -g -align 1
!define LIB_PATHS -L$(PROJECT_DIR) -Lc:\PROGRA~1\Metrow~1\CodeWa~1\Novell~1\Metrow~1\Librar~1\Runtime\
!define SCANMGR_LIBS -lmwcrtld.lib -lmwcppd.lib -lclib.imp -lthreads.imp -lnlmlib.imp -ltli.imp -lnit.imp -lrequestr.imp -lws2nlm.imp
!else
!define OUTDIR .\Release
!define LIB_PATHS -L$(PROJECT_DIR) -Lc:\PROGRA~1\Metrow~1\CodeWa~1\Novell~1\Metrow~1\Librar~1\Runtime\
!define SCANMGR_LIBS -lmwcrtl.lib -lmwcpp.lib -lclib.imp -lthreads.imp -lnlmlib.imp -ltli.imp -lnit.imp -lrequestr.imp -lws2nlm.imp
!endif

!define COMPILER_OPTS -nolink -bool on -O2 -prefix nlm_prefix.h $(DEBUG_FLAGS)

!define SCANMGR_VERSION_NUMBER "8,0,0"
!define COPYRIGHT_STRING "Copyright (C) 2001-2002 Symantec Corporation"
!define DESCRIPTION_STRING "Scan Manager NLM"
!define INITIAL_THREAD_NAME "scanmgr_Main"
!define PROJNAME scanmgr

!define INCLUDE_PATHS -I$(PROJECT_DIR) -I$(COMPILER_DIR)\Win32-~1\Headers\Win32S~1
!define LINK_FLAGS -stacksize 8192 -threadname $(INITIAL_THREAD_NAME) -osym $(PROJNAME).sym -map -sym codeview4 -sym internal -copy $(COPYRIGHT_STRING) -desc $(DESCRIPTION_STRING) -nlmversion $(SCANMGR_VERSION_NUMBER) -type generic -stdlib  -o $(OUTDIR)\$(PROJNAME).nlm


all : $(OUTDIR)\scanmgr.nlm .SYMBOLIC

$(OUTDIR)\scanmgr.o : .\scanmgr.cpp .AUTODEPEND
 if not exist $(OUTDIR) md $(OUTDIR)
 *mwccnlm.exe $(INCLUDE_PATHS) $(SYS_INCLUDES) $(COMPILER_OPTS) .\scanmgr.cpp -o $(OUTDIR)\

$(OUTDIR)\scanmgr.nlm : $(OUTDIR)\scanmgr.o .AUTODEPEND
 *mwldnlm.exe $(LINK_FLAGS) $(LIB_PATHS) $(SCANMGR_LIBS) $(OUTDIR)\*.o
 #

