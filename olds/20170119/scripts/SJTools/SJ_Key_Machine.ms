/*******************************************************
System J Tools 
********************************************************
Name:sj_key_Machine
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/

(

-----------------------------------------------------------------------------------------------------------
-- �O���[�o������
-----------------------------------------------------------------------------------------------------------
global sj_key_Machine_rol --���[���A�E�g�p
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
include "$scripts/SJTools/SJ_CommonLangSet.ms"

--Version etc ���O���̂�SJTools.ini����
Local nameAndVersion = "SJ Key Machine"
-----------------------------------------------------------------------------------------------------------
Local fileLockID = 6581883285124;

-----------------------------------------------------------------------------------------------------------
-- ���[���A�E�g����
-----------------------------------------------------------------------------------------------------------
--���Ԃ͍폜���ēo�^
--�o�^���폜
try(cui.unRegisterDialogBar sj_key_Machine_rol)catch();
--����
try(closeRolloutFloater sj_key_Machine_rol)catch();
--�폜	
try(destroydialog sj_key_Machine_rol)catch();
--�o�^�����_�C�A���O��s���ɂ���
try(cui.FloatDialogBar sj_key_Machine_rol)catch();

-----------------------------------------------------------------------------------------------------------
-- ���C�� Rollout
-----------------------------------------------------------------------------------------------------------
rollout sj_key_Machine_rol nameAndVersion
(

-----------------------------------------------------------------------------------------------------------
-- �t�@���N�V����
-----------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////
--���j���[
--////////////////////////////////////////////////
	fn menus_Fn =
	(
		rcMenu menuBar
		(
			local modInst
			/*
				menuItem maxPreviewMi "�v���r���[�̐ݒ�";
				menuItem createPreviewMi "�v���r���[���쐬";
				menuItem maxRenamePreviewMi "�v���r���[�ɖ��O��t���ĕۑ�";
				seperator sep01;
				menuItem reduceKeysMi "�L�[���_�N�V����";
				seperator sep02;
				menuItem setActiveKeyRangeMi "���݂̃I�u�W�F�N�g�̃L�[�Ń����W�ݒ�";
				seperator sep03;
				menuItem saveBookMi "�u�b�N�}�[�N��ۑ�";
				menuItem loadBookMi "�u�b�N�}�[�N��ǂݍ���"
				menuItem mergeBookMi "�u�b�N�}�[�N������"
				menuItem resetBookMi "�u�b�N�}�[�N�����Z�b�g"
			*/
				--menuItem offsetKeysMi "�L�[�I�t�Z�b�g"
				menuItem testMi "���̃c�[���͎������ł�"
				seperator sep01;
				menuItem helpMi "�w���v!"
				menuItem aboutMi "About"
				menuItem emailMi  "E-Mail"
			
			on maxPreviewMi picked do max preview;
			on createPreviewMi picked do createPreview();
			on maxRenamePreviewMi picked do max renamepreview;
			
			on reduceKeysMi picked do sj_key_Machine_rol.keysReduce_Fn();
			
			on setActiveKeyRangeMi picked do sj_key_Machine_rol.setActiveKeyRange_Fn();
			
			on saveBookMi picked do sj_key_Machine_rol.save_Fn();
			on mergeBookMi picked do sj_key_Machine_rol.merge_Fn();

			on resetBookMi picked do sj_key_Machine_rol.resetBook_Fn();
			
			on loadBookMi picked do sj_key_Machine_rol.load_Fn();
			on helpMi picked do shellLaunch "http://www.sakaiden.com/?page_id=5883" ""
			on emailMi picked do shellLaunch "mailTo:sakaiden@live.jp" ""
			on aboutMi picked do sj_functions.sjtools_about_Fn();
			
			on menuBar update do
			(
				 reduceKeysMi.caption = "a";
			);
		)
		menuBar.modInst = this;
		return menuBar;
	)

--////////////////////////////////////////////////
--�N�����̃A�b�v�f�[�g
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--load default
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--save default
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--save �u�b�N�}�[�N
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--load �u�b�N�}�[�N
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--merge �u�b�N�}�[�N
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--�u�b�N�}�[�N�����Z�b�g
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--�u�b�N�}�[�N���X�g��؂�ւ�
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--�C���^�[�o���Z�b�g
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--���݃Z�b�g
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--editMode�A�b�v�f�[�g
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--���݂̃A�j���[�V�����L�[�Ŕ͈͂�ݒ�
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--�L�[���_�N�V����
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--�}���A���k�A���]
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--���C�A�E�g
--////////////////////////////////////////////////
	local minRange = -1e+009, maxRange = 1e+009
	local bgBitMap = openBitmap "$Scripts/SJTools/Images/SJ_timemachine_bg.bmp"
	--ImgTag backGroundImage "Bitmap" pos:[0,0] width:2400 height:24 enabled:false bitmap:bgBitMap
	--bitmap backGroundImage "" pos:[0,0] width:1600 height:24 enabled:false fileName:"$Scripts/SJTools/Images/SJ_timemachine_bg.png"
	button closeBt "X" pos:[0,0] width:16 height:24 images:#("$Scripts/SJTools/Images//SJ_timemachine03.png", "undefined", 2, 1, 1, 2, 2)
	button maxPreviewBt "�v���r���[�ݒ�" pos:[20,0] width:78 height:21 enabled:true  toolTip:"�v���r���[�ݒ�" --images:#("$Scripts/SJTools/Images//SJ_timemachine02.png", "undefined", 1, 1, 1, 1, 1);
	button createPreviewBt "�v���r���[�쐬" pos:[104,0] width:78 height:21 enabled:true  toolTip:"�v���r���[�쐬" --images:#("$Scripts/SJTools/Images//SJ_timemachine02.png", "undefined", 1, 1, 1, 1, 1);
	button maxRenamePreviewBt "�v���r���[�ۑ�" pos:[188,0] width:78 height:21 enabled:true  toolTip:"�v���r���[�ۑ�" --images:#("$Scripts/SJTools/Images//SJ_timemachine02.png", "undefined", 1, 1, 1, 1, 1);
	button maxViewPreviewBt "�v���r���[�\��" pos:[272,0] width:78 height:21 enabled:true  toolTip:"�v���r���[�ۑ�" --images:#("$Scripts/SJTools/Images//SJ_timemachine02.png", "undefined", 1, 1, 1, 1, 1);
	--button helpBt "?" pos:[20,0] width:32 height:24 enabled:true --images:#("$Scripts/SJTools/Images//SJ_timemachine02.png", "undefined", 2, 1, 1, 2, 2)

	button keyCopyBt "Key Copy" pos:[372,0] width:128 height:24 enabled:false --images:#("$Scripts/SJTools/Images//SJ_timemachine02.png", "undefined", 2, 1, 1, 2, 2)
	button keyPasteBt "Key Paste" pos:[508,0] width:128 height:24 enabled:false --images:#("$Scripts/SJTools/Images//SJ_timemachine02.png", "undefined", 2, 1, 1, 2, 2)

--////////////////////////////////////////////////
--�A�N�V����
--////////////////////////////////////////////////
	on maxPreviewBt pressed do try(max preview)catch();
	on createPreviewBt pressed do try(createPreview())catch();
	on maxRenamePreviewBt pressed do try(max renamepreview)catch();
	on maxViewPreviewBt pressed do try(max viewpreview)catch();
		
	on closeBt pressed do
	(
		try(cui.unRegisterDialogBar sj_key_Machine_rol)catch()
		try(closeRolloutFloater sj_key_Machine_rol) catch()
		try(destroydialog sj_key_Machine_rol)catch()
		try(destroydialog sj_progressBar_rol)catch()
	);--end

	--////////////////////////////////////////////////
	--Open and Close
	--////////////////////////////////////////////////
	on sj_key_Machine_rol open do
	(
		--�h�b�L���O�A�N�V����
		if (queryBox "�L�[�}�V���c�[���o�[��\n�^�C�����C���Ƀh�b�L���O���܂���?\n
Are you sure you want to dock to the bottom this toolbar to screen?" title:MesseTitleInfoStr) then
		(
		cui.RegisterDialogBar sj_key_Machine_rol style:#(#cui_dock_all,#cui_handles,#cui_floatable,#cui_max_sized);/* minSize:[5,200] style:#(#cui_max_sized );*/
		cui.DockDialogBar sj_key_Machine_rol #cui_dock_bottom;
		);--�h�b�L���O���܂�--if end
		
	)

)--rol end

-----------------------------------------------------------------------------------------------------------
-- End of rollout & Create Dialog / Floater
-----------------------------------------------------------------------------------------------------------
CreateDialog sj_key_Machine_rol width:1600 height:28/*pos:[50,50]*/ style:#(/*#style_border, #style_titlebar,#style_toolwindow, */#style_toolwindow,#style_sysmenu, #style_resizing, #style_minimizebox) /*menu:CanvasMenu menu:pbakeMenuBar*/;

--cui.RegisterDialogBar sj_key_Machine_rol style:#(#cui_dock_all,#cui_handles,#cui_floatable,#cui_max_sized);/*style:#(#cui_max_sized );--�ő�T�C�Y��*/
--cui.DockDialogBar sj_key_Machine_rol #cui_dock_bottom;--�h�b�L���O
	
)--end macroscript