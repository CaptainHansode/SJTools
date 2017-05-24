/*******************************************************
System J Tools 
********************************************************
Name:SJ_Install
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
(
-----------------------------------------------------------------------------------------------------------
-- �O���[�o������
-----------------------------------------------------------------------------------------------------------
--���[���A�E�g�p
global sj_install_rol
--Version etc
Local nameAndVersion = "SJ Tools Install"
Local prosCount= 1
Local errorMesStr = "";
-----------------------------------------------------------------------------------------------------------
-- Rollouts
-----------------------------------------------------------------------------------------------------------
try(cui.FloatDialogBar sj_install_rol)catch()
try(cui.unRegisterDialogBar sj_install_rol)catch()
try( CloseRolloutFloater sj_install_rol) catch()
try(destroydialog sj_install_rol)catch()

rollout sj_install_rol "" width:452 height:300
(
-----------------------------------------------------------------------------------------------------------
-- �t�@���N�V����
-----------------------------------------------------------------------------------------------------------
	fn installTest_fn =
	(
		return true;
	);
-----------------------------------------------------------------------------------------------------------
-- �t�@���N�V����
-----------------------------------------------------------------------------------------------------------
	fn install_fn =
	(
		local  installErrorMes = "
�f�B���N�g���𐶐��ł��܂���ł���!
�A�N�Z�X����������Ă���\��������܂�
�ڂ����͉��L��URL���Q�Ƃ��Ă�������
http://www.sakaiden.com/?p=10778

�C���X�g�[���𒆒f���܂�

Install Error!

"
			--�Ȃ�����������$�w��̃p�X�A�Ӗ��͂Ȃ�
			--�t�@�C�����폜����
			print "�폜���Ă��܂� Delete"
		
			--try(
				
				--�X�N���v�g�{��
				files = getFiles "$max\scripts\SJTools\*.*";
				for i in files do deleteFile i;
					
				files = getFiles "$max\scripts\SJTools\SJScripts\*.*";
				for i in files do deleteFile i;
					
				files = getFiles "$max\scripts\SJTools\Images\*.*";
				for i in files do deleteFile i;
				
				--�v���O�C��
				files = getFiles "$max\plugins\SJTools\*.*";
				for i in files do deleteFile i;

				--�X�^�[�g�A�b�v�v���O�C��
				files = getFiles "$max\stdplugs\stdscripts\SJTools\*.*";
				for i in files do deleteFile i;
				
				/************************************
				max2010 - 2012���A�C�R���t�@�C��
				*************************************/
				--�}�N��
				deleteFile "$ui\macroscripts\SJTools.mcr";
				--�A�C�R��
				deleteFile "$ui\Icons\SJTools_Icon_16a.bmp";
				deleteFile "$ui\Icons\SJTools_Icon_16i.bmp";
				deleteFile "$ui\Icons\SJTools_Icon_24a.bmp";
				deleteFile "$ui\Icons\SJTools_Icon_24i.bmp";
				
				/************************************
				max2013���A�C�R���t�@�C��
				*************************************/
				--�}�N��
				deleteFile ("$max\Macroscripts\SJTools.mcr");
				--�e����
				deleteFile ("$max\ja-JP\MacroScripts\SJTools.mcr.res");
				deleteFile ("$max\de-DE\MacroScripts\SJTools.mcr.res");
				deleteFile ("$max\en-US\MacroScripts\SJTools.mcr.res");
				deleteFile ("$max\fr-FR\MacroScripts\SJTools.mcr.res");
				deleteFile ("$max\ko-KR\MacroScripts\SJTools.mcr.res");
				deleteFile ("$max\zh-CN\MacroScripts\SJTools.mcr.res");
				
				--�A�C�R��
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon_16a.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon_16i.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon_24a.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon_24i.bmp");
				--Dark�p
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon_16a.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon_16i.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon_24a.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon_24i.bmp");
				
				/************************************
				max2010 - 2012
				*************************************/
				--�}�N��
				deleteFile "$ui\macroscripts\SJTools.mcr";
				--�A�C�R��
				deleteFile "$ui\Icons\SJTools_Icon01_16a.bmp";
				deleteFile "$ui\Icons\SJTools_Icon01_16i.bmp";
				deleteFile "$ui\Icons\SJTools_Icon01_24a.bmp";
				deleteFile "$ui\Icons\SJTools_Icon01_24i.bmp";
				deleteFile "$ui\Icons\SJTools_Icon02_16a.bmp";
				deleteFile "$ui\Icons\SJTools_Icon02_16i.bmp";
				deleteFile "$ui\Icons\SJTools_Icon02_24a.bmp";
				deleteFile "$ui\Icons\SJTools_Icon02_24i.bmp";
				
				/************************************
				max2013
				*************************************/
				--�}�N��
				deleteFile ("$max\Macroscripts\SJTools.mcr");
				--�A�C�R��
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon01_16a.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon01_16i.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon01_24a.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon01_24i.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon02_16a.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon02_16i.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon02_24a.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon02_24i.bmp");
				--Dark�p
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon01_16a.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon01_16i.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon01_24a.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon01_24i.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon02_16a.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon02_16i.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon02_24a.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon02_24i.bmp");
				
		--	)catch()
			
			
			
				/************************************
				max2010 - 2013
				*************************************/
			print "�t�@�C�����R�s�[���Ă��܂�"
			--�G���[�΍�
			Local errorFlag = true;
			Local errorMesStr = undefined ;
			Local errorCheck = #();
			
			--�t�@�C�����R�s�[����
				--�X�N���v�g�{��
				dir = getDir #scripts
				--�f�B���N�g�������
				errorFlag = makeDir (dir + "\SJTools");
				--�f�B���N�g���̐����Ɏ��s���Ă���ꍇ�́A�������݌������Ȃ��Ɣ��f����
				if (errorFlag == false ) do errorMesStr = "Error Make Dir Scripts/SJTools\n";
				--�R�s�[�A�f�B���N�g�������Ɏ��s���Ă���ꍇ�̓R�s�[�����s����
				files = getFiles "$temp\SJTools_temp\Scripts\SJTools\*.*";
				for i in files do copyFile i (dir + "\SJTools\\" + (getFileNameFile i) + (getFileNameType i));
					
				--Spark�Ȃǂ̃C���N���[�h���X�N���v�g
				dir = getDir #scripts
				--�f�B���N�g�������
				errorFlag = makeDir (dir + "\SJTools\SJScripts");
				--�f�B���N�g���̐����Ɏ��s���Ă���ꍇ�́A�������݌������Ȃ��Ɣ��f����
				if (errorFlag == false ) do errorMesStr += "Error Make Dir Scripts/SJTools/SJScripts\n";
				--���ۂ̃R�s�[
				files = getFiles "$temp\SJTools_temp\Scripts\SJTools\SJScripts\*.*";
				for i in files do copyFile i (dir + "\SJTools\SJScripts\\" + (getFileNameFile i) + (getFileNameType i));
					
				--image
				dir = getDir #scripts
				--�f�B���N�g�������
				errorFlag = makeDir (dir + "\SJTools\Images");
				--�f�B���N�g���̐����Ɏ��s���Ă���ꍇ�́A�������݌������Ȃ��Ɣ��f����
				if (errorFlag == false ) do errorMesStr += "Error Make Dir Scripts/SJTools/Images\n";
				--�R�s�[
				files = getFiles "$temp\SJTools_temp\Scripts\SJTools\Images\*.*";
				for i in files do copyFile i (dir + "\SJTools\Images\\" + (getFileNameFile i) + (getFileNameType i));
					
			--�v���O�C��
				--�X�N���v�g�{��
				dir = getDir #maxroot
				--�f�B���N�g�������
				errorFlag = makeDir (dir + "\plugins\SJTools");
				--�f�B���N�g���̐����Ɏ��s���Ă���ꍇ�́A�������݌������Ȃ��Ɣ��f����
				if (errorFlag == false ) do errorMesStr += "Error Make Dir plugins/SJTools\n";
				--�R�s�[
				files = getFiles "$temp\SJTools_temp\Plugins\SJTools\*.*";
				for i in files do copyFile i (dir + "\plugins\SJTools\\" + (getFileNameFile i) + (getFileNameType i));
					
			--�X�^�[�g�A�b�v
				--�X�N���v�g�{��
				dir = getDir #maxroot
				--�f�B���N�g�������
				errorFlag = makeDir (dir + "\stdplugs\stdscripts\SJTools");
				--�f�B���N�g���̐����Ɏ��s���Ă���ꍇ�́A�������݌������Ȃ��Ɣ��f����
				if (errorFlag == false ) do errorMesStr += "Error Make Dir stdplugs/stdscripts/SJTools\n\n";
				--�R�s�[
				files = getFiles "$temp\SJTools_temp\stdplugs\stdscripts\SJTools\*.*";
				for i in files do copyFile i (dir + "\stdplugs\stdscripts\SJTools\\" + (getFileNameFile i) + (getFileNameType i));
					
				/************************************
				�����I�ȃG���[�X�g�b�v
				*************************************/
				if errorMesStr != undefined do
				(
					--messageBox (errorMesStr + installErrorMes) title:"Install Error!!"
					prosCount = -1;
					
					return false;--return();
				);--if end					
					
				/************************************
				max2010 - 2012
				*************************************/
				--�}�N��
				dir = getDir #maxroot;
				copyFile "$temp\SJTools_temp\MacroScripts\SJTools.mcr" (dir + "ui\macroscripts\SJTools.mcr");
				
				/************************************
				max2013
				*************************************/
				--�}�N��
				dir = getDir #maxroot;
				copyFile "$temp\SJTools_temp\MacroScripts\SJTools.mcr" (dir + "\MacroScripts\SJTools.mcr");
					
				/************************************
				max2011-2012
				�A�C�R��
				*************************************/				
				dir = getDir #maxroot;
				--temp�t�@�C������ł͂Ȃ��R�s�[�ς݂̃f�B���N�g������R�s�[
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16i.bmp" (dir + "ui\icons\SJTools_Icon01_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16i.bmp" (dir + "ui\icons\SJTools_Icon02_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24i.bmp" (dir + "ui\icons\SJTools_Icon01_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24i.bmp" (dir + "ui\icons\SJTools_Icon02_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16a.bmp" (dir + "ui\icons\SJTools_Icon01_16a.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16a.bmp" (dir + "ui\icons\SJTools_Icon02_16a.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24a.bmp" (dir + "ui\icons\SJTools_Icon01_24a.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24a.bmp" (dir + "ui\icons\SJTools_Icon02_24a.bmp");
				
				/************************************
				max2013
				�A�C�R��
				*************************************/
				--�}�N��
				dir = getDir #maxroot;
				--temp�t�@�C������ł͂Ȃ��R�s�[�ς݂̃f�B���N�g������R�s�[
				--�A�C�R��
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16i.bmp" (dir + "\UI_ln\Icons\SJTools_Icon01_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16i.bmp" (dir + "\UI_ln\Icons\SJTools_Icon02_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24i.bmp" (dir + "\UI_ln\Icons\SJTools_Icon01_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24i.bmp" (dir + "\UI_ln\Icons\SJTools_Icon02_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16a.bmp" (dir + "\UI_ln\Icons\SJTools_Icon01_16a.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16a.bmp" (dir + "\UI_ln\Icons\SJTools_Icon02_16a.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24a.bmp" (dir + "\UI_ln\Icons\SJTools_Icon01_24a.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24a.bmp" (dir + "\UI_ln\Icons\SJTools_Icon02_24a.bmp");
				--Dark�p
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16i.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon01_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16i.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon02_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24i.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon01_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24i.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon02_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16a.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon01_16a.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16a.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon02_16a.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24a.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon01_24a.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24a.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon02_24a.bmp");
					
			--�A�C�R���A�X�N���v�g�����[�h
			colorman.reInitIcons();
			
			macros.load((getDir #maxroot) + "\plugins\*.ms");
			macros.load((getDir #maxroot) + "\plugins\\");
			macros.load((getDir #maxroot) + "\stdplugs\stdscripts\SJTools\*.*");
			macros.load((getDir #maxroot) + "\stdplugs\stdscripts\SJTools\\");
			macros.load(getDir #ui);
			
			--2011-2012
			try(macros.load("$ui\macroscripts\\"))catch();
			--2013-
			try(macros.load((getDir #maxroot) + "\Macroscripts\\"))catch();
				
			--�ꎞ�t�@�C����|��
			print "�ꎞ�t�@�C�����폜"
				files = getFiles "$temp\SJTools_temp\Scripts\SJTools\*.*";
				for i in files do deleteFile i;
				files = getFiles "$temp\SJTools_temp\Scripts\SJTools\SJScripts\*.*";
				for i in files do deleteFile i;
				files = getFiles "$temp\SJTools_temp\Scripts\SJTools\Images\*.*";
				for i in files do deleteFile i;
				files = getFiles "$temp\SJTools_temp\Plugins\SJTools\*.*";
				for i in files do deleteFile i;			
				files = getFiles "$temp\SJTools_temp\stdplugs\stdscripts\SJTools\*.*";
				for i in files do deleteFile i;
				files = getFiles "$temp\SJTools_temp\MacroScripts\*.*";
				for i in files do deleteFile i;
				files = getFiles "$temp\SJTools_temp\*.*";
				for i in files do deleteFile i;
					
				
			print "���� Complate"
			
			return true;
	);--fn end
-----------------------------------------------------------------------------------------------------------
-- �C���X�g�[���ē�
-----------------------------------------------------------------------------------------------------------
	fn installGuide_fn = 
	(
		local rol = sj_install_rol;
		if (prosCount == 1) then
		(
			-----------------------------------------------------------------------------------------------------------
			--�ē�1
			-----------------------------------------------------------------------------------------------------------
			rol.mesLbl.text = "SJTools ���_�E�����[�h���Ē������肪�Ƃ��������܂�!
�c�[�����C���X�g�[�����܂���?

Thank you download this SJTools.
Continue installation?";
		
			--rol.backBt.caption = "aa"
			rol.backBt.pos = [-200,-200];
			--rol.instEdt.pos = [-200,-200];
			rol.instLbx.pos = [-200,-200]
			rol.mesLbl.pos = [25,68];
			rol.nextBt.caption = "���� Next"
			
		)else if (prosCount == 2) then
		(
			-----------------------------------------------------------------------------------------------------------
			--�ē�2
			-----------------------------------------------------------------------------------------------------------
			/*
			rol.instEdt.text = "���g�p�ɂ�����
			
			
���̃v���O�C���̎g�p�ɂ����
�����Ȃ��肪�������ꍇ���A����҂͂��̐ӔC�𕉂��܂���B
�o�[�W�����A�b�v��s��ɑ΂���Ή��̐ӔC������Ȃ����̂Ƃ��܂��B

�񎟔z�z�͂��������������B
������A�񎟂Ŕz�z���ꂽ���̃v���O�C����
�g�p���Ė�肪�����Ă��A����҂͂��̐ӔC�𕉂��܂���B
			
			
Upon use

			
Through the use of this plug-in
Even if there is any problem, the author is not responsible for it.
I shall not be liable for failure to respond to or upgrade.

Please refrain from the secondary distribution.
This plug-in that was distributed by any chance, in the secondary
Even if there is a problem using the author is not responsible for it.
			";*/
			
			local mesList = #();
			append mesList "���g�p�ɂ�����  Precautions for use";
			append mesList "";
			append mesList "";			
			append mesList "���̃v���O�C���̎g�p�ɂ����";
			append mesList "�����Ȃ��肪�������ꍇ���A����҂͂��̐ӔC�𕉂��܂���B";
			append mesList "�o�[�W�����A�b�v��s��ɑ΂���Ή��̐ӔC������Ȃ����̂Ƃ��܂��B";
			append mesList "";
			append mesList "���ς�񎟔z�z�͂��������������B";
			append mesList "������A�񎟔z�z���ꂽ���̃v���O�C����";
			append mesList "�g�p���Ė�肪�����Ă��A����҂͂��̐ӔC�𕉂��܂���B";
			append mesList "�܂��A���ς��ꂽ�R�[�h���g�p���Ė�肪�����Ă�";
			append mesList "����҂͂��̐ӔC�𕉂��܂���B";
			append mesList "";
			append mesList "Through the use of this plug-in";
			append mesList "Even if there is any problem, the author is not responsible for it.";
			append mesList "I shall not be liable for failure to respond to or upgrade.";
			append mesList "";			
			append mesList "Please refrain from the secondary distribution.";
			append mesList "This plug-in that was distributed by any chance, in the secondary";
			append mesList "Even if there is a problem using the author is not responsible for it.";
			append mesList "";
			
			rol.mesLbl.pos = rol.instLinkA.pos = rol.instLinkB.pos = rol.instLinkC.pos = [-200,-200];
			--rol.instEdt.pos = [20,64];
			rol.instLbx.pos = [20,65];
			rol.backBt.pos = [120,252];
			rol.instLbx.items = mesList;
			
			rol.nextBt.caption = "���� I Agree"

		)else if (prosCount == 3) then
		(
			-----------------------------------------------------------------------------------------------------------
			--�ē�3
			-----------------------------------------------------------------------------------------------------------
			rol.mesLbl.text = "Windows8�ł̂�����  Note in Windows8
			
Windows8�̏ꍇ�A�c�[����3dsMax�ɃG���[����������\��������܂��B
�G���[���o��ꍇ�́A����ݒ������K�v������܂��B
			
If Windows8, there is a possibility that the error occurs in 3dsMax.
If an error occurs, it is necessary to set several.";
			
			--���[�U�[�A�J�E���g�̐���̐ݒ�
		
			--rol.backBt.caption = "aa"
			--rol.backBt.pos = [-200,-200];
			--rol.instEdt.pos = [-200,-200];
			rol.instLbx.pos = [-200,-200]
			rol.mesLbl.pos = [25,68];
			rol.nextBt.caption = "���� Next"
			
			rol.instLinkA.pos = [25,172];
			rol.instLinkB.pos = [25,185];
			rol.instLinkC.pos = [25,198];
		)else if (prosCount == 4) then
		(
			-----------------------------------------------------------------------------------------------------------
			--�ē�4
			-----------------------------------------------------------------------------------------------------------
			rol.mesLbl.text = "���o�[�W�����̃t�@�C�����폜���܂�
���݂̐ݒ�t�@�C���Ȃǂ͎����܂��̂ł����Ӊ�����
�C���X�g�[���𑱍s���܂���?

Remove the old version of the file.
Please note that will be lost the current configuration file.
Continue installation?";
			
			rol.instLinkA.pos = rol.instLinkB.pos = rol.instLinkC.pos = [-200,-200];
		)else if (prosCount == 5) then
		(
			-----------------------------------------------------------------------------------------------------------
			--�ē�5�C���X�g�[��
			-----------------------------------------------------------------------------------------------------------
			rol.backBt.pos = rol.nextBt.pos = rol.cancelBt.pos = [-200,-200]
			
			rol.mesLbl.text = "�C���X�g�[�����Ă��܂��B
���΂炭���҂����������B
			
Start Installation.
Please wait.";
			
			
			
			if (install_fn()) then
			(
				--�C���X�g�[������
rol.mesLbl.text = "�C���X�g�[�����������܂���!
���C�����j���[��SJTools��o�^���܂���?

Install complete.
Create a Main menu?";
				
				 rol.yesBt.pos = [224,252];
				 rol.noBt.pos = [328,252];
				/*
				--rol.backBt.pos = [120,252];
				rol.cancelBt.caption = "�I�� Exit"
				rol.nextBt.caption = "�͂� Yes"
				rol.nextBt.pos = [224,252];
				rol.cancelBt.pos = [328,252];
				*/
			)else
			(
				--�C���X�g�[�����s
			rol.mesLbl.text = "�f�B���N�g���𐶐��ł��܂���ł���!  Install Error!
�C���X�g�[���𒆒f���܂��B Stop Installation.
				
�A�N�Z�X����������Ă���\��������܂�
Windows8�̏ꍇ�A�c�[����3dsMax�ɃG���[����������\��������܂��B
�G���[���o��ꍇ�́A����ݒ������K�v������܂��B
";
				rol.instLinkA.pos = [25,172];
				rol.instLinkB.pos = [25,185];
				rol.instLinkC.pos = [25,198];
				
				rol.cancelBt.caption = "�I�� Exit"
				rol.cancelBt.pos =[328,252];
			);--if end
			
		)else if (prosCount == 6) then
		(
			-----------------------------------------------------------------------------------------------------------
			--�ē�6
			-----------------------------------------------------------------------------------------------------------
			/*
�c�[���̐ݒ��ʂ��J���܂���?

Do you open Customize User Interface?
*/
			rol.mesLbl.text = "�C���X�g�[�����Max�̍ċN�������肢�v���܂��B

Please, Reboot 3dsMax.

			
			
�c�[���o�[�Ȃǂւ̓o�^��
[�J�X�^�}�C�Y] --> [���[�U�C���^�t�F�[�X���J�X�^�}�C�Y] ����s���܂��B
			
Registration to conduct such a toolbar
from the [Customize] --> [Customize User Interface].
	"
				rol.yesBt.pos = [-200,-200];
				rol.noBt.pos = [-200,-200];
				rol.cancelBt.caption = "�I�� Exit"
				rol.cancelBt.pos =[328,252];
		)else 
		(
			-----------------------------------------------------------------------------------------------------------
			--�ē��G���[
			-----------------------------------------------------------------------------------------------------------
			rol.mesLbl.text = "�C���X�g�[���Ɏ��s���܂����B
�f�B���N�g���[���쐬�ł��܂���B
			
Start Installation.";
			
			rol.backBt.pos = rol.nextBt.pos = rol.cancelBt.pos = [-200,-200]
			rol.cancelBt.caption = "�I�� Exit"
			rol.cancelBt.pos =[328,252];
		);--if end
		
	);--fn end
	

-----------------------------------------------------------------------------------------------------------
-- ���j���[�o�[�֘A
-----------------------------------------------------------------------------------------------------------
	fn installMenu_fn = 
	(
			--���łɃ��j���[���������ꍇ�͍폜����
			try(
				--���j���[�͂��邩�H
				myMenu = menuMan.findMenu "SJTools";
				--���j���[���폜
				menuMan.unRegisterMenu myMenu;
			)catch();

			--�܂��o�^�p��ID��p�ӂ��Ă����AID�������Ƃ��Ԃ��Ă���Ɠo�^�ł��Ȃ�
			myContextId = genClassID returnValue:true;
			
			try(

			--���j���[ID��o�^���Ȃ���쐬
				if menuMan.registerMenuContext myContextId[1] then
				(
				--���C�����j���[���擾
				local mainMenuBar = menuMan.getMainMenuBar();
				
				--���C�����j���[�ɐV�������ڂ����쐬����
				local subMenu = menuMan.createMenu "SJTools";
				--���j���[�ɃA�N�V������ǉ�����
				local testItem = menuMan.createActionItem "SJ_PBake" "SJTools";
				--������A�C�e�����̃��j���[�ɒǉ�����
				subMenu.addItem testItem -1;					
				testItem = menuMan.createActionItem "SJ_Renamer" "SJTools";
				subMenu.addItem testItem -1;					
				testItem = menuMan.createActionItem "SJ_Selector" "SJTools";
				subMenu.addItem testItem -1;					
				testItem = menuMan.createActionItem "SJ_Time_Machine" "SJTools";
				subMenu.addItem testItem -1;					
				testItem = menuMan.createSeparatorItem()
				subMenu.addItem testItem -1;
					
					
				testItem = menuMan.createActionItem "SJ_LayerLayer" "SJTools";
				subMenu.addItem testItem -1;			
				testItem = menuMan.createActionItem "SJ_Spark" "SJTools";
				subMenu.addItem testItem -1;
				testItem = menuMan.createActionItem "SJ_Bio_Skin_Plus" "SJTools";
				subMenu.addItem testItem -1;
				testItem = menuMan.createActionItem "SJ_Key_Machine" "SJTools";
				subMenu.addItem testItem -1;
				testItem = menuMan.createSeparatorItem()
				subMenu.addItem testItem -1;
				
				testItem = menuMan.createActionItem "SJ_Hider" "SJTools";
				subMenu.addItem testItem -1;
				testItem = menuMan.createActionItem "SJ_Scene_Slicer" "SJTools";
				subMenu.addItem testItem -1;
				testItem = menuMan.createActionItem "SJ_Roller" "SJTools";
				subMenu.addItem testItem -1;
				testItem = menuMan.createActionItem "SJ_AnimKey_Preview" "SJTools";
				subMenu.addItem testItem -1;
				testItem = menuMan.createSeparatorItem()
				subMenu.addItem testItem -1;
				
				testItem = menuMan.createActionItem "SJ_Adjuster" "SJTools";
				subMenu.addItem testItem -1;
				testItem = menuMan.createActionItem "SJ_Poser" "SJTools";
				subMenu.addItem testItem -1;
				testItem = menuMan.createSeparatorItem()
				subMenu.addItem testItem -1;
				
				testItem = menuMan.createActionItem "SJ_Language_Setting" "SJTools";
				subMenu.addItem testItem -1;
				testItem = menuMan.createActionItem "SJ_Icon_Setting" "SJTools";
				subMenu.addItem testItem -1;
				
				--���̃��j���[���T�u���j���[�Ƃ��č쐬����
				local subMenuItem = menuMan.createSubMenuItem "SJTools" subMenu;
				
				--���j���[�ǉ��p�Ƀ��C�����j���[��index���擾���Ă���
				local subMenuIndex = mainMenuBar.numItems() - 1;
				
				--���j���[�����C�����j���[�ɒǉ�
				mainMenuBar.addItem subMenuItem subMenuIndex;
				
				--�X�V
				menuMan.updateMenuBar();
				);--if end
				
			)catch(
				--messageBox"���j���[�ǉ��Ɏ��s���܂���\n\nFailed to add menu..." title:"Confirmation"
				--return false;
				);
				
			return true;
	);--fn end
		
-----------------------------------------------------------------------------------------------------------
-- Layout
-----------------------------------------------------------------------------------------------------------
	GroupBox instGrp "" pos:[8,8] width:437 height:282
	label instLbl "SJ Tools Install" pos:[191,32] width:72 height:24
	GroupBox instMesGrp "" pos:[18,56] width:417 height:174
	listbox instLbx "" items:#() pos:[-200,-200] width:413 height:12 readOnly:true --listbox instLbx "" items:#() pos:[20,65] width:412 height:12
	--edittext instEdt "" pos:[-200,-200] width:417 height:164 readOnly:true--editText instEdt "" pos:[16,64] width:417 height:164;
	
	label mesLbl "" pos:[25,68] width:396 height:152--editText instEdt "" pos:[16,64] width:417 height:164;
	
	button backBt "�߂� Back" pos:[120,252] width:104 height:24--	button backBt "�߂� Back" pos:[224,252] width:104 height:24;
	button nextBt "���� Next" pos:[224,252] width:104 height:24
	button cancelBt "�L�����Z�� Cancel" pos:[328,252] width:104 height:24
	
	button yesBt "�͂� Yes" pos:[-200,-200] width:104 height:24
	button noBt "������ No" pos:[-200,-200] width:104 height:24	


hyperLink instLinkA "�ڂ����͂�������������������Bhttp://wp.me/pyh1l-2NQ\nDescription of setting\n" pos:[-200,-200]  color:(color 248 123 0) hoverColor:(color 33 144 255) address:"http://www.sakaiden.com/?p=10778"
	hyperLink instLinkB "�t�@�C���̃A�N�Z�X�����̐ݒ�" pos:[-200,-200] color:(color 248 123 0) hoverColor:(color 33 144 255) address:"http://www.youtube.com/watch?feature=player_embedded&v=S-EsH55m0AA" pos:[28,252] ;
	hyperLink instLinkC "���[�U�[�A�J�E���g�̐���̐ݒ�"pos:[-200,-200] color:(color 248 123 0) hoverColor:(color 33 144 255) address:"http://www.youtube.com/watch?feature=player_embedded&v=t6mli9dtMag" pos:[28,252] ;

	on sj_install_rol open do
	(
		installGuide_fn();
	);
	on backBt pressed do
	(
		prosCount -= 1;
		installGuide_fn();
	);
	on nextBt pressed do
	(
		prosCount += 1;
		installGuide_fn();
	);
	on yesBt pressed do
	(
		prosCount += 1;
		installMenu_fn();
		installGuide_fn();
	);
	on noBt pressed do
	(
		prosCount += 1;
		installGuide_fn();
	);	
	on cancelBt pressed do
	(
		try(cui.FloatDialogBar sj_install_rol)catch()
		try(cui.unRegisterDialogBar sj_install_rol)catch()
		try( CloseRolloutFloater sj_install_rol) catch()
		try(destroydialog sj_install_rol)catch()
	);
)
--end rollout
-----------------------------------------------------------------------------------------------------------
-- End of rollout & Create Dialog / Floater
-----------------------------------------------------------------------------------------------------------
CreateDialog sj_install_rol style:#(#style_border, /*#style_titlebar,*/#style_toolwindow, #style_sysmenu, /*#style_resizing*/ #style_minimizebox);

);--end