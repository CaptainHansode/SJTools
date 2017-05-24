/*******************************************************
System J Tools 
********************************************************
Name:SJ_Attribute_Holder
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
----------------------------------------------------------------------
���̃v���O�C����PEN Productions Inc.��PEN_Attribute_Holder 2�̃N���[���łł�
UI��ύX�����{�ꉻ���ċ@�\�������s���Ă��܂�
Thank you! Paul Neale and PEN Productions Inc.
----------------------------------------------------------------------
*******************************************************/

global sjAHValue = #()

plugin modifier 'SJ_Attribute_Holder'
	name:"SJ_Attribute_Holder"
	classID:#(0x66b90afd, 0x335ef246)
	version:1 --�o�[�W�����Ǘ�
(
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
-----------------------------------------------------------------------------------------------------------
--��{����t�@�C��
Local languageFile = openFile (getINISetting ((getDir #scripts) + "\SJTools\SJTools.ini") "SJTools" "LanguageFile");
/*
����t�@�C���́A��xread�����StringStream�l���ړ����Ă��܂��̂�
�ݒ育�Ƃɓǂݍ��݂����邱�ƁI�I
*/
--Version etc
--skipToString languageFile "[SJ_Attribute_Holder.ms]";--�K���Ώۂ̃c�[���܂ň�x��΂�
--skipToString languageFile "SJ_Attribute_HolderNameAndVersion ="
--Local nameAndVersion = (readLine languageFile);
Local nameAndVersion = "SJ Attribute Holder";
-----------------------------------------------------------------------------------------------------------
	--Locals
	local Names = #(), Values = #(), updatePresets_Fn, presets_rol, NumStr = "01", curVals = #();

	parameters control_P 
	(
		presetName_str type:#stringTab tabSize:0 tabSizeVariable:true
		preset_str type:#stringTab tabSize:0 tabSizeVariable:true
	)
	parameters optionsP rollout:presets_rol
	(
		faderOn type:#boolean ui:faderOn_Cb default:true animatable:false
		faderValue type:#percent ui:(faderCa_Sl,faderSpn) animatable:false
	)
	
-----------------------------------------------------------------------------------------------------------
-- �t�@���N�V����
-----------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////
--�Q�b�g�A�g���r���[�g
--�A�g���r���[�g�̃p�����[�^�[���擾����
--////////////////////////////////////////////////
	fn getCaAttributes_Fn =
	(
		caDefs = #()
		caSubs = #()
		
		--Get the Defs
		caNum = (custAttributes.count this)
		for x = 1 to caNum do
		(
			append caDefs (custAttributes.get this x)
		);--for end
		
		--Get the Ca's in the Defs
		for x = 1 to cadefs.count do
		(
			for y = 1 to caDefs[x].numsubs do
			(
				append caSubs caDefs[x][y]
			);--for end
		);-- for end
		caSubs;
	);--fn end
	
--////////////////////////////////////////////////
--�v���Z�b�g��ǉ�
--////////////////////////////////////////////////
	fn addPreset_Fn =
	(
		--local presetName = presets_rol.presetName_et.text
		NumStr = (presetName_str.count as String)
		if NumStr.count == 1 then NumStr = ( "0"+ NumStr )
		local presetName = "New_Preset_" + NumStr
		local ss = stringStream ""
		
		if presetName != "" do
		(
			ca = getCaAttributes_Fn()
			format "%" "#(" to:ss
			for x = 1 to ca.count do
			(
				format "%" ca[x].value to:ss
				format "%" (if x == ca.count then (")")else (",")) to:ss
			)
			append presetName_str presetName 
			append preset_str (ss as string)
		)
		--presets_rol.presetName_et.text = ""
		updatePresets_Fn()
--		print presetName_str
--		print preset_str
	)-- end writePreset_fn
	
--////////////////////////////////////////////////
--�v���Z�b�g���폜
--////////////////////////////////////////////////
	fn deletePreset_Fn delNum =
	(
		CNTobj = (refs.dependents this)[1]
		
		deleteItem presetName_str delNum
		deleteItem preset_str delNum
		
		updatePresets_Fn()
	)--end deletePreset_fn
--////////////////////////////////////////////////
--Del
--////////////////////////////////////////////////
fn delPresetList_Fn list i = 
(
	deleteItem list i
	deleteItem presetName_str i
	deleteItem preset_str i
	--updatePresets_Fn()
)
--////////////////////////////////////////////////
--�ۑ�
--////////////////////////////////////////////////
	fn savePre_Fn =
	(
		fileName = getsavefileName caption:"�v���Z�b�g��ۑ�" filename:(this.name + ".cps") types:"(*.cps)|*.cps|All(*.*)|*.*"
		if fileName != undefined do							--Check for path
		(
			savedFile = createFile fileName					--Create the file
			close savedFile
			openedFile = openFile fileName mode:"a"
			
			for x = 1 to presetName_str.count do						--Format data to file
			(
				format "%" "**Name> " to:openedFile
				format "%%%\n" "\"" presetName_str[x] "\"" to:openedFile
				format "%" "**Value> " to:openedFile
				format "%%%\n" "\"" preset_str[x] "\"" to:openedFile
			)
			close openedFile
		)
		
	)-- end savePre_fn
--////////////////////////////////////////////////
--�ǂݍ���
--////////////////////////////////////////////////
	fn loadPre_Fn =
	(
		presetName_str = #()
		preset_str = #()
		
		fileName = getopenfileName caption:"�v���Z�b�g��ǂݍ���" types:"(*.cps)|*.cps|All(*.*)|*.*"
		
		if fileName != undefined do
		(
			openedFile = openFile fileName mode:"r"
			while (not (eof openedFile)) do
			(
				str = (readLine openedFile)
				if (filterString str ">")[1] == "**Name" do
				(
					append presetName_str (filterString str ">\" ")[2]
				)
				if (filterString str ">")[1] == "**Value" do
				(
					append preset_str (filterString str ">\" ")[2]
				)
			)
--			print presetName_str
--			print preset_str
			close openedFile
			
			updatePresets_Fn()
		)
		
	)-- end loadPre_fn
--////////////////////////////////////////////////
--����
--////////////////////////////////////////////////
	fn mergePre_Fn =
	(
		fileName = getopenfileName caption:"�v���Z�b�g������" types:"(*.cps)|*.cps|All(*.*)|*.*"
		
		if fileName != undefined do
		(
			openedFile = openFile fileName mode:"r"
			while (not (eof openedFile)) do
			(
				str = (readLine openedFile)
				if (filterString str ">")[1] == "**Name" do
				(
					append presetName_str (filterString str ">\" ")[2]
				)
				if (filterString str ">")[1] == "**Value" do
				(
					append preset_str (filterString str ">\" ")[2]
				)
			)
--			print presetName_str
--			print preset_str
			close openedFile
			
			updatePresets_Fn()
		)
	
	)--end mergePre_fn

--////////////////////////////////////////////////
--���X�g�R�s�[�p
--////////////////////////////////////////////////
	fn copyPresetsList_Fn =
	(
		fileName = createFile "$Scripts/SJTools//SJ_Attribute_Holder_Defalut.tmp"
			for x = 1 to presetName_str.count do						--Format data to file
			(
				format "%" "**Name> " to:fileName
				format "%%%\n" "\"" presetName_str[x] "\"" to:fileName
				format "%" "**Value> " to:fileName
				format "%%%\n" "\"" preset_str[x] "\"" to:fileName
			)
			close fileName
		
	)-- end savePre_fn
--////////////////////////////////////////////////
--���X�g�R�s�[�p
--////////////////////////////////////////////////
	fn pastePresetsList_Fn =
	(
		openedFile = openFile "$Scripts/SJTools//SJ_Attribute_Holder_Defalut.tmp"
			while (not (eof openedFile)) do
			(
				str = (readLine openedFile)
				if (filterString str ">")[1] == "**Name" do
				(
					append presetName_str (filterString str ">\" ")[2]
				)
				if (filterString str ">")[1] == "**Value" do
				(
					append preset_str (filterString str ">\" ")[2]
				)
			)--while end
			close openedFile
			updatePresets_Fn()
	)-- end loadPre_fn

--////////////////////////////////////////////////
--�������r�p
--////////////////////////////////////////////////
	fn uppercase_Fn inStr =
	(
		local upper, lower, outStr
		Upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		lower = "abcdefghijklmnopqrstuvwxyz" 		
		outStr = inStr
		for i = 1 to outStr.count do
		(
			j = findString lower outStr[i]
			if j != undefined do
			(
				outStr[i] = upper[j]
			)
		)
		outStr
	)
--////////////////////////////////////////////////
--���������`�F�b�N
--////////////////////////////////////////////////
	fn dupNameCheck_Fn inStr =
	(
		isDup = false
		for x in presetName_str do
		(
			if (uppercase_Fn x) == (uppercase_Fn inStr) do
			(
				isDup = true
				exit loop
			)
		)
		if isDup == false then 
		(
			addPreset_Fn()
		)else
		(
			messageBox "Duplicate Name has been entered" Title:"Error"
		)
	)
--////////////////////////////////////////////////
--�A�b�v�_�E��
--////////////////////////////////////////////////
fn selUp_Fn selUpList selUpIndex =
(
	next = selUpList[ selUpIndex - 1 ]
	selUpList[ selUpIndex - 1 ] = selUpList[selUpIndex]
	selUpList[selUpIndex] = next
)

fn selDown_Fn selDownList selDownIndex =
(
	next = selDownList[ selDownIndex + 1 ]
	selDownList[ selDownIndex + 1 ] = selDownList[selDownIndex]
	selDownList[selDownIndex] = next
)
--////////////////////////////////////////////////
--clear
--////////////////////////////////////////////////
fn clearList_Fn = 
(
	presets_rol.presetsCbx.items = #()
	presetName_str = #()
	preset_str = #()
	presets_rol.presetsEdt.text = ""
)
--////////////////////////////////////////////////
--�A�b�v�f�[�g
--////////////////////////////////////////////////
	fn updatePresets_Fn =									
	(
		presetName_ar = #()
		for x in presetName_str do (append presetName_ar x)
		presets_rol.presetsCbx.items = presetName_ar
		presets_rol.presetsCbx.selection = 1

		try(presets_rol.presetsEdt.text = presets_rol.presetsCbx.selected)catch()
	)--end updatePresets_Fn
	
--////////////////////////////////////////////////
--���j���[
--////////////////////////////////////////////////
	fn menus =
	(
		rcMenu menuBar
		(
			local modInst --Local instance of the scripted modifier
				menuItem helpMi "�w���v!"
				menuItem aboutMi "About"
				menuItem emailMi  "E-Mail"
			/*
			menuItem clearPresets "Clear Presets"
			menuItem addPreset "�ǉ�"
			menuItem deletePreset "�I�����폜"
			menuItem clearPresets "�S�č폜"
			menuItem savePreset "�ۑ�"
			menuItem loadPreset "�ǂݍ���"
			menuItem mergePreset "����"
			*/
			on helpMi picked do shellLaunch "http://www.sakaiden.com/?page_id=5898" "";
			on emailMi picked do shellLaunch "mailTo:sakaiden@live.jp" ""
			on aboutMi picked do sj_functions.sjtools_about_Fn();
		)
		menuBar.modInst=this --get the modifier and create an instance for the menu because of scope and contex issues.
		return menuBar --Return the menu
	)
--////////////////////////////////////////////////
--���[���A�E�g
--////////////////////////////////////////////////
	rollout presets_rol "Presets"
	(
		
	--////////////////////////////////////////////////
	--���C�A�E�g
	--////////////////////////////////////////////////
	GroupBox presetsGrp "���X�g" pos:[4,4] width:154 height:364;
	editText presetsEdt "" pos:[8,68] width:123 height:16
	listBox presetsCbx "" pos:[12,86] width:120 height:17 selection:1
	button addPresetBt "" pos:[12,20] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_add.png", "$Scripts/SJTools/Images//SJ_button_add_a.png", 2, 1, 1, 2, 2) toolTip:"�v���Z�b�g��ǉ�"
	button upBt "" pos:[36,20] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_up.png", "$Scripts/SJTools/Images//SJ_button_up_a.png", 2, 1, 1, 2, 2) toolTip:"�I�����ڂ���グ��"
	button downBt "" pos:[60,20] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_down.png", "$Scripts/SJTools/Images//SJ_button_down_a.png", 2, 1, 1, 2, 2) toolTip:"�I�����ڂ��������"
	button deleteBt "" pos:[84,20] width:20 height:20 enabled:true images:#("$Scripts/SJTools/Images//SJ_button_delete.png", "$Scripts/SJTools/Images//SJ_button_delete_a.png", 2, 1, 1, 2, 2) toolTip:"�폜"
	button clearBt "" pos:[108,20] width:20 height:20 enabled:true images:#("$Scripts/SJTools/Images//SJ_button_clear.png", "$Scripts/SJTools/Images//SJ_button_clear_a.png", 2, 1, 1, 2, 2) toolTip:"�N���A"
	button saveBt "Button" pos:[36,44] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_save.png", "$Scripts/SJTools/Images//SJ_button_save_a.png", 2, 1, 1, 2, 2) toolTip:"�v���Z�b�g��ۑ�"
	button loadBt "Button" pos:[60,44] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_open.png", "$Scripts/SJTools/Images//SJ_button_open_a.png", 2, 1, 1, 2, 2) toolTip:"�v���Z�b�g���J��"
	button mergeBt "Button" pos:[84,44] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_merge_open.png", "$Scripts/SJTools/Images//SJ_button_merge_open_a.png", 2, 1, 1, 2, 2) toolTip:"�v���Z�b�g������"
	button helpBt "Button" pos:[108,44] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_help.png", "$Scripts/SJTools/Images//SJ_button_help_a.png", 2, 1, 1, 2, 2) toolTip:"�w���v"
	slider faderCa_Sl "" pos:[11,314] width:132 height:25 range:[-1,1,0] ticks:0 scale:0.01 --across:2 
	spinner faderSpn "" pos:[12,342] width:56 height:16 range:[-1,1,0] scale:0.01
	checkbutton faderOn_Cb "On / Off" pos:[70,338] width:60 height:24 toolTip:"�t�F�[�_�[�g�p�̐؂�ւ�";

	--�����ݒ�
	GroupBox settingGrp "�����ݒ�" pos:[4,378] width:155 height:84;
	radiobuttons mixSetRb "" pos:[12,398] width:102 height:32 labels:#("���`","���Z", "���Z", "��Z") default:1 columns:2;
	checkbox zeroExcludeChk "0�����O" pos:[12,434] width:100 height:20;
	
	GroupBox optionGrp "�I�v�V����"  pos:[4,470] width:155 height:116;
	button presetsCopyBt "���X�g�R�s�[" pos:[12,486] width:120 height:20 enabled:true toolTip:"���X�g�S�̂����R�s�[";
	button presetsPasteBt "���X�g�y�[�X�g" pos:[12,510] width:120 height:20 toolTip:"���X�g�S�̂����y�[�X�g";
	button keyAll_bt "�L�[" pos:[12,534] width:56 height:20 enabled:true toolTip:"���ׂẴp�����[�^�[�ɃL�[���쐬" across:2;
	button resetall_bt "���Z�b�g" pos:[76,534] width:56 height:20 toolTip:"���ׂẴp�����[�^�[��0�ɂ���";
	button copyPreset_bt "�R�s�[" pos:[12,558] width:56 height:20 toolTip:"���݂̒l���R�s�[" across:2;
	button pastePreset_bt "�y�[�X�g" pos:[76,558] width:56 height:20 toolTip:"�l���y�[�X�g";


-----------------------------------------------------------------------------------------------------------
-- �����֐�

-----------------------------------------------------------------------------------------------------------

--////////////////////////////////////////////////
--�p�����[�^�[������
--���̃��[���A�E�g���Ńt�@���N�V������ݒ�
--////////////////////////////////////////////////
	fn attributeMixer_Fn val =
	(
			--�A�g���r���[�g���擾
			ca = getCaAttributes_Fn();
			
			--�R���{�{�b�N�X�̃A�C�e����0�ȏ�Ȃ�Ό��ݑI����index����p�����[�^�[���擾
			vals = if presetsCbx.items.count > 0 then (execute preset_str[presetsCbx.selection])else("")
			
			--�A�g���r���[�g�̐���0�ȏ�Ȃ��
			if ca.count > 0 do
			(
				
				--�A�g���r���[�g�̐��������s
				for x = 1 to ca.count do
				(
					--�A�g���r���[�g�ɐ��l����
					try(
						--�⊮
						--���݂̒l + ((�擾�����l-���݂̒l)*�X�s�i�[�̒l)
						--ca[x].value = curVals[x] + ((vals[x] - curVals[x]) * val);
						ca[x].value = curVals[x] + (vals[x] * val);
						
						case mixSetRb.state of
						(
							--���`
							1:(
								--�[�����O�ݒ肩?
								if (zeroExcludeChk.checked) then
								(
									--�l���[���������珜�O
									if (vals[x] != 0 ) then
									(
										ca[x].value = curVals[x] + ((vals[x] - curVals[x]) * val);
									);--if end
								)else
								(
										ca[x].value = curVals[x] + ((vals[x] - curVals[x]) * val);
								);--if end								
							);
							
							--���Z
							2:(
								--�[�����O�ݒ肩?
								if (zeroExcludeChk.checked) then
								(
									--�l���[���������珜�O
									if (vals[x] != 0 ) then
									(
										ca[x].value = curVals[x] + (vals[x] * val);
									);--if end
								)else
								(
										print curVals[x];
										ca[x].value = curVals[x] + (vals[x] * val);
									--ca[x].value += (vals[x] * val);
									--ca[x].value += 5;
								);--if end
							);--case 2 end
							
							--���Z
							3:(
								--�[�����O�ݒ肩?
								if (zeroExcludeChk.checked) then
								(
									--�l���[���������珜�O
									if (vals[x] != 0 ) then
									(
										ca[x].value = curVals[x] - (vals[x] * val);
									);--if end
								)else
								(
										ca[x].value = curVals[x] - (vals[x] * val);
								);--if end
							);--case 3 end
							
							--��Z
							4:(
								--�[�����O�ݒ肩?
								if (zeroExcludeChk.checked) then
								(
									--�l���[���������珜�O
									if (vals[x] != 0 ) then
									(
										ca[x].value = curVals[x] * (vals[x] * val);
									);--if end
								)else
								(
										ca[x].value = curVals[x] * (vals[x] * val);
								);--if end							
							);--case end
						);--case all end

						)catch()--try end
				);--for end
				
			);--if end

	);--fn end


-----------------------------------------------------------------------------------------------------------
-- �A�N�V����
-----------------------------------------------------------------------------------------------------------
	on addPresetBt pressed do addPreset_Fn()
	on saveBt pressed do savePre_Fn()
	on loadBt pressed do loadPre_Fn()
	on mergeBt pressed do mergePre_Fn()
	on helpBt pressed do
	(
		menuSys=menus()
		popUpMenu menuSys rollout:presets_rol
	);--on end
	--////////////////////////////////////////////////
	--���X�g�ҏW
	--////////////////////////////////////////////////
	on presetsEdt entered str do
	(
		if (str != "" and presetsCbx.items.count != 0) then
		(
			presetsCbx.selected = str
			presetName_str[presetsCbx.selection] = str
		)--if end
	)
	on presetsEdt changed str do
	(
	if (str != "" and presetsCbx.items.count != 0) then
	(
		presetName_str[presetsCbx.selection] = str
		presetsCbx.selected = str
		presetsCbx.items = presetsCbx.items
		presetsCbx.selection = presetsCbx.selection
		presetsEdt.text = str
	);--if end
	);--end

	on upBt pressed do
	(
	if presetsCbx.selection != 0 and presetsCbx.selection != 1 do
	(
	selUp_Fn presets_rol.presetsCbx.items presets_rol.presetsCbx.selection;
	selUp_Fn presetName_str presets_rol.presetsCbx.selection;
	selUp_Fn preset_str presets_rol.presetsCbx.selection;
		presetsCbx.items = presetsCbx.items --�\���X�V
		presetsCbx.selection -= 1 --�I���X�V�p
		presetsCbx.selection = presetsCbx.selection --�I���X�V
	);--if end
	);
	on downBt pressed do
	(
	if presetsCbx.selection != 0 and  presetsCbx.items.count > presetsCbx.selection do
	(
	selDown_Fn presets_rol.presetsCbx.items presets_rol.presetsCbx.selection;
	selDown_Fn presetName_str presets_rol.presetsCbx.selection;
	selDown_Fn preset_str presets_rol.presetsCbx.selection;
		presetsCbx.items = presetsCbx.items --�\���X�V
		presetsCbx.selection += 1 --�I���X�V�p
		presetsCbx.selection = presetsCbx.selection --�I���X�V
	);--if end
	);
	on deleteBt pressed do
	(
	--if queryBox "�I�����폜���Ă���낵���ł���?" then
	--(
		if presets_rol.presetsCbx.selection != 0 then
		(
		delPresetList_Fn presets_rol.presetsCbx.items presets_rol.presetsCbx.selection;
		presets_rol.presetsCbx.items = presets_rol.presetsCbx.items;
		);--if end
	--);--if end
	);
	on clearBt pressed do
	if queryBox "�v���Z�b�g��S�č폜���Ă���낵���ł���?" then
	(
	clearList_Fn();
	);--on end
	on presetsCbx entered str do
	(
	if str != "" then presets_rol.presetsCbx.selected = str;
	presetName_str[presets_rol.presetsCbx.selection] = str;
	);--on end
-----------------------------------------------------------------------------------------------------------
-- �I�v�V����
-----------------------------------------------------------------------------------------------------------
		on test pressed do (print (refs.dependents this))
		----------------------
		--���X�g���R�s�[�ƌ������ۑ�
		on presetsCopyBt pressed do copyPresetsList_Fn()
		----------------------
		--�f�t�H���g�t�@�C������ǂݍ���
		on presetsPasteBt pressed do pastePresetsList_Fn()
		----------------------
		--�R�s�[
		on copyPreset_bt pressed do
		(
			sjAHValue = #()
			ca = getCaAttributes_Fn()
			if ca.count > 0 do
			(
				for x = 1 to ca.count do
				(
					try(append sjAHValue ca[x].value)catch()
				);
			);
		);--on end
		----------------------
		--�y�[�X�g
		on pastePreset_bt pressed do
		( 			ca = getCaAttributes_Fn()
			if ca.count > 0 do
			(
				for x = 1 to ca.count do
				(
					try(ca[x].value = sjAHValue[x])catch()
				);
			);
		);--on end
		----------------------
		--�L�[
		on keyAll_bt pressed do
		(
			ca = getCaAttributes_Fn()
			with animate on
			(
			if ca.count > 0 do
			(
				for x = 1 to ca.count do
				(
					try(ca[x].value = ca[x].value)catch()
				);-- for end
			);--if end
			);
		);
		----------------------
		--���Z�b�g
		on resetAll_bt pressed do
		(
			ca = getCaAttributes_Fn()
			if ca.count > 0 do
			(
				for x = 1 to ca.count do
				(
					try(ca[x].value = 0)catch()
				);
			);
		);
		----------------------
		--�X�s�i�[���������Ƃ�
		on faderSpn buttonDown do
		(
			ca = getCaAttributes_Fn()
			if ca.count > 0 then
			(
				for x in ca do
				(
					append curVals x.value
				);--for end
			);--if end
		);
		----------------------
		--�X�s�i�[�̐��l���ς�����ꍇ
		on faderSpn changed val inSpin do
		(
			--�X�s�i�[�̓��̓t���O
			if inSpin then
			(
			--�t�F�[�_�[���[�h�Ȃ��
			if faderOn_Cb.checked then
			(
				attributeMixer_Fn val;
			)else(
				faderSpn.value = 0;
			);--if end
			);--if end
			--curVals = #()
		);--on end
		
		
		----------------------
		--�X���C�_�[�𗣂����Ƃ�
		on faderSpn buttonUp do
		(
			faderCa_Sl.value = 0
			curVals = #()
		);
		----------------------
		--�v���Z�b�g�I�����ς�����ꍇ
		on presetsCbx selected i do
		(
			presetsEdt.text = presetsCbx.selected
			if faderOn_Cb.checked == false then
			(
				ca = getCaAttributes_Fn()
				vals = (execute preset_str[i])
				if ca.count > 0 do
				(
					for x = 1 to ca.count do
					(
						try(ca[x].value = vals[x])catch()
					);--for end
				);--if end
			);--if end
		);
		----------------------
		--�X���C�_�[���������Ƃ�
		on faderCa_Sl buttonDown do
		(
			ca = getCaAttributes_Fn()
			if ca.count > 0 then
			(
				for x in ca do
				(
					append curVals x.value
				);--for end
			);--if end
		);
		
		
		----------------------
		--�X���C�_�[���ω������Ƃ�
		on faderCa_Sl changed val do
		(
			--�t�F�[�_�[���[�h�Ȃ��
			if faderOn_Cb.checked then
			(
				attributeMixer_Fn val;
			)else(
				faderSpn.value = 0;
			);--if end
		);--end
		
		
		----------------------
		--�X���C�_�[�𗣂����Ƃ�
		on faderCa_Sl buttonUp do
		(
			faderCa_Sl.value = 0
			curVals = #()
		);
		----------------------
		--���[���A�E�g�A�N�V����
		on presets_rol open do
		(
			updatePresets_Fn()
		)--end on open
		
	)-- end presets_rol
	--////////////////////////////////////////////////
	-- �A�b�v�f�[�g
	--////////////////////////////////////////////////
	on update do
	(
		if version == 1 then
		(
			print "Version 1 updated"
		)
	)--end on update	

	fn rollouts = (#(presets_rol))
)--end Plugin





