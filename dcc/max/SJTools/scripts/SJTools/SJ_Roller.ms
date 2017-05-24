/*******************************************************
System J Tools 
********************************************************
Name:SJ_Roller
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
(
-----------------------------------------------------------------------------------------------------------
-- �O���[�o������
-----------------------------------------------------------------------------------------------------------
--���[���A�E�g�p
global sj_roller_rol
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
include "$scripts/SJTools/SJ_CommonLangSet.ms"

--Version etc ���O���̂�SJTools.ini����
Local nameAndVersion = (getINISetting("$scripts/SJTools/SJTools.ini")  "SJToolsToolName" "SJRollerToolName");
-----------------------------------------------------------------------------------------------------------

--�S�Ẵ��[���[�I�u�W�F�N�g	
Local allObj = #(), allObjDelay = #(), allObjTag = #(), allObjRatio = #();
-----------------------------------------------------------------------------------------------------------
-- ���[���A�E�g����
-----------------------------------------------------------------------------------------------------------
try(cui.FloatDialogBar sj_roller_rol)catch()
try(cui.unRegisterDialogBar sj_roller_rol)catch()
try(closeRolloutFloater sj_roller_rol) catch()	
try(destroydialog sj_roller_rol)catch()

-----------------------------------------------------------------------------------------------------------
--���j���[
-----------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////
--���j���[
--////////////////////////////////////////////////
rcMenu rollerMenuBar
(

subMenu "�w���v"
( 
menuItem helpMi "�w���v"
menuItem aboutMi "About"
menuItem emailMi "E-Mail"
)
/*
subMenu "�ݒ�"
( 
menuItem realTimeMi "���A���^�C��" checked:true
menuItem btUpMi "�{�^���A�b�v"
menuItem selTypeAMi "�I����" checked:true
menuItem selTypeBMi "�K�w��"
)
*/

--////////////////////////////////////////////////
--�A�N�V����
--////////////////////////////////////////////////
on closeMi  picked do
(
try(cui.unRegisterDialogBar sj_roller_rol)catch()
try(closeRolloutFloater sj_roller_rol) catch()	
try(destroydialog sj_roller_rol)catch()
)
on helpMi picked do shellLaunch "http://www.sakaiden.com/?page_id=5981" "";
on aboutMi picked do sj_functions.sjtools_about_Fn();
on emailMi picked do shellLaunch "mailTo:sakaiden@live.jp" ""

--���j���[���J�����тɎ��s�����A�b�v�f�[�g
on rollerMenuBar update do
(
)
)--rcMenu end

-----------------------------------------------------------------------------------------------------------
-- ���C�� Rollout
-----------------------------------------------------------------------------------------------------------
rollout sj_roller_rol nameAndVersion width:452 height:376
(

-----------------------------------------------------------------------------------------------------------
-- �t�@���N�V����
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-- Rot
-----------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////
--���
--////////////////////////////////////////////////
fn getRollerObj = (
	local allName = #();
	--������
	allObj = #();
	
	suspendEditing();--�T�X�y���h���[�h
	with redraw off
	(--�ĕ`��֎~
		
	for i in objects do
	(
		try(
			if (i.modifiers[1].sjRoller) do append allObj i;
		)catch();
	);
	
	--////////////////////////////////////////////////
	--���O�ŕ��ёւ�
	--////////////////////////////////////////////////
	Local myObj = #(), myObjAfter = #();
	Local selObjName = for i in allObj collect i.name;
	Local selObjIh = for i in allObj collect i.inode.handle;
		--�\�[�g
		sort selObjName;
		for i in selObjName do
		(
			--���̖��O�̃I�u�W�F�N�g�����
			myObj = getNodeByName i all:true;
			--i�n���h���Ŗ��O�̏d�����m�F
			for k in myObj do
			(
			--�������
			if (findItem selObjIh k.inode.handle) != 0 then append myObjAfter k;
			);--for end
		);--for end
		
		--print myObjAfter
		--�\�[�g���ʂ�����
		allObj = myObjAfter;
	
	);--with redraw end
	--try(destroydialog sj_progressBar_rol)catch();
	resumeEditing();--�ĂуA�N�e�B�u��
	
	--���O���m��
	allName = for i in allObj collect i.name;
	sj_roller_rol.objectLbx.items = allName;
	allName = #();
	
);--fn end
--////////////////////////////////////////////////
--�^�[�Q�b�g�����
--////////////////////////////////////////////////	
fn getRollerObjTag = (
	allName = #();
	
	for i in allObj do
	(
			if (i.modifiers[1].targetNode != undefined) and (isvalidnode i.modifiers[1].targetNode.node) then
			(
					--�I�u�W�F�N�g���L���Ȃ�
					append allName i.modifiers[1].targetNode.node.name;
			)else(
				--�L���łȂ��Ȃ�
				append allName "Undefined";
			);--if end
	);--for end
	
	--allObjTag = for i in allObj collect 
	--���O���m��
	--allName = for i in allObjTag collect i.name;
	sj_roller_rol.targetLbx.items = allName;
	allName = #();
);--fn end
--////////////////////////////////////////////////
--Delay�����
--////////////////////////////////////////////////	
fn getRollerObjDelay = (
	allName = #();

	allObjDelay = for i in allObj collect i.modifiers[1].delay;	
	allName = for i in allObjDelay collect i as String;
	sj_roller_rol.delayLbx.items = allName;
	allName = #();
);--fn end
--////////////////////////////////////////////////
--ratio�����
--////////////////////////////////////////////////	
fn getRollerObjRatio = (
	allName = #();

	allObjRatio = for i in allObj collect i.modifiers[1].ratio;	
	allName = for i in allObjRatio collect i as String;
	sj_roller_rol.ratioLbx.items = allName;
	allName = #();
);--fn end
--Local allObj = #(), allObjDelay = #(), allObjTag = #(), allObjRatio = #();

--////////////////////////////////////////////////
--���C�A�E�g
--////////////////////////////////////////////////
	MultiListBox objectLbx "Object" pos:[16,16] width:128 height:16;
	MultiListBox targetLbx "Target" pos:[148,16] width:128 height:16;
	MultiListBox delayLbx "Delay" pos:[280,16] width:76 height:16;
	MultiListBox ratioLbx "Ratio" pos:[360,16] width:76 height:16;
	groupBox grp1 "" pos:[8,4] width:436 height:364;

	button allSelBt "���X�g�S�I��" pos:[16,252] width:128 height:20;
	pickButton pickBt "�^�[�Q�b�g��I��" pos:[148,252] width:108 height:20;
	button delBt "X" pos:[256,252] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_delete.png", "$Scripts/SJTools/Images//SJ_button_delete_a.png", 2, 1, 1, 2, 2) toolTip:"�폜"
	spinner delaySpn "" pos:[280,252] width:76 height:20 range:[-1e+006,1e+006,0];
	spinner ratioSpn "" pos:[360,252] width:76 height:20 range:[-1e+006,1e+006,0];

	groupBox grp2 "Info" pos:[16,274] width:420 height:72;
	label infoLbl "�ҏW" pos:[24,286] width:400 height:48;
	hyperLink  infoHl "www.sakaiden.com" pos:[24,327] width:400 height:16 address:"http://www.sakaiden.com/?p=7682";
	
	local resizeBitMap = openBitmap "$Scripts/SJTools/Images/SJ_button_resize.png"
	ImgTag resizeImg "Bitmap" pos:[442,366] width:10 height:10 enabled:false bitmap:resizeBitMap transparent:(color 255 255 255);

-----------------------------------------------------------------------------------------------------------
-- �A�N�V����
-----------------------------------------------------------------------------------------------------------
	--////////////////////////////////////////////////
	--�����C�x���g
	--////////////////////////////////////////////////
	on objectLbx selectionEnd do ratioLbx.selection = delayLbx.selection = targetLbx.selection = objectLbx.selection;
	on targetLbx selectionEnd do delayLbx.selection = objectLbx.selection = ratioLbx.selection = targetLbx.selection;
	on ratioLbx selectionEnd do delayLbx.selection = targetLbx.selection = objectLbx.selection = ratioLbx.selection;
	on delayLbx selectionEnd do ratioLbx.selection = targetLbx.selection = objectLbx.selection = delayLbx.selection;
	on allSelBt pressed do
	(
		local tempArray = #{};
		for i = 1 to objectLbx.items.count do
		(
			append tempArray i
		);--for end
		ratioLbx.selection = delayLbx.selection = targetLbx.selection = objectLbx.selection = tempArray;
	);--end
	--on allSelBt pressed do select allObj;
	--�I�u�W�F�N�g�I��
	on objectLbx doubleClicked index do select allObj[index];
	
	on pickBt picked obj do
	(
		for i in targetLbx.selection do
		(
			allObj[i].modifiers[1].targetNode = undefined;
			allObj[i].modifiers[1].targetNode = (nodeTransformMonitor node:obj forwardTransformChangeMsgs:false);
			getRollerObjTag();
		);--for end
	);

	on pickBt picked obj do
	(
		for i in targetLbx.selection do
		(
			allObj[i].modifiers[1].targetNode = undefined;
			allObj[i].modifiers[1].targetNode = (nodeTransformMonitor node:obj forwardTransformChangeMsgs:false);
			getRollerObjTag();
		);--for end
	);
	
	on delBt pressed do
	(
		for i in targetLbx.selection do
		(
			allObj[i].modifiers[1].targetNode = undefined;
			getRollerObjTag();
		);--for end
	);
	
	--���l����
	on delaySpn changed val inSpin do
	(
		--inSpine�͎g��Ȃ�
		for i in delayLbx.selection do
		(
			allObj[i].modifiers[1].delay = val;
			getRollerObjDelay();
		);--for end
	);--for end
	on ratioSpn changed val inSpin do
	(
		--inSpine�͎g��Ȃ�
		for i in ratioLbx.selection do
		(
			allObj[i].modifiers[1].ratio = val;
			getRollerObjRatio();
		);--for end
	);--for end
	--���l����
	on delaySpn entered val inSpin do
	(
		--inSpine�͎g��Ȃ�
		for i in delayLbx.selection do
		(
			allObj[i].modifiers[1].delay = delaySpn.value;
			getRollerObjDelay();
		);--for end
	);--for end
	on ratioSpn entered val inSpin do
	(
		--inSpine�͎g��Ȃ�
		for i in ratioLbx.selection do
		(
			allObj[i].modifiers[1].ratio = ratioSpn.value;
			getRollerObjRatio();
		);--for end
	);--for end
	
	on sj_roller_rol open do
	(
		infoLbl.caption = "�ҏW�Ώۂ�Objects�̃��X�g����I�����A�e���ڂ̉�������ҏW���܂�
���ڂ͕����I���\�ł�
�f�B���C�ݒ�I�u�W�F�N�g�͉��L�̃T���v���V�[��������������"
	--�擾
	getRollerObj();
	getRollerObjTag();
	getRollerObjDelay();
	getRollerObjRatio();
		
	);

	on sj_roller_rol close do
	(

	--gc();
	);
	
	--////////////////////////////////////////////////
	--���T�C�Y�C�x���g
	--////////////////////////////////////////////////
	on sj_roller_rol resized val do
	(
	--������
		local width = val[1] - 452;
		local height = val[2] - 376;

		--�傫�������̑傫���𒴂��Ă����
		if ((sj_roller_rol.width >= 452) and (sj_roller_rol.height >= 376)) then
		(
			grp1.width = val[1] - 16;
			grp1.height = val[2] - 12;
			
			objectLbx.width = 128 + width/2.0;
			targetLbx.width = 128 + width/2.0;
			
			objectLbx.height = 214 + height;
			targetLbx.height = 214 + height;
			delayLbx.height = 214 + height;
			ratioLbx.height = 214 + height;
			
			targetLbx.pos = [148 + width/2.0,32 ];
			delayLbx.pos = [280 + width,32 ];
			ratioLbx.pos= [360 + width,32 ];
			
			allSelBt.pos = [16,val[2]-124];
			pickBt.pos = [148 + width/2.0,val[2]-124];
			delBt.pos = [256 + width/2.0,val[2]-124];
			delaySpn.pos = [344 + width ,val[2]-124];
			ratioSpn.pos = [424 + width,val[2]-124];
			
			--info�n
			grp2.pos = [16,val[2]-102];
			infoLbl.pos = [24,val[2]-90];
			infoHl.pos = [24,val[2]-52];
			
			--���T�C�Y�C���[�W�̈ʒu
			resizeImg.pos = [(val[1]-10),(val[2]-10)];
			
		)else
		(
			/*
			sj_roller_rol.width = 452;
			sj_roller_rol.height = 376;
			*/
		);--if end
		
	);--event end
	
)--rollout end
createDialog sj_roller_rol menu:rollerMenuBar /*bgColor:[0,0,0]*/ style:#(#style_border, /*#style_titlebar,*/#style_toolwindow, #style_sysmenu, #style_resizing, #style_minimizebox) menu:CanvasMenu

)--end macroscript