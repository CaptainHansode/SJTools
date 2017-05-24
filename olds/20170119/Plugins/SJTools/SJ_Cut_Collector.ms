/*******************************************************
System J Tools 
********************************************************
Name:SJ_Cut_Collector
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/

--global sjAHValue = #()

plugin modifier 'SJ_Cut_Collector'
	name:"SJ_Cut_Collector"
	classID:#(0x5b733fd8, 0xa052070)
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
--skipToString languageFile "[SJ_Cut_Collector.ms]";--�K���Ώۂ̃c�[���܂ň�x��΂�
--skipToString languageFile "SJ_Cut_CollectorNameAndVersion ="
--Local nameAndVersion = (readLine languageFile);
Local nameAndVersion = "SJ Cut Collector";
-----------------------------------------------------------------------------------------------------------
	--�J�������ق�����nodeTransformMonitor�z��
	Local tempCameraList = #(), tempArray =#();
	--����������������X�g��Index
	Local lastCheck = undefined;
	
	--Locals
	Local Values = #(), cut_list_rol;
	Local defaultNameStr = "Group", NumStr = "01";
	
	/*
	parameters SJ_Cut_CollectorParam
	(
		presetName_str type:#stringTab tabSize:0 tabSizeVariable:true;
		preset_str type:#stringTab tabSize:0 tabSizeVariable:true;
	);
	*/
	parameters  SJ_Cut_CollectorParam rollout:cut_list_rol
	(
		cameraListNTF type:#maxObjectTab tabSize:0 tabSizeVariable:true animatable:false;
		startList type:#intTab tabSize:0 tabSizeVariable:true animatable:false;
		endList type:#intTab tabSize:0 tabSizeVariable:true animatable:false;
		cutListOn type:#boolean ui:cutListOnCb default:false animatable:false;
		--faderValue type:#percent ui:(faderCa_Sl,faderSpn) animatable:false;
	);
-----------------------------------------------------------------------------------------------------------
-- �t�@���N�V����
-----------------------------------------------------------------------------------------------------------
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

			on helpMi picked do shellLaunch "http://www.sakaiden.com/?page_id=5885" ""
			on emailMi picked do shellLaunch "mailTo:sakaiden@live.jp" ""
			on aboutMi picked do sj_functions.sjtools_about_Fn();
		)
		menuBar.modInst=this --get the modifier and create an instance for the menu because of scope and contex issues.
		return menuBar --Return the menu
	);--fn end

--////////////////////////////////////////////////
--���[���A�E�g
--////////////////////////////////////////////////
rollout cut_list_rol "Cut List"
(
--////////////////////////////////////////////////
--
--
--
--���X�g�Ƃ��̕ҏW
--
--
--
--////////////////////////////////////////////////

--////////////////////////////////////////////////
--���X�g���쐬����t�@���N�V����
/*
�A�N�e�B�ux�Ń��X�g�����open���ɂ��̃t�@���N�V���������s
*/
--////////////////////////////////////////////////
fn makeListView_Fn list =
(
	
	/*�r���[�̎��*/
	--list.View = #lvwReport;
	/*�O���b�h���C���̗L��*/
	--list.gridLines = true;
	/*��̃w�b�h���C����\�����邩?*/
	--list.View = #lvwReport;
	/*�I�����ɍs�S�̂�I�����邩�̗L��*/
	list.fullRowSelect = true;
	/*�}���`�Z���N�g*/
	list.MultiSelect = true;
	
	/*���C�A�E�g*/
	list.Appearance = #ccFlat;
	list.BorderStyle = #ccNone;
	--���X�g�̔w�i�F
	--list.backColor = color 255 255 255;
	
	--�`�F�b�N�{�b�N�X��L���ɂ���
	list.checkboxes = false;
	--���X�g�̃w�b�_�[�ƕ��A���X�g�͑������z��
	Local layout_def = #(#("Camera",70), #("Start",40), #("End",40));
	--layout_def = #(#("On",40), #("Object Name",120), #("Object Class",80), #("Verts",45), #("Faces",45), #("Material",120));

	--�ݒ肵���z���ǉ�
	for i in layout_def do
	(
		column = list.ColumnHeaders.add();
		column.text = i[1];
	);

	/*
	���[�U�[�ϐ���2��쐬�A�A�h���X�ƁA��̕�
	windowsHandle�ɑ���id���܂܂�Ă���
	windows��ActiveX�R���g���[���̃v���O���~���O�Ȃ̂ŁA�ڂ�����WindowsActiveX���Q�Ƃ���
	*/
	LV_FIRST = 0x1000;
	LV_SETCOLUMNWIDTH = (LV_FIRST + 30);
	/*MaxScript�̔z��Index��1�Ŏn�܂�̂ɑ΂��AActiveX����0�Ŏn�܂�s�s������菜��*/
	for i = 0 to layout_def.count-1 do windows.sendMessage list.hwnd LV_SETCOLUMNWIDTH i layout_def[1+i][2];
);--fn end

--////////////////////////////////////////////////
--���X�g�̃e�X�g�p
--////////////////////////////////////////////////
fn addTest_Fn list =
(
	/*���X�g�����ׂĂ��肠*/
	--.ListSubItems���X�g�̃T�u�A�C�e���ɃA�N�Z�X�ł���
	list.ListItems.clear()
	 
	/*1���珇�Ƀ��X�g�ɒǉ�*/
	temp = undefined;
	sub_li = undefined;
	for i = 1 to 12 do
	(
		temp = list.ListItems.add();
		--temp.checked = true;
		temp.text = "Group01";

		sub_li = temp.ListSubItems.add();
		sub_li.text = i;
		
		sub_li = temp.ListSubItems.add();
		sub_li.text = i + 100;
	);--for end
);--fn end

--////////////////////////////////////////////////
--�v���Z�b�g��ǉ��̃t���[������
--////////////////////////////////////////////////
fn addList_Fn =
(
	--�J������o�^��������Ȃ̂ŁA�J�E���g��1���ǂ����Ŕz��̂͂��߂�������
	--���̓J������1�߂������ꍇ
	if (cameraListNTF.count == 1) then
	(
		append startList 1;
		append endList 2;
	)else(
	--�z��S�̂̃J�E���g����
	--print cameraListNTF.count
		append startList (endList[(endList.count)] + 1);
		append endList (startList[(endList.count)+1] + 1);
	);--if end
						
)-- end fn
	
--////////////////////////////////////////////////
--Del
--////////////////////////////////////////////////
fn delList_Fn listName listFrame i = 
(
	deleteItem cameraListNTF i;
	deleteItem startList i;
	deleteItem endList i;
);--fn end

--////////////////////////////////////////////////
--clear
--////////////////////////////////////////////////
fn clearList_Fn listName listFrame = 
(
	--���O�̃��X�g�A�{�̂̃��X�g�Aflag������
	cameraListNTF = #();
	startList = #();
	endList = #();
	listName.items = #();
	listFrame.items = #();
);--fn end

--////////////////////////////////////////////////
--save
--////////////////////////////////////////////////
fn saveList_Fn =
(
--�t�@�C�����Ȃǂ�ϐ��ɓ���Ă���
--type�̕����͂���Ȋ���  types:"Transform File(*.file)|*.file|Text(*.txt)|*.txt"
local saveName = getSaveFileName types:"Text(*.txt)|*.txt" caption:"�ۑ�";

	--�L�����Z���Ȃǂŕϐ����������������������������ꍇ�͎��s���Ȃ�	
	if (saveName != undefined) do
	(
		--�擾�����t�@�C�����ȂǂŃt�@�C�����쐬
		saveFile = createfile saveName;
		
		for i=1 to cameraListNTF.count do
		(
		--cut_list_rol
		
		--�J�������������o��
		format "%," cut_list_rol.cutList.items[i] to:saveFile;
		--�J�n�t���[��
		format "%," startList[i] to:saveFile;
		--�I���t���[��
		format "%\n" endList[i] to:saveFile;
		
		);--for end
		close saveFile;
	);--if end
);--fn end


--////////////////////////////////////////////////
--load
--////////////////////////////////////////////////
fn  loadList_Fn =
(
local loadStr = "", str = "";
local loadName = getOpenFileName types:"Text(*.txt)|*.txt" caption:"�ǂݍ���";

	if loadName != undefined do
	(
		--�t�@�C�����J��
		loadFile = openFile loadName;
		--�ǂݍ��ݍs�������Ȃ�܂�
		while not eof loadFile do
		(
			loadStr = readLine loadFile;
			
			--��xStringStream�ɕϊ�
			loadStr = (loadStr as stringStream);
			
			--�t�@�C���͖��O,start,end,�̏��ŏ������܂�Ă���̂�3�񂸂�
			str = (readDelimitedString loadStr ",");
			
			if isvalidnode (obj = (getNodeByName str)) then
			(
			
			if (classOf obj == Freecamera or classOf obj == Targetcamera or classOf obj == VRayPhysicalCamera) then
			(
			append cameraListNTF (nodeTransformMonitor node:(execute("$"+str)) forwardTransformChangeMsgs:false);
			)else(
			--�J�����łȂ������ꍇ�ł����o�^���Ă���
			--�A�b�v�f�[�g���󂾂����ꍇ�ɏ���ɍ폜���Ă����
			messageBox("�ȉ��̑Ώۂ��o�^�ł��܂���\n�J�����ł͂Ȃ��\��������܂�\n\n"+str) title:"���b�Z�[�W";
			append cameraListNTF (nodeTransformMonitor node:undefined forwardTransformChangeMsgs:false);
			);			
			
			)else(
			--�I�u�W�F�N�g�������ꍇ�ł����o�^���Ă���
			--�A�b�v�f�[�g���󂾂����ꍇ�ɏ���ɍ폜���Ă����
			messageBox("�ȉ��̑Ώۂ̃J����������܂���\n\n"+str) title:"���b�Z�[�W";
			append cameraListNTF (nodeTransformMonitor node:undefined forwardTransformChangeMsgs:false);
			);
			
			str = (readDelimitedString loadStr ",");
			append startList (str as Integer);
		
			str = (readDelimitedString loadStr ",");
			append endList (str as Integer);

		);--while end
		close loadFile;
	);

);--fn end

--////////////////////////////////////////////////
--�A�b�v�_�E��
--////////////////////////////////////////////////
fn upList_Fn Index =
(
	next = cameraListNTF[Index-1];
	cameraListNTF[Index - 1 ] = cameraListNTF[Index];
	cameraListNTF[Index] = next;
);--fn end

fn downList_Fn Index =
(
	next = cameraListNTF[Index + 1];
	cameraListNTF[Index + 1] = cameraListNTF[Index];
	cameraListNTF[Index] = next;
);--fn end

--////////////////////////////////////////////////
--���X�g�A�b�v�f�[�g
--////////////////////////////////////////////////
fn updateList_Fn listName listFrame =
(
	Local k = 1, i = 1;--�J�E���g�p
	tempArray = #();

	--��[�N���A
	listName.items = #();
	listFrame.items = #();
	listName.items = listName.items;
	listFrame.items = listFrame.items;
	
	for i in cameraListNTF do
	(
		--node�͖����Ȃ��Ă��Ȃ����H
		if not (isvalidnode i.node) then
		(
			append tempArray k;
		);--if end
		k += 1;
	);--for end
	
	--�ȉ��͖����Ȃ��Ă��������̃J�����Ȃǂ��폜
	if ( tempArray.count != 0 ) then
	(
		i = tempArray.count;
		while i > 0 do
		(
			deleteItem cameraListNTF tempArray[i];
			deleteItem startList tempArray[i];
			deleteItem endList tempArray[i];
			--list.ListItems.Remove i;
			i -= 1;
		);--while ends
	);--if end

	--���X�g�̖��O���X�V
	k = 1;--�J�E���g�p
	for i in cameraListNTF do
	(
		listName.items[k] = i.node.name;
		listFrame.items[k] = (startList[k] as String) + " -> " + (endList[k] as String);
		--�\���X�V
		listName.items = listName.items;
		listFrame.items = listFrame.items;
		--sub_li.text = startList[k];
		--sub_li.text = endList[k];
		
		k += 1;
	);--for end


	
	
	
/*���X�g�����ׂĂ��肠*/
--list.ListItems.clear();
--tempArray = #();

/*1���珇�Ƀ��X�g�ɒǉ�*/
--temp = undefined;
--sub_li = undefined;
/*
Local k = 1, i = 1;
	for i in cameraListNTF do
	(
	--node�͖����Ȃ��Ă��Ȃ����H
	if not (isvalidnode i.node) then
	(
		append tempArray k;
	);--if end
		k += 1;
	);--for end
	
	--�ȉ��͖����Ȃ��Ă��������̃J�����Ȃǂ��폜
	if ( tempArray.count != 0 ) then
	(
		i = tempArray.count;
		while i > 0 do
		(
			deleteItem cameraListNTF tempArray[i];
			deleteItem startList tempArray[i];
			deleteItem endList tempArray[i];
			--list.ListItems.Remove i;
			i -= 1;
		);--while ends
	);--if end

	--�������X�g�ɒǉ�
	k = 1;
	for i in cameraListNTF do
	(
		temp = list.ListItems.add();
		temp.text = i.node.name;

		sub_li = temp.ListSubItems.add();
		sub_li.text = startList[k];
		
		sub_li = temp.ListSubItems.add();
		sub_li.text = endList[k];
		
		k += 1;
	);--for end
*/
)--end updateList_Fn

--////////////////////////////////////////////////
--
--
--
--���ʂ̃t�@���N�V����
--
--
--
--////////////////////////////////////////////////
--////////////////////////////////////////////////
--pickObject���̂��߂̃t�B���^�[�Anode�����O����
--////////////////////////////////////////////////
fn pickFilter_Fn o =
(
--�J�����ȊO�͏��O
(classOf o == Freecamera or classOf o == Targetcamera or classOf o == VRayPhysicalCamera);
--(o != selection[1]);
-- or selection[1] != o
);
--fn pickFilter_Fn o = ((findItem allNodes o) == 0);

--////////////////////////////////////////////////
--�t���[���ݒ�
--////////////////////////////////////////////////
fn changeFrameSet_Fn start end Index =
(
	--�z������ւ�
	startList[Index] = start;
	endList[Index] = end;
	
	for i = Index to cameraListNTF.count do
	(
		--�I������Index��1�̏ꍇ�͍s��Ȃ�
		if (i != 1) then
		(
			--�ЂƂO�̃G���h���X�^�[�g���傫�����Ƃ��m�F����
			if ((endList[i-1] < startList[i]) == false) then
			(
				startList[i] = (endList[i-1] + 1);
			);--if end
			
			--�G���h���X�^�[�g�����傫�����Ƃ��m�F����
			if ((startList[i] < endList[i]) == false) then
			(
				endList[i] = startList[i] + 1;
			);--if end
		);--if end	
		
	);--for end
);--fn end

--////////////////////////////////////////////////
--�I����Ԃ��`�F�b�N
--////////////////////////////////////////////////
fn cameraRename_Fn Str Index =
(
	cameraListNTF[Index].node.name = Str;
);--fn end

--////////////////////////////////////////////////
--�I����Ԃ��`�F�b�N
--////////////////////////////////////////////////
fn selectionCheck_Fn obj =
(
	--�I�����Ă��邩?
	--if selection.count !=0 then
	--(
	--�I�𕨂�
		if ((classOf obj == Freecamera) or (classOf obj == Targetcamera)) then
		(	
			--�`�F�b�N���ʂ��ǍD�Ȃ�
			return true;
		);--if end
	--)--if end
	--�`�F�b�N���ʂ͋C�܂���
	return false;
);--fn end

--////////////////////////////////////////////////
--�g�����X�t�H�[���p�̃X�N���v�g��ǉ�
--////////////////////////////////////////////////
fn addTransformScript_Fn =
(
Local scritpStr = "try(
Local obj = $" + selection[1].name + ";
if (obj.modifiers[#SJ_Cut_Collector].cutListOn) then
(
Local myValue = obj.modifiers[#SJ_Cut_Collector].cameraListNTF[1].node.transform;
Local lastIndex = obj.modifiers[#SJ_Cut_Collector].cameraListNTF.count;
for i=1 to lastIndex do
(
if ( F >= obj.modifiers[#SJ_Cut_Collector].startList[i] ) then myValue = obj.modifiers[#SJ_Cut_Collector].cameraListNTF[i].node.transform;
);
myValue;
)else(matrix3 [1,0,0] [0,1,0] [0,0, 1] [0,0,0]);--if end
)catch(matrix3 [1,0,0] [0,1,0] [0,0, 1] [0,0,0]);
"
	--�R���g���[���[��ϊ��X�N���v�g�ǉ�
	selection[1].Transform.controller = transform_script ();
	--��[�N���A���ē����
	selection[1].Transform.controller.script = "matrix3 [1,0,0] [0,1,0] [0,0, 1] [0,0,0]";
	selection[1].Transform.controller.script = scritpStr;
);--fn end

--////////////////////////////////////////////////
--FOV�p�̃X�N���v�g��ǉ�
--////////////////////////////////////////////////
fn addFovScript_Fn =
(
Local scritpStr = "try(
Local obj = $" + selection[1].name + ";
if (obj.modifiers[#SJ_Cut_Collector].cutListOn) then
(
Local myValue = obj.modifiers[#SJ_Cut_Collector].cameraListNTF[1].node.fov;
Local lastIndex = obj.modifiers[#SJ_Cut_Collector].cameraListNTF.count;
for i=1 to lastIndex do
(
if ( F >= obj.modifiers[#SJ_Cut_Collector].startList[i] ) then myValue = obj.modifiers[#SJ_Cut_Collector].cameraListNTF[i].node.fov;
);
degToRad(myValue);
)else(0.785398);--if end
)catch(0.785398);
"
	--�R���g���[���[��ϊ��X�N���v�g�ǉ�
	selection[1].fov.controller = float_script ();
	--��[�N���A���ē����
	selection[1].fov.controller.script = "0";
	selection[1].fov.controller.script = scritpStr;
);--fn end

--Vray�p�AVray�̓��W�A���ł͂Ȃ��̂ŁA���W�A���̕ύX�̕K�v�͖���
fn addFovScriptVray_Fn =
(
Local scritpStr = "try(
Local obj = $" + selection[1].name + ";
if (obj.modifiers[#SJ_Cut_Collector].cutListOn) then
(
Local myValue = obj.modifiers[#SJ_Cut_Collector].cameraListNTF[1].node.fov;
Local lastIndex = obj.modifiers[#SJ_Cut_Collector].cameraListNTF.count;
for i=1 to lastIndex do
(
if ( F >= obj.modifiers[#SJ_Cut_Collector].startList[i] ) then myValue = obj.modifiers[#SJ_Cut_Collector].cameraListNTF[i].node.fov;
);
myValue;
)else(45.0);--if end
)catch(45.0);
"
	--�R���g���[���[��ϊ��X�N���v�g�ǉ�
	selection[1].fov.controller = float_script ();
	--��[�N���A���ē����
	selection[1].fov.controller.script = "0";
	selection[1].fov.controller.script = scritpStr;
);--fn end

--////////////////////////////////////////////////
--���C�A�E�g
--////////////////////////////////////////////////
	GroupBox cutListGrp "Cut List" pos:[4,4] width:154 height:340
	--listbox presetsCbx "" pos:[12,68] width:120 height:8 selection:1
	
	checkbutton addListBt "" pos:[12,20] width:20 height:20 toolTip:"�ǉ�" images:#("$Scripts/SJTools/Images//SJ_button_add.png", "$Scripts/SJTools/Images//SJ_button_add_a.png", 2, 1, 1, 2, 2)
	button allSelBt "" pos:[36,20] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_allSel.png", "$Scripts/SJTools/Images//SJ_button_allSel_a.png", 2, 1, 1, 2, 2) toolTip:"�S�đI��"
	button deleteBt "" pos:[60,20] width:20 height:20 enabled:true images:#("$Scripts/SJTools/Images//SJ_button_delete.png", "$Scripts/SJTools/Images//SJ_button_delete_a.png", 2, 1, 1, 2, 2) toolTip:"�폜"
	button clearBt "" pos:[84,20] width:20 height:20 enabled:true images:#("$Scripts/SJTools/Images//SJ_button_clear.png", "$Scripts/SJTools/Images//SJ_button_clear_a.png", 2, 1, 1, 2, 2) toolTip:"�N���A"
	button helpBt "" pos:[108,20] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_help.png", "$Scripts/SJTools/Images//SJ_button_help_a.png", 2, 1, 1, 2, 2) toolTip:"�w���v"
	button upBt "" pos:[12,44] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_up.png", "$Scripts/SJTools/Images//SJ_button_up_a.png", 2, 1, 1, 2, 2) toolTip:"���ڂ��A�b�v"
	button downBt "" pos:[36,44] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_down.png", "$Scripts/SJTools/Images//SJ_button_down_a.png", 2, 1, 1, 2, 2) toolTip:"���ڂ��_�E��"
	checkbutton replaceBt "" pos:[60,44] width:20 height:20 toolTip:"���ڂ����ւ�" images:#("$Scripts/SJTools/Images//SJ_button_replace.png", "$Scripts/SJTools/Images//SJ_button_replace_a.png", 2, 1, 1, 2, 2)
	button saveBt "" pos:[84,44] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_save.png", "$Scripts/SJTools/Images//SJ_button_save_a.png", 2, 1, 1, 2, 2) toolTip:"���X�g��ۑ�"
	button loadBt "" pos:[108,44] width:20 height:20 images:#("$Scripts/SJTools/Images//SJ_button_open.png", "$Scripts/SJTools/Images//SJ_button_open_a.png", 2, 1, 1, 2, 2) toolTip:"���X�g��ǂݍ���"
	edittext cutEdt "" pos:[8,68] width:140 height:16
	listbox cutList "" pos:[12,84] width:60 height:17 selection:1 --items:#("cut01","cut02","cut03");
	listbox cutFrameList "" pos:[72,84] width:76 height:17 selection:1 --items:#("cut01","cut02","cut03");
	
	GroupBox settingGrp "Frame Setting" pos:[4,352] width:154 height:56
	label startLbl "Start" pos:[12,368] width:48 height:16
	label endLbl "End" pos:[76,368] width:48 height:16
	spinner startSpn "" pos:[9,384] width:56 height:16 range:[-1e+009,1e+009,0] type:#integer scale:1
	spinner endSpn "" pos:[73,384] width:56 height:16 range:[-1e+009,1e+009,1] type:#integer scale:1
	checkbutton cutListOnCb "On / Off" pos:[12,316] width:120 height:20 toolTip:"�J�����̃g���[�X�̐؂�ւ�" --highlightColor:[0,255,0]

-----------------------------------------------------------------------------------------------------------
-- �A�N�V����
-----------------------------------------------------------------------------------------------------------
	on cutListOnCb changed state do
	(
		if (cameraListNTF.count == 0) then
		(
			messageBox ("�J�������o�^����Ă��܂���") titel:"���b�Z�[�W";
		);--if end
	);--end
	

	on addListBt changed state do
	(
		if state == on then
		(
			tempCameraList = #();
			Local picObj = undefined;
			picObj = pickObject message:"�I�u�W�F�N�g��I�����Ă�������:" count:1 select:false forceListenerFocus:false filter:pickFilter_Fn;
			--picObj = pickObject message:"�I�u�W�F�N�g��I�����Ă�������:" count:#multiple forceListenerFocus:false filter:pickFilter_Fn
			
			if ((picObj == selection[1]) or (picObj == undefined)) then
			(	messageBox ("�o�^�o���܂���") titel:"���b�Z�[�W";
			)else(
				append cameraListNTF (nodeTransformMonitor node:picObj forwardTransformChangeMsgs:false);
				addList_Fn();
				updateList_Fn cutList cutFrameList;
			);--if end
			addListBt.state = off;
			cutListOnCb.enabled = true;
			max select;
		)else(
			--���[�h��؂�ւ��邱�ƂŃo�O���
			max move;
			max select;
		)--if end
	);--end

	on  clearBt pressed do
	(
		cutListOnCb.checked = false;
		cutListOnCb.enabled = false;
		clearList_Fn cutList cutFrameList;
		updateList_Fn cutList cutFrameList;
	);
	
	on deleteBt pressed do
	(
		--���X�g�͋󂩁H
		if ( cutList.items.count != 0 ) then
		(
		delList_Fn cutList cutFrameList cutList.selection;
		if (cameraListNTF.count == 0) then
		(
		cutListOnCb.checked = false;
		cutListOnCb.enabled = false;
		);--if end
		updateList_Fn cutList cutFrameList;
		);--if end
	);
	
	on allSelBt pressed do
	(
		tempArray = #();
		--���X�g�͋󂩁H
		if ( cutList.items.count != 0 ) then
		(
			for i in cameraListNTF do
			(
				append tempArray i.node;
			);--for end
			undo on (select tempArray);
		);--if end
	);--end
	
	on upBt pressed do
	(
		--���X�g�͋󂩁H
		if ( cutList.items.count != 0 ) then
		(
			--�I������Index��1�łȂ��A���ڂ��I������Ă����
			if  (cutList.selection != 1) then
			(
				--��[Index�l���i�[����
				tempIndex = cutList.selection;
				upList_Fn cutList.selection;
				updateList_Fn cutList cutFrameList;
				--�i�[����Index�l����I��������
				cutList.selection = tempIndex-1;
				cutFrameList.selection = tempIndex-1;
			);--if end
		);--if end
	);--end
	
	on downBt pressed do
	(
		--���X�g�͋󂩁H
		if ( cutList.items.count != 0 ) then
		(
			--�I������Index���Ō�łȂ��I������Ă����
			if  (cutList.selection != cutList.items.count) then
			(
				--��[Index�l���i�[����
				tempIndex = cutList.selection;
				downList_Fn cutList.selection;
				updateList_Fn cutList cutFrameList;
				--�i�[����Index�l����I��������
				--�i�[����Index�l����I��������
				cutList.selection = tempIndex+1;
				cutFrameList.selection = tempIndex+1;
			);--if end
		);--if end
	);--if end
	
	on replaceBt changed state do
	(
		--���X�g�͋󂩁H
		if ( cutList.items.count != 0 ) then
		(
		
		if (cutList.selection != 0) then
		(

		if state == on then
		(
			tempCameraList = #();
			Local picObj = undefined;
			picObj = pickObject message:"�I�u�W�F�N�g��I�����Ă�������:" count:1 select:false forceListenerFocus:false filter:pickFilter_Fn;
			
			if ((picObj == selection[1]) or (picObj == undefined)) then
			(	messageBox ("�o�^�o���܂���") titel:"���b�Z�[�W";
			)else(
				--����ւ�
				cameraListNTF[cutList.selection] = (nodeTransformMonitor node:picObj forwardTransformChangeMsgs:false);
				updateList_Fn cutList cutFrameList;
			);--if end
			
			replaceBt.state = off;
			cutListOnCb.enabled = true;
			max move;
			max select;
		)else(
			--���[�h��؂�ւ��邱�ƂŃo�O���
			max move;
			max select;
		)--if end
		
		);--if end
		
		)else(
			replaceBt.state = off;
			max move;
			max select;
		);--if end
		
	);--end
	
	on saveBt pressed do
	(
		--���X�g�͋󂩁H
		if ( cutList.items.count != 0 ) then
		(
			saveList_Fn();
			--���X�g�̃e�L�X�g���o��
			/*
			for i in cameraList.ListItems do
			(
			print i.text;
			--cameraList.ListItems[1].text;
			);--for end
			*/
		);--if end
	);--end
	
	on loadBt pressed do
	(
		clearList_Fn cutList cutFrameList;
		loadList_Fn();
		updateList_Fn cutList cutFrameList;
	);--end
	
	on helpBt pressed do
	(
		menuSys=menus()
		popUpMenu menuSys rollout:cut_list_rol
	);--on end
	
	--////////////////////////////////////////////////
	--���X�g�ҏW
	--////////////////////////////////////////////////
	/*�`�F�b�N�{�b�N�X���L���ȂƂ�����
	on cameraList ItemCheck item do
	(
	);--end
	*/
	
	--���E�̃��X�g�̑I���𓯊�
	on cutList selected sel do
	(
		if (sel != 0) do
		(
			cutFrameList.selection = cutList.selection;
			cutEdt.text = cutList.selected;
			--�X�s�i�[�̒l�����
			startSpn.value = startList[cutList.selection];
			endSpn.value = endList[cutList.selection];
		);--if end
		--hideEdt.text = hideCbx.selected;
	);--on end
	on cutFrameList selected sel do
	(
		if (sel != 0) do
		(
			cutList.selection = cutFrameList.selection;
			cutEdt.text = cutList.selected;
			--�X�s�i�[�̒l�����
			startSpn.value = startList[cutList.selection];
			endSpn.value = endList[cutList.selection];
		);--if end
		--hideEdt.text = hideCbx.selected;
	);--on end
	
	--���O�X�V
	on cutEdt entered str do
	(
		
		--��łȂ����
		if (str != "" and cutList.items.count != 0) then
		(
			cutList.selected = str;
			--�\���X�V
			cutList.items = cutList.items;
			cutEdt.text = str;
			
			--�J�����̖��O�𒼐ڕύX����
			cameraListNTF[cutList.selection].node.name = str;
			
		);--if end
	);--end
	--�ύX���ꂽ�Ƃ�
	on cutEdt changed str do
	(
		--��łȂ����
		if (str != "" and cutList.items.count != 0) then
		(
			cutList.selected = str;
			--�\���X�V
			cutList.items = cutList.items;
			cutEdt.text = str;
		);--if end
	);--end
	
	--�_�u���N���b�N�őI���A�A���h�D�Ώ�
	on cutList doubleclicked sel do
	(
		--�󂶂�Ȃ����
		if (cutList.items.count != 0) do
		(
			undo on(select cameraListNTF[sel].node);
		);--if end
	);
	--�_�u���N���b�N�őI���A�A���h�D�Ώ�
	on cutFrameList doubleclicked sel do
	(
		--�󂶂�Ȃ����
		if (cutList.items.count != 0) do
		(
			undo on(select cameraListNTF[sel].node);
		);--if end
	);	

-----------------------------------------------------------------------------------------------------------
--�t���[���ݒ�
-----------------------------------------------------------------------------------------------------------
		on startSpn changed val inSpin do
		(
			--�󂩂ǂ���
			if ( cameraListNTF.count != 0 and  cutList.selection != 0) then
			(
				--inSpine�Ƃ̓}�E�X���g���Ēl���ύX���ꂽ���ǂ����ł���
				--�l����������������s����
				if ( val < endSpn.value ) then
				(
					changeFrameSet_Fn val endSpn.value cutList.selection;
				)else(
					--end�����傫���Ȃ�Ȃ�end�̒l��1�𑫂�
					endSpn.value = val + 1;
					changeFrameSet_Fn val endSpn.value cutList.selection;
				);--if end
				updateList_Fn cutList cutFrameList;
			);--if end
		);--on end
		on endSpn changed val inSpin do
		(
			--�󂩂ǂ���
			if ( cameraListNTF.count != 0 and  cutList.selection != 0) then
			(
				--inSpine�Ƃ̓}�E�X���g���Ēl���ύX���ꂽ���ǂ����ł���
				--�l���傫��������
				if ( val > startSpn.value ) then
				(
					changeFrameSet_Fn startSpn.value val cutList.selection;
				)else(
					startSpn.value = val - 1;
					changeFrameSet_Fn startSpn.value val cutList.selection;
				);--if end
				updateList_Fn cutList cutFrameList;
			);--if end
		);--end
	
		on startSpn entered inSpine inCancel do
		(
			--�󂩂ǂ���
			if ( cameraListNTF.count != 0 and  cutList.selection != 0) then
			(
				--inSpine�Ƃ̓}�E�X���g���Ēl���ύX���ꂽ���ǂ����ł���
				--�l����������������s����
				if ( startSpn.value < endSpn.value ) then
				(
					changeFrameSet_Fn startSpn.value endSpn.value cutList.selection;
				)else(
					--end�����傫���Ȃ�Ȃ�end�̒l��1�𑫂�
					endSpn.value = endSpn.value + 1;
					changeFrameSet_Fn startSpn.value endSpn.value cutList.selection;
				);--if end
				updateList_Fn cutList cutFrameList;
			);--if end
		);--on end
		on endSpn entered inSpine inCancel do
		(
			--�󂩂ǂ���
			if ( cameraListNTF.count != 0 and  cutList.selection != 0) then
			(
				--inSpine�Ƃ̓}�E�X���g���Ēl���ύX���ꂽ���ǂ����ł���
				--�l���傫��������
				if ( endSpn.value > startSpn.value ) then
				(
					changeFrameSet_Fn startSpn.value endSpn.value cutList.selection;
				)else(
					startSpn.value = startSpn.value - 1;
					changeFrameSet_Fn startSpn.value endSpn.value cutList.selection;
				);--if end
				updateList_Fn cutList cutFrameList;
			);--if end
		);--end
		
		
		
		
		----------------------
		--���[���A�E�g�A�N�V����
		on cut_list_rol open do
		(
			--�t���[�J�������HV-Ray�̃J������
			if ((classOf selection[1] != Freecamera) and (classOf selection[1] != VRayPhysicalCamera)) then 
			(
				messageBox("���̃��f�B�t�@�C�A�̓t���[�J������p�ł�\n���f�B�t�@�C�A���폜���Ă�������")title:"���b�Z�[�W";
				--clearSelection()
				cutListOnCb.checked = false;
				cutListOnCb.enabled = false;
				addListBt.enabled = false;
				allSelBt.enabled = false;
				clearBt.enabled = false;
				deleteBt.enabled = false;
			)else(
				lastCheck = undefined;
				--makeListView_Fn cameraList;
				
				--V-Ray�̃J�������^�[�Q�b�g�J������������A�^�[�Q�b�g�𖳌��ɂ���
				if (classOf selection[1] == VRayPhysicalCamera) do
				(
					--�^�[�Q�b�g�J�������H�i�x�[�X�I�u�W�F�N�g�Ō����j
					 if (selection[1].targeted == true) do
					(
					selection[1].targeted = false;
					messageBox("V-Ray�J�������t���[�J�����ɕύX���܂����B\n�^�[�Q�b�g�J�����͎g�p�o���܂���B")title:"���b�Z�[�W";
					);--if end
					
					--V-ray�J�����������ꍇ��fov�ɕύX����
					selection[1].specify_fov = on
					
					--V-ray�J�����������ꍇ�t�B�����Q�[�g����v������
					--if (queryBox("�J�����̃t�B�����Q�[�g�������_�����O�ݒ�Ɉ�v�����܂���?")) do selection[1].film_width = getRendApertureWidth();
					selection[1].film_width = getRendApertureWidth();
					
					--VRay�������ꍇ��FOV�X�N���v�g
					addFovScriptVray_Fn();
					
				);--if end
				
				--updateList_Fn cameraList;
				
				--�X�N���v�g��ǉ�
				addTransformScript_Fn();
				--�t���[�J�����̏ꍇ��FOV
				if (classOf selection[1] == Freecamera) do addFovScript_Fn();
				
				--���X�g�͋󂩁H
				if ( cameraListNTF.count != 0 ) then
				(
					--messageBox "aaa"
					cutListOnCb.enabled = true
					--�I��1�̃t���[����������
					startSpn.value = startList[1];
					endSpn.value = endList[1];
					)else(
					cutListOnCb.enabled = false
					);--if end

				addListBt.enabled = true;
				allSelBt.enabled = true;
				clearBt.enabled = true;
				deleteBt.enabled = true;
				updateList_Fn cutList cutFrameList;
				
				--�X�s�i�[�̒l�����Ă����A���X�g��I�����Ă���
				cutFrameList.selection = 1;
				cutList.selection = 1;
				
			);--if end
		)--end on open
		
	)-- end cut_list_rol
	--////////////////////////////////////////////////
	-- �A�b�v�f�[�g
	--////////////////////////////////////////////////
	on update do
	(
		if version == 1 then
		(
			--print "Version 1 updated"
		)
	)--end on update	

	fn rollouts = (#(cut_list_rol))
)--end Plugin


/*

*/