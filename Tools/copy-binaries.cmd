if exist ..\..\Release\Next rmdir /s /q ..\..\Release\Next
mkdir ..\..\Release\Next

rem Desktop example
mkdir ..\..\Release\Next\WhisperDesktop
copy ..\x64\Release\Whisper.dll ..\..\Release\Next\WhisperDesktop\
copy ..\x64\Release\WhisperDesktop.exe ..\..\Release\Next\WhisperDesktop\

rem Library
mkdir ..\..\Release\Next\Library
mkdir ..\..\Release\Next\Library\Binary
copy ..\x64\Release\Whisper.dll ..\..\Release\Next\Library\Binary\
mkdir ..\..\Release\Next\Library\Include
copy ..\Whisper\API\*.* ..\..\Release\Next\Library\Include\
mkdir ..\..\Release\Next\Library\Linker
copy ..\x64\Release\Whisper.lib ..\..\Release\Next\Library\Linker\

rem debug symbols
copy ..\x64\Release\Whisper.pdb ..\..\Release\Next\

rem C++ CLI example
mkdir ..\..\Release\Next\cli
copy ..\x64\Release\Whisper.dll ..\..\Release\Next\cli\
copy ..\x64\Release\main.exe ..\..\Release\Next\cli\

rem PowerShell module
mkdir ..\..\Release\Next\WhisperPS
copy ..\WhisperPS\bin\Release\*.dll ..\..\Release\Next\WhisperPS\
copy ..\WhisperPS\bin\Release\WhisperPS.psd1 ..\..\Release\Next\WhisperPS\
copy ..\WhisperPS\bin\Release\WhisperPS.dll.config ..\..\Release\Next\WhisperPS\
copy ..\WhisperPS\bin\Release\WhisperPS.dll-Help.xml ..\..\Release\Next\WhisperPS\

rem Zip these things, using command-line 7zip.exe with maximum level
rem https://www.7-zip.org/download.html

set ZIP="C:\Program Files\7-Zip\7z.exe" a -mmt1 -mx9 -bd
pushd ..\..\Release\Next
%ZIP% -tzip .\WhisperDesktop.zip .\WhisperDesktop\*.*
%ZIP% -tzip -r .\Library.zip .\Library\Include .\Library\Linker .\Library\Binary
%ZIP% -t7z -sdel .\Whisper.pdb.7z .\Whisper.pdb
%ZIP% -tzip .\cli.zip .\cli\*.*
%ZIP% -tzip -r .\WhisperPS.zip .\WhisperPS
popd