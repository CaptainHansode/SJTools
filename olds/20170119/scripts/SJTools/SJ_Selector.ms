/*******************************************************
System J Tools 
********************************************************
Name:SJ_Selector
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/

(

-----------------------------------------------------------------------------------------------------------
-- �O���[�o������
-----------------------------------------------------------------------------------------------------------
global sj_selector_rol --���[���A�E�g�p
global sj_selector_rol_pos = #(50,50) --���[���A�E�g�ʒu�m�ۗp
global sj_selector_node = undefined;--�A�N�^�[�m�ۂ�selectorRig�Ɉ����n��
global sj_selector_isopened = true;--�Z���N�^�[�͊J�������H
--�K�v�ȃv���p�e�B�͍��E�̋r�̈ʒu�A�����A�w����̖{���A�����A�ʒu
--�ŏ��̈ʒu��������΂��Ƃ͌��Z���Ă����΂���
--global sj_selector_ui = #();--�A�N�^�[�m�ۂ�selectorRig�Ɉ����n��
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
include "$scripts/SJTools/SJ_CommonLangSet.ms"

--Version etc ���O���̂�SJTools.ini����
Local nameAndVersion = (getINISetting("$scripts/SJTools/SJTools.ini")  "SJToolsToolName" "SJSelectorToolName");
-----------------------------------------------------------------------------------------------------------

Local actorArray = #(), cameraArray = #(), tempArray = #(), tempNameArray = #();
Local check = 0, doubleName = #(), singleName = #();

-----------------------------------------------------------------------------------------------------------
-- ���[���A�E�g����
-----------------------------------------------------------------------------------------------------------
try(cui.FloatDialogBar sj_selector_rol)catch()
try(cui.unRegisterDialogBar sj_selector_rol)catch()
try(closeRolloutFloater sj_selector_rol) catch()
try(destroydialog sj_selector_rol)catch()
-----------------------------------------------------------------------------------------------------------
--���j���[
-----------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////
--���j���[
--////////////////////////////////////////////////
rcMenu selectorMenuBar
(
/*
subMenu "�t�@�C��"
(
menuItem savePoseFileMi "�ۑ�" enabled:true
menuItem loadPoseFileMi "�J��" enabled:true
menuItem mergePoseFileMi "����" enabled:true
seperator sep01
menuItem closeMi "�I��" enabled:true
)
*/
subMenu "�w���v"
( 
menuItem helpMi "�w���v"
menuItem aboutMi "About"
menuItem emailMi "E-Mail"
)
--////////////////////////////////////////////////
--�A�N�V����
--////////////////////////////////////////////////
on helpMi picked do shellLaunch "http://www.sakaiden.com/?page_id=5979" ""
on aboutMi picked do sj_functions.sjtools_about_Fn();
on emailMi picked do shellLaunch "mailTo:sakaiden@live.jp" ""
);--menu end

-----------------------------------------------------------------------------------------------------------
-- ���C�� Rollout
-----------------------------------------------------------------------------------------------------------
rollout sj_selector_rol nameAndVersion width:144 height:372
(
--���[���A�E�g�ɕϐ���ǉ�
Local old_selectorRig_rol_pos = #(50,50) --���[���A�E�g�ʒu�m�ۗp

--////////////////////////////////////////////////
--���O�Z���N�^�@��
--////////////////////////////////////////////////
fn sj_rigSelector_Fn=
(
	--UI�̒l�����肵�Ă���
	--�K�v�ȃv���p�e�B�͍��E�̋r�̈ʒu�A�����A�w����̖{���A�����A�ʒu
	--�ŏ��̈ʒu��������΂��Ƃ͌��Z���Ă����΂���
	--sj_selector_ui = #();--��[������
	
	
--��[�폜
try(cui.FloatDialogBar sj_selectorRig_rol)catch();
try(cui.unRegisterDialogBar sj_selectorRig_rol)catch();
try(closeRolloutFloater sj_selectorRig_rol) catch();
try(destroydialog sj_selectorRig_rol)catch();
	--�X�N���v�g�����s
	macros.run "SJTools" "SJ_Selector_Rig";
)--fn end
	
		
-----------------------------------------------------------------------------------------------------------
-- �t�@���N�V����
-----------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////
--�r�����h�ƃJ��������
--////////////////////////////////////////////////
fn searchActorAndCam_Fn =
(
	actorArray = #();
	cameraArray = #();
	--bip�p�̕ϐ�
	testBip = undefined;
	local tempBip = undefined;
	local tempBipArray = #();
	local tempXrefArray = #();
	
	--////////////////////////////////////////////////
	--�A�N�^�[�ƃJ���������
	for i in objects do
	(
		if (classOf i == SJ_Helper) do
		(
			append actorArray (nodeTransformMonitor node:i forwardTransformChangeMsgs:false);
			--append tempArray i;
		);--if end
		
		if (classOf i == Freecamera) do
		(
			--append cameraArray (nodeTransformMonitor node:i forwardTransformChangeMsgs:false)
			append tempArray i;
		);--if end
		
		--�^�[�Q�b�g�J������
		if (classOf i == Targetcamera)  do
		(
			--append cameraArray (nodeTransformMonitor node:i forwardTransformChangeMsgs:false)
			append tempArray i;
			append tempArray i.target;
		);--if end
		
		--V-ray�J���������
		if (classOf i == VRayDomeCamera) or (classOf i == VRayPhysicalCamera) do
		(
			--append cameraArray (nodeTransformMonitor node:i forwardTransformChangeMsgs:false)
			append tempArray i;
			--�^�[�Q�b�g�J�����̏ꍇ�Ȃ��
			if (i.target != undefined) do append tempArray i.target;
		);--if end

		--Bip������Ai��Biped���H
		if ((classOf i) == Biped_Object) do
		(
			--�}�Y�R���g���[���[�����
			tempBip = i.controller
			--���[�g�m�[�h�����
			tempBip = tempBip.rootNode
			--���߂ăm�[�h�̃R���g���[���[����
			
			--��[���ʂ̔z���nodeTransformMonitor���g�킸��
			--node�n���h��Index�𗘗p���āAIndex�l������Ȃ������ꍇ�̂�index�����
			if ((findItem tempBipArray tempBip.inode.handle) < 1) do append tempBipArray tempBip.inode.handle
		);--if end
		
	--////////////////////////////////////////////////
	--���t�@�����X�΍�
	--////////////////////////////////////////////////
		--Xref�����
		if ((classOf i) == XRefObject) do
		(
			append tempXrefArray i;
		);--if end
		
	);--for end
	
	--////////////////////////////////////////////////
	--���t�@�����X�΍�
	--////////////////////////////////////////////////
	for i in tempXrefArray do
	(
		--local tempClassName = i.GetSourceObject true
		if ((classOf (i.GetSourceObject true)) == SJ_Helper) do
		(
			append actorArray (nodeTransformMonitor node:i forwardTransformChangeMsgs:false);
			--append tempArray i;
		);--if end
		
		--Bip������Ai��Biped���H
		if ((classOf (i.GetSourceObject true)) == Biped_Object) do
		(
			--�}�Y�R���g���[���[�����
			tempBip = i.controller
			--���[�g�m�[�h�����
			tempBip = tempBip.rootNode
			--���߂ăm�[�h�̃R���g���[���[����
			
			--��[���ʂ̔z���nodeTransformMonitor���g�킸��
			--node�n���h��Index�𗘗p���āAIndex�l������Ȃ������ꍇ�̂�index�����
			if ((findItem tempBipArray tempBip.inode.handle) < 1) do append tempBipArray tempBip.inode.handle
		);--if end
		
		--if ((classOf (i.GetSourceObject true)) == Freecamera) or ((classOf (i.GetSourceObject true)) == Targetcamera) do
		if ((classOf (i.GetSourceObject true)) == Freecamera) do
		(
			--append cameraArray (nodeTransformMonitor node:i forwardTransformChangeMsgs:false)
			append tempArray i;
		);--if end
		
		--�J�����̃^�[�Q�b�g��
		if ((classOf (i.GetSourceObject true)) == Targetcamera) do
		(
			--append cameraArray (nodeTransformMonitor node:i forwardTransformChangeMsgs:false)
			append tempArray i;
			append tempArray i.target;
		);--if end
		
		--V-ray�J���������
		if ((classOf (i.GetSourceObject true)) == VRayDomeCamera) or ((classOf (i.GetSourceObject true)) == VRayPhysicalCamera) do
		(
			append tempArray i;
			--�^�[�Q�b�g�J�����̏ꍇ�Ȃ��
			if (i.target != undefined) do append tempArray i.target;
		);--if end
	);--for end
			--print tempArray
	
	--////////////////////////////////////////////////
	--Biped���Ԃ������ڂ���|����
	makeUniqueArray tempBipArray;
	--node�n���h������I�u�W�F�N�g�����
	for i in tempBipArray do
	(
		append actorArray (nodeTransformMonitor node:(maxOps.getNodeByHandle i) forwardTransformChangeMsgs:false);
	);--for end

	
	--////////////////////////////////////////////////
	--�J�����̖��O���\�[�g
	tempNameArray = for i in tempArray collect i.name;
	sort tempNameArray;

	--print tempNameArray;
	--print "��x���g���`�F�b�N";

	--////////////////////////////////////////////////
	--�J�����̖��O�̏d�����m�F
	doubleName = #();
	singleName = #();
	i = 1;
	
	--i���J�E���g�𖞂����܂�
	--���O��O��Œ��׏グ�Ă��Ԃ������̂̓_�u���l�[���A���Ԃ�Ȃ����̂̓V���O���l�[��
	while i <= tempNameArray.count do
	(
	check = 0;
	--////////////////////////////////////////////////
	--���O���`�F�b�N�A�d�����m�F�ł����z��̓X�L�b�v
		for k = (i+1) to tempNameArray.count do
		(
		--�������H�啶������������r�Ώ�
		if tempNameArray[i] == tempNameArray[k] then check += 1;
		);--for end
		
		--�`�F�b�N��������΁Ai�͎��ցA����Εʂ̕ϐ��֊i�[
		if check != 0 then
		(
			append doubleName tempNameArray[i]
			i += (check+1);
		)else(
			append singleName tempNameArray[i]
			i += 1;
		);--if end
	);--whiel end

	--////////////////////////////////////////////////
	--�ĂёI��
	cameraArray = #();
	
	--�V���O��
	for i in singleName do 
	(
		k = (getNodeByName i ignoreCase:false all:false);
		if (classOf k == Freecamera) or
		(classOf k == Targetcamera) or
		(classOf k == Targetobject) or
		(classOf k == VRayDomeCamera) or
		(classOf k == VRayPhysicalCamera) do
		(
			append cameraArray (nodeTransformMonitor node:k forwardTransformChangeMsgs:false)
		);--if end
	);--for end

	--�V���O��
	try(
	for i in singleName do 
	(
	k = (getNodeByName i ignoreCase:false all:false);
	if ((classOf (k.GetSourceObject true)) == Freecamera) or
		((classOf (k.GetSourceObject true)) == Targetcamera) or
		((classOf (k.GetSourceObject true)) == Targetobject) or
		((classOf (k.GetSourceObject true)) == VRayDomeCamera) or
		((classOf (k.GetSourceObject true)) == VRayPhysicalCamera) do
	(
		append cameraArray (nodeTransformMonitor node:k forwardTransformChangeMsgs:false)
	);--if end
	);--for end	
	)catch();
	
	--�_�u��
	for i in doubleName do 
	(
		--�啶�����������܂߈�v�������
		k = (getNodeByName i ignoreCase:false all:true);
			for j in k do(
			if (classOf j == Freecamera) or
				(classOf j == Targetcamera) or
				(classOf j == Targetobject) or
				(classOf j == VRayDomeCamera) or
				(classOf j == VRayPhysicalCamera) do
			(
				append cameraArray (nodeTransformMonitor node:j forwardTransformChangeMsgs:false)
			);--if end
		);--for end
	);--for end

	
	--�_�u��
	try(
	for i in doubleName do 
	(
		--�啶�����������܂߈�v�������
		k = (getNodeByName i ignoreCase:false all:true);
			for j in k do(
			if ((classOf (k.GetSourceObject true)) == Freecamera) or
				((classOf (k.GetSourceObject true)) == Targetcamera) or
				((classOf (k.GetSourceObject true)) == Targetobject) or
				((classOf (k.GetSourceObject true)) == VRayDomeCamera) or
				((classOf (k.GetSourceObject true)) == VRayPhysicalCamera) do
			(
				append cameraArray (nodeTransformMonitor node:j forwardTransformChangeMsgs:false)
			);--if end
		);--for end
	);--for end
	)catch();
	
	if doubleName.count != 0 then messageBox "���̂��d�����Ă���J����������܂�" title:"�x��"


	--////////////////////////////////////////////////
	--�Ō�Ƀ��X�g�ɒǉ�
	
	tempArray = #();
	
		for i in actorArray do
		(
			append tempArray i.node.name
		);
		sj_selector_rol.actorList.items = tempArray;
		tempArray = #()
		for i in cameraArray do
		(
			append tempArray i.node.name
		);
		sj_selector_rol.cameraList.items = tempArray;

	tempArray = #()	
	doubleName = #();
	singleName = #();
	tempXrefArray = #();

);--fn end

--////////////////////////////////////////////////
--���C�A�E�g
--////////////////////////////////////////////////
	GroupBox selectorGrp "Actor and Camera List" pos:[4,4] width:136 height:364

	checkbox actorFocusChk "�t�H�[�J�X" pos:[12,20] width:84 height:20
	checkbox rigSelectorChk "RIG�Z���N�^" pos:[12,36] width:108 height:20
	listbox actorList "�A�N�^�[" pos:[12,60] width:120 height:8
	button allSelectABt "A" pos:[112,56] width:20 height:20 enabled:true images:#("$Scripts/SJTools/Images//SJ_button_allsel.png", "$Scripts/SJTools/Images//SJ_button_allsel_a.png", 2, 1, 1, 2, 2) toolTip:"�S�đI��"

	checkbox camFocusChk "�t�H�[�J�X" pos:[12,190] width:84 height:20
	listbox cameraList "�J����" pos:[12,212] width:120 height:8
	button allSelectCBt "A" pos:[112,208] width:20 height:20 enabled:true images:#("$Scripts/SJTools/Images//SJ_button_allsel.png", "$Scripts/SJTools/Images//SJ_button_allsel_a.png", 2, 1, 1, 2, 2) toolTip:"�S�đI��"
	button refrechBt "���t���b�V��" pos:[12,344] width:120 height:20 enabled:true toolTip:"���X�g���ŐV�̏�ԂɍX�V" --images:#("$Scripts/SJTools/Images//SJ_button_clear.png", "$Scripts/SJTools/Images//SJ_button_clear_a.png", 2, 1, 1, 2, 2)

	local resizeBitMap = openBitmap "$Scripts/SJTools/Images/SJ_button_resize.png"
	ImgTag resizeImg "Bitmap" pos:[134,362] width:10 height:10 enabled:false bitmap:resizeBitMap transparent:(color 255 255 255);

	on actorList doubleclicked state do
	(
		try(
		select actorArray[state].node;
		sj_selector_node = actorArray[state].node;
		if actorFocusChk.checked do max zoomext sel;
		)catch();
		if rigSelectorChk.checked do sj_rigSelector_Fn();
		
	);--end

	on cameraList doubleclicked state do
	(
		try(
		select cameraArray[state].node;
		if camFocusChk.checked do max zoomext sel;
		)catch();
	);--end

	on refrechBt pressed do
	(
		suspendEditing()--�T�X�y���h���[�h
		with redraw off
		(--�ĕ`��֎~
		searchActorAndCam_Fn()
		)--with redraw end	
		resumeEditing()--�ĂуA�N�e�B�u��
	);--end

	on allSelectABt pressed do
	(
		Local allSel = #();
		for i in actorArray do append allSel i.node;
		select allSel;
		if actorFocusChk.checked do max zoomext sel;
		max zoom in 2x;
	)
	
	on allSelectCBt pressed do
	(
		--�폜�΍�ЂƂ܂�trycatch
		try(
		Local allSel = #();
		for i in cameraArray do append allSel i.node;
		select allSel;
		if camFocusChk.checked do max zoomext sel;
		)catch();
	);--end

	on sj_selector_rol open do
	(
		sj_selector_isopened = true;
		suspendEditing()--�T�X�y���h���[�h
		with redraw off
		(--�ĕ`��֎~
		searchActorAndCam_Fn()
		)--with redraw end	
		resumeEditing()--�ĂуA�N�e�B�u��
		
		callbacks.removescripts id:#SJ_Selector_Refresh; ---�R�[���o�b�N���d���o�^����Ȃ��悤�ɁA���S�΍�
		callbacks.addScript #filePostOpenProcess "sj_selector_rol.searchActorAndCam_Fn()" id:#SJ_Selector_Refresh; --���[���A�E�g���̃t�@���N�V�����𒼐ړo�^
		
	);--end
	
	on sj_selector_rol close do
	(
		sj_selector_isopened = false;
		
		---�R�[���o�b�N���d���o�^����Ȃ��悤�ɁA���S�΍�
		callbacks.removescripts id:#SJ_Selector_Refresh;
	);--end

	--////////////////////////////////////////////////
	--���T�C�Y�C�x���g
	--////////////////////////////////////////////////
	on sj_selector_rol resized val do
	(
		width = 144;
		height = 372;

		refrechBtPos = [12,344];
		refrechBtPosTemp = [12,344];
		
		if ((sj_selector_rol.width >= 144) and (sj_selector_rol.height >= 372)) do
		(
			--�������o��
			addH = val[2] - height;
			
			--���X�g�̕�
			selectorGrp.width = cameraList.width = actorList.width =  val[1] - 24;
			selectorGrp.width = selectorGrp.width + 16;
			--refrechBt.width = 30;--��H���̃v���p�e�B���˂��E�E�E

			--�����͑���������+���̑傫���A���X�g��2����̂�2�Ŋ����Ă���
			actorList.height = cameraList.height = 110 + (addH/2.0);
			selectorGrp.height = val[2] - 8;
			
			--�|�W�V������80�͓K���ɍ��킹���A�����̓A�N�^�[���X�g�Ɠ���
			camFocusChk.pos = [12,80 + actorList.height]
		
			--118�͓K���ɍ��킹��
			cameraList.pos = [12,118 + actorList.height]
			allSelectCBt.pos = [112,98 + actorList.height]
			
			refrechBtPosTemp[2] = refrechBtPos[2] + addH;
			refrechBt.pos = refrechBtPosTemp;
			
			--���T�C�Y�C���[�W�̈ʒu
			resizeImg.pos = [(val[1]-10),(val[2]-10)];
		
		);--if end
	)--end
	
	--�E�B���h�E�̈ړ����ɃO���[�o���ϐ����m��
	on sj_selector_rol moved val do
	(
		sj_selector_rol_pos[1] = val[1];
		sj_selector_rol_pos[2] = val[2];
	);--end
	 
	
)--rol end

-----------------------------------------------------------------------------------------------------------
-- End of rollout & Create Dialog / Floater
-----------------------------------------------------------------------------------------------------------
createDialog sj_selector_rol pos:[50,50] menu:selectorMenuBar /*bgColor:[0,0,0]*/ style:#(#style_border, /*#style_titlebar,*/#style_toolwindow, #style_sysmenu, #style_resizing, #style_minimizebox) menu:CanvasMenu


)--end macroscript