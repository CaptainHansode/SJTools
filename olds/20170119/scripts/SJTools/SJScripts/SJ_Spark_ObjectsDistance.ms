/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark_ObjectsDistance.ms
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
	group "Objects Distance"
	(
	button parentDistanceBt "�e����̋���" width:160 height:20
	button measureObjectsBt "���W���["  width:160 height:20
	)
	
	on parentDistanceBt pressed do
	(
	Local myFlag = false;
	if queryBox ("���ʂ����b�Z�[�W�{�b�N�X�ŕ\�����܂���?") then myFlag = true;
	for i in selection do
	(
		Local parentObj = i.parent
		if parentObj != undefined then
		(
			myValue = distance i i.parent
			print (i.name + "  -->  " + i.parent.name + "�̋�����  " + myValue as String + " ")
			print myValue;
			print "\n";
			if myFlag then messageBox (i.name + "  -->  " + i.parent.name + "�̋�����  " + myValue as String + " ");
		)else(
			print ("�e�͂���܂���\n�|�W�V������  "+(i.pos as String))
			print "\n"
			if myFlag then messageBox ("�e�͂���܂���\n�|�W�V������  "+(i.pos as String));
		)--if end
	)--for end
	)--end
	
	on measureObjectsBt pressed do
	(
		if selection.count != 0 then
		(
			Local myObj = selection[1];
			Local targetObj = PickObject count:1 select:true message:"�I�u�W�F�N�g��I�����Ă��������B" Rubberband:selection[1].pos rubberBandColor:[0,0,0] ForceListenerFocus:False
			if targetObj != undefined then
			(
			myValue = distance myObj targetObj
			if queryBox ("���ʂ����b�Z�[�W�{�b�N�X�ŕ\�����܂���?") then
			(
				print (myObj.name + "  -->  " + targetObj.name + "�̋�����  " + myValue as String + " ")
				print myValue;
				print "\n"
				messageBox (myObj.name + "  -->  " + targetObj.name + "�̋�����  " + myValue as String + " ");
			)else(
				print (myObj.name + "  -->  " + targetObj.name + "�̋�����  " + myValue as String + " ")
				print myValue;
				print "\n"
			);--if end	
			);--ifend
		)else(messageBox("�I�u�W�F�N�g��I�����Ă�������"));--if end
	)