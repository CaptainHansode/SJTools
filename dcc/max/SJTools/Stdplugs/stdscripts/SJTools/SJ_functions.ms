/*******************************************************
System J Tools 
********************************************************
Name:SJ_functions
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/

--////////////////////////////////////////////////
--�\���̒�`
--�\���̂̓J���}�ŋ�؂鎖�I
--////////////////////////////////////////////////
struct sj_functions
--struct sjtools_basefunctions
--struct sjtools_functions
(
	--////////////////////////////////////////////////
	--�A�o�E�g
	--////////////////////////////////////////////////
	fn sjtools_about_Fn=
		(
			try(
			--���O�t�@�C�����w��
			logFile = (openFile ((getDir #scripts) + "\SJTools\SJTools_Log.ms"));
			--�w��̕�����܂œǂݍ���
			messageBox((readDelimitedString logFile "//")) title:"About";
			)catch();
		),--end about
		
	--////////////////////////////////////////////////
	--����؂�ւ�
	--////////////////////////////////////////////////
	fn sjtools_changeLanguage_Fn=
		(
			if ((getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJTools" "Language") != "JP") then
			(
				--���{���
				if (queryBox("SJTools�̌������{��֐؂�ւ��܂���?\n\nDo you switch the language to Japanese?\n") title:"Check") do
					(
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJTools" "Language" "JP";
					
					--�c�[������S�ĕύX
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJPBakeToolName" "�ҁ[�ׂ���";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJRenamerToolName" "��ˁ[�܁[";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJSparkToolName" "���ρ[����";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJBioSkinPlusToolName" "�΂�����+";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJTimeMachineToolName" "�����ނ܂���";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJSelectorToolName" "���ꂭ�ɂ�[";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJSelectorRigToolName" "���ꂭ�ɂ�[�͂肯�[��";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJAdjusterToolName" "�����Ⴗ���[";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJPoserToolName" "�ہ[�����";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJHiderToolName" "�͂����[";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJRollerToolName" "��[��[";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJBipFitterToolName" "�т��Ղӂ������[";
					
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJSceneSlicerToolName" "���[�񂷂炢�����";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJLayerLayerToolName" "�ꂢ��[�ꂢ�₟�`";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJAnimKeyPreviewToolName" "���ɂ��[";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJKeyMachineToolName" "���[�܂���";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJMultiPRSToolName" "�܂邿�ɂ�[";
					
					--�ēǂݍ���
					--�}�N���̏���
					--2011-2012
					deleteFile ("$ui\macroscripts\SJTools.mcr");
					--2013-
					deleteFile ("$max\Macroscripts\SJTools.mcr");
					
					--�}�N���̃R�s�[
					--2011-2012
					copyFile "$max\Scripts\SJTools\SJTools_jp.mcr" "$ui\macroscripts\SJTools.mcr";
					--2013-
					copyFile "$max\Scripts\SJTools\SJTools_jp.mcr" "$max\MacroScripts\SJTools.mcr";
					
					--2011-2012
					try(macros.load("$ui\macroscripts\\"))catch();
					--2013-
					--try(macros.load((getDir #maxroot) + "\Macroscripts\\"))catch();
					try(macros.load("$max\Macroscripts\\"))catch();
					
					--���m�点
					messageBox("�؂�ւ����I���܂���\n�c�[�����ċN�����Ă�������\n\nComplete\nPlease Reboot this tool.\n") title:"Complete";
					);--if end
			)else
			(
				--�p���
				if (queryBox("SJTools�̌�����p��֐؂�ւ��܂���?\n\nDo you switch the language to English?\n") title:"Check") do
					(
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJTools" "Language" "EN";
					
					--�c�[������S�ĕύX
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJPBakeToolName" "SJ PBake";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJRenamerToolName" "SJ Renamer";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJSparkToolName" "SJ Spark";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJBioSkinPlusToolName" "SJ Bio Skin +";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJTimeMachineToolName" "SJ Time Machine";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJSelectorToolName" "SJ Selector";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJSelectorRigToolName" "SJ Selector Hurricane";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJAdjusterToolName" "SJ Adjuster";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJPoserToolName" "SJ Poser";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJHiderToolName" "SJ Hider";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJRollerToolName" "SJ Roller";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJBipFitterToolName" "SJ Bip Fitter";
					
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJSceneSlicerToolName" "SJ Scene Slicer";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJLayerLayerToolName" "SJ Layer Layer";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJAnimKeyPreviewToolName" "SJ Anim Key Preview";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJKeyMachineToolName" "SJ Key Mathine";
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJToolsToolName" "SJMultiPRSToolName" "SJ MultiRPS";
					
					--�ēǂݍ���
					--�}�N���̏���
					--2011-2012
					deleteFile ("$ui\macroscripts\SJTools.mcr");
					--2013-
					deleteFile ("$max\Macroscripts\SJTools.mcr");
					
					--�}�N���̃R�s�[
					--2011-2012
					copyFile "$max\Scripts\SJTools\SJTools_en.mcr" "$ui\macroscripts\SJTools.mcr";
					--2013-
					copyFile "$max\Scripts\SJTools\SJTools_en.mcr" "$max\MacroScripts\SJTools.mcr";
					
					--2011-2012
					try(macros.load("$ui\macroscripts\\"))catch();
					--2013-
					try(macros.load("$max\Macroscripts\\"))catch();
					
					--���m�点
					messageBox("�؂�ւ����I���܂���\n�c�[�����ċN�����Ă�������\n\nComplete\nPlease Reboot this tool.\n") title:"Complete";
					);--if end
			);--if end

			return true;
		),--end about
		
	--////////////////////////////////////////////////
	--�A�C�R��
	--////////////////////////////////////////////////
	fn sjtools_changeIcon_Fn=
		(
			if ((getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJTools" "Icon") != "Standard") then
			(
				--�ʏ�A�C�R��
				if (queryBox("�K�D�K�D�I�K�D�K�D�K�@�`�`?\n(�A�C�R�������ɖ߂��܂���?)\n\nGow gow! gow gow gow?\n(Change to Standard Icon?)\n") title:"Check") do
					(
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJTools" "Icon" "Standard";
					
				/************************************
				max2010 - 2012
				*************************************/
				deleteFile "$ui\Icons\SJTools_Icon01_16i.bmp";
				deleteFile "$ui\Icons\SJTools_Icon01_24i.bmp";
				deleteFile "$ui\Icons\SJTools_Icon02_16i.bmp";
				deleteFile "$ui\Icons\SJTools_Icon02_24i.bmp";
				
				/************************************
				max2013
				*************************************/
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon01_16i.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon01_24i.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon02_16i.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon02_24i.bmp");
				--Dark�p
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon01_16i.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon01_24i.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon02_16i.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon02_24i.bmp");
				
				/************************************
				max2011-2012
				*************************************/				
				dir = getDir #maxroot;
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16i.bmp" (dir + "ui\icons\SJTools_Icon01_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16i.bmp" (dir + "ui\icons\SJTools_Icon02_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24i.bmp" (dir + "ui\icons\SJTools_Icon01_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24i.bmp" (dir + "ui\icons\SJTools_Icon02_24i.bmp");
				/************************************
				max2013
				*************************************/
				--�}�N��
				dir = getDir #maxroot;
				--�A�C�R��
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16i.bmp" (dir + "\UI_ln\Icons\SJTools_Icon01_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16i.bmp" (dir + "\UI_ln\Icons\SJTools_Icon02_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24i.bmp" (dir + "\UI_ln\Icons\SJTools_Icon01_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24i.bmp" (dir + "\UI_ln\Icons\SJTools_Icon02_24i.bmp");
				--Dark�p
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16i.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon01_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16i.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon02_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24i.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon01_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24i.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon02_24i.bmp");
				
				--�A�C�R�����ēǂݍ���
				colorman.reInitIcons();
				
					);--if end
			)else
			(
				--�ʏ�A�C�R��
				if (queryBox("�K�D�K�D�K�D�D?�E�K�@�`�`?\n(�A�C�R�����w���Ȃ̂ɕς��܂���?)\n\nGow gow gowww! Uga?\n(Change to Animal Icon?)\n") title:"Check") do
					(
					setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJTools" "Icon" "Animal";
					
				/************************************
				max2010 - 2012
				*************************************/
				deleteFile "$ui\Icons\SJTools_Icon01_16i.bmp";
				deleteFile "$ui\Icons\SJTools_Icon01_24i.bmp";
				deleteFile "$ui\Icons\SJTools_Icon02_16i.bmp";
				deleteFile "$ui\Icons\SJTools_Icon02_24i.bmp";
				
				/************************************
				max2013
				*************************************/
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon01_16i.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon01_24i.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon02_16i.bmp");
				deleteFile ("$max\UI_ln\Icons\SJTools_Icon02_24i.bmp");
				--Dark�p
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon01_16i.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon01_24i.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon02_16i.bmp");
				deleteFile ("$max\UI_ln\IconsDark\SJTools_Icon02_24i.bmp");
				
				
				/************************************
				max2011-2012
				*************************************/				
				dir = getDir #maxroot;
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16i_Aml.bmp" (dir + "ui\icons\SJTools_Icon01_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16i_Aml.bmp" (dir + "ui\icons\SJTools_Icon02_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24i_Aml.bmp" (dir + "ui\icons\SJTools_Icon01_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24i_Aml.bmp" (dir + "ui\icons\SJTools_Icon02_24i.bmp");
				/************************************
				max2013
				*************************************/
				--�}�N��
				dir = getDir #maxroot;
				--�A�C�R��
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16i_Aml.bmp" (dir + "\UI_ln\Icons\SJTools_Icon01_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16i_Aml.bmp" (dir + "\UI_ln\Icons\SJTools_Icon02_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24i_Aml.bmp" (dir + "\UI_ln\Icons\SJTools_Icon01_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24i_Aml.bmp" (dir + "\UI_ln\Icons\SJTools_Icon02_24i.bmp");
				--Dark�p
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_16i_Aml.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon01_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_16i_Aml.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon02_16i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon01_24i_Aml.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon01_24i.bmp");
				copyFile "$max\scripts\SJTools\Images\SJTools_Icon02_24i_Aml.bmp" (dir + "\UI_ln\IconsDark\SJTools_Icon02_24i.bmp");
				
				--�A�C�R�����ēǂݍ���
				colorman.reInitIcons();
					
					);--if end
			);--if end

			return true;
		),--end about


	--////////////////////////////////////////////////
	--�v���O���X�o�[
	--////////////////////////////////////////////////
	fn sj_progressBar_Fn =
	(
		global sj_progressBar_rol
		try (destroydialog sj_progressBar_rol) catch()
		rollout sj_progressBar_rol "" width:416 height:56
		(
		progressBar progbar "" pos:[8,8] width:400 height:24 color:(color 30 10 190)
		label processInfo "" pos:[8,36] width:400 height:16
		)--rollout selset_rol
		CreateDialog sj_progressBar_rol style:#(/*#style_border, #style_titlebar, #style_sysmenu, #style_resizing,*/ #style_toolwindow, #style_minimizebox) --pos:[50,50]
	),--fn end
	
	--////////////////////////////////////////////////
	--hide
	--////////////////////////////////////////////////
	fn sj_SetHide_Fn nodes state =
	(
		for i in nodes do
		(
			hide i.node
		)--for end
		
		if state then
		(
			for i in nodes do
			(
			unhide i.node
			)--for end
		)--if end
	),--fn end
	
	--////////////////////////////////////////////////
	--freeze
	--////////////////////////////////////////////////
	fn sj_SetFreeze_Fn nodes state =
	(
		for i in nodes do
		(
			freeze i.node
		)--for end
		
		if state then
		(
			for i in nodes do
			(
			unfreeze i.node
			)--for end
		)--if end
	),--fn end

	--////////////////////////////////////////////////
	--showFrozenInGray
	--////////////////////////////////////////////////
	fn sj_SetFrozenGray_Fn nodes =
	(
		for i in nodes do
		(
			i.node.showFrozenInGray = off
		)--for end
	),--fn end

	--////////////////////////////////////////////////
	--select
	--////////////////////////////////////////////////
	fn sj_SelectNodes_Fn nodes =
	(
		for i in nodes do
		(
			selectMore i.node
		)--for end
	),--fn end
	
	--////////////////////////////////////////////////
	--�I�u�W�F�N�g��I�����Ă���̂�??
	--////////////////////////////////////////////////
	fn sj_SelectCheck_Fn =
	(
		if (selection.count != 0) then
		(
			return true;
		)
		else
		(
			--�I�u�W�F�N�g�������ꍇ���s�o���Ȃ��́A�I������s�𑣂�
			messageBox("�I�u�W�F�N�g���I������Ă��܂���\n�Ȃɂ��I�u�W�F�N�g��I�����Ď��s��������\n ")title:"���b�Z�[�W";
			return false;
		);--if end
	),--fn end
	
	/*////////////////////////////////////////////////
	--SJ_selectbranch_Fn
	--�w��̃I�u�W�F�N�g�ȉ��̍\����I������
	--���� obj�͒P��̃I�u�W�F�N�g�̂�
	--pram 0:�͍\�����ׂ� 1:�I���ȉ�
	--�Ԃ�lobjectBranch ��������\���I�u�W�F�N�g�S��
	////////////////////////////////////////////////*/
	fn sj_selectBranch_Fn obj pram =
	(
--�V�E�\����S���I������
	with redraw off
	(--�ĕ`��֎~
	--�K�w�\����S�Ď擾
	--�ϐ�������
	Local objRoot = obj,
	objectBranch = #();--��������q��
	--obj = undefined;
	checkObj = undefined;--�`�F�b�N����I�u�W�F�N�g
	checkChildren = #();--�`�F�b�N����I�u�W�F�N�g�̔z��
		
	--��ł��I�����Ă��邩�H
	if (obj != undefined) do
		(
			
		--�\����S�̂�I������Ȃ��
		if (pram != 1) do
		(
			--�I���������̂̊K�w�������̂ڂ�A�e�I�u�W�F�N�g�������Ȃ�������
			while objRoot.parent != undefined do
			(
				objRoot = objRoot.parent
			)--while end
		);--if end
		
		--�z��Ɋi�[
		append objectBranch objRoot
		
		--�q���̐�������
		numChild = objRoot.children.count;
		--�������
		for i =1 to objRoot.children.count do
		(
			--2�ɉ��
			append checkChildren objRoot.children[i];
			append objectBranch objRoot.children[i];
		);--for end
		
		--0�ɂȂ�܂ŌJ��Ԃ�
		while numChild != 0 do
		(
			--deleteItem checkChildren 1;
			checkObj = checkChildren[numChild];
			
			--�`�F�b�N�p�z�񂩂�̂����肩��폜
			deleteItem checkChildren numChild;
			numChild -= 1;			
			
			--�q�͂��邩�H
			if (checkObj.children.count != 0) then
			(
				--print "�L��";
				numChild += checkObj.children.count;--�J�E���g�A�b�v
				for i =1 to checkObj.children.count do
				(
					append checkChildren checkObj.children[i];
					append objectBranch checkObj.children[i];
				);--for end
			)else
			(
				--�q��������Ȃ����
				--print "����"
			);--if end
			--checkObj += objRoot.children[numChild];
		);

		--�Ō�ɑI��
		--select objectBranch;
		--print "�I���I��";
	);--if end
	
		--�z���S��return
		return objectBranch;
	);--with redraw end
	
	),--fn end
	
	
	--////////////////////////////////////////////////
	--�z����̃I�u�W�F�N�g�𖼑O�Ń\�[�g����
	--////////////////////////////////////////////////
	fn sj_nameStringSort_Fn s1 s2 =
	(
		--���O�̕�������r�������ʂ���
		local a = (stricmp s1.name s2.name);
		--��r���ʂ���d�������s��
		case of
			(
			(a < 0.): -1
			(a > 0.): 1
			default: 0
			);--case end
	),--fn end	
	
	/*////////////////////////////////////////////////
	--SJ_sortByBranch
	--�z����e��e�q���Ƀ\�[�g���Ȃ���
	--�����͒��ׂ�I�u�W�F�N�g�z��
	--�Ԃ�l ���ג������z��
	////////////////////////////////////////////////*/
	fn sj_sortByBranch_Fn objArray =
	(
		--�K�w�\����S�Ď擾
		Local myObjAll = #(), delIndex = undefined;
			--Local selObj = for i in selection collect i;
		Local selObj = objArray;
		Local objLevel = 1;
		Local myObj = #();--��Ɨp�A���Ō�ɕԂ��z��
		--////////////////////////////////////////////////
		--�z�������
		--////////////////////////////////////////////////
		for i = 1 to 256 do
		(
			append myObjAll #();
		);--for end
		--�v���O���X�o�[
		sj_functions.sj_progressBar_Fn()
		--////////////////////////////////////////////////
		--�K�w���x����]��
		--////////////////////////////////////////////////
		--�v���O���X����
		Local progCountAll = selObj.count;
		Local progCount = 1;
		
		for i in selObj do
		(
			sj_progressBar_rol.processInfo.caption =  "�\����]�����Ă��܂�   " + (floor(((100.0/progCountAll) * progCount))as String) + "%";
			sj_progressBar_rol.progbar.value = ((100.0/progCountAll) * progCount);
			progCount += 1;
			
			myObj = #();
			objLevel = 1;
			obj = i;
			--�e�������Ȃ�܂ŉ��񂩂��������H=�K�w���x��
			while obj.parent != undefined do
			(
				obj = obj.parent
				objLevel += 1;
			)--while end
			append myObjAll[objLevel] i;
		);--for end
		--////////////////////////////////////////////////
		--�z����𖼑O�Ń\�[�g
		--////////////////////////////////////////////////
		progCountAll = myObjAll.count;
		progCount = 1;
		for i in myObjAll do
		(
			sj_progressBar_rol.processInfo.caption =  "���X�g���\�[�g���Ă��܂�   " + (floor(((100.0/progCountAll) * progCount))as String) + "%";
			sj_progressBar_rol.progbar.value = ((100.0/progCountAll) * progCount);
			progCount += 1;
			if i.count != 0 then
			(
				--��ȏ�ł���Ζ��O�Ŕz����\�[�g--�܂����O���r���Ȃ���z������\�[�g����
				if (i.count > 1) do qsort i sj_functions.sj_nameStringSort_Fn;
			)
		);--for end
		--////////////////////////////////////////////////
		--�ЂƂ̔z��ɂ܂Ƃ߂�
		--////////////////////////////////////////////////
		myObj=#();
		--�z��0�Ŗ������
		for i in myObjAll do if (i.count != 0) do join myObj i;
		try(destroydialog sj_progressBar_rol)catch();
		return myObj;

	),--fn end

	/*////////////////////////////////////////////////
	--SJ_searchSimilarStrings
	--�������O�𒲂ׂ�
	--�����͒��ׂ镶����A�Ώۂ̕�����A�]�����x���A���ɁAstring array value
	--���背�x����10�`0�A10�ł�100�_�̂݁A0�_�͂قڂ��ׂĂ𑗂�Ԃ�
	--�Ԃ�l ���׏グ�������񂷂ׂ�
	////////////////////////////////////////////////*/
	fn sj_searchSimilarStrings_Fn tagStr srchList judgLevel =
	(
			/*�����̑g�ݍ��킹�́A�ő傪������
			�ŏ���1����
			�ׂ����������̑g�ݍ��킹��
			�Ⴆ�΁A4�����̏ꍇ
			�ő��4�����͈�A	�ꕶ���ɕ��������4����
			3�����̑g�ݍ��킹��2��
			2�����̑g�ݍ��킹��3��
			�ő�=������
			�ő�-�i�ő�-1�j=�ő�ƍŏ��̂������̑g�ݍ��킹��
			�ŏ�=1����
			*/
			--�e�X�g�p
			--tagStr = "abcdefg";
			--srchList = #("abasdcdefadsfwe","343as","4","cab","abcdefg","tyui","bac");
			
		Local resultList = #();--���ʂ̔z��
		Local scoreList = #(#(),#(),#(),#(),#(),#(),#(),#(),#(),#(),#());--�_�����Ɍ��ʂ��������A�E����100-0�_��10���
		--�z��̃C���f�b�N�X�l�A1:100�A2:90�A3:80�A4:70�A5:60�A6:50�A7:40�A8:30�A9:20�A10:10�A11:0
		Local strHit = 0;--��v��������
			Local i = tagStr.count;
			Local u = 0;--�A�������̕�����
			Local j = 1;--�����̍����񐔁A�ŏ���1����
			Local compStr = "";--��������
			Local analysisTagStr = #();--���׏グ�镶����̑g�ݍ��킹
			
			--�����̍ő吔���J��Ԃ�
			while i > 0 do
			(
				--�����񐔂�ݒ�
				u = j;
				while u > 0 do
				(
					--��U������������
					compStr = "";
					
					--K�����ڂ���i���������̕����������
					--
					for k = u to (u+(i-1)) do
					(
						compStr += tagStr[k];
					);--for end
					append analysisTagStr compStr;
					u -= 1;
				);--while end
				
				--�J�E���g����ړ�����
				i -= 1;
				j += 1;
			);--while end
			
			--print analysisTagStr;
			--print analysisTagStr.count;
			
			--�v���O���X�o�[
			sj_functions.sj_progressBar_Fn()
			sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
			Local progCount = 1;
			
			for k in srchList do
			(
				--�J�E���g��0
				strHit = 0;
				--�i�[���������񂪂ǂꂭ�炢���邩��r����
				for i in analysisTagStr do
				(
					--�����񂪂����
					if ((findString k i) != undefined) do strHit += 1;
				);--for end
				
				--�ǂꂾ����v�������]������
				--���U�Ə����_�������Čv�Z����
				strHit = (((strHit*1.0) / ((analysisTagStr.count)*1.0)) * 100);
				
				--�S�Ĉ�v���Ă���ꍇ�́A���������Ō�ɔ�r
				--1����2�_�Ō��_����A�܂�50�����ȏ�̕�����͌����ΏۊO
				--abs�Ő�Βl��
				tempVal = (abs(tagStr.count - k.count)) * 2;
				--���_
				strHit = strHit - tempVal;
				
				--�_�����ɐU�蕪��			
				--�z��̃C���f�b�N�X�l�A1:100�A2:90�A3:80�A4:70�A5:60�A6:50�A7:40�A8:30�A9:20�A10:10�A11:0
				--100�_�ȏ�
				if (strHit >= 100) then (append scoreList[1] k)
				else if (strHit >= 90) then (append scoreList[2] k)
				else if (strHit >= 80) then (append scoreList[3] k)
				else if (strHit >= 70) then (append scoreList[4] k)
				else if (strHit >= 60) then (append scoreList[5] k)
				else if (strHit >= 50) then (append scoreList[6] k)
				else if (strHit >= 40) then (append scoreList[7] k)
				else if (strHit >= 30) then (append scoreList[8] k)					
				else if (strHit >= 20) then (append scoreList[9] k)
				else if (strHit >= 10) then (append scoreList[10] k)
				else if (strHit >= 0) then (append scoreList[11] k);
				
				--�v���O���X���X�V
				sj_progressBar_rol.progbar.value = ((100.00/srchList.count) * progCount)
				progCount += 1;
					
			);--for end
			
				--�e�z����\�[�g
				sort scoreList[1];
				sort scoreList[2];
				sort scoreList[3];
				sort scoreList[4];
				sort scoreList[5];
				sort scoreList[6];
				sort scoreList[7];
				sort scoreList[8];
				sort scoreList[9];
				sort scoreList[10];
				sort scoreList[11];
			
			--���U���g�ɉ���A�������A������邩�̓W���b�W���x���Ɉˑ�
			if (scoreList[1].count != 0) and (judgLevel <= 10) do join resultList scoreList[1];
			if (scoreList[2].count != 0) and (judgLevel <= 9) do join resultList scoreList[2];
			if (scoreList[3].count != 0) and (judgLevel <= 8) do join resultList scoreList[3];
			if (scoreList[4].count != 0) and (judgLevel <= 7) do join resultList scoreList[4];
			if (scoreList[5].count != 0) and (judgLevel <= 6) do join resultList scoreList[5];
			if (scoreList[6].count != 0) and (judgLevel <= 5) do join resultList scoreList[6];
			if (scoreList[7].count != 0) and (judgLevel <= 4) do join resultList scoreList[7];
			if (scoreList[8].count != 0) and (judgLevel <= 3) do join resultList scoreList[8];
			if (scoreList[9].count != 0) and (judgLevel <= 2) do join resultList scoreList[9];
			if (scoreList[10].count != 0) and (judgLevel <= 1) do join resultList scoreList[10];
			if (scoreList[11].count != 0) and (judgLevel <= 0) do join resultList scoreList[11];
			
			--print resultList;
		--�v���O���X�I��
		try(destroydialog sj_progressBar_rol)catch();
		--���^�[�����ďI��
		return resultList;
	),--fn end
	
	/*////////////////////////////////////////////////
	--SJ_checkObjByName
	--�w��̖��O�̃I�u�W�F�N�g�̓V�[�����ɂ��邩�H
	--�����͒��ׂ�I�u�W�F�N�g��
	--�Ԃ�l true / false
	////////////////////////////////////////////////*/
	fn sj_checkObjByName_Fn objName =
	(
		--�I�u�W�F�N�g���m��--�啶�����������肠��
		 getNodeTemp = (getNodeByName i exact:false ignoreCase:false all:true);
		 --���getNodeByname�͔z�񂪕Ԃ����̂Œ��ӁI
		 
		--�I�u�W�F�N�g�͂��邩?�z��̐���0�Ȃ��
		if (getNodeTemp.count == 0) then
		(
		messageBox("�ȉ��̃I�u�W�F�N�g���V�[����ɂ���܂���\n" + i) title:"�G���[";
		return false;
		);--if end
		
			--�������O�̃I�u�W�F�N�g�����邩?
			if (getNodeTemp.count >= 2) do doubleNameCheck = true;
		
			--bip���ǂ����m�F
			--�O�̃��cif ((sj_pbake_rol.pbTypeRb.state == 1) or (sj_pbake_rol.pbTypeRb.state == 3)) then
			if (sj_pbake_rol.pbTypeRb.state == 3) then
			(
				tempObj = getNodeByName i;
				if ((classOf tempObj) == Biped_Object) or ((classOf tempObj.controller) == BipSlave_Control) then
				(
				--messageBox("PBake��Plot��Biped�ɑΉ����Ă��܂���B\n" + i) title:"�G���[";
				messageBox("Plot��Biped�ɑΉ����Ă��܂���B\n" + i) title:"�G���[";
				return false;
				);--if end
			/*
			try(
			biped.getNode (getNodeByName i) 1;
			)catch();
			*/
			);--if end
	),--fn end

	--////////////////////////////////////////////////
	--�t�@���N�V�����G���h�A�J���}��؂���~�X���Ȃ��悤��
	--////////////////////////////////////////////////
	fn sj_fnEnd_Fn =
	(
		return print"fnEnd";
	);--fn end
	
)