/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark_PickTheCopy
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
	group "Pick The Copy"
	(
		button pickCopyBt "�s�b�N�U�R�s�[" width:160 hight:20
		button selCopyBt "�Z���N�g�U�R�s�[" width:160 hight:20
	)
	
	/*
	on pickCopyBt rightclick do
	(
	);--end
	*/
	
	on pickCopyBt pressed do
	(
		
		if selection.count != 0 then
		(
			
			Local pickedObj = undefined;
			messageBox "�R�s�[��̑Ώۂ̃I�u�W�F�N�g��I�����Ă�������" title:"���b�Z�[�W"
			pickedObj = PickObject count:1 select:false message:"�I�u�W�F�N�g��I�����Ă�������" ForceListenerFocus:true;
		
			try(
			pickedObj.controller = copy selection[1].controller;
				
			--�ŗL�ɂ���
			--obj.controller = prs (); 
				
			move pickedObj [0,0,0]; --���t���b�V���p�@0�����ړ�
			--ATSOps.Refresh()
			
			)catch();
			
			--obj.Transform.controller = selection[1].Transform.controller
			--obj.Transform.controller = prs () --�ŗL�ɂ���
		)
		else
		(
		messageBox("�R�s�[���̃I�u�W�F�N�g��I��ł�������") title:"���b�Z�[�W";
		)--if end
	);--on end
	
	on selCopyBt pressed do
	(
		if selection.count >= 2 then
		(
			try(
			selection[2].controller = copy selection[1].controller;
				
				move selection[2] [0,0,0]; --���t���b�V���p�@0�����ړ�
				sliderTime = (currenttime + 1);
				sliderTime = (currenttime - 1);
				
			--�ĕ`��
			max views redraw;
			
			)catch();--try end
		)
		else
		(
		messageBox("�ŏ��ɃR�s�[���A2�ԖڂɃR�s�[���I��ł�������") title:"���b�Z�[�W";
		)--if end
	);--end