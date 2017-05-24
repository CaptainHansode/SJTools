/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark_PolyMan.ms
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
	group "�ȈՃ|���S���Ǘ�"
	(
		button countPAndVBt "�|���S�����_�J�E���g" width:160 hight:20
		button fiveGonSelectBt "5�p�`�ȏ��I��" width:160 hight:20
/*
		button nearTagClearBt "�N���A" width:160 hight:20
		button doppelLinkerBt "�h�b�y�������J�[" width:160 hight:20
		button nearSearchTagBt "��ԋ߂��̃I�u�W�F�N�g�Ƀ����N" width:160 hight:20
		button nearSearchTagCPBt "�߂Ɉʒu�R���X�g���C���g" width:160 hight:20
		checkbox posOffsetOLChk "�I�t�Z�b�g" align:#left
		button nearSearchTagCRBt "�߂ɉ�]�R���X�g���C���g" width:160 hight:20
		checkbox rotOffsetOLChk "�I�t�Z�b�g" align:#left
*/
	)
--////////////////////////////////////////////////
--�|���S���J�E���g
--////////////////////////////////////////////////	
	on countPAndVBt pressed do
	(
		Local myMesh = undefined, totalFaces = 0, totalVerts = 0;
		for i in selection do
		(
			myMesh = snapshotAsMesh i;
			messageBox(i.name+"\n" + (myMesh.faces.count as String) + "\n" + (myMesh.verts.count as String)) title:"Count stats";
			totalFaces += myMesh.faces.count;
			totalVerts +=  myMesh.verts.count;
			delete myMesh;
		);--for end
			messageBox("Total\n" + (totalFaces as String) + "\n" + (totalVerts as String)) title:"Count stats";

	);--end
--////////////////////////////////////////////////
--�m��
--////////////////////////////////////////////////
	on fiveGonSelectBt pressed do
	(
	Local selectBitArray = #{};
		for i in selection do
		(
			--Edit_Poly�������ꍇ��
			if classOf i.baseobject != Editable_Poly then
			(
				 if (queryBox ("�ҏW�\�|���S���ł͂���܂���\n�����ɕҏW�\�|���S���ɕϊ����܂����H")title:"���b�Z�[�W") then
				 (
				 	convertto i editable_poly;
				 )else();--if end
			)else
			(
				for j = 1 to i.faces.count do
				(
					if (polyOp.getFaceDeg i j) >= 5 then append selectBitArray j;
				);--for end
				
			--�Ō�ɑI��
			--print selectBitArray
			if (selectBitArray.numberSet != 0) then
			(
			try(
				i.EditablePoly.SetSelection #Face selectBitArray;
				--messageBox(i.name + "��5�p�`�ȏ�̃|���S����\n" + (i.selectedFaces.count as String) + "  �|���S������܂���")title:"���b�Z�[�W";
				messageBox(i.name + "��5�p�`�ȏ�̃|���S����\n" + (selectBitArray.numberSet as String) + "  �|���S������܂���")title:"���b�Z�[�W";
			)catch(messageBox(i.name + "�̃|���S���I���Ɏ��s���܂���")title:"���b�Z�[�W");--try end
			)else(messageBox("5�p�`�ȏ�̃|���S���͂���܂���")title:"���b�Z�[�W");--if end
			
			);--if end
		
			selectBitArray = #{};
			
		);--for end
	);--end