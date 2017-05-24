/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark_SetController
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
		group "Controller Add And Changes"
		(
			button nuAttachBt "Null �Z�O�����g�A�^�b�`" width:160
			button addContPosBt "XYZ�ʒu�R���g���[���[��ǉ�" width:160
			button posContAttBt "XYZ�ʒu�R���g���[���[�ɕϊ�" width:160
			button addContRotBt "�I�C���[XYZ�ǉ�" width:160
			
			button scaContInstBt "�X�P�[�����C���X�^���X" width:160
			button scaContAttBt "XYZ�X�P�[���ɕϊ�" width:160
			
			button xtosaBt "�^�[���A���O��2XRot" width:160
		)
		
		group "Controll Breaker"
		(
		button scbPosBt "�ʒu" width:160 height:20
		button scbPosOffsetBt "�I�t�Z�b�g�ʒu" width:160 height:20
		
		button scbRotBt "��]" width:160 height:20
		button scbRotOffsetBt "�I�t�Z�b�g��]" width:160 height:20

		button scbScaBt "�X�P�[��" width:160 height:20
		button scbScaOffsetBt "�I�t�Z�b�g�X�P�[��" width:160 height:20
		)
-----------------------------------------------------------------------------------------------------------
-- �ȉ�����
-----------------------------------------------------------------------------------------------------------
		
		
--////////////
--�I�����b�V���̑I�𒸓_��Null��z�u����
--///////////
	on nuAttachBt pressed do
	(
	if selection.count == 1 and classOf selection[1].baseobject == Editable_Mesh	 then	--�I��1�ł��ҏW�\���b�V�����H
	(
		local p = #()	--�z��錾
			for i = 1 to selection[1].selectedVerts.count do
			(
				print selection[1].selectedVerts[i].index	--�ЂƂ܂��v�����g���Ƃ���
				p = Point pos:[0,0,0]	--Null�쐬
				p.position.controller = position_script()	--�R���g���[���[���ʒu�X�N���v�g�ɂ���
				p.position.controller.script = "pos = getvert $" + selection[1].name + " " + (selection[1].selectedVerts[i].index as String)	--�X�N���v�g�ǉ�
				--progbar.value = ((100.00/selection[1].selectedVerts.count)*i)	--�v���O���X�o�[����
			)--for end
		--progbar.value = 0
	)
	else(messageBox"�~�X����")--if end
	)

--////////////
--�I�𕨂Ɉꊇ�Ń}�N���X�N���v�g�����s�E�E�E�E�z���g�ɃR���ł����́H
--////////////
	on addContPosBt pressed do
	(
	try(
		local sl = for i in selection collect i;
		for i = 1 to sl.count do
		(
		select sl[i]
		macros.run "Controllers" "XYZ_P"	--�}�N���X�N���v�g��
		--clearSelection()
		)
	)catch(messageBox "���s" title:"�x��")--try end
	)--end


--////////////
--XYZ�|�W�V�����R���g���[���[�ɕϊ�
--///////////
on PosContAttBt pressed do
(
	for i = 1 to selection.count do
	(
	selection[i].pos.controller = Position_XYZ ()
	)--for end
)

--////////////
--�I�𕨂Ɉꊇ�Ń}�N���X�N���v�g�����s�E�E�E�E�z���g�ɃR���ł����́H
--////////////
	on addContRotBt pressed do
	(
	try(
		local sl = for i in selection collect i;
		for i = 1 to sl.count do
		(
		select sl[i]
		macros.run "Controllers" "EulerXYZ_R"	--�}�N���X�N���v�g��
		--progbar.value = ((100.00/sl.count)*i)
		clearSelection()
		)
	--progbar.value = 0
	)catch(messageBox "���s" title:"�x��")--try end
	)
	
	on scaContInstBt pressed do
	(
	try(
		for i in selection do
		(
			i.scale.controller = selection[1].scale.controller;
		)
	--progbar.value = 0
	)catch(messageBox "���s" title:"�x��")--try end
	);--end
	
	
	on scaContAttBt pressed do
	(
	try(
		for i in selection do
		(
			i.scale.controller = ScaleXYZ ();
		)
	--progbar.value = 0
	)catch(messageBox "���s" title:"�x��")--try end
	);--end
	
	
--////////////
--�^�[���p�x��ݒ�
--///////////
	on xtosaBt pressed do
	(
	try(
		for i = 1 to selection.count do
		(
		selection[i].transform.controller.swivelAngle.controller = float_script()	--�����X�N���v�g���^�[���p�x�ɓK��
		--selection[i].transform.controller.swivelAngle.controller.script = "--AAA\n"
		--selection[i].transform.controller.swivelAngle.controller.script += "2"
		--selection[i].transform.controller.swivelAngle.controller.script = "Local obj = nodeTransformMonitor node:selection[1] forwardTransformChangeMsgs:false;\n"
		--selection[i].transform.controller.swivelAngle.controller.script += "obj.node.transform.controller.IK_goal.controller.Rotation.controller.X_Rotation" + " / (1/tan(1))\n"
		selection[i].transform.controller.swivelAngle.controller.script = "$" + selection[i].name + ".transform.controller.IK_goal.controller.Rotation.controller.X_Rotation" + " / (1/tan(1))\n"
		selection[i].transform.controller.swivelAngle.controller.script += "--AAA\n"		
		)--for end
	)catch(messageBox "�I�u�W�F�N�g���� IK Chain �ȂǈȊO�ɂ��Ă݂Ă�������" title:"�x��")--try end
	)

-----------------------------------------------------------------------------------------------------------
-- �R���g���[���u���[�J�[
-----------------------------------------------------------------------------------------------------------
	on scbPosBt pressed do	
	(
	undo on(
		for i in selection do
		(
			i.pos.controller = position_list ();
			i.pos.controller.delete 1;
		);--for end
	);--undo end
	)--end

	on scbPosOffsetBt pressed do
	(
	undo on(
		for i in selection do
		(
			i.pos.controller = position_list ();
			i.pos.controller.enabled.controller = position_list ();
			i.pos.controller.active = 2;
		);--for end
	);--undo end
	)--end
	
	
	on scbRotBt pressed do
	(
	undo on(
		for i in selection do
		(
			i.rotation.controller = rotation_list ();
			i.rotation.controller.delete 1;
		);--for end
	);--undo end
	)--end
	
	on scbRotOffsetBt pressed do
	(
	undo on(
		for i in selection do
		(
			i.rotation.controller = rotation_list ();
			i.rotation.controller.enabled.controller = rotation_list ();
			i.rotation.controller.active = 2;
		);--for end
	);--undo end
	)--end
	
	on scbScaBt pressed do
	(
	undo on(
		for i in selection do
		(
			i.scale.controller = scale_list ();
			i.scale.controller.delete 1;
		);--for end
	);--undo end
	)--end
	
	on scbScaOffsetBt pressed do
	(
	undo on(
		for i in selection do
		(
			i.scale.controller = scale_list ();
			i.scale.controller.enabled.controller = scale_list ();
			i.scale.controller.active = 2;
		);--for end
	);--undo end
	)--end


	