#include "Dbstruct.ch"
#include "videoclub.ch"

Function Main
	LOCAL nRet:=0
	LOCAL nIndInicial:=1
	
	PUBLIC aIndices:={1,2,3,4,5,6,7}
	PUBLIC aValInd:={}
	
	PRIVATE cDbPelic:="pelic"
	
	If !File(cDbPelic+".dbf")
		CrearDB()
		
	Endif
	
	AbreDB(cDbPelic,aIndices)
	
	If PonerIndice(nIndInicial)
		DbGoTop()
		DbSeek("Yepa")
	
		If(Eof(),Alert("No encontrado"),Alert("Encontrado en la posici"+_oTilde+"n "+AllTrim(Str(RecNo()))))
	Else
		Alert("No se pudo poner el "+_iTilde+"ndice "+AllTrim(Str(nIndInicial)))
	Endif
	
	Sleep(300)
	
Return nRet



Procedure CrearDB()
	LOCAL aEstruct:={{},{},{},{},{},{},{}}
	
	AddEstruct(aEstruct[1],"TITULO","C",20,0)
	AddEstruct(aEstruct[2],"GENERO","C",20,0)
	AddEstruct(aEstruct[3],"ADULTOS","L",1,0)
	AddEstruct(aEstruct[4],"DIRECTOR","C",15,0)
	AddEstruct(aEstruct[5],"PRECIO","N",3,2)
	AddEstruct(aEstruct[6],"EXIST","N",2,0)
	AddEstruct(aEstruct[7],"DISP","N",2,0)
	
	DbCreate(m->cDbPelic,aEstruct,"DBFNTX")
	//DbUseArea(true,,,"pelic.dbf",false)
	USE (m->cDbPelic)
	
	OrdCreate(m->cDbPelic+"1",,"TITULO")
	OrdCreate(m->cDbPelic+"2",,"GENERO")
	OrdCreate(m->cDbPelic+"",,"ADULTOS")
	OrdCreate(m->cDbPelic+"",,"DIRECTOR")
	OrdCreate(m->cDbPelic+"5",,"PRECIO")
	OrdCreate(m->cDbPelic+"6",,"EXIST")
	OrdCreate(m->cDbPelic+"7",,"DISP")
	
	DbCloseArea() 
Return



Procedure AddEstruct(aArray,cNombre,cTipo,nLong,nDec)
	AAdd(aArray,cNombre)
	AAdd(aArray,cTipo)
	AAdd(aArray,nLong)
	AAdd(aArray,nDec)
Return



Function AbreDB(cDBNom)
	LOCAL lRet:=true
	LOCAL cListaIndices:=""
	LOCAL i
	
	For i:=1 To Len(aIndices)
		If File(cDBNom+AllTrim(Str(aIndices[i]))+".ntx")
			AAdd(aValInd,cDBNom+AllTrim(Str(aIndices[i])))
			cListaIndices+=cDBNom+AllTrim(Str(aIndices[i]))+".ntx,"
		Else 
			AAdd(aValInd,NIL)
		Endif
	Next
	
	cListaIndices:=SubStr(cListaIndices,0,Len(cListaIndices)-1)
	
	USE (cDBNom) SHARED
	
Return lRet



Function PonerIndice(nInd)
	LOCAL lRet:=false
	
	If nInd<=Len(aValInd).and.aValInd[nInd]!=NIL
		DbSetIndex(m->cDbPelic+AllTrim(Str(nInd)))
		lRet:=true
	Endif
Return lRet
