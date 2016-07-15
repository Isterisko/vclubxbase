CLASS _Menu
	
ENDCLASS




CLASS _DB
	EXPORTED:
	METHOD init,SetIndex,Abrir
	
	PROTECTED:
	VAR cDB,aIndices
	METHOD Seleccionar
ENDCLASS



METHOD _DB:init(cNombre,aEstruct,aInd)
	LOCAL i
	
	If(Empty(aIndices),aIndices:={},)
	::cDB:=cNombre
	
	If !File(::cDB+".dbf")
		DbCreate(::cDB,aEstruct,"DBFNTX")
		USE ::cDB
		For i:=1 To Len(aEstruct)
			OrdCreate(::cDB+AllTrim(Str(i))+".ntx",,::cDB[i][1])
			AAdd(::aIndices,::cDB+AllTrim(Str(i)+".ntx"))
		Next
		DbCloseArea()
		ASize(aEstruct,0)
	Else
		i:=1
		While File(::cDB+AllTrim(Str(i))+".ntx")
			AAdd(::aIndices,::cDB+AllTrim(Str(i)+".ntx"))
			i++
		Next
	Endif
Return self



METHOD _DB:Abrir()
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

Return self



