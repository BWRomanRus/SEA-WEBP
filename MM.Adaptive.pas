unit MM.Adaptive;



interface

type
  HMEMORYMODULE = Pointer;

function MemoryLoadLibrary(Data: Pointer; Size: NativeUInt): HMEMORYMODULE;
function MemoryGetProcAddress(Lib: HMEMORYMODULE; Name: PAnsiChar): Pointer;
procedure MemoryFreeLibrary(Lib: HMEMORYMODULE);

implementation

{$IFDEF USE_BTMM}
  // ===== ВЕТКА: BTMemoryModule (Win32) =====
uses
  BTMemoryModule;

function MemoryLoadLibrary(Data: Pointer; Size: NativeUInt): HMEMORYMODULE;
begin
  // В BTMemoryModule размер обязателен
  Result := BTMemoryLoadLibary(Data, Size);
end;

function MemoryGetProcAddress(Lib: HMEMORYMODULE; Name: PAnsiChar): Pointer;
begin
  Result := BTMemoryGetProcAddress(Lib, Name);
end;

procedure MemoryFreeLibrary(Lib: HMEMORYMODULE);
begin
  BTMemoryFreeLibrary(Lib);
end;

{$ELSE}
  // ===== ВЕТКА: Delphi_MemoryModule (Fr0sT-Brutal, x86/x64) =====
uses
  MemoryModule;

function MemoryLoadLibrary(Data: Pointer; Size: NativeUInt): HMEMORYMODULE;
begin
  { У разных версий порта встречаются 2 варианта API:
      1) function MemoryLoadLibrary(Data: Pointer; Size: NativeUInt): HMEMORYMODULE;
      2) function MemoryLoadLibary (Data: Pointer): HMEMORYMODULE; // с опечаткой в названии
    Ниже — адаптация через DECLARED. }
  {$IF DECLARED(MemoryModule.MemoryLoadLibrary)}
    Result := MemoryModule.MemoryLoadLibrary(Data, Size);
  {$ELSEIF DECLARED(MemoryModule.MemoryLoadLibary)}
    Result := MemoryModule.MemoryLoadLibary(Data);
  {$ELSE}
    {$MESSAGE ERROR 'MemoryModule: не найден MemoryLoadLibrary/MemoryLoadLibary'}
    Result := nil;
  {$IFEND}
end;

function MemoryGetProcAddress(Lib: HMEMORYMODULE; Name: PAnsiChar): Pointer;
begin
  {$IF DECLARED(MemoryModule.MemoryGetProcAddress)}
    Result := MemoryModule.MemoryGetProcAddress(Lib, Name);
  {$ELSEIF DECLARED(MemoryModule.GetProcAddressMemory)}
    Result := MemoryModule.GetProcAddressMemory(Lib, Name);
  {$ELSE}
    {$MESSAGE ERROR 'MemoryModule: не найден MemoryGetProcAddress/GetProcAddressMemory'}
    Result := nil;
  {$IFEND}
end;

procedure MemoryFreeLibrary(Lib: HMEMORYMODULE);
begin
  {$IF DECLARED(MemoryModule.MemoryFreeLibrary)}
    MemoryModule.MemoryFreeLibrary(Lib);
  {$ELSEIF DECLARED(MemoryModule.FreeLibraryMemory)}
    MemoryModule.FreeLibraryMemory(Lib);
  {$ELSE}
    {$MESSAGE ERROR 'MemoryModule: не найден MemoryFreeLibrary/FreeLibraryMemory'}
  {$IFEND}
end;

{$ENDIF} // USE_BTMM

end.

