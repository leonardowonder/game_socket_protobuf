@echo off

cd PBMessage

echo --delete all files in bin\Release\ [ɾ���ɵ������ļ�]
del /q bin\Release\*

echo --delete all files in obj\Release\ [ɾ���ɵ������ļ�]
del /q obj\Release\*

echo --gen proto message to PBMessage.cs [���ɽ�������,ȫ���ŵ�һ��csԴ����]
cd ..\gen
call __genbat.bat

echo --compile PBMessage.cs [����Դ�� ����DLL]
cd ..\PBMessage
C:\Windows\Microsoft.NET\Framework\v4.0.30319\Csc.exe /noconfig /nowarn:1701,1702 /nostdlib+ /errorreport:prompt /warn:4 /define:TRACE /reference:C:\Windows\Microsoft.NET\Framework\v2.0.50727\mscorlib.dll /reference:protobuf-net.dll /reference:C:\Windows\Microsoft.NET\Framework\v2.0.50727\System.dll /debug:pdbonly /filealign:512 /optimize+ /out:obj\Release\PBMessage.dll /target:library /utf8output PBMessage.cs Properties\AssemblyInfo.cs

echo --output to bin\Release\ [����DLL���·��]
copy obj\Release\PBMessage.dll bin\Release\PBMessage.dll
copy obj\Release\PBMessage.pdb bin\Release\PBMessage.pdb
copy protobuf-net.dll bin\Release\protobuf-net.dll

echo --precompile PBMessage.dll [����ר�����л���DLL�ļ�]
cd bin\Release
..\..\..\protobuf-net\Precompile\precompile.exe PBMessage.dll -o:PBMessageSerializer.dll -t:PBMessageSerializer

: �����ļ���ָ���ļ���
echo --copy dlls to unity project [�����ļ���ָ���ļ���Plugins]

copy PBMessage.dll ..\..\..\..\..\UnityEnv\Assets\Plugins\PBMessage.dll
copy PBMessageSerializer.dll ..\..\..\..\..\UnityEnv\Assets\Plugins\PBMessageSerializer.dll
copy protobuf-net.dll ..\..\..\..\..\UnityEnv\Assets\Plugins\protobuf-net.dll

echo �Ѿ�����dll��Unity����PluginsĿ¼�£�
rem pause
exit