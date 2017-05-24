/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark_ObjectsLinker.ms
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
	group "Objects Linker"
	(
		button nearGetTagBt "�Ώۓo�^" width:160 hight:20
		button nearTagClearBt "�N���A" width:160 hight:20
		button doppelLinkerBt "�h�b�y�������J�[" width:160 hight:20
		button nearSearchTagBt "��ԋ߂��̃I�u�W�F�N�g�Ƀ����N" width:160 hight:20
		button nearSearchTagCPBt "�߂Ɉʒu�R���X�g���C���g" width:160 hight:20
		checkbox posOffsetOLChk "�I�t�Z�b�g" align:#left
		button nearSearchTagCRBt "�߂ɉ�]�R���X�g���C���g" width:160 hight:20
		checkbox rotOffsetOLChk "�I�t�Z�b�g" align:#left
	)
--////////////////////////////////////////////////
--�m��
--////////////////////////////////////////////////
	on nearGetTagBt pressed do
	(
		NearSearchTagObj = for i in selection collect i;
		nearGetTagBt.caption = "�o�^�ς�";
	);--end
	on nearTagClearBt pressed do
	(
		NearSearchTagObj = #();
		nearGetTagBt.caption = "�Ώۓo�^";
	)
--////////////////////////////////////////////////
--doppelLinker
--////////////////////////////////////////////////
	on doppelLinkerBt pressed do
	(
		Local dopObj, myObj = undifined;
	
	if selection.count != 0 then
	(
	if NearSearchTagObj != undefined then
	(
		for i in selection do
		(
			if i.parent != undefined then
			(
				dopObj = i.parent;
				i.parent = undefined;
				--�Đڑ�
				for k in NearSearchTagObj do
				(
					if k.name == dopObj.name then
					(
						if dopObj.inode.handle != k.inode.handle then i.parent = k;
					)--if end
				);--for end
			);--if end
		);--for end
	);--if end
	);--if end
	);--end

--////////////////////////////////////////////////
--���s
--////////////////////////////////////////////////
	on nearSearchTagBt pressed do
	(
	Local distanceA, distanceB, myObj = undifined;
	Local baseObj = selection[1];
	
	if NearSearchTagObj != undefined then
	(

	for k in selection do
	(
	 baseObj = k;
	 
		distanceA = distance baseObj NearSearchTagObj[1];
		myObj = NearSearchTagObj[1];

		--2�ڍs�������߂���Γ���ւ�
		for i = 2 to nearSearchTagObj.count do
		(
			distanceB = distance baseObj NearSearchTagObj[i];
			
			if distanceA > distanceB then
			(
				distanceA = distanceB;
				myObj = NearSearchTagObj[i];
			);--if end

		);--for end

		try(baseObj.parent = myObj)catch();

	);--for end

	);--if end
	
	)--on end
	
--////////////////////////////////////////////////
--�R���X�g���C���g
--////////////////////////////////////////////////
	on nearSearchTagCPBt pressed do
	(
	suspendEditing()--�T�X�y���h���[�h
	--max create mode--�N���G�[�g���[�h�ɕύX
	with redraw off
	(--�ĕ`��֎~
	
	Local distanceA, distanceB, myObj = undifined;
	Local baseObj = selection[1];
	if NearSearchTagObj != undefined then
	(

	for k in selection do
	(
	 baseObj = k;
	 
		distanceA = distance baseObj NearSearchTagObj[1];
		myObj = NearSearchTagObj[1];
		
		--2�ڍs�������߂���Γ���ւ�
		for i = 2 to nearSearchTagObj.count do
		(
			distanceB = distance baseObj NearSearchTagObj[i];
			if distanceA > distanceB then
			(
				distanceA = distanceB;
				myObj = NearSearchTagObj[i];
			);--if end
		);--for end

		--�R���X�g���C���g�����s
		try(
			baseObj.pos.controller = Position_XYZ ()--��U���Z�b�g
			baseObj.pos.controller = position_list ();
			baseObj.pos.controller.enabled.controller = Position_Constraint ();
			baseObj.pos.controller.active = 2;
			baseObj.pos.controller.Position_Constraint.controller.appendTarget myObj 50.0
			if posOffsetOLChk.checked then baseObj.pos.controller.Position_Constraint.controller.relative = on
		)catch();

	);--for end

	);--if end
	
	
	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
	
	)--on end

--////////////////////////////////////////////////
--��]�R���X�g���C���g
--////////////////////////////////////////////////
	on nearSearchTagCRBt pressed do
	(
	suspendEditing()--�T�X�y���h���[�h
	--max create mode--�N���G�[�g���[�h�ɕύX
	with redraw off
	(--�ĕ`��֎~
	
	Local distanceA, distanceB, myObj = undifined;
	Local baseObj = selection[1];
	if NearSearchTagObj != undefined then
	(

	for k in selection do
	(
	 baseObj = k;
	 
		distanceA = distance baseObj NearSearchTagObj[1];
		myObj = NearSearchTagObj[1];
		
		--2�ڍs�������߂���Γ���ւ�
		for i = 2 to nearSearchTagObj.count do
		(
			distanceB = distance baseObj NearSearchTagObj[i];
			if distanceA > distanceB then
			(
				distanceA = distanceB;
				myObj = NearSearchTagObj[i];
			);--if end
		);--for end

		--�R���X�g���C���g�����s
		try(
			baseObj.rotation.controller = Euler_XYZ ();--��U���Z�b�g
			baseObj.rotation.controller = rotation_list ();
			baseObj.rotation.controller.enabled.controller = Orientation_Constraint ();
			baseObj.rotation.controller.active = 2;
			baseObj.rotation.controller[2].controller.appendTarget myObj 50.0;
			if rotOffsetOLChk.checked then baseObj.rotation.controller[2].controller.relative = on;
		)catch();

	);--for end

	);--if end
	
	
	)--with redraw end	
	resumeEditing()--�ĂуA�N�e�B�u��
	
	)--on end