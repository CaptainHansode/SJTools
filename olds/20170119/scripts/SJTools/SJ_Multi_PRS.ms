/*******************************************************
System J Tools 
********************************************************
Name:SJ_MultiPRS
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/

(

-----------------------------------------------------------------------------------------------------------
-- �O���[�o������
-----------------------------------------------------------------------------------------------------------
global sj_multi_rps_rol--���[���A�E�g�p
	
-- ���ꏉ����
include "$scripts/SJTools/SJ_CommonLangSet.ms"

-----------------------------------------------------------------------------------------------------------
-- ���[���A�E�g����
-----------------------------------------------------------------------------------------------------------
try(cui.FloatDialogBar sj_multi_rps_rol)catch()	--�_�C�A���O�̃t���[�g�������݂܂�
try(cui.unRegisterDialogBar sj_multi_rps_rol)catch()		--�h�b�L���O�\�� MAXScript �E�B���h�E�𖢓o�^�ɂ��܂�
try(closeRolloutFloater sj_multi_rps_rol) catch()	--���[���A�E�g�t���[�^�[���J���Ă������[����
try(destroydialog sj_multi_rps_rol)catch()		--�_�C�A���O�����ɊJ���Ă����ꍇ�͈�x��������݂܂�

-----------------------------------------------------------------------------------------------------------
-- �t�@���N�V����
-----------------------------------------------------------------------------------------------------------
--////////////////////////////////////////////////
--�A�b�v�f�[�g
--////////////////////////////////////////////////
fn selCountCheck_Fn =
(
	local checkTemp = true
	
	if selection.count != 0 then
	(
	
		if (selection[1].position.controller as String) != "Controller:Position_XYZ" then
		(
		sj_multi_rps_rol.infoLbl.caption = "����ȃR���g���[���[��\n�܂܂�Ă��܂�"
		)
		else
		(
		sj_multi_rps_rol.infoLbl.caption = ""
		)--if end

		if (selection[1].rotation.controller as String) != "Controller:Euler_XYZ" then
		(
		sj_multi_rps_rol.infoLbl.caption = "����ȃR���g���[���[��\n�܂܂�Ă��܂�"
		)
		else
		(
		sj_multi_rps_rol.infoLbl.caption = ""
		)--if end
	
		checkTemp = true
	)
	else
	(
		CheckTemp = false
		--pos
		sj_multi_rps_rol.posXSp.value = 0.0
		sj_multi_rps_rol.posYSp.value = 0.0
		sj_multi_rps_rol.posZSp.value = 0.0
		--rot
		sj_multi_rps_rol.rotXSp.value = 0.0
		sj_multi_rps_rol.rotYSp.value = 0.0
		sj_multi_rps_rol.rotZSp.value = 0.0
		--sca
		sj_multi_rps_rol.scaXSp.value = 0.0
		sj_multi_rps_rol.scaYSp.value = 0.0
		sj_multi_rps_rol.scaZSp.value = 0.0
	)--if end
	sj_multi_rps_rol.posXSp.enabled = checkTemp
	sj_multi_rps_rol.posYSp.enabled = checkTemp
	sj_multi_rps_rol.posZSp.enabled = checkTemp
	sj_multi_rps_rol.rotXSp.enabled = checkTemp
	sj_multi_rps_rol.rotYSp.enabled = checkTemp
	sj_multi_rps_rol.rotZSp.enabled = checkTemp
	sj_multi_rps_rol.scaXSp.enabled = checkTemp
	sj_multi_rps_rol.scaYSp.enabled = checkTemp
	sj_multi_rps_rol.scaZSp.enabled = checkTemp
)--fn end

fn multi_rps_update_Fn =
(
	try(
	selCountCheck_Fn()
	if selection.count != 0 do --�I�u�W�F�N�g�͑I������Ă��邩�H
	(
		--if selection.count > 1 do sj_multi_rps_rol.infoLbl.caption = "�����I���̏ꍇ��\n�ŏ��ɑI�������Ώۂ̐��l��\n���f����܂�"

		case sj_multi_rps_rol.typeRb.state of
		(
		1:(
			--pos
			sj_multi_rps_rol.posXSp.value = (in coordsys world selection[1].pos.x)
			sj_multi_rps_rol.posYSp.value = (in coordsys world selection[1].pos.y)
			sj_multi_rps_rol.posZSp.value = (in coordsys world selection[1].pos.z)
			--rot
			sj_multi_rps_rol.rotXSp.value = (in coordsys world selection[1].rotation.X_rotation)
			sj_multi_rps_rol.rotYSp.value = (in coordsys world selection[1].rotation.Y_rotation)
			sj_multi_rps_rol.rotZSp.value = (in coordsys world selection[1].rotation.Z_rotation)
			--sca
			sj_multi_rps_rol.scaXSp.value = ((in coordsys world selection[1].scale.x) * 100.0)
			sj_multi_rps_rol.scaYSp.value = ((in coordsys world selection[1].scale.y) * 100.0)
			sj_multi_rps_rol.scaZSp.value = ((in coordsys world selection[1].scale.z) * 100.0)
		)--case 1 end
		
		2:(
			--pos
			sj_multi_rps_rol.posXSp.value = (in coordsys parent selection[1].pos.x)
			sj_multi_rps_rol.posYSp.value = (in coordsys parent selection[1].pos.y)
			sj_multi_rps_rol.posZSp.value = (in coordsys parent selection[1].pos.z)
			--rot
			sj_multi_rps_rol.rotXSp.value = (in coordsys parent selection[1].rotation.X_rotation)
			sj_multi_rps_rol.rotYSp.value = (in coordsys parent selection[1].rotation.Y_rotation)
			sj_multi_rps_rol.rotZSp.value = (in coordsys parent selection[1].rotation.Z_rotation)
			--sca
			sj_multi_rps_rol.scaXSp.value = ((in coordsys parent selection[1].scale.x) * 100.0)
			sj_multi_rps_rol.scaYSp.value = ((in coordsys parent selection[1].scale.y) * 100.0)
			sj_multi_rps_rol.scaZSp.value = ((in coordsys parent selection[1].scale.z) * 100.0)
		)--case 2 end
		
		3:(
			--pos
			sj_multi_rps_rol.posXSp.value = 0.0
			sj_multi_rps_rol.posYSp.value = 0.0
			sj_multi_rps_rol.posZSp.value = 0.0
			--rot
			sj_multi_rps_rol.rotXSp.value = 0.0
			sj_multi_rps_rol.rotYSp.value = 0.0
			sj_multi_rps_rol.rotZSp.value = 0.0
			--sca
			sj_multi_rps_rol.scaXSp.value = 0.0
			sj_multi_rps_rol.scaYSp.value = 0.0
			sj_multi_rps_rol.scaZSp.value = 0.0
		)--case 3 end
		
		)--case end
	)--if end
	
	)catch(sj_multi_rps_rol.infoLbl.caption = "�ϊ��o���܂���ł���\n���FBiped�͔�Ή��ł�")
)

--////////////////////////////////////////////////
--���
--////////////////////////////////////////////////
--�ʒu
fn changePosValue_Fn axis value =
(
	case axis of
	(
		1:(
			case sj_multi_rps_rol.typeRb.state of
			(
				3:(
					for i=1 to selection.count do
					(
						selection[i].pos.x += value
					) --for end
				) --case 3 end
				default:(
					for i=1 to selection.count do
					(
						selection[i].pos.x = value
					) --for end					
				) --default end
			) --case end
		)--case 1 end

		2:(
			case sj_multi_rps_rol.typeRb.state of
			(
				3:(
					for i=1 to selection.count do
					(
						selection[i].pos.y += value
					) --for end
				) --case 3 end
				default:(
					for i=1 to selection.count do
					(
						selection[i].pos.y = value
					) --for end					
				) --default end
			) --case end
		) --case 2 end

		3:(
			case sj_multi_rps_rol.typeRb.state of
			(
				3:(
					for i=1 to selection.count do
					(
						selection[i].pos.z += value
					) --for end
				) --case 3 end
				default:(
					for i=1 to selection.count do
					(
						selection[i].pos.z = value
					) --for end					
				) --default end
			) --case end
		) --case 3 end
	) --case axis end
) --Fn end

--��]
fn changeRotValue_Fn axis valueX valueY valueZ =
Local valueTemp = ((EulerAngles valueX valueY valueZ) as quat)
print valueTemp
(
	case axis of
	(
		1:(
			case sj_multi_rps_rol.typeRb.state of
			(
				3:(
					for i=1 to selection.count do
					(
						selection[i].rotation += valueTemp
						--selection[i].rotation.X_rotation += value
					) --for end
				) --case 3 end
				default:(
					for i=1 to selection.count do
					(
						selection[i].rotation = valueTemp
						--selection[i].rotation.X_rotation = valueTemp
					) --for end					
				) --default end
			) --case end
		)--case 1 end

		2:(
			case sj_multi_rps_rol.typeRb.state of
			(
				3:(
					for i=1 to selection.count do
					(
						selection[i].rotation.Y_rotation += value
					) --for end
				) --case 3 end
				default:(
					for i=1 to selection.count do
					(
						selection[i].rotation.Y_rotation = value
					) --for end					
				) --default end
			) --case end
		) --case 2 end

		3:(
			case sj_multi_rps_rol.typeRb.state of
			(
				3:(
					for i=1 to selection.count do
					(
						selection[i].rotation.Z_rotation += value
					) --for end
				) --case 3 end
				default:(
					for i=1 to selection.count do
					(
						selection[i].rotation.Z_rotation = value
					) --for end					
				) --default end
			) --case end
		) --case 3 end
	) --case axis end
) --Fn end

--�X�P�[��
fn changeScaValue_Fn axis value =
(
	local valueTemp = value / 100
	case axis of
	(
		1:(
			case sj_multi_rps_rol.typeRb.state of
			(
				3:(
					for i=1 to selection.count do
					(
						selection[i].scale.x += valueTemp
					) --for end
				) --case 3 end
				default:(
					for i=1 to selection.count do
					(
						selection[i].scale.x = (in coordsys parent valueTemp)
					) --for end					
				) --default end
			) --case end
		)--case 1 end

		2:(
			case sj_multi_rps_rol.typeRb.state of
			(
				3:(
					for i=1 to selection.count do
					(
						selection[i].scale.y += valueTemp
					) --for end
				) --case 3 end
				default:(
					for i=1 to selection.count do
					(
						selection[i].scale.y = (in coordsys parent valueTemp)
					) --for end					
				) --default end
			) --case end
		) --case 2 end

		3:(
			case sj_multi_rps_rol.typeRb.state of
			(
				3:(
					for i=1 to selection.count do
					(
						selection[i].scale.z += valueTemp
					) --for end
				) --case 3 end
				default:(
					for i=1 to selection.count do
					(
						selection[i].scale.z = (in coordsys parent valueTemp)
					) --for end					
				) --default end
			) --case end
		) --case 3 end
	) --case axis end
) --Fn end


-----------------------------------------------------------------------------------------------------------
-- ���C�� Rollout
-----------------------------------------------------------------------------------------------------------
rollout sj_multi_rps_rol "�j���[ v0.1Beta" width:160 height:464
(
--////////////////////////////////////////////////
--���C�A�E�g
--////////////////////////////////////////////////
	local minRange = -10000000, maxRange = 10000000
	groupBox typeGb "�Z�b�e�B���O" pos:[8,8] width:144 height:68
	radioButtons typeRb "" pos:[16,24] width:79 height:48 labels:#("���[���h", "�e", "�I�t�Z�b�g") columns:1

	groupBox posGb "�ʒu" pos:[8,80] width:144 height:88	
	spinner posXSp "X : " pos:[10,96] width:132 height:16 range:[minRange,maxRange,0] scale:0.01 enabled:false
	spinner posYSp "Y : " pos:[10,120] width:132 height:16 range:[minRange,maxRange,0] scale:0.01 enabled:false
	spinner posZSp "Z : " pos:[10,144] width:132 height:16 range:[minRange,maxRange,0] scale:0.01 enabled:false
	
	groupBox rotGb "��]" pos:[8,176] width:144 height:88
	spinner rotXSp "X : " pos:[10,192] width:132 height:16 range:[minRange,maxRange,0] scale:0.1 enabled:false
	spinner rotYSp "Y : " pos:[10,216] width:132 height:16 range:[minRange,maxRange,0] scale:0.1 enabled:false
	spinner rotZSp "Z : " pos:[10,240] width:132 height:16 range:[minRange,maxRange,0] scale:0.1 enabled:false
	
	groupBox scaleGb "�X�P�[��" pos:[8,272] width:144 height:88
	spinner scaXSp "X : " pos:[10,288] width:132 height:16 range:[minRange,maxRange,0] scale:0.01 enabled:false
	spinner scaYSp "Y : " pos:[10,312] width:132 height:16 range:[minRange,maxRange,0] scale:0.01 enabled:false
	spinner scaZSp "Z : " pos:[10,336] width:132 height:16 range:[minRange,maxRange,0] scale:0.01 enabled:false

	groupBox infoGb "Info" pos:[8,368] width:144 height:88
	label infoLbl "" pos:[16,384] width:128 height:48
	--label lbl8 "0�I��" pos:[16,402] width:128 height:16

--////////////////////////////////////////////////
--�A�b�v�f�[�g
--////////////////////////////////////////////////
	on typeRb changed state do multi_rps_update_Fn()

	on posXSp changed state do with redraw off(changePosValue_Fn 1 state)
	on posYSp changed state do changePosValue_Fn 2 state
	on posZSp changed state do changePosValue_Fn 3 state
	
	on rotXSp changed state do with redraw off(changeRotValue_Fn 1 state rotYSp.value rotZSp.value)
	on rotYSp changed state do changeRotValue_Fn 2 state
	on rotZSp changed state do changeRotValue_Fn 3 state

	on scaXSp changed state do changeScaValue_Fn 1 state
	on scaYSp changed state do changeScaValue_Fn 2 state
	on scaZSp changed state do changeScaValue_Fn 3 state
	
	--Open,Close
	on sj_multi_rps_rol open do
	(
	/*
		messageBox("
����Beta�ł̂��߂Ɋ���s�������܂�\n
�E��]�l����肭�ϊ�����Ȃ���������܂�
�ETCB�R���g���[���[�Ȃǂɂ͑Ή����Ă��܂���
�E�A���h�D�ō�Ƃ�߂����Ƃ͂ł��܂���\n
�E�����I���̏ꍇ�́A�ŏ��ɑI�������I�u�W�F�N�g�̐��l��\���܂�
�E�����I���ł̉�]�͊e�I�u�W�F�N�g���ɉ�]���܂�\n
�EBiped�͔�Ή��ł��ABiped�ɑ΂��Ďg�p���Ȃ��ł�������
�o�O��܂�\n
���ǒ��ł���
") title:"����"
*/
		registerRedrawViewsCallback multi_rps_update_Fn --�R�[���o�b�N�ɓo�^���܂��@�R�[���o�b�N�͍폜����Ȃ����蓮�삵�Â��܂�
		multi_rps_update_Fn() --�ЂƂ܂����s
	)

	on sj_multi_rps_rol close do unregisterRedrawViewsCallback multi_rps_update_Fn --�R�[���o�b�N���폜���܂�

)--rol end

-----------------------------------------------------------------------------------------------------------
-- End of rollout & Create Dialog / Floater
-----------------------------------------------------------------------------------------------------------
CreateDialog sj_multi_rps_rol

)--end macroscript