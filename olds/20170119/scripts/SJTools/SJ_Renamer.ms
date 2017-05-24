/*******************************************************
System J Tools 
********************************************************
Name:SJ_LayerLayer
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
(
-----------------------------------------------------------------------------------------------------------
-- �O���[�o�����[�J������
-----------------------------------------------------------------------------------------------------------
global sj_renamer_rol
global sj_rs_hitobj_rol
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
include "$scripts/SJTools/SJ_CommonLangSet.ms"
	
--��{����t�@�C��
Local language = getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJTools" "Language";
--�p�X�̐؂蕪��
if  (language == "JP") then
(
	--���{��
	Local languageFilePath = "$scripts/SJTools/SJTools_JP.ms";
)else(
	--���{��ȊO�͊�{�p��
	Local languageFilePath = "$scripts/SJTools/SJTools_EN.ms";
);
--Local languageFile = openFile (getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJTools" "LanguageFile");
Local languageFile = openFile (languageFilePath);

/*
����t�@�C���́A��xread�����StringStream�l���ړ����Ă��܂��̂�
�ݒ育�Ƃɓǂݍ��݂����邱�ƁI�I
*/
--���j���[
/*
skipToString languageFile "rcMenuFileMiStr ="
Local rcMenuFileMiStr ="(readLine languageFile);"
skipToString languageFile "rcMenuHelpMiStr ="
Local rcMenuHelpMiStr =(readLine languageFile);
*/

--�S�Ẵc�[���ŋ��ʂ̕�����
skipToString languageFile "MesseTitleInfoStr =";Local MesseTitleInfoStr = (readLine languageFile);
skipToString languageFile "MesseTitleWngStr =";Local MesseTitleWngStr = (readLine languageFile);
skipToString languageFile "MesseTitleCtnStr =";Local MesseTitleCtnStr = (readLine languageFile);
skipToString languageFile "MesseTitleErrStr =";Local MesseTitleErrStr = (readLine languageFile);
skipToString languageFile "MesseTitleChkStr =";Local MesseTitleChkStr = (readLine languageFile);

skipToString languageFile "MesseCmnErrStr =";Local MesseCmnErrStr = (readLine languageFile);
skipToString languageFile "MesseCmnChkStr =";Local MesseCmnChkStr = (readLine languageFile);
skipToString languageFile "MesseCmnFileErrStr =";Local MesseCmnFileErrStr = (readValue languageFile);
skipToString languageFile "MesseCmnProgStr =";Local MesseCmnProgStr = (readLine languageFile);--���΂炭���҂���������

--Version etc ���O���̂�SJTools.ini����
Local nameAndVersion = (getINISetting("$scripts/SJTools/SJTools.ini")  "SJToolsToolName" "SJRenamerToolName");
-----------------------------------------------------------------------------------------------------------
--�Ȃ񂩐F�X
Local allOj = #(), hitOj = #(), hitText = undefined, hitCount = 0, k = 0, NumStr = "", NameStr = "";
--�t���O
Local searchType = true

-----------------------------------------------------------------------------------------------------------
-- Rollouts
-----------------------------------------------------------------------------------------------------------
try(cui.FloatDialogBar sj_renamer_rol)catch()
try(cui.unRegisterDialogBar sj_renamer_rol)catch()
try(closeRolloutFloater sj_renamer_rol) catch()
try(destroydialog sj_renamer_rol)catch()
try(closeRolloutFloater sj_rs_hitobj_rol) catch()
try(destroydialog sj_rs_hitobj_rol)catch()
try(destroydialog sj_progressBar_rol)catch()

-----------------------------------------------------------------------------------------------------------
--���j���[
-----------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////
--���j���[
--////////////////////////////////////////////////
if  (language == "JP") then
(
rcMenu renamerMenuBar
(
	subMenu "�w���v"
	( 
	menuItem helpMi "�w���v"
	menuItem aboutMi "About"
	menuItem emailMi "E-Mail"
	seperator sepChangeLang;
	menuItem ChangeLangMi "����ύX(Change Language)";
	)
--////////////////////////////////////////////////
--�A�N�V����
--////////////////////////////////////////////////
	on helpMi picked do shellLaunch "http://www.sakaiden.com/?page_id=5880" ""
	on aboutMi picked do sj_functions.sjtools_about_Fn();
	on emailMi picked do shellLaunch "mailTo:sakaiden@live.jp" "";
	on ChangeLangMi	picked do sj_functions.sjtools_changeLanguage_Fn();
on poserMenuBar update do
(
)
)--rcMenu end
)else(
--////////////////////////////////////////////////
--�p��
rcMenu renamerMenuBar
(
	subMenu "Help"
	( 
	menuItem helpMi "Help";
	menuItem aboutMi "About";
	menuItem emailMi "E-Mail";
	seperator sepChangeLang;
	menuItem ChangeLangMi "����ύX(Change Language)";
	)
--////////////////////////////////////////////////
--�A�N�V����
--////////////////////////////////////////////////
	on helpMi picked do shellLaunch "http://www.sakaiden.com/?page_id=5880" ""
	on aboutMi picked do sj_functions.sjtools_about_Fn();
	on emailMi picked do shellLaunch "mailTo:sakaiden@live.jp" "";
	on ChangeLangMi	picked do sj_functions.sjtools_changeLanguage_Fn();
on poserMenuBar update do
(
)
)--rcMenu end
);--if end
-----------------------------------------------------------------------------------------------------------
-- ���C�� Rollout
-----------------------------------------------------------------------------------------------------------
rollout sj_renamer_rol nameAndVersion width:200 height:676;
(
-----------------------------------------------------------------------------------------------------------
-- �t�@���N�V����
-----------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////
--��������
--////////////////////////////////////////////////
fn hitSelList_Fn=
(
	global sj_rs_hitobj_rol
	try (destroydialog sj_rs_hitobj_rol) catch()
		
		rollout sj_rs_hitobj_rol ((hitOj.count as string) + "��������܂���" + "  ��������") width:200 height:336
		(
			Local OjNameTemp = #(), NumStr = "", k = 0;
			
			--////////////////////////////////////////////////
			--���C�A�E�g
			--////////////////////////////////////////////////
				listBox hitOjList "9999��������܂���" pos:[8,8] width:184 height:17;
				label info2 "�_�u���N���b�N�őI���ł��܂�" pos:[8,256] width:184 height:16;
				button allSelBt "�S�đI��" pos:[16,276] width:80 height:24 toolTip:"���ڑS�Ă�I�����܂�";
				button closeBt "����" pos:[104,276] width:80 height:24 toolTip:"���̃E�B���h�E����܂�";
				button numberingBt "����ɘA�Ԃ�t����" pos:[16,308] width:168 height:24 toolTip:"�S�Ă̍��ڂ̌���ɘA�Ԃ�t���܂�";
				
			local resizeBitMap = openBitmap "$Scripts/SJTools/Images/SJ_button_resize.png"
			ImgTag resizeImg "Bitmap" pos:[190,326] width:10 height:10 enabled:false bitmap:resizeBitMap transparent:(color 255 255 255);
			
			
			--////////////////////////////////////////////////
			--�A�N�V����
			--////////////////////////////////////////////////			
			on sj_rs_hitobj_rol open do --���[���A�E�g���J�����Ƃ�
			(
				OjNameTemp = #()
				for i=1 to hitOj.count do append OjNameTemp (hitOj[i].name as String)
				hitOjList.items = OjNameTemp
				sj_rs_hitobj_rol.hitOjList.caption = (hitOj.count as string) + "��������܂���";			
			)--open do end

			--////////////////////////////////////////////////
			--�_�u���N���b�N
			--////////////////////////////////////////////////	
			on hitOjList doubleclicked s do --�_�u���N���b�N�Ŏ��s����C�x���g�n���h��
			(
			clearSelection()
			try(selectMore hitOj[s])catch(messageBox("�I���������O�̃I�u�W�F�N�g������܂���!"))
			)--end

			--////////////////////////////////////////////////
			--�S�đI��
			--////////////////////////////////////////////////
			on allSelBt pressed do
			(
			suspendEditing()--�T�X�y���h���[�h
			with redraw off
			(--�ĕ`��֎~
			
			sj_functions.sj_progressBar_Fn()
			sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
			clearSelection()
			 	k = 1;
			 	for i in hitOj do--�I���e�X�g�J�n
				 (
					try(selectMore i)catch(
					messageBox("�I�u�W�F�N�g���V�[����ɂ���܂���")
					)
				k += 1;
				sj_progressBar_rol.progbar.value = ((100.00/hitOj.count) * k);
				)--for end
				sj_progressBar_rol.progbar.value = 0
				try(destroydialog sj_progressBar_rol)catch()
				
			)--with redraw end	
			resumeEditing()--�ĂуA�N�e�B�u��
			)--end

			--////////////////////////////////////////////////
			--�i���o�����O
			--////////////////////////////////////////////////
			on numberingBt pressed do
			(
	suspendEditing()--�T�X�y���h���[�h
	with redraw off
	(--�ĕ`��֎~
			
			sj_functions.sj_progressBar_Fn()
			sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
				OjNameTemp = #()
			 	k = 1;
			 	for i in hitOj do--�I���e�X�g�J�n
				 (
					NumStr = (k as String);
					if NumStr.count == 1 then NumStr = ( "0"+ NumStr );
					
					try(
						i.name = i.name + "_" + NumStr;
						append OjNameTemp (i.name as String)
					)
					catch
					(
					messageBox("�I�u�W�F�N�g���V�[����ɂ���܂���")
					)
				sj_progressBar_rol.progbar.value = ((100.00/hitOj.count) * k);
				k += 1;
				)--for end
				sj_progressBar_rol.progbar.value = 0
				try(destroydialog sj_progressBar_rol)catch()
				hitOjList.items = OjNameTemp
				--try (destroydialog rs_hitobj_rol) catch() --�_�C�A���O�����
	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
			)--end
			
			--////////////////////////////////////////////////
			--�L�����Z��
			--////////////////////////////////////////////////
			on closeBt pressed do
			(
				try (destroydialog sj_rs_hitobj_rol) catch() --�_�C�A���O�����
			)--end
			
	--////////////////////////////////////////////////
	--���T�C�Y�C�x���g
	--////////////////////////////////////////////////
	on sj_rs_hitobj_rol resized val do
	(
	/*
				listBox hitOjList "9999��������܂���" pos:[8,8] width:184 height:17
				label info2 "�_�u���N���b�N�őI���ł��܂�" pos:[8,256] width:184 height:16
				button  "�S�đI��" pos:[16,276] width:80 height:24
				button  "����" pos:[104,276] width:80 height:24
				button numberingBt "����ɘA�Ԃ�t����" pos:[16,308] width:168 height:24
	*/
		
		width = 200;
		height = 336;
		
		--val�����T�C�Y���̑傫��
		--1����
		--print val;
		listWidth = 184;
		listHeight = 98;
		
		posTemp = [16,276];
		posTempB = [104,276];
		
		if ((sj_rs_hitobj_rol.width >= 200) and (sj_rs_hitobj_rol.height >= 336)) then
		(
			ratioW = (val[1] as float) / (width as float);
			ratioH = (val[2] as float) / (height as float);
			
			hitOjList.width = val[1] - 16;
			hitOjList.height = val[2] - 110;

			posTemp[2] = val[2] - 82;
			
			info2.pos = posTemp;
			
			--posTemp = val[2] - height;
			posTempB[2] = posTemp[2] = val[2] - 62;
			
			allSelBt.pos = posTemp;
			closeBt.pos = posTempB;
			
			posTemp[2] = val[2] - 30;
			numberingBt.pos = posTemp;
			
			--���T�C�Y�C���[�W�̈ʒu
			resizeImg.pos = [(val[1]-10),(val[2]-10)];
			
		)
		else
		(
		sj_rs_hitobj_rol.width = 200;
		sj_rs_hitobj_rol.height = 336;
		);--if end

		
	)--end			
			
			
			
		)--rollout rs_hitobj_rol

		--////////////////////////////////////////////////
		--�_�C�A���O�N���G�[�g
		--////////////////////////////////////////////////	
		CreateDialog sj_rs_hitobj_rol /*pos:[sj_renamer_rol.pos[1],sj_renamer_rol.pos[2]]*/ style:#(#style_border, #style_titlebar, #style_sysmenu, #style_minimizebox, #style_resizing, #style_toolwindow) --pos:[50,50]
)--fn end

--////////////////////////////////////////////////
--�V�K���O
--////////////////////////////////////////////////
fn newName_Fn =
(
suspendEditing()--�T�X�y���h���[�h
with redraw off
(--�ĕ`��֎~
	sj_functions.sj_progressBar_Fn()
	sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
	
	if sj_renamer_rol.newNameEdt.text != "" then
	(NameStr = sj_renamer_rol.newNameEdt.text)else(NameStr = "Empty");
	
	--���̐ݒ�
	NumStr = "";
	k = 0;
	digitNum = sj_renamer_rol.newNameSpn3.value;
	
	if sj_renamer_rol.withNumberChk.checked then
	(
		--��x���
		NumStr = (sj_renamer_rol.newNameSpn1.value as String);
		
		for i in selection do
		(
			--���������������
			NumStr = ((sj_renamer_rol.newNameSpn1.value + (k*sj_renamer_rol.newNameSpn2.value)) as String);
			
			--���͑���Ă��邩?
			while ( NumStr.count < digitNum) do NumStr = ("0" + NumStr);
			--if NumStr.count < digitNum
			--if NumStr.count == 1 then NumStr = ("0" + NumStr);
			
			--���O������
			if sj_renamer_rol.addNumberChk.checked then
			(i.name = i.name + NumStr)else(i.name = NameStr + NumStr);
			
			--�v���O���X
			sj_progressBar_rol.progbar.value = ((100.00/selection.count) * k);
			k += 1;
		);--for end
		
	)else(
		for i in selection do
		(
			i.name = NameStr;
			sj_progressBar_rol.progbar.value = ((100.00/selection.count) * k);
			k += 1;
		);--for end
	);--if end

	try(destroydialog sj_progressBar_rol)catch()
)--with redraw end	
resumeEditing()--�ĂуA�N�e�B�u��
);--fn end
--////////////////////////////////////////////////
--�u��
--////////////////////////////////////////////////
fn replaceName_Fn =
(
	suspendEditing()--�T�X�y���h���[�h
	with redraw off
	(--�ĕ`��֎~
	
	sj_functions.sj_progressBar_Fn()
	sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
	hitText = undefined
		if sj_renamer_rol.beforeEdt.text != "" then
		(
			k = 1;
			for i in selection do	--s����n�܂�I���̐������I�i���̂Ƃ���s�Ƃ����ϐ����錾����Ă��܂��j
			(
				hitText = findString i.name sj_renamer_rol.beforeEdt.text	--a�ɑI���I�u�W�F�N�g���當�����T��
				if hitText != undefined then	--����������������I�i��������undefind�łȂ���΁j
				(
					i.name = replace i.name hitText sj_renamer_rol.beforeEdt.text.count sj_renamer_rol.afterEdt.text	--hitText�����ڂ���xx�������܂ł�u�������܂�
				)--if end
			sj_progressBar_rol.progbar.value = ((100.00/selection.count) * k)
			k += 1;
			)--for end
		sj_progressBar_rol.progbar.value = 0
		try(destroydialog sj_progressBar_rol)catch()
		)
		else
		(
			try(destroydialog sj_progressBar_rol)catch()
			messageBox("���������񂪋�ł�!")
		)--if end
		
	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
);--for end
--////////////////////////////////////////////////
--�v���t�B�b�N�X
--////////////////////////////////////////////////
fn prefixName_Fn =
(
	suspendEditing()--�T�X�y���h���[�h
	with redraw off
	(--�ĕ`��֎~
	
	sj_functions.sj_progressBar_Fn()
	sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
		if sj_renamer_rol.multiNameEdt.text != "" then	--�����񂪋󂩂ǂ����H
		(
			for i=1 to selection.count do
			(
				selection[i].name = sj_renamer_rol.multiNameEdt.text + selection[i].name	--������u�������܂�
				sj_progressBar_rol.progbar.value = ((100.00/selection.count) * i)
			)--for end
		sj_progressBar_rol.progbar.value = 0
		try(destroydialog sj_progressBar_rol)catch()
		)
		else
		(
			try(destroydialog sj_progressBar_rol)catch()
			messageBox("���������񂪋�ł�!")
		)--if end
		
	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
);-- end
--////////////////////////////////////////////////
--�T�t�B�b�N�X
--////////////////////////////////////////////////
fn suffixName_Fn =
(
	suspendEditing()--�T�X�y���h���[�h
	with redraw off
	(--�ĕ`��֎~
	
	sj_functions.sj_progressBar_Fn()
	sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
		if sj_renamer_rol.multiNameEdt.text != "" then
		(
			for i=1 to selection.count do --s����n�܂�I���̐������I�i���̂Ƃ���s�Ƃ����ϐ����錾����Ă��܂��j
			(
				selection[i].name = selection[i].name + sj_renamer_rol.multiNameEdt.text	--������u�������܂�
				sj_progressBar_rol.progbar.value = ((100.00/selection.count) * i)
			)--for end
		sj_progressBar_rol.progbar.value = 0
		try(destroydialog sj_progressBar_rol)catch()
		)
		else
		(
			try(destroydialog sj_progressBar_rol)catch()
			messageBox("���������񂪋�ł�!")
		)--if end
		
	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
);--end

--////////////////////////////////////////////////
--n�Ԗڃv���t�B�b�N�X
--////////////////////////////////////////////////
fn nPrefixName_Fn =
(
	suspendEditing()--�T�X�y���h���[�h
	with redraw off
	(--�ĕ`��֎~
	
	sj_functions.sj_progressBar_Fn()
	sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
		if sj_renamer_rol.multiNameEdt.text != "" then	--�����񂪋󂩂ǂ����H
		(
			k = selection.count;
			j = 0;
			errorCount = 0;
			nNum = sj_renamer_rol.nNumberSpn.value;
			for i in selection do
			(
				--�擪����n�Ԗڂ܂ł̕������i�[
				tempStrA = substring i.name 1 nNum;--1�`�w�萔�܂�
				tempStrB = substring i.name (nNum+1) -1;--�w�萔����Ō�܂�
				i.name = tempStrA + sj_renamer_rol.multiNameEdt.text + tempStrB;--�����������
				sj_progressBar_rol.progbar.value = ((100.00/k) * j)
				j += 1;
			);--for end
		sj_progressBar_rol.progbar.value = 0
		
		try(destroydialog sj_progressBar_rol)catch()
		)
		else
		(
			try(destroydialog sj_progressBar_rol)catch()
			messageBox("���������񂪋�ł�!")
		)--if end
		
		if (errorCount != 0) then (messageBox("�������̖��O�̕ύX�Ɏ��s���Ă��܂�"))
		
	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
);-- end
--////////////////////////////////////////////////
--n�ԖڃT�t�B�b�N�X
--////////////////////////////////////////////////
fn nSuffixName_Fn =
(
	suspendEditing()--�T�X�y���h���[�h
	with redraw off
	(--�ĕ`��֎~
	
	sj_functions.sj_progressBar_Fn()
	sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
		if sj_renamer_rol.multiNameEdt.text != "" then	--�����񂪋󂩂ǂ����H
		(
			k = selection.count;
			j = 0;
			errorCount = 0;
			nNum = sj_renamer_rol.nNumberSpn.value;
			for i in selection do
			(
				--�w�蕶�����𒴂��Ă�����
				if (i.name.count < nNum) then
				(
					--���O�ȏ�̐��l���ݒ肳��Ă�����A�擪�ɒǉ����邾���ł悢
					i.name = sj_renamer_rol.multiNameEdt.text + i.name;
				)
				else
				(
					--�擪����n�Ԗڂ܂ł̕������i�[
					tempStrA = substring i.name 1 (i.name.count - nNum);--1�����ڂ���`�w�蕶���܂�
					tempStrB = substring i.name (i.name.count - nNum+1) -1;--�w�萔����`�Ō�܂�
					i.name = tempStrA + sj_renamer_rol.multiNameEdt.text + tempStrB;--�����������
					sj_progressBar_rol.progbar.value = ((100.00/k) * j)
					j += 1;
				);--if end
			);--for end
		sj_progressBar_rol.progbar.value = 0
		
		try(destroydialog sj_progressBar_rol)catch()
		)
		else
		(
			try(destroydialog sj_progressBar_rol)catch()
			messageBox("���������񂪋�ł�!")
		)--if end
		
		if (errorCount != 0) then (messageBox("�������̖��O�̕ύX�Ɏ��s���Ă��܂�"))

		
	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
);--end

--////////////////////////////////////////////////
--�폜
--////////////////////////////////////////////////
fn deleteName_Fn =
(
	suspendEditing()--�T�X�y���h���[�h
	with redraw off
	(--�ĕ`��֎~
	
	sj_functions.sj_progressBar_Fn()
	sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
	hitText = undefined
		if sj_renamer_rol.multiNameEdt.text != "" then
		(
			for i=1 to selection.count do
			(
				hitText = findString selection[i].name sj_renamer_rol.multiNameEdt.text	--a�ɑI���I�u�W�F�N�g���當�����T���܂�
				if hitText != undefined then	--����������������I�i��������undefind�łȂ���΁j
				(
					selection[i].name = replace selection[i].name hitText sj_renamer_rol.multiNameEdt.text.count ""--������u�������܂�
				)
				sj_progressBar_rol.progbar.value = ((100.00/selection.count) * i)
			)--for end
		sj_progressBar_rol.progbar.value = 0
		try(destroydialog sj_progressBar_rol)catch()
		)
		else
		(
			try(destroydialog sj_progressBar_rol)catch()
			messageBox("���������񂪋�ł�!")
		)--if end
		
	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
);-- end
--////////////////////////////////////////////////
--����
--////////////////////////////////////////////////
fn searchName_Fn =
(
	suspendEditing()--�T�X�y���h���[�h
	with redraw off
	(--�ĕ`��֎~
	
	sj_functions.sj_progressBar_Fn()
	sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
	
	try (destroydialog sj_rs_hitobj_rol) catch() --�_�C�A���O�����
	hitOj = #()
	
	if sj_renamer_rol.searchNameEdt.text != "" then
	(
	allOj = for i in objects collect i --�I�u�W�F�N�g�̐������I�u�W�F�N�g���e�����W
		k = 1;
		for i in allOj do
		(
			if (findString (i.name as String) sj_renamer_rol.searchNameEdt.text) != undefined do append hitOj i
			sj_progressBar_rol.progbar.value = ((100.00/allOj.count) * k)
			k += 1;
		)--for end

	sj_progressBar_rol.progbar.value = 0
	try(destroydialog sj_progressBar_rol)catch()

		if hitOj.count != 0 then
		(
			hitSelList_Fn()
		)
		else
		(
			messageBox("������܂���ł���") title:"��������"
		)--if end

	)else
	(
		try(destroydialog sj_progressBar_rol)catch()
		messageBox("���������񂪋�ł�!")
	)--if end
	
	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
);-- end

--////////////////////////////////////////////////
--�߂����O
--////////////////////////////////////////////////
fn similarSearchBt_Fn =
(
	Local resultList = #();
	Local tempObj = #();
	hitOj = #();
	
	try (destroydialog sj_rs_hitobj_rol) catch() --�_�C�A���O�����
	allOj = for i in objects collect i.name --�I�u�W�F�N�g�̐������I�u�W�F�N�g���e�����W
	--���背�x��2�Ŏ��s
	resultList = sj_functions.sj_searchSimilarStrings_Fn sj_renamer_rol.searchNameEdt.text allOj 3;
	
	--���Ԃ��Ă�����̂�r��
	resultList = makeUniqueArray resultList;
	--print resultList;
	
	--���O�őI������hitOj�Ɋi�[
	for i in resultList do
	(
		--��������z��ɉ��
		tempObj = (getNodeByName i exact:false ignoreCase:false all:true);
		for u in tempObj do append hitOj u;
	);--for end
	
		if hitOj.count != 0 then
		(
			temp
			hitSelList_Fn()
		)
		else
		(
			messageBox("������܂���ł���") title:"��������"
		)--if end
	
	--�N���A
	allOj = undefined;
	gc();

)

--////////////////////////////////////////////////
--�_�u���l�[��
--////////////////////////////////////////////////
fn doubleNameName_Fn =
(
	suspendEditing()--�T�X�y���h���[�h
	with redraw off
	(--�ĕ`��֎~
	
	sj_functions.sj_progressBar_Fn()
	sj_progressBar_rol.processInfo.caption = "���΂炭���҂���������"
	
	try (destroydialog sj_rs_hitobj_rol) catch() --�_�C�A���O�����

	allOj = for i in objects collect i --�I�u�W�F�N�g�̐������I�u�W�F�N�g���e�����W
	hitOj = #()
	hitCount = 0
		k = 1;
		for i in allOj do
		(
		hitCount = 0
			for u in allOj do
			(
			if (matchPattern i.name pattern:u.name ignoreCase:SearchType) == true do hitCount += 1;
			)--for end
		if hitCount > 1 do append hitOj i --�J�E���g��2�ȏゾ������
		
		sj_progressBar_rol.progbar.value = ((100.00/allOj.count) * k)
		k += 1;
		)--for end

	sj_progressBar_rol.progbar.value = 0
	try(destroydialog sj_progressBar_rol)catch()

		if hitOj.count != 0 then
		(
			hitSelList_Fn()
		)
		else
		(
			messageBox("������܂���ł���") title:"��������"
		)--if end

	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
);--end


--////////////////////////////////////////////////
--������
--////////////////////////////////////////////////
fn initialize_Fn = (
	sj_renamer_rol.newNameEdt.text = (getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "LastKeyWordNews");
	sj_renamer_rol.beforeEdt.text = (getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "LastKeyWordReplaceA");
	sj_renamer_rol.afterEdt.text = (getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "LastKeyWordReplaceB");
	sj_renamer_rol.multiNameEdt.text = (getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "LastKeyWordAdd");
	sj_renamer_rol.searchNameEdt.text = (getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "LastKeyWordSearch");
	sj_renamer_rol.newNameSpn1.value = execute(getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "BaseNumber");
	sj_renamer_rol.newNameSpn2.value = execute(getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "Steps");
	sj_renamer_rol.newNameSpn3.value = execute(getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "Digit");
	sj_renamer_rol.nNumberSpn.value = execute(getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "nNumber");
	
	sj_renamer_rol.withNumberChk.checked = execute(getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "Numbering");
	sj_renamer_rol.addNumberChk.checked = execute(getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "OnlyNumbering");

		--ui��ݒ�
		if (sj_renamer_rol.withNumberChk.checked) then
		(
			sj_renamer_rol.baseNoLbl.enabled  = true;
			sj_renamer_rol.stepLbl.enabled  = true;
			sj_renamer_rol.digitLbl.enabled  = true;
			sj_renamer_rol.newNameSpn1.enabled  = true;
			sj_renamer_rol.newNameSpn2.enabled  = true;
			sj_renamer_rol.newNameSpn3.enabled  = true;
			sj_renamer_rol.addNumberChk.enabled = true;
		)
		else
		(
			sj_renamer_rol.baseNoLbl.enabled  = false;
			sj_renamer_rol.stepLbl.enabled  = false;
			sj_renamer_rol.digitLbl.enabled  = false;
			sj_renamer_rol.newNameSpn1.enabled  = false;
			sj_renamer_rol.newNameSpn2.enabled  = false;
			sj_renamer_rol.newNameSpn3.enabled  = false;
			sj_renamer_rol.addNumberChk.enabled = false;
		);--if end
		
		--ui��ݒ�
		if (sj_renamer_rol.addNumberChk.checked) then
		(
			sj_renamer_rol.basenameLbl.enabled = false;
			sj_renamer_rol.newNameEdt.enabled = false;
		)else
		(
			sj_renamer_rol.basenameLbl.enabled = true;
			sj_renamer_rol.newNameEdt.enabled = true;
		);
-----------------------------------------------------------------------------------------------------------
-- UI��ݒ�
-----------------------------------------------------------------------------------------------------------
	--�ݒ肷�郍�[���A�E�g
	local rol = sj_renamer_rol
	languageFile = openFile(languageFilePath);
	skipToString languageFile "[SJ_Renamer.ms]";--�K���Ώۂ̃c�[���܂ň�x��΂�
	skipToString languageFile "similarSearchBt =";
	rol.similarSearchBt.caption = (readLine languageFile);
	skipToString languageFile "toolTip =";
	rol.similarSearchBt.tooltip = (readLine languageFile);
	--Local similarSearchBtStr = (readLine languageFile);
	--print similarSearchBtStr

);--end

--////////////////////////////////////////////////
--�ݒ��ۑ�
--////////////////////////////////////////////////
fn saveIni_Fn = (
	(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "LastKeyWordNews" sj_renamer_rol.newNameEdt.text);
	(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "LastKeyWordReplaceA" sj_renamer_rol.beforeEdt.text);
	(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "LastKeyWordReplaceB" sj_renamer_rol.afterEdt.text);
	(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "LastKeyWordAdd" sj_renamer_rol.multiNameEdt.text);
	(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "LastKeyWordSearch" sj_renamer_rol.searchNameEdt.text);
	(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "BaseNumber" ((sj_renamer_rol.newNameSpn1.value) as String));
	(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "Steps" ((sj_renamer_rol.newNameSpn2.value) as String));
	(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "Digit" ((sj_renamer_rol.newNameSpn3.value) as String));
	(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "nNumber" ((sj_renamer_rol.nNumberSpn.value) as String));

	
		(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "Numbering" ((sj_renamer_rol.withNumberChk.checked) as String));
		(setINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJRenamer" "OnlyNumbering" ((sj_renamer_rol.addNumberChk.checked) as String));
);--end

--////////////////////////////////////////////////
--���C�A�E�g
--////////////////////////////////////////////////
	GroupBox grp1 "�V�K" pos:[8,8] width:184 height:188
	label basenameLbl "��{�̖��O" pos:[16,28] width:164 height:16
	edittext newNameEdt "" pos:[12,44] width:172 height:16
	checkbox withNumberChk "�ԍ��t��" pos:[16,66] width:82 height:16 checked:true toolTip:"��{�ɘA�Ԃ�ǉ����܂�";
	checkbox addNumberChk "�A�Ԃ���" pos:[104,66] width:86 height:16 checked:false toolTip:"��{��t�����A�Ԃ����ǉ����܂�";
	label baseNoLbl "��{�̔ԍ�" pos:[16,88] width:72 height:16
	label stepLbl "�X�e�b�v" pos:[104,88] width:72 height:16
	label digitLbl "�A�Ԃ̌���" pos:[16,124] width:72 height:16
	spinner newNameSpn1 "" pos:[16,104] width:80 height:16 range:[0,9999,1] type:#integer scale:1
	spinner newNameSpn2 "" pos:[104,104] width:80 height:16 range:[1,999,1] type:#integer scale:1
	spinner newNameSpn3 "" pos:[16,140] width:80 height:16 range:[1,12,1] type:#integer scale:1
	button newNameBt "���O��ύX" pos:[16,164] width:168 height:24 toolTip:"���O��ύX"
	
	GroupBox grp2 "�u��" pos:[8,204] width:184 height:132
	label beforLbl "����������" pos:[16,224] width:164 height:16
	edittext beforeEdt "" pos:[12,240] width:172 height:16
	label afterLbl "�u��������" pos:[16,264] width:164 height:16
	edittext afterEdt "" pos:[12,280] width:172 height:16
	button renameSubstringBt "�u��" pos:[16,304] width:168 height:24 toolTip:"��L������Œu��"

	GroupBox grp3 "�ǉ� �폜" pos:[8,344] width:184 height:176
	edittext multiNameEdt "" pos:[12,364] width:172 height:16
	button addFNameBt "�擪�ɒǉ�" pos:[16,388] width:80 height:24 toolTip:"���O�̐擪�ɒǉ����܂�"
	button addBNameBt "����ɒǉ�" pos:[104,388] width:80 height:24 toolTip:"���O�̌���ɒǉ����܂�"
	
	label nNumberLbl "n�Ԗڂɒǉ�" pos:[16,416] width:72 height:16
	spinner nNumberSpn "" pos:[16,432] width:80 height:16 range:[1,99,1] type:#integer scale:1
	button nAddFNameBt "�擪����n�Ԗ�" pos:[16,456] width:80 height:24 toolTip:"�擪����n�Ԗڂɒǉ����܂�"
	button nAddBNameBt "�������n�Ԗ�" pos:[104,456] width:80 height:24 toolTip:"�������n�Ԗڂɒǉ����܂�"
	
	button deleteNameBt "��������폜" pos:[16,488] width:168 height:24 toolTip:"�w��̕�������폜���܂�"

	GroupBox grp4 "����" pos:[8,528] width:184 height:140
	edittext searchNameEdt "" pos:[12,548] width:172 height:16
	button SearchBt "����" pos:[16,572] width:168 height:24 toolTip:"�w��̕�����Ō������܂�"
	button similarSearchBt "�߂����̂�����" pos:[16,604] width:168 height:24 enabled:true toolTip:"�w��̕�����ɋ߂����O�̃I�u�W�F�N�g���������܂�"
	button doubleNameBt "�d�����̌���" pos:[16,636] width:168 height:24 toolTip:"�V�[������d���������O���������܂�"

--////////////////////////////////////////////////
--�A�N�V����
--////////////////////////////////////////////////
	on withNumberChk changed state do
	(
		--ui��ݒ�
		if state then
		(
			baseNoLbl.enabled  = true;
			stepLbl.enabled  = true;
			digitLbl.enabled  = true;
			newNameSpn1.enabled  = true;
			newNameSpn2.enabled  = true;
			newNameSpn3.enabled  = true;
			addNumberChk.enabled = true;
		)
		else
		(
			baseNoLbl.enabled  = false;
			stepLbl.enabled  = false;
			digitLbl.enabled  = false;
			newNameSpn1.enabled  = false;
			newNameSpn2.enabled  = false;
			newNameSpn3.enabled  = false;
			addNumberChk.enabled = false;
		);--if end
		
		saveIni_Fn();
	);
	
	on addNumberChk changed state do
	(
		--ui��ݒ�
		if state then
		(
			basenameLbl.enabled = false;
			newNameEdt.enabled = false;
		)else
		(
			basenameLbl.enabled = true;
			newNameEdt.enabled = true;
		);
		
		saveIni_Fn();
	);--end

	on newNameBt pressed do newName_Fn();
	on renameSubstringBt pressed do replaceName_Fn()
	on addFNameBt pressed do prefixName_Fn()
	on addBNameBt pressed do suffixName_Fn()
	on nAddFNameBt pressed do nPrefixName_Fn()
	on nAddBNameBt pressed do nSuffixName_Fn()
	on deleteNameBt pressed do deleteName_Fn()
	on SearchBt pressed do searchName_Fn()
	on similarSearchBt pressed do similarSearchBt_Fn()
	on doubleNameBt pressed do doubleNameName_Fn()

	on newNameEdt changed txt do saveIni_Fn();
	on beforeEdt changed txt do saveIni_Fn();
	on afterEdt changed txt do saveIni_Fn();
	on multiNameEdt changed txt do saveIni_Fn();
	on searchNameEdt changed txt do saveIni_Fn();
	on newNameSpn1 changed val do saveIni_Fn();
	on newNameSpn2 changed val do saveIni_Fn();
	on newNameSpn3 changed val do saveIni_Fn();
	on newNameSpn1 changed val do saveIni_Fn();
	on nNumberSpn changed  val do saveIni_Fn();
	
	on sj_renamer_rol open do initialize_Fn();
)--rollout end

-----------------------------------------------------------------------------------------------------------
-- End of rollout & Create Dialog / Floater
-----------------------------------------------------------------------------------------------------------
CreateDialog sj_renamer_rol pos:[50,50] menu:renamerMenuBar style:#(#style_border, /*#style_titlebar,*/#style_toolwindow, #style_sysmenu, #style_resizing, #style_minimizebox) menu:CanvasMenu

)--end macroscript