r/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
(
-----------------------------------------------------------------------------------------------------------
-- �O���[�o������
-----------------------------------------------------------------------------------------------------------
--���[���A�E�g�p
global sj_spark_rol
global sj_sparksub_rol
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
-----------------------------------------------------------------------------------------------------------
-- ���ꏉ����
include "$scripts/SJTools/SJ_CommonLangSet.ms"

--Version etc ���O���̂�SJTools.ini����
Local nameAndVersion = (getINISetting("$scripts/SJTools/SJTools.ini")  "SJToolsToolName" "SJSparkToolName");
-----------------------------------------------------------------------------------------------------------
Local NearSearchTagObj;
-----------------------------------------------------------------------------------------------------------
-- Rollouts
-----------------------------------------------------------------------------------------------------------
try(cui.FloatDialogBar sj_spark_rol)catch()
try(cui.unRegisterDialogBar sj_spark_rol)catch()
try( CloseRolloutFloater sj_spark_rol) catch()
try(destroydialog sj_spark_rol)catch()

-----------------------------------------------------------------------------------------------------------
--���j���[
-----------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////
--���j���[
--////////////////////////////////////////////////
rcMenu sparkMenuBar
(
subMenu "�w���v"
( 
menuItem helpMi "�w���v"
menuItem aboutMi "About"
menuItem emailMi "E-Mail"
)

--////////////////////////////////////////////////
--�A�N�V����
--////////////////////////////////////////////////
on helpMi picked do shellLaunch "http://www.sakaiden.com/?page_id=5896" ""
on aboutMi picked do sj_functions.sjtools_about_Fn();
on emailMi picked do shellLaunch "mailTo:sakaiden@live.jp" ""
on poserMenuBar update do
(
)
)--rcMenu end

-----------------------------------------------------------------------------------------------------------
--�؂�ւ��^�u�p
-----------------------------------------------------------------------------------------------------------
rollout sj_spark_tabs_rol "�^�u�؂�ւ��{�^��"-- width:224 height:800
(

	
)--rol end


-----------------------------------------------------------------------------------------------------------
--�I�u�W�F�N�g�֘A�A�\���֘A
-----------------------------------------------------------------------------------------------------------
rollout sj_spark_objects_rol "Spark!! Objects"-- width:224 height:800
(
	include "$scripts/SJTools/SJScripts/SJ_Spark_ParentButton.ms"	
	include "$scripts/SJTools/SJScripts/SJ_Spark_HelperVisualChange.ms"	
	include "$scripts/SJTools/SJScripts/SJ_Spark_HelperGa.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_DummyBoxSizeChange.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_SnapShotMaster.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_Select.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_ArraySort.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_Text2EditableMesh.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_LayerLayer.ms"
	
)--rol end


-----------------------------------------------------------------------------------------------------------
--�A�j���[�V�����֘A
-----------------------------------------------------------------------------------------------------------
rollout sj_spark_animations_rol "Spark!! Animtions"-- width:224 height:800
(
	include "$scripts/SJTools/SJScripts/SJ_Spark_CameraConverter.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_PickTheCopy.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_BipControll.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_AnimKeyDelete.ms"
		
)--rol end


-----------------------------------------------------------------------------------------------------------
--�R���g���[���[�֘A
-----------------------------------------------------------------------------------------------------------
rollout sj_spark_contorollers_rol "Spark!! Controllers"
(
	include "$scripts/SJTools/SJScripts/SJ_Spark_SetController.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_ObjectsDistance.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_ObjectsLinker.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_ParamerLinker.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_MakeLookatPoint.ms"
	--include "$scripts/SJTools/SJScripts/SJ_Spark_AllBeyondArrayCheck.ms"

)--end

-----------------------------------------------------------------------------------------------------------
--�\���A�c�[���֘A
-----------------------------------------------------------------------------------------------------------
rollout sj_spark_tools_rol "Spark!! Tools"
(
	include "$scripts/SJTools/SJScripts/SJ_Spark_MrSkiner.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_PolyMan.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_Zweihander.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_SoundCnt.ms"	
	include "$scripts/SJTools/SJScripts/SJ_Spark_ExportBatch.ms"
	include "$scripts/SJTools/SJScripts/SJ_Spark_ScaleChecker.ms"
)--end

-----------------------------------------------------------------------------------------------------------
--���̑��A����
-----------------------------------------------------------------------------------------------------------
rollout sj_spark_other_rol "Spark!! Other"
(
	include "$scripts/SJTools/SJScripts/SJ_Spark_Others.ms"
	--include "$scripts/SJTools/SJScripts/SJ_Spark_AllBeyondArrayCheck.ms"

)--end

-----------------------------------------------------------------------------------------------------------
--���̑�
-----------------------------------------------------------------------------------------------------------



rollout sj_spark_rol nameAndVersion width:234 height:980
(
-----------------------------------------------------------------------------------------------------------
-- �t�@���N�V����
-----------------------------------------------------------------------------------------------------------
--�A�N�e�B�uX�̐ݒ�
--activeXcontrol menuTabs "MSComctlLib.TabStrip.2" height:20;

--���[���A�E�g�ݒ�
--�T�u���[���A�E�g�̃G���A��2�ݒ肷��

--�^�u�؂�ւ����[���A�E�g
--subrollout sj_sparkTabs pos:[0,0] width:sj_spark_rol.width height:20;
--���C���̃��[���A�E�g
subrollout sj_sparkarea pos:[0,60] width:sj_spark_rol.width height:920;
	button sparkTabsS "S" pos:[0,8] width:46 height:46;
	button sparkTabsP "P" pos:[47,8] width:46 height:46;
	button sparkTabsA "A" pos:[94,8] width:46 height:46;
	button sparkTabsR "R" pos:[141,8] width:46 height:46;
	button sparkTabsK "K" pos:[188,8] width:46 height:46;

	--�^�u�؂�ւ��A�N�V����
	on sparkTabsS pressed do
		(
		removeSubRollout sj_sparkarea sj_spark_animations_rol
		removeSubRollout sj_sparkarea sj_spark_contorollers_rol
		removeSubRollout sj_sparkarea sj_spark_tools_rol
		removeSubRollout sj_sparkarea sj_spark_other_rol
		addSubRollout sj_sparkarea sj_spark_objects_rol
		)--on end
	on sparkTabsP pressed do
		(
		removeSubRollout sj_sparkarea sj_spark_objects_rol
		removeSubRollout sj_sparkarea sj_spark_contorollers_rol
		removeSubRollout sj_sparkarea sj_spark_tools_rol
		removeSubRollout sj_sparkarea sj_spark_other_rol
		addSubRollout sj_sparkarea sj_spark_animations_rol
		)--on end
	on sparkTabsA pressed do
		(
		removeSubRollout sj_sparkarea sj_spark_objects_rol
		removeSubRollout sj_sparkarea sj_spark_animations_rol
		removeSubRollout sj_sparkarea sj_spark_tools_rol
		removeSubRollout sj_sparkarea sj_spark_other_rol
		addSubRollout sj_sparkarea sj_spark_contorollers_rol
		)--on end
	on sparkTabsR pressed do
		(
		removeSubRollout sj_sparkarea sj_spark_objects_rol
		removeSubRollout sj_sparkarea sj_spark_animations_rol
		removeSubRollout sj_sparkarea sj_spark_contorollers_rol
		removeSubRollout sj_sparkarea sj_spark_other_rol
		addSubRollout sj_sparkarea sj_spark_tools_rol
		)--on end
	on sparkTabsK pressed do
		(
		removeSubRollout sj_sparkarea sj_spark_objects_rol
		removeSubRollout sj_sparkarea sj_spark_animations_rol
		removeSubRollout sj_sparkarea sj_spark_contorollers_rol
		removeSubRollout sj_sparkarea sj_spark_tools_rol
		addSubRollout sj_sparkarea sj_spark_other_rol
		)--on end


--�A�N�e�B�uX�̐؂�ւ��A�N�V����
/*
on menuTabs Click do
(
	case menuTabs.SelectedItem.index of
	(
		1:
		(
		removeSubRollout sj_sparkarea sj_spark_animations_rol
		removeSubRollout sj_sparkarea sj_spark_contorollers_rol
		removeSubRollout sj_sparkarea sj_spark_tools_rol
		removeSubRollout sj_sparkarea sj_spark_other_rol
		addSubRollout sj_sparkarea sj_spark_objects_rol
		)--case 1 end
		2:
		(
		removeSubRollout sj_sparkarea sj_spark_objects_rol
		removeSubRollout sj_sparkarea sj_spark_contorollers_rol
		removeSubRollout sj_sparkarea sj_spark_tools_rol
		removeSubRollout sj_sparkarea sj_spark_other_rol
		addSubRollout sj_sparkarea sj_spark_animations_rol
		)--case 2 end
		3:
		(
		removeSubRollout sj_sparkarea sj_spark_objects_rol
		removeSubRollout sj_sparkarea sj_spark_animations_rol
		removeSubRollout sj_sparkarea sj_spark_tools_rol
		removeSubRollout sj_sparkarea sj_spark_other_rol
		addSubRollout sj_sparkarea sj_spark_contorollers_rol
		)--case 2 end
		4:
		(
		removeSubRollout sj_sparkarea sj_spark_objects_rol
		removeSubRollout sj_sparkarea sj_spark_animations_rol
		removeSubRollout sj_sparkarea sj_spark_contorollers_rol
		removeSubRollout sj_sparkarea sj_spark_other_rol
		addSubRollout sj_sparkarea sj_spark_tools_rol
		)--case 2 end
		5:
		(
		removeSubRollout sj_sparkarea sj_spark_objects_rol
		removeSubRollout sj_sparkarea sj_spark_animations_rol
		removeSubRollout sj_sparkarea sj_spark_contorollers_rol
		removeSubRollout sj_sparkarea sj_spark_tools_rol
		addSubRollout sj_sparkarea sj_spark_other_rol
		)--case 2 end
	)--case end
)
*/

on sj_spark_rol open do
(

--Local aaa = #("$Scripts/SJTools/Images//SJ_button_add.gif", "$Scripts/SJTools/Images//SJ_button_add_a.gif", 2, 1, 1, 2, 2);
--print aaa
--showProperties menuTabs.ImageList
--print menuTabs.ImageList.count
--menuTabs[1].Image = aaa
--menuTabs.Image = #("$Scripts/SJTools/Images//SJ_button_pose.gif", "$Scripts/SJTools/Images//SJ_button_pose_a.gif", 2, 1, 1, 2, 2);

	/*�A�N�e�B�uX�̐ݒ�
	menuTabs.tabs[1].caption = "S"
	menuTabs.tabs.add pvCaption:"P"
	menuTabs.tabs.add pvCaption:"A"
	menuTabs.tabs.add pvCaption:"R"
	menuTabs.tabs.add pvCaption:"K"
	*/
);

on sj_spark_rol close do try(gc())catch();

);--endMainRollout



-----------------------------------------------------------------------------------------------------------
-- End of rollout & Create Dialog / Floater
-----------------------------------------------------------------------------------------------------------
CreateDialog sj_spark_rol pos:[50,50] style:#(#style_border, /*#style_titlebar,*/#style_toolwindow, #style_sysmenu, #style_resizing, #style_minimizebox) menu:sparkMenuBar;
--CreateDialog sj_spark_rol pos:[50,50] menu:sparkMenuBar style:#(#style_border, #style_titlebar, #style_sysmenu, #style_minimizebox) menu:CanvasMenu


--�T�u���[���A�E�g��ǉ�
--�^�u�p
--addSubRollout sj_spark_rol.sj_sparkTabs sj_spark_tabs_rol;
--�I�u�W�F�N�g�p
addSubRollout sj_spark_rol.sj_sparkarea sj_spark_objects_rol;
--����ȕ��ɂ��ǉ��\
--addSubRollout sj_spark_rol.sj_sparkarea sj_spark_tools_rol



--addSubRollout sj_spark_rol.sj_sparkarea sj_spark_animations_rol
--addSubRollout sj_spark_rol.sj_sparkarea sj_spark_contorollers_rol

)--end macroscript