/*******************************************************
System J Tools 
********************************************************
Name:SJ_Spark_DummyBoxSizeChange
Created By:CaptainHansode
WEB:www.sakaiden.com
E-Mail:sakaiden@live.jp
*******************************************************/
	group "�_�~�[�̑傫����ύX"
	(
		button dummySizeChangeBt "�T�C�Y�ύX" width:160 hight:20
		spinner dummySizeSpn "�T�C�Y:" range:[0,01e+009,1] type:#float width:160 align:#center
	);
	
	on dummySizeChangeBt pressed do
	(
		try(
			for i in selection do i.boxsize = [dummySizeSpn.value,dummySizeSpn.value,dummySizeSpn.value];
		)catch();
	);