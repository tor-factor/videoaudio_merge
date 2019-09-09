@echo off
Title VIDEO AND AUDIO MERGE
cd Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\
:folder_verif
IF EXIST "0_Input" (
echo Inputs folder : check
) ELSE (
md "0_Input"
echo Inputs folder was missing. Inputs folder created
echo please add your Inputs in the 0_Input Folder
pause
exit
)
IF EXIST "1_Projects" (
echo Projects folder : check
) ELSE (
md "1_Projects"
echo Projects folder was missing. Projects folder created
)
IF EXIST "zz_wf" (
echo Working folder : check
) ELSE (
md "zz_wf"
echo Working folder was missing. Working folder created
)
cd Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf\
IF EXIST "*.*" (
del /q /f "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf"
echo Cleaning working folder
) ELSE (
echo Working folder clean
)
:script
set /p projectname="Nom du projet ?  "
cd Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\
IF EXIST "%projectname%" (
goto:rendfold
) ELSE (
md "%projectname%"
)
:rendfold
cd Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\
IF EXIST "renders" (
goto :sources
) ELSE ( 
md "renders"
)
:sources
IF EXIST "sources" (
goto :countrenders
) ELSE (
md "sources"
)
:countrenders
for /f %%a in ('2^>nul dir "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\" /a-d/b/-o/-p/s^|find /v /c ""') do set g=%%a
set /a "n=%g%+1"
:copy
cd Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\0_Input
xcopy /s /q /y "*.*" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\sources"
xcopy /s /q /y "*.*" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf\"
del /q /f "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\0_Input"
cd Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf\
ren *.mp4 "video.mp4"
setlocal enabledelayedexpansion
SET /A COUNT=0
FOR %%A IN (*.wav) DO (
  SET /A COUNT+=1
  REN "%%A" "son_!COUNT!.wav"
)
IF /I "!count!" EQU "1" goto :one_audio
IF /I "!count!" EQU "2" goto :two_audio
IF /I "!count!" EQU "3" goto :three_audio
IF /I "!count!" EQU "4" goto :four_audio
IF /I "!count!" EQU "5" goto :five_audio
IF /I "!count!" EQU "6" goto :six_audio
IF /I "!count!" GEQ "7" goto :error
:one_audio
ffmpeg -i video.mp4 -i son_1.wav -c:v libx264 -crf 20 -map 0:v -map 1:a "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\%projectname%_EXPORT%n%.mp4"
start "et voila copain" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\"
del /q /f "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf"
echo SUCCESS
SLEEP 3
exit
:two_audio
ffmpeg -i video.mp4 -i son_1.wav -i son_2.wav -filter_complex "[1:a][2:a]amerge=inputs=2,pan=stereo|c0<c0+c2|c1<c1+c3[aout]" -c:v libx264 -crf 20 -map 0:v -map "[aout]" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\%projectname%_EXPORT%n%.mp4"
start "et voila copain" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\"
del /q /f "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf"
ECHO SUCCESS
SLEEP 3
exit
:three_audio
ffmpeg -i video.mp4 -i son_1.wav -i son_2.wav -i son_3.wav -filter_complex "[1:a][2:a][3:a]amerge=inputs=3,pan=stereo|c0<c0+c2+c4|c1<c1+c3+c5[aout]" -c:v libx264 -crf 20 -map 0:v -map "[aout]" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\%projectname%_EXPORT%n%.mp4"
start "et voila copain" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\"
del /q /f "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf"
ECHO SUCCES
SLEEP 3
exit
:four_audio
ffmpeg -i video.mp4 -i son_1.wav -i son_2.wav -i son_3.wav -i son_4.wav -filter_complex "[1:a][2:a][3:a][4:a]amerge=inputs=4,pan=stereo|c0<c0+c2+c4+c6|c1<c1+c3+c5+c7[aout]" -c:v libx264 -crf 20 -map 0:v -map "[aout]" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\%projectname%_EXPORT%n%.mp4"
start "et voila copain" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\"
del /q /f "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf"
ECHO SUCCES
SLEEP 3
exit
:five_audio
ffmpeg -i video.mp4 -i son_1.wav -i son_2.wav -i son_3.wav -i son_4.wav -i son_5.wav -filter_complex "[1:a][2:a][3:a][4:a][5:a]amerge=inputs=5,pan=stereo|c0<c0+c2+c4+c6+c8|c1<c1+c3+c5+c7+c9[aout]" -c:v libx264 -crf 20 -map 0:v -map "[aout]" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\%projectname%_EXPORT%n%.mp4"
start "et voila copain" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\"
del /q /f "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf"
ECHO SUCCES
SLEEP 3
exit
:six_audio
ffmpeg -i video.mp4 -i son_1.wav -i son_2.wav -i son_3.wav -i son_4.wav -i son_5.wav -filter_complex "[1:a][2:a][3:a][4:a][5:a][6:a]amerge=inputs=6,pan=stereo|c0<c0+c2+c4+c6+c8+c10|c1<c1+c3+c5+c7+c9+c11[aout]" -c:v libx264 -crf 20 -map 0:v -map "[aout]" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\%projectname%_EXPORT%n%.mp4"
start "et voila copain" "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\1_Projects\%projectname%\renders\"
del /q /f "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf"
ECHO SUCCES
SLEEP 3
exit
:error
echo Sorry, unable to encode more than six audio files.
del /q /f "Z:\3. Exchange\0_CAMILLE\00_TU_ME_FAIS_UN_EXPORT\zz_wf"
pause
exit
