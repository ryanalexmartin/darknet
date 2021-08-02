:: This batch file is for automatically generating standard config files, 
:: hopefully taking some of the repetitiveness out of using YOLO

:: First, create a folder in the root of the repository for your dataset.  
:: All your custom files (including configs) will go in there. This will 
:: keep the repository cleaner and keep your data separate from the rest 
:: of the repository's mess.

:: For this, I'm calling the top-level folder ".\_custom"  (underscore to help it stand out)
:: In that, create a folder for your dataset:  ".\_custom\albion-online"
:: Now, in that folder, create subfolders "test" and "train" and create a file called "obj.names" 
:: which will contain class definitions.
:: Now, make sure your training data (images and labels) are in test and training, respectively.
:: Now, create a `backup` folder within _custom\albion-online

:: TODO var for dataset folder's name so we don't have to hardcode it.

:: Change directory to project root
cd .. 
cd ..
cd .\_custom\albion-online

cd test
del test.txt
for %%f in (*.png) do echo %cd%\%%f>> test.txt
cd ..

cd training
del training.txt
for %%f in (*.png) do echo %cd%\%%f>> training.txt
cd ..


:: Create your-dataset.data file
del albion-online.data

@echo off
cls
setlocal EnableDelayedExpansion
set "cmd=findstr /R /N "^^" obj.names | find /C ":""

for /f %%a in ('!cmd!') do set classes=%%a
echo classes = %classes% >> albion-online.data


echo train = _custom/albion-online/training/training.txt >> albion-online.data
echo valid = _custom/albion-online/test/test.txt >> albion-online.data
echo names = _custom/albion-online/obj.names >> albion-online.data
echo backup = _custom/albion-online/backup >> albion-online.data


:: TODO create .cfg file with neural network specification.
:: This will have to be done with a template file.  It can be found in .\_custom\albion-online-yolov4.cfg

:: copy example-template.cfg into albion-online folder as albion-online-yolov4.cfg
XCOPY example-template.cfg albion-online-yolov4.cfg 

:: Replace {MAX_BATCHES} with:  classes * 2000
set /a max_batches = %classes% * 2000
powershell -Command "(gc albion-online-yolov4.cfg) -replace '{MAX_BATCHES}', '%max_batches%' | Out-File -encoding ASCII albion-online-yolov4.cfg"

:: TODO replace {STEPS} WITH:  max_batches * 0.7, max_batches * 0.8
set /a steps_low = %max_batches% * 70/100
set /a steps_high = %max_batches% * 80/100
powershell -Command "(gc albion-online-yolov4.cfg) -replace '{STEPS_LOW}', '%steps_low%' | Out-File -encoding ASCII albion-online-yolov4.cfg"
powershell -Command "(gc albion-online-yolov4.cfg) -replace '{STEPS_HIGH}', '%steps_high%' | Out-File -encoding ASCII albion-online-yolov4.cfg"

:: TODO Replace {CLASSES} with # of classes from above.  Do this for all 3 YOLO layers
powershell -Command "(gc albion-online-yolov4.cfg) -replace '{CLASSES}', '%classes%' | Out-File -encoding ASCII albion-online-yolov4.cfg"

:: TODO change {FILTERS} to filters=(classes + 5)x3
set /a filters = (%classes% + 5) * 3
powershell -Command "(gc albion-online-yolov4.cfg) -replace '{FILTERS}', '%filters%' | Out-File -encoding ASCII albion-online-yolov4.cfg"

