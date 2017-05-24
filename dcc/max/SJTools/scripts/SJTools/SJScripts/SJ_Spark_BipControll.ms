/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark_BipControll.ms
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
	group "Bip Controll"
	(
		button slidingToFreeBt "Bip Slide to Free" width:160
		button freeToSlidingBt "Bip Free to Slide" width:160
	)

--////////////////////////////////////////////////
--Action
--////////////////////////////////////////////////
	on slidingToFreeBt pressed do
	(
		if (queryBox("�葫�S�ẴL�[���t���[�L�[�ɂ��܂�\n���s���܂���?\n ")title:"�m�F") do
		(
		Local tempK = #()
		suspendEditing()--�T�X�y���h���[�h
		if maxOps.getSetKeyMode() == true do max set key mode --�Z�b�g�L�[���[�h�������ꍇ�ɃZ�b�g�L�[���[�h��off
		--set animate off
		
		--with redraw off
		--(--�ĕ`��֎~
		
		try(
		for i=1 to 2 do
		(
			tempObj = biped.getNode $ i
			tempBip = tempObj.transform.controller
			
			if tempBip.keys.count != 0 then
			(
			for u=1 to tempBip.keys.count do
			(
			append tempK tempBip.keys[u].time
			)--for end
			
			for k=1 to tempK.count do
			(
			sliderTime = tempK[k]
			biped.setFreeKey tempObj
			)--for end
			tempK = #()
			)--if end
		)--for end
		for i=5 to 6 do
		(
			tempObj = biped.getNode $ i
			tempBip = tempObj.transform.controller
			
			if tempBip.keys.count != 0 then
			(
			for u=1 to tempBip.keys.count do
			(
			append tempK tempBip.keys[u].time
			)--for end
			
			for k=1 to tempK.count do
			(
			sliderTime = tempK[k]
			biped.setFreeKey tempObj
			)--for end
			tempK = #()
			)--if end
		)--for end
		)catch(messageBox("���s���܂���")title:"���b�Z�[�W");
		--)--with redraw end	
		resumeEditing()--�ĂуA�N�e�B�u��
		);--if end
	)

	on freeToSlidingBt pressed do
	(
		if (queryBox("�葫�S�ẴL�[���X���C�h�L�[�ɂ��܂�\n���s���܂���?\n ")title:"�m�F") do
		(
		Local tempK = #()
		suspendEditing()--�T�X�y���h���[�h
		if maxOps.getSetKeyMode() == true do max set key mode --�Z�b�g�L�[���[�h�������ꍇ�ɃZ�b�g�L�[���[�h��off
		--set animate off
		
		--with redraw off
		--(--�ĕ`��֎~
		
		try(
		for i=1 to 2 do
		(
			tempObj = biped.getNode $ i
			
			tempBip = tempObj.transform.controller
			if tempBip.keys.count != 0 then
			(
			for u=1 to tempBip.keys.count do
			(
			append tempK tempBip.keys[u].time
			)--for end
		
			for k=1 to tempK.count do
			(
			sliderTime = tempK[k]
			biped.setSlidingKey tempObj
			)--for end
			tempK = #()
			)--if end
		)--for end
		for i=5 to 6 do
		(
			tempObj = biped.getNode $ i
			
			tempBip = tempObj.transform.controller
			if tempBip.keys.count != 0 then
			(
			for u=1 to tempBip.keys.count do
			(
			append tempK tempBip.keys[u].time
			)--for end
		
			for k=1 to tempK.count do
			(
			sliderTime = tempK[k]
			biped.setSlidingKey tempObj
			)--for end
			tempK = #()
			)--if end
		)--for end

		)catch(messageBox("���s���܂���")title:"���b�Z�[�W");
		--)--with redraw end	
		resumeEditing()--�ĂуA�N�e�B�u��
		);--if end
	)