/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark_ParamerLinker.ms
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
	group "Parameter Linker"
	(
		button paramLinkerBt "�p�����[�^�[�����J�[" width:160 hight:20
		spinner paramLinkerSpn "" range:[1,54,1] type:#integer width:160 align:#center
		radiobuttons paramLinkerRb "" width:160 enabled:true labels:#("Pos", "Rot","Sca") default:1 columns:3 align:#center
	)

--////////////////////////////////////////////////
--�m��
--////////////////////////////////////////////////
	on paramLinkerBt pressed do
	(
		
Local parameterLinkerStr1 = "
�A�g���r���[�g������I�u�W�F�N�g��I��ł�������

�ʏ�A�A�g���r���[�g�p�����[�^�[�͈ȉ��̂悤�ȃv���p�e�B�ɂȂ�܂�
$.modifiers[#SJ_Attribute_Holder].params.**.controller
(**�̓p�����[�^�[��)
��L�̈ȊO�̃p�����[�^�ɂ̓����N�ł��܂���
	
"

Local parameterLinkerStr2 = "
�ΏۃI�u�W�F�N�g��I�����Ă�������
�p�����[�^�[�̓x�W�G�����łȂ���΂Ȃ�܂���
����ȊO�̃p�����[�^�[�͓\��t�����܂���
	
"
		messageBox parameterLinkerStr1 title:"�p�����[�^�[�I�u�W�F�N�g��I��"
		Local pLinkerA = PickObject count:1 select:true message:"�I�u�W�F�N�g��I�����Ă��������B" ForceListenerFocus:False

		messageBox parameterLinkerStr2 title:"�ΏۃI�u�W�F�N�g��I��"
		Local pLinkerB = PickObject count:1 select:true message:"�I�u�W�F�N�g��I�����Ă��������B" Rubberband:selection[1].pos rubberBandColor:white ForceListenerFocus:False

		Local pLinkerTagX = undefined, pLinkerTagY = undefined, pLinkerTagZ = undefined;

		case paramLinkerRb.state of
		(
			1:(
				pLinkerTagX = "$"+ pLinkerA.name +".modifiers[#SJ_Attribute_Holder].params.X" + (paramLinkerSpn.value as String) + ".controller"
				pLinkerTagY = "$"+ pLinkerA.name +".modifiers[#SJ_Attribute_Holder].params.Y" + (paramLinkerSpn.value as String) + ".controller"
				pLinkerTagZ = "$"+ pLinkerA.name +".modifiers[#SJ_Attribute_Holder].params.Z" + (paramLinkerSpn.value as String) + ".controller"
					try(pLinkerB.pos.controller.X_Position.controller = execute(pLinkerTagX))catch(messageBox"X�̓\��t���Ɏ��s���܂���");
					try(pLinkerB.pos.controller.Y_Position.controller = execute(pLinkerTagY))catch(messageBox"Y�̓\��t���Ɏ��s���܂���");
					try(pLinkerB.pos.controller.Z_Position.controller = execute(pLinkerTagZ))catch(messageBox"Z�̓\��t���Ɏ��s���܂���");
			)--1end
			2:(
				pLinkerTagX = "$"+ pLinkerA.name +".modifiers[#SJ_Attribute_Holder].params.X" + (paramLinkerSpn.value as String) + ".controller"
				pLinkerTagY = "$"+ pLinkerA.name +".modifiers[#SJ_Attribute_Holder].params.Y" + (paramLinkerSpn.value as String) + ".controller"
				pLinkerTagZ = "$"+ pLinkerA.name +".modifiers[#SJ_Attribute_Holder].params.Z" + (paramLinkerSpn.value as String) + ".controller"
					try(pLinkerB.rotation.controller.X_Rotation.controller = execute(pLinkerTagX))catch(messageBox"X�̓\��t���Ɏ��s���܂���");
					try(pLinkerB.rotation.controller.Y_Rotation.controller = execute(pLinkerTagY))catch(messageBox"Y�̓\��t���Ɏ��s���܂���");
					try(pLinkerB.rotation.controller.Z_Rotation.controller = execute(pLinkerTagZ))catch(messageBox"Z�̓\��t���Ɏ��s���܂���");
			)--2end
			3:(
				pLinkerTagX = "$"+ pLinkerA.name +".modifiers[#SJ_Attribute_Holder].params.X" + (paramLinkerSpn.value as String) + ".controller"
				pLinkerTagY = "$"+ pLinkerA.name +".modifiers[#SJ_Attribute_Holder].params.Y" + (paramLinkerSpn.value as String) + ".controller"
				pLinkerTagZ = "$"+ pLinkerA.name +".modifiers[#SJ_Attribute_Holder].params.Z" + (paramLinkerSpn.value as String) + ".controller"
					try(pLinkerB.scale.controller.X_Scale.controller = execute(pLinkerTagX))catch(messageBox"X�̓\��t���Ɏ��s���܂���");
					try(pLinkerB.scale.controller.Y_Scale.controller = execute(pLinkerTagY))catch(messageBox"Y�̓\��t���Ɏ��s���܂���");
					try(pLinkerB.scale.controller.Z_Scale.controller = execute(pLinkerTagZ))catch(messageBox"Z�̓\��t���Ɏ��s���܂���");
			);--3end

		);--case end
		
		pLinkerA = undefined;
		pLinkerB = undefiend;
	);--end